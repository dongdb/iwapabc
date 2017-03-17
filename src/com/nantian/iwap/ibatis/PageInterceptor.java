package com.nantian.iwap.ibatis;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import org.apache.ibatis.executor.parameter.ParameterHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.reflection.DefaultReflectorFactory;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.ReflectorFactory;
import org.apache.ibatis.reflection.factory.DefaultObjectFactory;
import org.apache.ibatis.reflection.factory.ObjectFactory;
import org.apache.ibatis.reflection.wrapper.DefaultObjectWrapperFactory;
import org.apache.ibatis.reflection.wrapper.ObjectWrapperFactory;
import org.apache.ibatis.scripting.defaults.DefaultParameterHandler;
import org.apache.ibatis.session.Configuration;
import org.apache.log4j.Logger;

@Intercepts({@org.apache.ibatis.plugin.Signature(type=StatementHandler.class, method="prepare", args={Connection.class})})
public class PageInterceptor
  implements Interceptor
{
  private static final Logger logger = Logger.getLogger(PageInterceptor.class);
  private static final ObjectFactory DEFAULT_OBJECT_FACTORY = new DefaultObjectFactory();
  private static final ObjectWrapperFactory DEFAULT_OBJECT_WRAPPER_FACTORY = new DefaultObjectWrapperFactory();
  private static final ReflectorFactory DEFAULT_REFLECTOR_FACTORY = new DefaultReflectorFactory();
  private static String defaultDialect = "mysql";
  private static String defaultPageSqlId = ".*Page$";
  private static String dialect = "";
  private static String pageSqlId = "";

  public Object intercept(Invocation invocation) throws Throwable
  {
    StatementHandler statementHandler = (StatementHandler)invocation.getTarget();
    MetaObject metaStatementHandler = MetaObject.forObject(statementHandler, DEFAULT_OBJECT_FACTORY, 
      DEFAULT_OBJECT_WRAPPER_FACTORY, DEFAULT_REFLECTOR_FACTORY);

    while (metaStatementHandler.hasGetter("h")) {
      Object object = metaStatementHandler.getValue("h");
      metaStatementHandler = MetaObject.forObject(object, DEFAULT_OBJECT_FACTORY, DEFAULT_OBJECT_WRAPPER_FACTORY, DEFAULT_REFLECTOR_FACTORY);
    }

    while (metaStatementHandler.hasGetter("target")) {
      Object object = metaStatementHandler.getValue("target");
      metaStatementHandler = MetaObject.forObject(object, DEFAULT_OBJECT_FACTORY, DEFAULT_OBJECT_WRAPPER_FACTORY, DEFAULT_REFLECTOR_FACTORY);
    }
    Configuration configuration = (Configuration)metaStatementHandler.getValue("delegate.configuration");
    dialect = configuration.getVariables().getProperty("dialect");
    if ((dialect == null) || ("".equals(dialect))) {
      logger.warn("Property dialect is not setted,use default 'mysql' ");
      dialect = defaultDialect;
    }
    pageSqlId = configuration.getVariables().getProperty("pageSqlId");
    if ((pageSqlId == null) || ("".equals(pageSqlId))) {
      logger.warn("Property pageSqlId is not setted,use default '.*Page$' ");
      pageSqlId = defaultPageSqlId;
    }
    logger.info("Property pageSqlId:" + pageSqlId);
    MappedStatement mappedStatement = (MappedStatement)metaStatementHandler.getValue("delegate.mappedStatement");

    if (mappedStatement.getId().matches(pageSqlId)) {
      BoundSql boundSql = (BoundSql)metaStatementHandler.getValue("delegate.boundSql");
      Object parameterObject = boundSql.getParameterObject();

      if (parameterObject == null) {
        PageParameter page = new PageParameter();
        page.setPageSize(10);
        page.setCurrentPage(1);
        metaStatementHandler.setValue("delegate.boundSql.parameterObject.__$page", page);
        logger.warn("parameter not set default pageSize 10 currentPage 1");
      }
      PageParameter page = (PageParameter)metaStatementHandler
        .getValue("delegate.boundSql.parameterObject.__$page");
      String sql = boundSql.getSql();

      String pageSql = buildPageSql(sql, page);
      metaStatementHandler.setValue("delegate.boundSql.sql", pageSql);

      metaStatementHandler.setValue("delegate.rowBounds.offset", Integer.valueOf(0));
      metaStatementHandler.setValue("delegate.rowBounds.limit", Integer.valueOf(2147483647));
      Connection connection = (Connection)invocation.getArgs()[0];

      setPageParameter(sql, connection, mappedStatement, boundSql, page);
    }

    return invocation.proceed();
  }

  public Object plugin(Object target)
  {
    if ((target instanceof StatementHandler)) {
      return Plugin.wrap(target, this);
    }
    return target;
  }

  public void setProperties(Properties properties)
  {
  }

  private void setPageParameter(String sql, Connection connection, MappedStatement mappedStatement, BoundSql boundSql, PageParameter page)
  {
    String countSql = "select count(0) as total from (" + sql + ")";
    logger.info("countSql:"+countSql);
    
    PreparedStatement countStmt = null;
    ResultSet rs = null;
    try {
      countStmt = connection.prepareStatement(countSql);
      BoundSql countBS = new BoundSql(mappedStatement.getConfiguration(), countSql, 
        boundSql.getParameterMappings(), boundSql.getParameterObject());
      setParameters(countStmt, mappedStatement, countBS, boundSql.getParameterObject());
      rs = countStmt.executeQuery();
      int totalCount = 0;
      if (rs.next()) {
        totalCount = rs.getInt(1);
      }
      page.setTotalCount(totalCount);
      int totalPage = totalCount / page.getPageSize() + (totalCount % page.getPageSize() == 0 ? 0 : 1);
      page.setTotalPage(totalPage);
    }
    catch (SQLException e) {
      logger.error("Ignore this exception", e);
      try
      {
        rs.close();
      } catch (SQLException e1) {
        logger.error("Ignore this exception", e1);
      }
      try {
        countStmt.close();
      } catch (SQLException e2) {
        logger.error("Ignore this exception", e2);
      }
    }
    finally
    {
      try
      {
        rs.close();
      } catch (SQLException e) {
        logger.error("Ignore this exception", e);
      }
      try {
        countStmt.close();
      } catch (SQLException e) {
        logger.error("Ignore this exception", e);
      }
    }
  }

  private void setParameters(PreparedStatement ps, MappedStatement mappedStatement, BoundSql boundSql, Object parameterObject)
    throws SQLException
  {
    ParameterHandler parameterHandler = new DefaultParameterHandler(mappedStatement, parameterObject, boundSql);
    parameterHandler.setParameters(ps);
  }

  private String buildPageSql(String sql, PageParameter page)
  {
    if (page != null) {
      StringBuilder pageSql = new StringBuilder();
      if ("mysql".equals(dialect))
        pageSql = buildPageSqlForMysql(sql, page);
      else if ("oracle".equals(dialect))
        pageSql = buildPageSqlForOracle(sql, page);
      else {
        return sql;
      }
      return pageSql.toString();
    }
    return sql;
  }

  public StringBuilder buildPageSqlForMysql(String sql, PageParameter page)
  {
    StringBuilder pageSql = new StringBuilder(100);
    String beginrow = String.valueOf((page.getCurrentPage() - 1) * page.getPageSize());
    pageSql.append(sql);
    pageSql.append(" limit " + beginrow + "," + page.getPageSize());
    return pageSql;
  }

  public StringBuilder buildPageSqlForOracle(String sql, PageParameter page)
  {
    StringBuilder pageSql = new StringBuilder(100);
    String beginrow = String.valueOf((page.getCurrentPage() - 1) * page.getPageSize());
    String endrow = String.valueOf(page.getCurrentPage() * page.getPageSize());

    pageSql.append("select * from ( select temp.*, rownum row_id from ( ");
    pageSql.append(sql);
    pageSql.append(" ) temp where rownum <= ").append(endrow);
    pageSql.append(") where row_id > ").append(beginrow);
    return pageSql;
  }
}