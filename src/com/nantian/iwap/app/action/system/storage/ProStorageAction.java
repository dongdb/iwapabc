package com.nantian.iwap.app.action.system.storage;

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

public class ProStorageAction extends TransactionBizAction {
	private static Logger logger = Logger.getLogger(ProStorageAction.class);
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
		if ("addInd".equals(option)) {
			return addInd(dtbHelper);
		}
		return 0;
	}

	protected int query(DTBHelper dtbHelper) {

		return 0;
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

	protected int addInd(DTBHelper dtbHelper) throws BizActionException {
		logger.info("-------add-------"+dtbHelper);
		int flag = 0;
		DBAccessBean dbBean = null;
		try {
			dbBean = DBAccessPool.getDbBean();
			dbBean.setAutoCommit(false);
			
			String fid =  DateUtil.getCurrentDate("yyyyMMddHHmmss");
			String name = dtbHelper.getStringValue("name");
			PasswordEncrypt encrypt = (PasswordEncrypt) Class.forName(encryptClazz).newInstance();
			fid = encrypt.encryptPassword(name, DateUtil.getCurrentDate("yyyyMMddHHmmss"));// 默认密码
			logger.info("-fid-"+fid);
			String kind = dtbHelper.getStringValue("kind");
			String sname = dtbHelper.getStringValue("sname");
			String zcsl = dtbHelper.getStringValue("zcsl");
			String price = dtbHelper.getStringValue("price");
			String currency = dtbHelper.getStringValue("currency");
			String isfa = dtbHelper.getStringValue("isfa");
			String spectype = dtbHelper.getStringValue("spectype");
			String usetype = dtbHelper.getStringValue("usetype");
			String factory = dtbHelper.getStringValue("factory");
			String fdate = dtbHelper.getStringValue("fdate");
			String bdate = dtbHelper.getStringValue("bdate");
			String warn = dtbHelper.getStringValue("warn");
			String wdate = dtbHelper.getStringValue("wdate");
			String unit = dtbHelper.getStringValue("unit");
			String detailInfo = dtbHelper.getStringValue("detailInfo");
			String budget = dtbHelper.getStringValue("budget");
			String remark = dtbHelper.getStringValue("remark");			
			
			String sqlStr = "insert into OA_AS_IND(FID,FNAME,FKIND,FSIMPLENAME,"
						  + "FZCSL,FPRICE,FCURRENCY,FISFA,FSPECTYPE,FUSETYPE,"
						  + "FFACTORY,FFACTORYDATE,FBUYDATE,FWARRANTYMONTH,FWARRANTYDATE,"
						  + "FUNIT,FDETAILINFO,FBUDGET,FREMARK) values (?,?,?,?,?,?,?,?,?,?,?,"
						  + "to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),?,"
						  + "to_date(?,'yyyy-mm-dd'),?,?,?,?)";
			dbBean.executeUpdate(sqlStr, fid, name, kind, sname, zcsl, price, currency,
					isfa, spectype, usetype, factory, fdate, bdate, warn, wdate, 
					unit, detailInfo, budget, remark);

			dbBean.executeCommit();
			flag = 1;
		} catch (Exception e) {
			logger.error("资产新增出错", e);
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

	

}
