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

public class ManageStorageAction extends TransactionBizAction {
	private static Logger logger = Logger.getLogger(ManageStorageAction.class);
	private String encryptClazz = "com.nantian.iwap.app.util.DefaultEncrypt";// 默认加密方式

	public int actionExecute(DTBHelper dtbHelper) throws BizActionException {
		String option = dtbHelper.getStringValue("option");
		if (StringUtil.isBlank(option)) {
			return query(dtbHelper);
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
		if ("asset".equals(option)) {
			return asset(dtbHelper);
		}
		if ("bill".equals(option)) {
			return bill(dtbHelper);
		}
		return 0;
	}

	protected int query(DTBHelper dtbHelper) {
		logger.info("-------query-------" + dtbHelper);
		int flag = 0;
		DBAccessBean dbBean = null;
		int start = Integer.valueOf(dtbHelper.getStringValue("start"));
		int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
		String mode = "%" + dtbHelper.getStringValue("mode") + "%";
		String statename = "%" + dtbHelper.getStringValue("statename") + "%";
		String fuzzySearch = "%" + dtbHelper.getStringValue("fuzzySearch")
				+ "%";
		String createtime = dtbHelper.getStringValue("createtime");
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
		try {
			dbBean = DBAccessPool.getDbBean();
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			// String remark = dtbHelper.getStringValue("remark");

			String sqlStr = "select FID,FSTATENAME,FNO,to_char(FDATE,'yyyy-mm-dd') FDATE,"
					+ "FAMOUNT,FMODE,FCREATEPSNNAME,FREMARK,"
					+ "substr(fcreatedeptname,instr(fcreatedeptname,'/',-1,1)+1) fcreatedeptname "
					+ " from OA_AS_INM "
					+ " where 1=1 "
					+ str
					+ " and FMODE like ? and FSTATE like ? "
					+ " and (FMODE like ? or FNO like ? or FSTATENAME like ? "
					+ " or FCREATEDEPTNAME like ? or FREMARK like ? or FCREATEPSNNAME like ?) ";
			logger.info("执行sql语句:" + sqlStr);
			List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr,
					page, mode, statename, fuzzySearch, fuzzySearch,
					fuzzySearch, fuzzySearch, fuzzySearch, fuzzySearch);

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
			dtbHelper.setError("usermg-err-add-002",
					"[资产新增出错]" + e.getMessage());
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

	public int show(DTBHelper dtbHelper) throws BizActionException {
		String fno = dtbHelper.getStringValue("fno");
		String fstatename = dtbHelper.getStringValue("fstatename");
		logger.info("------------fno:" + fno);
		String sqlStr = "";
		if ("已入库".equals(fstatename)) {
			sqlStr = "select distinct b.FNO,b.FRESPONSEDEPTID,b.FRESPONSEDEPTNAME,"
					+ "b.FRESPONSEPSNID,b.FRESPONSEPSNNAME,b.FSIGNID,b.FMODE,"
					+ "TO_CHAR(a.FCREATETIME,'yyyy-mm-dd') AS FCREATETIME,"
					+ "b.FAMOUNT,a.FEXTENDSTR2,b.FCONTRACT,b.FSUPPLIER,"
					+ "b.FREMARK from OA_AS_CARD a,OA_AS_INM b"
					+ " where a.FASSETINNO=b.FNO" 
					+ " and b.FNO='" + fno + "'";
		} else {
			sqlStr = "select distinct FNO,FRESPONSEDEPTID,FRESPONSEDEPTNAME,FRESPONSEPSNID,FRESPONSEPSNNAME,"
					+ "FSIGNID,FMODE,FAMOUNT,FFZWZ,FCONTRACT,FSUPPLIER,FREMARK "
					+ "from OA_AS_INM "
					+ " where FNO='" + fno + "'";
		}
		if (!fno.equals("")) {
			try {
				DBAccessBean dbBean = DBAccessPool.getDbBean();
				List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr);
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
	
	public int asset(DTBHelper dtbHelper) throws BizActionException {
		String fid = dtbHelper.getStringValue("fid");
		//String fstatename = dtbHelper.getStringValue("fstatename");
		logger.info("------------fid:" + fid);
		int start = Integer.valueOf(dtbHelper.getStringValue("start"));
		int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
		String sqlStr = "select distinct b.FKIND,b.FNAME,b.FSPECTYPE,"
					+ "b.FZCSL,b.FISFA,b.FREMARK,b.FUSETYPE,b.FPRICE "
					+ "from oa_as_inm a,oa_as_ind b "
					+ "where a.FID = b.FMASTERID " 
					+ " and a.FID='" + fid + "'";
		if (!fid.equals("")) {
			try {
				DBAccessBean dbBean = DBAccessPool.getDbBean();
				PaginationSupport page = new PaginationSupport(start, limit, limit);
				List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr,page);
				logger.info("执行sql语句:" + sqlStr);
				if (dataList.size() > 0) {
					dtbHelper.setRstData("rows", dataList);
					//dtbHelper.setRstData("total", page.getTotalCount());
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
	
	public int bill(DTBHelper dtbHelper) throws BizActionException {
		String fid = dtbHelper.getStringValue("fid");
		logger.info("------------fid:" + fid);
		int start = Integer.valueOf(dtbHelper.getStringValue("start"));
		int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
		String sqlStr = "select distinct b.FP_NUM,b.FP_MONEY,b.FMTYPE,"
				+ "to_char(FP_DATE,'yyyy-mm-dd') FP_DATE,"
				+ "b.FPEOPLE,b.FPROVIDER,b.FRATE,b.FCURRENCY "
				+ "from oa_as_inm a,asset_bill b,oa_as_ab c "
				+ "where a.FID = c.FASSETID and b.FID = c.FBILLID " 
				+ " and a.FID='" + fid + "'";
		if (!fid.equals("")) {
			try {
				DBAccessBean dbBean = DBAccessPool.getDbBean();
				PaginationSupport page = new PaginationSupport(start, limit, limit);
				List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr,page);
				logger.info("执行sql语句:" + sqlStr);
				if (dataList.size() > 0) {
					dtbHelper.setRstData("rows", dataList);
					//dtbHelper.setRstData("total", page.getTotalCount());
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
