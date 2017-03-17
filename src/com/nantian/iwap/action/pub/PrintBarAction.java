package com.nantian.iwap.action.pub;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.nantian.iwap.action.common.CRUDAction;
import com.nantian.iwap.biz.actions.TransactionBizAction;
import com.nantian.iwap.biz.flow.BizActionException;
import com.nantian.iwap.common.util.StringUtil;
import com.nantian.iwap.app.common.PubAction;
import com.nantian.iwap.databus.DTBHelper;
import com.nantian.iwap.persistence.DBAccessBean;
import com.nantian.iwap.persistence.DBAccessPool;
import com.nantian.iwap.persistence.DataObject;
import com.nantian.iwap.persistence.PaginationSupport;

public class PrintBarAction extends TransactionBizAction {
	private static Logger logger = Logger.getLogger(PrintBarAction.class);

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
		return 0;
	}

	protected int query(DTBHelper dtbHelper) {

		return 0;
	}

	protected int add(DTBHelper dtbHelper) {
		String fno = dtbHelper.getStringValue("fno");
		logger.info("------------fno:"+fno);
		String sqlStr = "select b.FNO,b.FRESPONSEDEPTNAME,"
				  + "b.FRESPONSEPSNNAME,b.FSIGNID,b.FMODE,"
				  + "TO_CHAR(a.FCREATETIME,'yyyy-mm-dd') AS FCREATETIME,"
				  + "b.FAMOUNT,a.FEXTENDSTR2,b.FCONTRACT,b.FSUPPLIER,"
				  + "b.FREMARK from OA_AS_CARD a,OA_AS_INM b"
				  + " where a.FASSETINNO=b.FNO"
				  + " and b.FNO='"
				  + fno
				  + "'";
		if(!fno.equals("")){
			logger.info("------------sqlStr:"+sqlStr);
		try {
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			List<Map<String,Object>> dataList = dbBean.queryForList(sqlStr);
			
			logger.info("执行sql语句:" + sqlStr);
			
			if (dataList.size() > 0) {
				dtbHelper.setRstData("rows", dataList.get(0));
			} else {
				dtbHelper.setError("depmg-err-s", "[数据库显示失败!]" );
				DBAccessPool.releaseDbBean();
				return 0;
			}
		} catch (Exception e) {
			logger.error("数据库访问异常!", e);
			dtbHelper.setError("depmg-err-s", "[数据库访问异常!]" );
		}finally {
			DBAccessPool.releaseDbBean();
		}
		}
		return 0;
	}

	protected int save(DTBHelper dtbHelper) {

		return 0;
	}

	protected int remove(DTBHelper dtbHelper) {

		return 0;
	}

	public int show(DTBHelper dtbHelper) throws BizActionException {
		// TODO Auto-generated method stub
		String asset_id = dtbHelper.getStringValue("fid");
		logger.info("------------asset_id:" + asset_id);
		String sqlStr = "select FID,ERPCODE,FCODE,FUSETYPE,FKIND,FSIMPLENAME,FNAME,"
				+ "FSPECTYPE,FISFA,FORIGINVALUE,FCURRENCY,FSOURCENAME,"
				+ "FUNIT,FSTATUSNAME,FASSETCONFIRM,FCHECKED,"
				+ "TO_CHAR(FCONFIRMDATE,'yyyy-mm-dd') AS FCONFIRMDATE,"
				+ "TO_CHAR(FIMPORTFADATE,'yyyy-mm-dd') AS FIMPORTFADATE,"
				+ "FRESPONSEDEPTNAME,FRESPONSEPSNNAME,"
				+ "FDUTYDEPTNAME,FDUTYPSNNAME,FISDEPT,"
				+ "TO_CHAR(FCREATETIME,'yyyy-mm-dd') AS FCREATETIME,"
				+ "TO_CHAR(FFACTORYDATE,'yyyy-mm-dd') AS FFACTORYDATE,"
				+ "TO_CHAR(FBUYDATE,'yyyy-mm-dd') AS FBUYDATE,"
				+ "FWARRANTYMONTH,"
				+ "TO_CHAR(FWARRANTYDATE,'yyyy-mm-dd') AS FWARRANTYDATE,"
				+ "ADMINDEPT,FEXTENDSTR2,FDETAILINFO,FREMARK,"
				+ "FBARCODE,FPHOTO,"
				+ "FFACTORY,FCONTRACT,FPROJECTID,FREMAINVALUE,"
				+ "FADDDEPREVALUE,FBGDEPRE,FASSETINNO,"
				+ "TO_CHAR(FBGDEPREDATE,'yyyy-mm-dd') AS FBGDEPREDATE from OA_AS_CARD where FID='"
				+ asset_id + "'";
		if (!asset_id.equals("")) {
			try {
				DBAccessBean dbBean = DBAccessPool.getDbBean();
				List<Map<String, Object>> dataList = dbBean
						.queryForList(sqlStr);

				logger.info("执行sql语句:" + sqlStr);

				if (dataList.size() > 0) {
					dtbHelper.setRstData("rows", dataList.get(0));
				} else {
					dtbHelper.setError("depmg-err-s", "[数据库显示失败!]");
					DBAccessPool.releaseDbBean();
					return 0;
				}
			} catch (Exception e) {
				logger.error("数据库访问异常!", e);
				dtbHelper.setError("depmg-err-s", "[数据库访问异常!]");
			} finally {
				DBAccessPool.releaseDbBean();
			}
		}
		return 0;
	}

	protected int other(DTBHelper dtbHelper) throws BizActionException {

		return 0;
	}

}
