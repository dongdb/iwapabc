package com.nantian.iwap.action.pub;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.log4j.Logger;

import com.nantian.iwap.action.common.CRUDAction;
import com.nantian.iwap.biz.actions.TransactionBizAction;
import com.nantian.iwap.biz.flow.BizActionException;
import com.nantian.iwap.common.util.DateUtil;
import com.nantian.iwap.common.util.StringUtil;
import com.nantian.iwap.app.common.PubAction;
import com.nantian.iwap.databus.DTBHelper;
import com.nantian.iwap.persistence.DBAccessBean;
import com.nantian.iwap.persistence.DBAccessPool;
import com.nantian.iwap.persistence.DataObject;
import com.nantian.iwap.persistence.PaginationSupport;

public class AssetDetailAction extends TransactionBizAction {
	private static Logger logger = Logger.getLogger(AssetDetailAction.class);

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
		if ("use".equals(option)) {
			return use(dtbHelper);
		}
		if ("account".equals(option)) {
			return account(dtbHelper);
		}
		if ("repair".equals(option)) {
			return repair(dtbHelper);
		}

		if ("bill".equals(option)) {
			return bill(dtbHelper);
		}
		
		if ("place".equals(option)) {
			return place(dtbHelper);
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
				  + "b.FREMARK,b.FPRICE,b.FZCSL,b.FISFA from OA_AS_CARD a,OA_AS_INM b"
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
		logger.info("-------update保存修改资产卡片-------" + dtbHelper);
		int flag = 0;
		DBAccessBean dbBean = null;
		try {
			dbBean = DBAccessPool.getDbBean();
			dbBean.setAutoCommit(false);
			String date = DateUtil.getCurrentDate("yyyyMMdd");
			String fid = dtbHelper.getStringValue("fid");
			String usetype = dtbHelper.getStringValue("FUSETYPE");//财务大类
			String kind = dtbHelper.getStringValue("FKIND");
			String sname = dtbHelper.getStringValue("FSIMPLENAME");
			String name = dtbHelper.getStringValue("FNAME");
			String spectype = dtbHelper.getStringValue("FSPECTYPE");
			String currency = dtbHelper.getStringValue("FCURRENCY");
			String isfa = dtbHelper.getStringValue("FISFA");
			String redept = dtbHelper.getStringValue("FRESPONSEDEPTNAME");
			String repsn = dtbHelper.getStringValue("FRESPONSEPSNNAME");
			String facdate = dtbHelper.getStringValue("FFACTORYDATE");
			String buydate = dtbHelper.getStringValue("FBUYDATE");
			String warn = dtbHelper.getStringValue("FWARRANTYMONTH");
			String wdate = dtbHelper.getStringValue("FWARRANTYDATE");
			String admindept = dtbHelper.getStringValue("ADMINDEPT");
			String fzwz = dtbHelper.getStringValue("FEXTENDSTR2");
			String detailInfo = dtbHelper.getStringValue("FDETAILINFO");
			String remark = dtbHelper.getStringValue("FREMARK");
			String factory = dtbHelper.getStringValue("FFACTORY");
			String PSNID = dtbHelper.getStringValue("userInfo.ACCT_ID");
			String PSNNM = dtbHelper.getStringValue("userInfo.ACCT_NM");
			
			String sqlStr = "update OA_AS_CARD set "
					+ "FNAME = ?,FKIND = ?,FSIMPLENAME = ?,FISFA = ?,"
					+ "FSPECTYPE = ?,FUSETYPEID = ?,FUSETYPE = ?,FFACTORY = ?,"
					+ "FFACTORYDATE = to_date(?,'yyyy-mm-dd'),"
					+ "FBUYDATE = to_date(?,'yyyy-mm-dd'),FWARRANTYMONTH = ?,"
					+ "FWARRANTYDATE = to_date(?,'yyyy-mm-dd'),"
					+ "FDETAILINFO = ?,FREMARK = ?,FUPDATEPSNID = ?,FUPDATEPSNNAME = ?,"
					+ "FEXTENDSTR2 = ?,FCURRENCY = ?,FRESPONSEDEPTNAME = ?,FRESPONSEPSNNAME = ?,"
					+ "ADMINDEPT = ?,FUPDATETIME = to_date(?,'yyyy-mm-dd') "
					+ " where FID = ?";
			dbBean.executeUpdate(sqlStr, name, kind, sname,isfa, 
					spectype, usetype, usetype, factory, 
					facdate,buydate, warn, wdate, 
					detailInfo, remark,PSNID, PSNNM, fzwz, 
					currency, redept, repsn, admindept, date, fid);
			
			dbBean.executeCommit();
			flag = 1;
		} catch (Exception e) {
			logger.error("资产保存出错", e);
			dtbHelper.setError("usermg-err-add-002",
					"[资产保存出错]" + e.getMessage());
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

	protected int remove(DTBHelper dtbHelper) {

		return 0;
	}

	public int show(DTBHelper dtbHelper) throws BizActionException {
		// TODO Auto-generated method stub
		String asset_id = dtbHelper.getStringValue("deptid");
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
				+ "TO_CHAR(FBGDEPREDATE,'yyyy-mm-dd') AS FBGDEPREDATE from OA_AS_CARD where FCODE="
				+ asset_id;
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

	protected int use(DTBHelper dtbHelper) throws BizActionException {
		String fcode = dtbHelper.getStringValue("fcode");
		logger.info("------------fcode:" + fcode);
		String sqlStr = "select b.FISDEPT as A, "
				+ "to_char(b.FBEGINDATE,'yyyy-mm-dd') as B,"
				+ "to_char(b.FENDDATE,'yyyy-mm-dd') as C,"
				+ "b.FDUTYDEPTFNAME as D,b.FDUTYPSNNAME as E,"
				+ "b.FRESPONSEDEPTFNAME as F,b.FRESPONSEPSNNAME as G,"
				+ "a.FEXTENDSTR2 as H,b.FREMARK as I"
				+ " from oa_as_userecord b,oa_as_card a"
				+ " where a.fid=b.fassetid and a.fid='" + fcode + "'";
		if (!fcode.equals("")) {
			logger.info("------------sqlStr:" + sqlStr);
			try {
				DBAccessBean dbBean = DBAccessPool.getDbBean();
				PaginationSupport page = new PaginationSupport(0, 100, 100);
				List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr,page);
				
				logger.info("执行sql语句:" + sqlStr);

				if (dataList.size() > 0) {
					dtbHelper.setRstData("rows", dataList);
					dtbHelper.setRstData("total", page.getTotalCount());
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

	protected int repair(DTBHelper dtbHelper) throws BizActionException {
		String fbarcode = dtbHelper.getStringValue("fcode");
		logger.info("------------fbarcode:" + fbarcode);
		String sqlStr = "select b.REPAIRNO,b.REPAIRTYPELABEL,b.REPAIRAMOUNT,"
				+ "to_char(b.DELIVERDATE,'yyyy-mm-dd') DELIVERDATE,"
				+ "to_char(b.RETURNDATE,'yyyy-mm-dd') RETURNDATE,"
				+ "b.HANDLEPSNNAME,b.REMARK"
				+ " from oa_as_card a,oa_asset_repair_parent b"
				+ " where a.FBARCODE=b.ASSETBARCODE and a.FBARCODE='" + fbarcode + "'";
		if (!fbarcode.equals("")) {
			logger.info("------------sqlStr:" + sqlStr);
			try {
				DBAccessBean dbBean = DBAccessPool.getDbBean();
				PaginationSupport page = new PaginationSupport(0, 100, 100);
				List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr,page);
				
				logger.info("执行sql语句:" + sqlStr);

				if (dataList.size() > 0) {
					dtbHelper.setRstData("rows", dataList);
					dtbHelper.setRstData("total", page.getTotalCount());
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

	protected int account(DTBHelper dtbHelper) throws BizActionException {
		String fbarcode = dtbHelper.getStringValue("fcode");
		logger.info("------------fbarcode:" + fbarcode);
		String sqlStr = "select b.STATUSLABEL,b.RESULTLABEL,"
				+ "to_char(b.SCANTIME,'yyyy-mm-dd') SCANTIME,"
				+ "b.REVISIONSTATUSLABEL,b.REVISIONUSER"
				+ " from oa_as_card a,oa_inventory_result b"
				+ " where a.FBARCODE=b.BARCODE and a.FBARCODE='" + fbarcode + "'";
		if (!fbarcode.equals("")) {
			logger.info("------------sqlStr:" + sqlStr);
			try {
				DBAccessBean dbBean = DBAccessPool.getDbBean();
				PaginationSupport page = new PaginationSupport(0, 100, 100);
				List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr,page);
				
				logger.info("执行sql语句:" + sqlStr);

				if (dataList.size() > 0) {
					dtbHelper.setRstData("rows", dataList);
					dtbHelper.setRstData("total", page.getTotalCount());
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

	protected int bill(DTBHelper dtbHelper) throws BizActionException {
		String fid = dtbHelper.getStringValue("fid");
		logger.info("------------fid:" + fid);
		String sqlStr = "select b.FP_NUM,b.FPEOPLE,b.FPROVIDER,"
				+ "to_char(b.FP_DATE,'yyyy-mm-dd') FP_DATE,"
				+ "b.FP_MONEY,b.FMTYPE,b.BDOWN"
				+ " from oa_as_card a,asset_bill b,oa_as_cardbill c"
				+ " where a.fid=c.fcode and b.fid=c.fbillid and a.fid='" + fid + "'";
		if (!fid.equals("")) {
			logger.info("------------sqlStr:" + sqlStr);
			try {
				DBAccessBean dbBean = DBAccessPool.getDbBean();
				PaginationSupport page = new PaginationSupport(0, 100, 100);
				List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr,page);
				
				logger.info("执行sql语句:" + sqlStr);

				if (dataList.size() > 0) {
					dtbHelper.setRstData("rows", dataList);
					dtbHelper.setRstData("total", page.getTotalCount());
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

	protected int place(DTBHelper dtbHelper) {
		logger.info("-------place-------"+dtbHelper);
		int flag = 0;
		DBAccessBean dbBean = null;
		int start = Integer.valueOf(dtbHelper.getStringValue("start"));
		int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
		String fuzzysearch = "%" + dtbHelper.getStringValue("fuzzysearch") + "%";
		logger.info("fuzzysearch:"+fuzzysearch);
		try {
			dbBean = DBAccessPool.getDbBean();
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			String sqlStr = "select FID,FJGMC,FLZMC,"
							+ "FJGLX,FJGWZ,FMJ,FSYJGNAME,FSYBMNAME "
							+ "from ASSET_FWDYJG where 1=1 "
							+ "and (FJGMC like ? or FLZMC like ? "
							+ " or FJGLX like ?  or FJGWZ like ? "
							+ " or FSYJGNAME like ?  or FSYBMNAME like ? )";
			logger.info("执行sql语句:" + sqlStr);
			List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr,page,
					fuzzysearch,fuzzysearch,fuzzysearch,fuzzysearch,fuzzysearch,fuzzysearch);
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

}
