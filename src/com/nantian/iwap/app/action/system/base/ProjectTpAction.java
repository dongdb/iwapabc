package com.nantian.iwap.app.action.system.base;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.log4j.Logger;

import com.nantian.iwap.biz.actions.TransactionBizAction;
import com.nantian.iwap.biz.flow.BizActionException;
import com.nantian.iwap.common.util.DateUtil;
import com.nantian.iwap.common.util.StringUtil;
import com.nantian.iwap.databus.DTBHelper;
import com.nantian.iwap.persistence.DBAccessBean;
import com.nantian.iwap.persistence.DBAccessPool;
import com.nantian.iwap.persistence.DataObject;
import com.nantian.iwap.persistence.PaginationSupport;

/**
 * ClassName: ProjectTpAction <br/>
 * Function: 获取工程类型菜单<br/>
 * date: 2016年3月2日15:18:49 <br/>
 * 
 * @author zsj
 * @version
 * @since JDK 1.7 Copyright (c) 2016, 广州南天电脑系统有限公司 All Rights Reserved.
 */
public class ProjectTpAction extends TransactionBizAction {

	private static Logger log = Logger.getLogger(ProjectTpAction.class);
	
	public int actionExecute(DTBHelper dtbHelper) throws BizActionException {
		String option = dtbHelper.getStringValue("option");
		if (StringUtil.isBlank(option)) {
			return query(dtbHelper);
		}
		if ("add".equals(option)) {
			return add(dtbHelper);
		}
		if ("save".equals(option)) {
			return save(dtbHelper);
		}
		if ("remove".equals(option)) {
			return remove(dtbHelper);
		}
		if ("restart".equals(option)){
			return restart(dtbHelper);
		}
		if ("stop".equals(option)){
			return stop(dtbHelper);
		}
		return 0;
	}

	protected int query(DTBHelper dtbHelper) throws BizActionException {
		int flag = 0;
		try {
			int start = Integer.valueOf(dtbHelper.getStringValue("start"));
			int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			List<Map<String, Object>> dataList = null;
			String sqlStr = "select FID,VERSION,FNAME,FDESCRIPTION,FUSESTATUSNAME  "
						  + "from OA_PUB_BASECODE "
						  + "where FSCOPE = '工程类型' "
						  + "order by fsequence asc";
			dataList = dbBean.queryForList(sqlStr, page);	
			log.info(sqlStr);
			dtbHelper.setRstData("rows", dataList);
			dtbHelper.setRstData("total", page.getTotalCount());
			flag = 1;
		} catch (Exception e) {
			log.error("工程类型查询出错", e);
			dtbHelper.setError("projecttp-err-qry", "[工程类型查询出错]" + e.getMessage());
		}
		return flag;
	}

	protected int add(DTBHelper dtbHelper) throws BizActionException {
		int flag = 0;
		DBAccessBean dbBean = null;
		try {
			dbBean = DBAccessPool.getDbBean();
			dbBean.setAutoCommit(false);
			UUID uuid = UUID.randomUUID();
			String FID = uuid.toString().replaceAll("-", "");
			String FUSESTATUSNAME = dtbHelper.getStringValue("FUSESTATUSNAME");
			String FUSESTATUS = "";
			if(FUSESTATUSNAME.equals("启用")){
				FUSESTATUS="1";
			}else{
				FUSESTATUS="0";
			}
			String PSNID = dtbHelper.getStringValue("userInfo.ACCT_ID");
			String PSNNM = dtbHelper.getStringValue("userInfo.ACCT_NM");
			String ORGID = dtbHelper.getStringValue("userInfo.ORG_ID");
			String time= DateUtil.getCurrentDate("yyyy-MM-dd HH:mm:ss");
			String FNAME = dtbHelper.getStringValue("FNAME");
			String FDESCRIPTION = dtbHelper.getStringValue("FDESCRIPTION");

			String sqlStr = "select FNAME from OA_PUB_BASECODE where "
						  + "FSCOPE ='工程类型' and FNAME = ?";
			DataObject result = dbBean.executeSingleQuery(sqlStr, FNAME);
			if (result != null) {
				dbBean.executeRollBack();
				log.warn("工程类型新增出错：该工程类型已存在!");
				dtbHelper.setError("projecttp-err-add-001", "[工程类型新增出错]该工程类型已存在!");
				return flag;
			}
			String sql = "select count(0)+1 fsequence from OA_PUB_BASECODE where "
					  + "FSCOPE ='工程类型'";
			DataObject data = dbBean.executeSingleQuery(sql);
			String FSEQUENCE = data.getValue("fsequence");
			
			sqlStr = "insert into OA_PUB_BASECODE "
					+ "(FID,VERSION,FSCOPE,FNAME,FSEQUENCE,FDESCRIPTION,FUSESTATUS,FUSESTATUSNAME,"
					+ "FCREATEOGNID,FCREATEPSNID,FCREATEPSNNAME,FCREATETIME,FUPDATETIME) "
					+ "values (?,?,?,?,?,?,?,?,?,?,?,to_date(?,'yyyy-MM-dd HH24:mi:ss'),to_date(?,'yyyy-MM-dd HH24:mi:ss'))";
			dbBean.executeUpdate(sqlStr, FID, 0,"工程类型",FNAME,FSEQUENCE,FDESCRIPTION,
					FUSESTATUS,FUSESTATUSNAME,ORGID,PSNID,PSNNM,time,time);
			dbBean.executeCommit();
			flag = 1;
		} catch (Exception e) {
			log.error("工程类型新增出错", e);
			dtbHelper.setError("projecttp-err-add-002", "[工程类型新增出错]" + e.getMessage());
			try {
				if (dbBean != null) {
					dbBean.executeRollBack();
				}
			} catch (Exception e2) {
				log.error("数据库回滚出错", e2);
			}
		}
		return flag;
	}

	protected int save(DTBHelper dtbHelper) throws BizActionException {
		int flag = 0;
		DBAccessBean dbBean = null;
		try {
			dbBean = DBAccessPool.getDbBean();
			dbBean.setAutoCommit(false);
			String FUSESTATUSNAME = dtbHelper.getStringValue("FUSESTATUSNAME");
			String FUSESTATUS = "";
			if(FUSESTATUSNAME.equals("启用")){
				FUSESTATUS="1";
			}else{
				FUSESTATUS="0";
			}
			String PSNID = dtbHelper.getStringValue("userInfo.ACCT_ID");
			String PSNNM = dtbHelper.getStringValue("userInfo.ACCT_NM");
			String time= DateUtil.getCurrentDate("yyyy-MM-dd HH:mm:ss");
			String FNAME = dtbHelper.getStringValue("FNAME");
			String FID = dtbHelper.getStringValue("FID");
			String VERSION = dtbHelper.getStringValue("VERSION");
			String FDESCRIPTION = dtbHelper.getStringValue("FDESCRIPTION");
			String sqlStr = "UPDATE OA_PUB_BASECODE set "
						  + "FNAME=?,FDESCRIPTION=?,VERSION=?,FUSESTATUS=?,FUSESTATUSNAME=?, "
						  + "FUPDATEPSNID=?,FUPDATEPSNNAME=?,FUPDATETIME=to_date(?,'yyyy-MM-dd HH24:mi:ss')"
						  + " where FID=?";
			dbBean.executeUpdate(sqlStr, FNAME, FDESCRIPTION, VERSION, FUSESTATUS,
								 FUSESTATUSNAME,PSNID,PSNNM,time,FID);
			dbBean.executeCommit();
			flag = 1;
		} catch (Exception e) {
			log.error("工程类型保存出错", e);
			dtbHelper.setError("projecttp-err-sv", "[工程类型保存出错]" + e.getMessage());
		}
		return flag;
	}

	protected int remove(DTBHelper dtbHelper) throws BizActionException {
		int flag = 0;
		DBAccessBean dbBean = null;
		try {
			dbBean = DBAccessPool.getDbBean();
			dbBean.setAutoCommit(false);
			String repids = dtbHelper.getStringValue("repids");
			String[] reparr = repids.split(",");
			int u_cnt = 0;
			int s_cnt = 0;
			for (String project : reparr) {
				if (project == null || "".equals(project.trim())) {
					continue;
				}
				
				u_cnt++;
				int i = dbBean.executeUpdate("delete from OA_PUB_BASECODE where FID = ?", project);
				if (i == 1) {
					s_cnt++;
				}
			}
			dbBean.executeCommit();
			if (u_cnt != s_cnt) {
				log.warn("工程类型删除出错:删除失败" + (u_cnt - s_cnt) + "条");
				dtbHelper.setError("projecttp-err-rm-001", "[工程类型删除出错]删除失败" + (u_cnt - s_cnt) + "条");
			} else {
				flag = 1;
			}
		} catch (Exception e) {
			log.error("工程类型删除出错", e);
			dtbHelper.setError("projecttp-err-rm-002", "[工程类型删除出错]" + e.getMessage());
			try {
				if (dbBean != null) {
					dbBean.executeRollBack();
				}
			} catch (Exception e2) {
				log.error("数据库回滚出错", e2);
			}
		}
		return flag;
	}
	protected int restart(DTBHelper dtbHelper) throws BizActionException {
		int flag = 0;
		DBAccessBean dbBean = null;
		try {
			dbBean = DBAccessPool.getDbBean();
			dbBean.setAutoCommit(false);
			String FID = dtbHelper.getStringValue("FID");
			String FUSESTATUSNAME = "启用";
			String FUSESTATUS = "1";
			String PSNID = dtbHelper.getStringValue("userInfo.ACCT_ID");
			String PSNNM = dtbHelper.getStringValue("userInfo.ACCT_NM");
			String time= DateUtil.getCurrentDate("yyyy-MM-dd HH:mm:ss");

			String sqlStr = "UPDATE OA_PUB_BASECODE set "
						  + "FUSESTATUS=?,FUSESTATUSNAME=?,FUPDATEPSNID=?,"
						  + "FUPDATEPSNNAME=?,FUPDATETIME=to_date(?,'yyyy-MM-dd HH24:mi:ss')"
						  + " where FID=?";
			dbBean.executeUpdate(sqlStr,FUSESTATUS,FUSESTATUSNAME,PSNID,PSNNM,time,FID);
			dbBean.executeCommit();
			flag = 1;
		} catch (Exception e) {
			log.error("工程类型删除出错", e);
			dtbHelper.setError("projecttp-err-rm-002", "[工程类型删除出错]" + e.getMessage());
			try {
				if (dbBean != null) {
					dbBean.executeRollBack();
				}
			} catch (Exception e2) {
				log.error("数据库回滚出错", e2);
			}
		}
		return flag;
	}
	protected int stop(DTBHelper dtbHelper) throws BizActionException {
		int flag = 0;
		DBAccessBean dbBean = null;
		try {
			dbBean = DBAccessPool.getDbBean();
			dbBean.setAutoCommit(false);
			String FID = dtbHelper.getStringValue("FID");
			String FUSESTATUSNAME = "停用";
			String FUSESTATUS = "0";
			String PSNID = dtbHelper.getStringValue("userInfo.ACCT_ID");
			String PSNNM = dtbHelper.getStringValue("userInfo.ACCT_NM");
			String time= DateUtil.getCurrentDate("yyyy-MM-dd HH:mm:ss");

			String sqlStr = "UPDATE OA_PUB_BASECODE set "
						  + "FUSESTATUS=?,FUSESTATUSNAME=?,FUPDATEPSNID=?,"
						  + "FUPDATEPSNNAME=?,FUPDATETIME=to_date(?,'yyyy-MM-dd HH24:mi:ss')"
						  + " where FID=?";
			dbBean.executeUpdate(sqlStr,FUSESTATUS,FUSESTATUSNAME,PSNID,PSNNM,time,FID);
			dbBean.executeCommit();
			flag = 1;
		} catch (Exception e) {
			log.error("工程类型删除出错", e);
			dtbHelper.setError("projecttp-err-rm-002", "[工程类型删除出错]" + e.getMessage());
			try {
				if (dbBean != null) {
					dbBean.executeRollBack();
				}
			} catch (Exception e2) {
				log.error("数据库回滚出错", e2);
			}
		}
		return flag;
	}
}
