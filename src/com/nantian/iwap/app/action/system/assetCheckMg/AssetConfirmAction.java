package com.nantian.iwap.app.action.system.assetCheckMg;

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
 * ClassName: AssetConfirmAction <br/>
 * Function: 资产确认<br/>
 * date: 2016年11月24日 <br/>
 * 
 * @author zsj
 * @version
 * @since JDK 1.7 Copyright (c) 2016, 广州南天电脑系统有限公司 All Rights Reserved.
 */
public class AssetConfirmAction extends TransactionBizAction {

	private static Logger log = Logger.getLogger(AssetConfirmAction.class);

	public int actionExecute(DTBHelper dtbHelper) throws BizActionException {
		String option = dtbHelper.getStringValue("option");
		if (StringUtil.isBlank(option)) {
			return query(dtbHelper);
		}
		if ("bill".equals(option)) {
			return bill(dtbHelper);
		}
		if ("confirm".equals(option)) {
			return confirm(dtbHelper);
		}
		return 0;
	}

	protected int query(DTBHelper dtbHelper) throws BizActionException {
		try {
			int start = Integer.valueOf(dtbHelper.getStringValue("start"));
			int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
			String fuzzySearch = "%" + dtbHelper.getStringValue("fuzzySearch") + "%";
			String FASSETCONFIRM = "%" + dtbHelper.getStringValue("FASSETCONFIRM") + "%";
			String createtime = dtbHelper.getStringValue("FCREATETIME");
			String pid1 = dtbHelper.getStringValue("pid1");
			String pid2 = dtbHelper.getStringValue("pid2");
			String str = "";
			if (createtime.equals("1")) {
				str = " and to_char(FDATE,'yyyy')=to_char(sysdate,'yyyy')"
						+ " and to_char(FDATE,'mm')=to_char(sysdate,'mm')"
						+ " and to_char(FDATE,'dd')=to_char(sysdate,'dd')";
			}
			if (createtime.equals("2")) {
				str = " and to_char(FDATE,'yyyy')=to_char(sysdate,'yyyy')"
						+ " and to_char(FDATE,'mm')=to_char(sysdate,'mm')"
						+ " and to_char(FDATE,'dd')=(to_char(sysdate,'dd')-1)";
			}
			if (createtime.equals("3")) {
				str = " and to_char(FDATE,'yyyy')=to_char(sysdate,'yyyy')"
						+ " and to_char(FDATE,'iw')=to_char(sysdate,'iw')";
			}
			if (createtime.equals("4")) {
				str = " and to_char(FDATE,'yyyy')=to_char(sysdate,'yyyy')"
						+ " and to_char(FDATE,'iw')=(to_char(sysdate,'iw')-1)";
			}
			if (createtime.equals("5")) {
				str = " and to_char(FDATE,'yyyy')=to_char(sysdate,'yyyy')"
						+ " and to_char(FDATE,'mm')=to_char(sysdate,'mm')";
			}
			if (createtime.equals("6")) {
				str = " and to_char(FDATE,'yyyy')=to_char(sysdate,'yyyy')"
						+ " and to_char(FDATE,'mm')=(to_char(sysdate,'mm')-1)";
			}
			if (createtime.equals("7")) {
				str = " and to_char(FDATE,'yyyy')=to_char(sysdate,'yyyy')";
			}
			if (createtime.equals("8")) {
				str = " and to_char(FDATE,'yyyy')=(to_char(sysdate,'yyyy')-1)";
			}
			if (createtime.equals("9")) {
				// logger.info("pid1:"+pid1+"pid2:"+pid2);
				str = " and FDATE > to_date('" + pid1 + "','yyyy-mm-dd')"
						+ " and FDATE < to_date('" + pid2 + "','yyyy-mm-dd')";
			}
			log.info("fuzzySearch:" + fuzzySearch);
			String sqlStr = "select a.fid,a.FASSETCONFIRM,a.FNO,"
					+ "to_char(a.FDATE,'yyyy-mm-dd') FDATE,a.FSIGNID,"
					+ "a.FMODE,a.FAMOUNT,a.FRESPONSEDEPTFNAME,"
					+ "a.FRESPONSEPSNNAME,a.FREMARK "
					+ "from oa_as_inm a  "
					+ " where 1=1 "+ str 
					//+ " and (a.fmode = '购入' or a.fmode='工程结转') "
					+ " and a.FASSETCONFIRM like ? "
					+ " and (a.FNO like ? or a.FSIGNID like ? or a.FMODE like ? "
					+ " or a.FRESPONSEPSNNAME like ? or a.FRESPONSEDEPTFNAME like ? ) "
					+ " order by a.fassetconfirm asc ";
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr, page, 
					FASSETCONFIRM, fuzzySearch, fuzzySearch, fuzzySearch, fuzzySearch, fuzzySearch);
			log.info("执行sql语句:" + sqlStr);

			if (dataList.size() > 0) {
				dtbHelper.setRstData("rows", dataList);
				dtbHelper.setRstData("total", page.getTotalCount());
			} else {
				dtbHelper.setError("depmg-err-s", "[数据库显示失败!]");
				DBAccessPool.releaseDbBean();
				return 0;
			}
		} catch (Exception e) {
			log.error("数据库访问异常!", e);
			dtbHelper.setError("depmg-err-s", "[数据库访问异常!]");
		} finally {
			DBAccessPool.releaseDbBean();
		}
		return 0;
	}

	protected int bill(DTBHelper dtbHelper) throws BizActionException {
		int flag = 0;
		try {
			int start = Integer.valueOf(dtbHelper.getStringValue("start"));
			int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
			String fuzzySearch = "%" + dtbHelper.getStringValue("fuzzySearch1") + "%";
			String fid = dtbHelper.getStringValue("fid");
			log.info("fid:" + fid);
			log.info("fuzzySeaerch:" + fuzzySearch);
			String sqlStr = "select b.fp_num,b.fmtype,b.frate,b.fcurrency,"
					+ "to_char(b.fp_date,'yyyy-mm-dd'),b.fp_money,"
					+ "b.fpeople,b.fchecked,b.fprovider,b.fcreatepsnname,"
					+ "b.fremark,b.bdown "
					+ " from asset_bill b,oa_as_ab c  "
					+ " where 1=1 "
					+ " and b.fid = c.fbillid "
					+ " and c.fassetid = ? "
					+ " and (b.fp_num like ? or b.fpeople like ? or b.fprovider like ? "
					+ " or b.fcreatepsnname like ? or b.fchecked like ? ) ";
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr, page , 
					fid, fuzzySearch, fuzzySearch, fuzzySearch, fuzzySearch, fuzzySearch);
			log.info("执行sql语句:" + sqlStr);

			if (dataList.size() > 0) {
				dtbHelper.setRstData("rows", dataList);
				dtbHelper.setRstData("total", page.getTotalCount());
			} else {
				dtbHelper.setError("depmg-err-s", "[数据库显示失败!]");
				DBAccessPool.releaseDbBean();
				return 0;
			}
		} catch (Exception e) {
			log.error("数据库访问异常!", e);
			dtbHelper.setError("depmg-err-s", "[数据库访问异常!]");
		} finally {
			DBAccessPool.releaseDbBean();
		}
		return flag;
	}

	protected int confirm(DTBHelper dtbHelper) throws BizActionException {
		log.info("-------update资产确认状态Confirm-------" + dtbHelper);
		int flag = 0;
		DBAccessBean dbBean = null;
		try {
			dbBean = DBAccessPool.getDbBean();
			dbBean.setAutoCommit(false);
			String fid = dtbHelper.getStringValue("fid");
			log.info("------------fid:" + fid);
			String psnid = dtbHelper.getStringValue("userInfo.ACCT_ID");
			String psnnm = dtbHelper.getStringValue("userInfo.ACCT_NM");
			String orgid = dtbHelper.getStringValue("userInfo.ORG_ID");
			String fdate = DateUtil.getCurrentDate("yyyyMMdd");
			
			String sqlOrg="select ORG_NM from SYS_ORG where ORG_ID = '"+orgid+"'";
			log.info("执行sql语句:" + sqlOrg);
			DataObject data = dbBean.executeSingleQuery(sqlOrg);
			String orgnm = data.getValue("org_nm");
			log.info("ORG_NM:"+orgnm);
			
			String sqlStr = "update OA_AS_INM set "
					+ " FASSETCONFIRM = '已确认', "
					+ " FUPDATEPSNID = ?,FUPDATEPSNNAME = ?,"
					+ " FUPDATETIME = to_date(?,'yyyy-mm-dd'), "
					+ " FCHECKDEPTID=?,FCHECKDEPT=?,FCHECKPSNID=?,FCHECKPSN=?,"
					+ " FCHECKDATE = to_date(?,'yyyy-mm-dd') "
					+ " where FID = ? ";
			dbBean.executeUpdate(sqlStr, psnid, psnnm, fdate, 
							orgid, orgnm, psnid, psnnm, fdate, fid);
			
			String sqlCard = "update OA_AS_CARD set "
					+ " FASSETCONFIRM = '已确认', "
					+ " FUPDATEPSNID = ?,FUPDATEPSNNAME = ?,"
					+ " FUPDATETIME = to_date(?,'yyyy-mm-dd'), "
					+ " FCONFIRMDATE = to_date(?,'yyyy-mm-dd') "
					+ " where FASSETINID = ? ";
			dbBean.executeUpdate(sqlCard, psnid, psnnm, fdate, fdate, fid);
			dbBean.executeCommit();
			flag = 1;
		} catch (Exception e) {
			log.error("资产确认出错", e);
			dtbHelper.setError("usermg-err-add-002",
					"[资产确认出错]" + e.getMessage());
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
