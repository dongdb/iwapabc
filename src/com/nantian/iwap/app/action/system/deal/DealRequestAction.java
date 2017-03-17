package com.nantian.iwap.app.action.system.deal;

import java.util.List;
import java.util.Map;

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

public class DealRequestAction extends TransactionBizAction {
	private static Logger logger = Logger.getLogger(DealRequestAction.class);
	private String encryptClazz = "com.nantian.iwap.app.util.DefaultEncrypt";// 默认加密方式

	public int actionExecute(DTBHelper dtbHelper) throws BizActionException {
		String option = dtbHelper.getStringValue("option");
		if (StringUtil.isBlank(option)) {
			return query(dtbHelper);
		}
		if ("asset".equals(option)) {
			return asset(dtbHelper);
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
		if ("transfer".equals(option)) {
			return transfer(dtbHelper);
		}
		if ("query".equals(option)) {
			return query(dtbHelper);
		}
		if ("init".equals(option)) {
			return init(dtbHelper);
		}
		return 0;
	}
	
	protected int init(DTBHelper dtbHelper) throws BizActionException {
		try {
			String ZCCZ = "ZCCZ";
			String date = DateUtil.getCurrentDate("yyyyMMdd");
			ZCCZ += date;
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			String sql="select zccz_seq.nextval seq from dual ";
			DataObject data = dbBean.executeSingleQuery(sql);
			String seq  = data.getValue("seq");
			int length = 6;
			while (seq.length() < length){
				seq = "0" + seq;
			}
			ZCCZ += seq;
			logger.info("处置单号："+ZCCZ);
			dtbHelper.setRstData("ZCCZ", ZCCZ);
		} catch (Exception e) {
			logger.error("数据库访问异常!", e);
			dtbHelper.setError("depmg-err-s", "[数据库访问异常!]");
		} finally {
			DBAccessPool.releaseDbBean();
		}
		return 0;
	}

	protected int asset(DTBHelper dtbHelper) {
		logger.info("-------asset-------"+dtbHelper);
		int flag = 0;
		DBAccessBean dbBean = null;
		int start = Integer.valueOf(dtbHelper.getStringValue("start"));
		int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
		String fuzzysearch = "%" + dtbHelper.getStringValue("fuzzyAsset") + "%";
		logger.info("fuzzysearch:"+fuzzysearch);
		try {
			dbBean = DBAccessPool.getDbBean();
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			String sqlStr = "select FID,FBARCODE,FNAME,"
							+ "FSPECTYPE,FSOURCENAME,FORIGINVALUE,"
							+ "FRESPONSEPSNNAME,"
							+ "to_char(FCREATETIME,'yyyy-mm-dd') FCREATETIME,"
							+ "FREMARK "
							+ "from OA_AS_Card where 1=1 "
							+ "and (FBARCODE like ? or FNAME like ? "
							+ " or FSPECTYPE like ?  or FSOURCENAME like ? "
							+ " or FRESPONSEPSNNAME like ? )";
			logger.info("执行sql语句:" + sqlStr);
			List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr,page,
					fuzzysearch,fuzzysearch,fuzzysearch,fuzzysearch,fuzzysearch);
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
			logger.error("资产列表查询出错", e);
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
	

	protected int query(DTBHelper dtbHelper) {
		logger.info("-------query-------"+dtbHelper);
		int flag = 0;
		DBAccessBean dbBean = null;
		int start = Integer.valueOf(dtbHelper.getStringValue("start"));
		int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
		String fuzzySearch = "%" + dtbHelper.getStringValue("fuzzySearch") + "%";
		logger.info("fuzzySearch:"+fuzzySearch);
		try {
			dbBean = DBAccessPool.getDbBean();
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			String sqlStr = "select a.repairno,"
							+ "to_char(a.CREATEDATETIME,'yyyy-mm-dd') CREATEDATETIME,"
							+ "a.CREATEPSNNAME,a.ASSETNAME,a.ASSETBARCODE,"
							+ "a.FAULTDESCN,b.SEXECUTORNAMES,b.SSTATUSNAME "
							+ "from OA_ASSET_REPAIR_PARENT a,SA_TASK b where a.fid = b.SDATA1 "
							+ "and (REPAIRNO like ? or CREATEPSNNAME like ? or ASSETNAME like ? "
							+ "or ASSETBARCODE like ? or SEXECUTORNAMES like ? or SSTATUSNAME like ?) ";
			logger.info("执行sql语句:" + sqlStr);
			List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr,page,fuzzySearch,fuzzySearch,fuzzySearch,fuzzySearch,fuzzySearch,fuzzySearch);
			logger.info("-----------dataList:" + dataList);
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
			logger.error("维修列表查询出错", e);
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
		logger.info("-------query-------"+dtbHelper);
		int flag = 0;
		DBAccessBean dbBean = null;
		int start = Integer.valueOf(dtbHelper.getStringValue("start"));
		int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
		String fuzzysearch = "%" + dtbHelper.getStringValue("fuzzysearch") + "%";
		logger.info("fuzzysearch:"+fuzzysearch);
		try {
			dbBean = DBAccessPool.getDbBean();
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			String sqlStr = "select FCODE,FNAME,FORIGINVALUE,"
							+ "FISDEPT,FEXTENDSTR2,FSPECTYPE "
							+ "from OA_AS_CARD where 1=1 "
							+ "and (FCODE like ? or FNAME like ? )";
			logger.info("执行sql语句:" + sqlStr);
			List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr,page,fuzzysearch,fuzzysearch);
			logger.info("-----------dataList:" + dataList);
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
			logger.error("资产列表查询出错", e);
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

	protected int save(DTBHelper dtbHelper) {

		return 0;
	}

	protected int remove(DTBHelper dtbHelper) {

		return 0;
	}

	public int transfer(DTBHelper dtbHelper) throws BizActionException {
		
		return 0;
	}

	protected int other(DTBHelper dtbHelper) throws BizActionException {

		return 0;
	}
}
