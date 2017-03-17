package com.nantian.iwap.app.action.system.repair;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.nantian.iwap.action.common.CRUDAction;
import com.nantian.iwap.biz.actions.TransactionBizAction;
import com.nantian.iwap.biz.flow.BizActionException;
import com.nantian.iwap.common.util.DateUtil;
import com.nantian.iwap.common.util.StringUtil;
import com.nantian.iwap.app.common.PubAction;
import com.nantian.iwap.app.util.PasswordEncrypt;
import com.nantian.iwap.databus.DTBHelper;
import com.nantian.iwap.persistence.DBAccessBean;
import com.nantian.iwap.persistence.DBAccessPool;
import com.nantian.iwap.persistence.DataObject;
import com.nantian.iwap.persistence.PaginationSupport;

public class RepairReportAction extends TransactionBizAction {
	private static Logger logger = Logger.getLogger(RepairReportAction.class);
	private String encryptClazz = "com.nantian.iwap.app.util.DefaultEncrypt";// 默认加密方式

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
		if ("show".equals(option)) {
			return show(dtbHelper);
		}
		if ("query".equals(option)) {
			return query(dtbHelper);
		}
		return 0;
	}

	protected int query(DTBHelper dtbHelper) {
		logger.info("-------query-------"+dtbHelper);
		int flag = 0;
		DBAccessBean dbBean = null;
		int start = Integer.valueOf(dtbHelper.getStringValue("start"));
		int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
		String search = "%" + dtbHelper.getStringValue("search") + "%";
		String createtime = dtbHelper.getStringValue("createtime");
		String pid1 = dtbHelper.getStringValue("pid1");
		String pid2 = dtbHelper.getStringValue("pid2");
		String str= "";
		if(createtime.equals("1") ){
			str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
				+" and to_char(FCREATETIME,'mm')=to_char(sysdate,'mm')"
				+" and to_char(FCREATETIME,'dd')=to_char(sysdate,'dd')";
		}
		if(createtime.equals("2")){
			str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
				+" and to_char(FCREATETIME,'mm')=to_char(sysdate,'mm')"
				+" and to_char(FCREATETIME,'dd')=(to_char(sysdate,'dd')-1)";
		}
		if(createtime.equals("3")){
			str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
				+" and to_char(FCREATETIME,'iw')=to_char(sysdate,'iw')";
		}
		if(createtime.equals("4")){
			str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
				+" and to_char(FCREATETIME,'iw')=(to_char(sysdate,'iw')-1)";
		}
		if(createtime.equals("5")){
			str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
				+" and to_char(FCREATETIME,'mm')=to_char(sysdate,'mm')";
		}
		if(createtime.equals("6")){
			str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
				+" and to_char(FCREATETIME,'mm')=(to_char(sysdate,'mm')-1)";
		}
		if(createtime.equals("7")){
			str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')";
		}
		if(createtime.equals("8")){
			str=" and to_char(FCREATETIME,'yyyy')=(to_char(sysdate,'yyyy')-1)";
		}
		if(createtime.equals("9")){
			str=" and FCREATETIME > to_date('"+pid1+"','yyyy-mm-dd')"
					+" and FCREATETIME < to_date('"+pid2+"','yyyy-mm-dd')";
		}
		try {
			dbBean = DBAccessPool.getDbBean();
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			//String remark = dtbHelper.getStringValue("remark");			
			
			String sqlStr = "select FSTATENAME,FNO,to_char(FDATE,'yyyy-mm-dd') FDATE,"
							+ "FAMOUNT,FMODE,FCREATEPSNNAME,FCHECKDEPT,"
							+ "substr(fcreatedeptname,instr(fcreatedeptname,'/',-1,1)+1) fcreatedeptname,"
							+ "FCHECKPSN,to_char(FCHECKDATE,'yyyy-mm-dd') FCHECKDATE "
							+ "from OA_AS_INM where 1=1 "
							+ "and (FSTATE='2' OR FCHECKPSN IS NOT NULL) "
							+ "and (FMODE like ? or FNO like ? or FSTATENAME like ? "
							+ "or FCREATEDEPTNAME like ? or FCHECKDEPT like ? or FCHECKPSN like ? or FCREATEPSNNAME like ?) "
							+ str;
			List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr,page,search,search,search,search,search,search,search);
			logger.info("执行sql语句:" + sqlStr);
			if (dataList.size() > 0) {
				dtbHelper.setRstData("rows", dataList);
				dtbHelper.setRstData("total", page.getTotalCount());
			} else {
				dtbHelper.setError("depmg-err-s", "[数据库显示失败!]");
				DBAccessPool.releaseDbBean();
				return 0;
			}
			flag = 1;
		} catch (Exception e) {
			logger.error("入库验收查询出错", e);
			dtbHelper.setError("usermg-err-add-002", "[资产新增出错]" + e.getMessage());
			try {
				if (dbBean != null) {
					dbBean.executeRollBack();
				}
			} catch (Exception e2) {
				logger.error("数据库回滚出错", e2);
			}
		}
		return flag;
	}

	protected int add(DTBHelper dtbHelper) {
		
		return 0;
	}

	protected int save(DTBHelper dtbHelper) {

		return 0;
	}

	protected int remove(DTBHelper dtbHelper) {

		return 0;
	}

	public int show(DTBHelper dtbHelper) throws BizActionException {
		
		return 0;
	}

	protected int other(DTBHelper dtbHelper) throws BizActionException {

		return 0;
	}
}
