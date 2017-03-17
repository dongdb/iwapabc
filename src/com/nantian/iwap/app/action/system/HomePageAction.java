package com.nantian.iwap.app.action.system;

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

public class HomePageAction extends TransactionBizAction {
	private static Logger logger = Logger.getLogger(HomePageAction.class);
	private String encryptClazz = "com.nantian.iwap.app.util.DefaultEncrypt";// 默认加密方式

	public int actionExecute(DTBHelper dtbHelper) throws BizActionException {
		String option = dtbHelper.getStringValue("option");
		if (StringUtil.isBlank(option)) {
			return init(dtbHelper);
		}
		if ("init".equals(option)) {
			return init(dtbHelper);
		}
		return 0;
	}

	protected int init(DTBHelper dtbHelper) {
		logger.info("-------init-------" + dtbHelper);
		int flag = 0;
		DBAccessBean dbBean = null;
		String user = dtbHelper.getStringValue("userInfo.ACCT_NM");
		try {
			dbBean = DBAccessPool.getDbBean();
			String sqlStr = "select SPARENTID,SDATA1,SNAME,SCREATORPERSONNAME,"
					+ " SEURL,to_char(SCREATETIME,'yyyy-mm-dd') SCREATETIME "
					+ " from SA_TASK "
					+ " where 1=1 "
					+ " and SSTATUSID='tesReady' "
					+ " and SEXECUTORNAMES = '"
					+ user + "'";
			logger.info("执行sql语句:" + sqlStr);
			List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr);

			if (dataList.size() > 0) {
				dtbHelper.setRstData("rows", dataList);
				dtbHelper.setRstData("total", dataList.size());
			} else {
				dtbHelper.setError("depmg-err-s", "[数据库显示失败!]");
				DBAccessPool.releaseDbBean();
				return 0;
			}
			String sqlStr1 = "select SPARENTID,SDATA1,SNAME,SEXECUTORNAMES,"
					+ " SEURL,to_char(SCREATETIME,'yyyy-mm-dd') SCREATETIME "
					+ " from SA_TASK "
					+ " where 1=1 "
					+ " and SSTATUSID='tesReady' "
					+ " and SKINDID='tkTask' "
					+ " and SCREATORPERSONNAME = '"
					+ user + "'";
			logger.info("执行sql语句:" + sqlStr1);
			List<Map<String, Object>> dataList1 = dbBean.queryForList(sqlStr1);

			if (dataList1.size() > 0) {
				dtbHelper.setRstData("rows1", dataList1);
				dtbHelper.setRstData("total1", dataList1.size());
			} else {
				dtbHelper.setError("depmg-err-s", "[数据库显示失败!]");
				DBAccessPool.releaseDbBean();
				return 0;
			}
			flag = 1;
		} catch (Exception e) {
			logger.error("查询出错", e);
			dtbHelper.setError("usermg-err-add-002", "[出错]" + e.getMessage());
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

}
