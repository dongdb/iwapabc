package com.nantian.iwap.app.action.system.storage;

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

public class InsertStorageAction extends TransactionBizAction {
	private static Logger logger = Logger.getLogger(InsertStorageAction.class);

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
		if ("addInd".equals(option)) {
			return addInd(dtbHelper);
		}
		if ("addInm".equals(option)) {
			return addInm(dtbHelper);
		}
		if ("init".equals(option)) {
			return init(dtbHelper);
		}
		if ("place".equals(option)) {
			return place(dtbHelper);
		}
		if ("contract".equals(option)) {
			return contract(dtbHelper);
		}
		if ("budget".equals(option)) {
			return budget(dtbHelper);
		}
		if ("budgetd".equals(option)) {
			return budgetd(dtbHelper);
		}
		return 0;
	}

	protected int query(DTBHelper dtbHelper) throws BizActionException {
		try {
			int start = Integer.valueOf(dtbHelper.getStringValue("start"));
			int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
			String fuzzySearch = "%" + dtbHelper.getStringValue("fuzzySearch")
					+ "%";
			String sqlStr = "select distinct fid,fp_num,"
					+ "to_char(fp_date,'yyyy-mm-dd') fp_date,"
					+ "fp_money,fmtype,fprovider,fpeople,"
					+ "fchecked,fcreatepsnname,"
					+ "frate,fcurrency,fremark,bdown "
					+ " from asset_bill "
					+ " where 1=1 "
					+ " and (fp_num like ? or fmtype like ? or fprovider like ? "
					+ " or fpeople like ? or fchecked like ? or fcreatepsnname like ? ) "
					+ " order by fp_date desc";
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr,
					page, fuzzySearch, fuzzySearch, fuzzySearch, fuzzySearch,
					fuzzySearch, fuzzySearch);
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
		return 0;
	}

	protected int init(DTBHelper dtbHelper) throws BizActionException {
		try {
			String ZCRK = "ZCRK";
			String date = DateUtil.getCurrentDate("yyyyMMdd");
			ZCRK += date;
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			String sql = "select zcrk_seq.nextval seq from dual ";
			DataObject data = dbBean.executeSingleQuery(sql);
			String seq = data.getValue("seq");
			int length = 6;
			while (seq.length() < length) {
				seq = "0" + seq;
			}
			ZCRK += seq;
			logger.info("入库单号：" + ZCRK);
			dtbHelper.setRstData("ZCRK", ZCRK);
		} catch (Exception e) {
			logger.error("数据库访问异常!", e);
			dtbHelper.setError("depmg-err-s", "[数据库访问异常!]");
		} finally {
			DBAccessPool.releaseDbBean();
		}
		return 0;
	}

	protected int addInd(DTBHelper dtbHelper) throws BizActionException {
		logger.info("-------add-------" + dtbHelper);
		int flag = 0;
		DBAccessBean dbBean = null;
		try {
			dbBean = DBAccessPool.getDbBean();
			dbBean.setAutoCommit(false);
			String date = DateUtil.getCurrentDate("yyyyMMdd");
			UUID uuid = UUID.randomUUID();
			String fid = uuid.toString().replaceAll("-", "");
			String name = dtbHelper.getStringValue("name");
			String fno = dtbHelper.getStringValue("FNO");
			String kind = dtbHelper.getStringValue("kind");
			String kindno = dtbHelper.getStringValue("kindno");
			String sname = dtbHelper.getStringValue("sname");
			String zcsl = dtbHelper.getStringValue("zcsl");
			String price = dtbHelper.getStringValue("price");
			String currency = dtbHelper.getStringValue("currency");
			String isfa = dtbHelper.getStringValue("isfa");
			String spectype = dtbHelper.getStringValue("spectype");
			String usetype = dtbHelper.getStringValue("usetype");
			String factory = dtbHelper.getStringValue("factory");
			String fdate = dtbHelper.getStringValue("fdate")
					.replaceAll("-", "");
			String bdate = dtbHelper.getStringValue("bdate")
					.replaceAll("-", "");
			String warn = dtbHelper.getStringValue("warn");
			String wdate = dtbHelper.getStringValue("wdate")
					.replaceAll("-", "");
			String unit = dtbHelper.getStringValue("unit");
			String detailInfo = dtbHelper.getStringValue("detailInfo");
			String budget = dtbHelper.getStringValue("budget");
			String remark = dtbHelper.getStringValue("remark");
			String PSNID = dtbHelper.getStringValue("userInfo.ACCT_ID");
			String PSNNM = dtbHelper.getStringValue("userInfo.ACCT_NM");

			String sqlFid = "select * from oa_as_inm where fno= ? ";
			DataObject data = dbBean.executeSingleQuery(sqlFid, fno);
			String fid1 = data.getValue("fid");
			String fzwz = data.getValue("ffzwz");
			String sign = data.getValue("fsignid");
			String source = data.getValue("fmode");
			String create = data.getValue("fcreatetime");
			if (create != "") {
				create = create.replaceAll("-", "").substring(0, 8);
			}
			String sqlSource = "select fid from oa_pub_basecode where fscope='资产入库类型' and fname= '"
					+ source + "'";
			DataObject dataSource = dbBean.executeSingleQuery(sqlSource);
			String sourceid = dataSource.getValue("fid");
			String sqlStr = "insert into OA_AS_IND(FID,VERSION,FMASTERID,FNAME,FKIND,FSIMPLENAME,"
					+ "FZCSL,FPRICE,FCURRENCY,FCURRENCYCODE,FISFA,FSPECTYPE,FUSETYPE,FUSETYPEID,"
					+ "FFACTORY,FFACTORYDATE,FBUYDATE,FWARRANTYMONTH,FWARRANTYDATE,"
					+ "FUNIT,FDETAILINFO,FBUDGET,FREMARK) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,"
					+ "to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),?,"
					+ "to_date(?,'yyyy-mm-dd'),?,?,?,?)";
			dbBean.executeUpdate(sqlStr, fid, 0, fid1, name, kind, sname, zcsl,
					price, currency, "CNY", isfa, spectype, usetype, usetype,
					factory, fdate, bdate, warn, wdate, unit, detailInfo,
					budget, remark);
			/*
			 * FCODE FBARCODE 自增长表 FKINDID FKIND 下拉列表选择 FBGDEPREDATE 开始折旧日期
			 * FBGDEPRE 折旧年限 FADDDEPREVALUE 累计折旧 FCHECKED 是否导入财务 FCONTRACTID
			 * FCONTRACT 下拉列表选择 FSUPPLIER 根据合同编号查出 FSOURCE FSOURCENAME 资产来源
			 * FCONFIRMDATE 资产确认日期 FEXTENDSTR1 FEXTENDSTR2 FEXTENDSTR3
			 * 房间ID、放置位置、楼座ID FISDEPT资产使用类型FROOMID FROOM库房ID库房 FARRANGEDATE安排日期
			 * FIMPORTFADATE 财务导入时间 ERPCODE FPROJECTID FDUTYOGNID FDUTYOGNNAME
			 * FDUTYOGNFID FDUTYDEPTID FDUTYDEPTNAME FDUTYDEPTFID FDUTYDEPTFNAME
			 * FDUTYPOSID FDUTYPOSNAME FDUTYPSNID FDUTYPSNNAME FDUTYPSNFID
			 * FDUTYPSNFNAME FCREATEOGNID FCREATEOGNNAME FCREATEDEPTID
			 * FCREATEDEPTNAME FCREATEPOSID FCREATEPOSNAME FCREATEPSNFID
			 * FCREATEPSNFNAME FRESPONSEOGNNAME FRESPONSEOGNID FRESPONSEDEPTNAME
			 * FRESPONSEDEPTID FRESPONSEDEPTFNAME FRESPONSEDEPTFID
			 * FRESPONSEPSNNAME FRESPONSEPSNID FRESPONSEPSNFNAME FRESPONSEPSNFID
			 * FPHOTO 图片 FLIMITDATE 使用/截止日期 FCODESIGN 条码标注 FPARENTASSET
			 * ADMINDEPT ADMINDEPTID FCURRENCYCODE FCURRENCY FBUDGETID
			 */

			String ORGID = dtbHelper.getStringValue("userInfo.ORG_ID");
			String tFCODE = ORGID + kindno;
			String sqlSEQ = "select max(fcode) fcode from oa_as_card where fcode like '%"
					+ tFCODE + "%'";
			DataObject seqData = dbBean.executeSingleQuery(sqlSEQ);
			String FCODE = seqData.getValue("fcode");
			if (FCODE == null) {
				FCODE = tFCODE + "00001";
			} else {
				//取后五位+1
				String num = FCODE.substring(FCODE.length()-5,FCODE.length());
				FCODE = "" + (Integer.parseInt(num) + 1);
				int length = 5;
				while (FCODE.length() < length){
					FCODE = "0" + FCODE;
				}
				FCODE = tFCODE+FCODE;
			}
			logger.info("-------addAsset-------" + dtbHelper);
			//新增资产卡片 （资产数量）条数据
			for (int i = 0; i < Integer.parseInt(zcsl); i++) {
				UUID uuid2 = UUID.randomUUID();
				String fid2 = uuid2.toString().replaceAll("-", "");
				String sqlStr1 = "insert into OA_AS_CARD(FID,VERSION,FCODE,FBARCODE,FASSETINID,FASSETINNO,FNAME,FKIND,FSIMPLENAME,"
						+ "FISFA,FSPECTYPE,FUSETYPE,FUSETYPEID,FFACTORY,FFACTORYDATE,FBUYDATE,FWARRANTYMONTH,"
						+ "FWARRANTYDATE,FUNIT,FDETAILINFO,FBUDGET,FREMARK,FCREATEPSNID,FCREATEPSNNAME,"
						+ "FUPDATEPSNID,FUPDATEPSNNAME,FSTATUS,FSTATUSNAME,FORIGINVALUE,FREMAINVALUE,"
						+ "FEXTENDSTR2，FSIGNID,FCREATETIME,FUPDATETIME,FINDETAILID,"
						+ "FASSETCONFIRM,FCHECKED，FSOURCE,FSOURCENAME) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,"
						+ "to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),?,"
						+ "to_date(?,'yyyy-mm-dd'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,"
						+ "to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),?,?,?,?,?)";
				dbBean.executeUpdate(sqlStr1, fid2, 0, FCODE, FCODE, fid1, fno,
						name, kind, sname, isfa, spectype, usetype, usetype,
						factory, fdate, bdate, warn, wdate, unit, detailInfo,
						budget, remark, PSNID, PSNNM, PSNID, PSNNM, 0, "闲置",
						price, price, fzwz, sign, create, date, fid, "未确认",
						"否", source, sourceid);
				//FCODE递增
				String num = FCODE.substring(FCODE.length()-5,FCODE.length());
				FCODE = "" + (Integer.parseInt(num) + 1);
				int length = 5;
				while (FCODE.length() < length){
					FCODE = "0" + FCODE;
				}
				FCODE = tFCODE+FCODE;
				// 增加发票关联 1-->N
				String list = dtbHelper.getStringValue("billFID");
				String[] billFID = list.split(",");
				for (String id : billFID) {
					UUID uuid1 = UUID.randomUUID();
					String FID1 = uuid1.toString().replaceAll("-", "");
					if (id.length() > 10) {
						id = id.substring(1, 32);
						logger.info("=========" + id);
						String sql = "insert into OA_AS_CARDBILL(FID,VERSION,FCODE,FBILLID) values (?,?,?,?)";
						dbBean.executeUpdate(sql, FID1, 0, fid2, id);
					}
				}
			}
			dbBean.executeCommit();
			flag = 1;
		} catch (Exception e) {
			logger.error("资产新增出错", e);
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

	protected int addInm(DTBHelper dtbHelper) throws BizActionException {
		/* 新增入库单 */
		logger.info("-------add入库方式InM-------" + dtbHelper);
		int flag = 0;
		DBAccessBean dbBean = null;
		try {
			dbBean = DBAccessPool.getDbBean();
			dbBean.setAutoCommit(false);
			UUID uuid = UUID.randomUUID();
			String FID = uuid.toString().replaceAll("-", "");
			String FNO = dtbHelper.getStringValue("FNO");
			String FDATE = DateUtil.getCurrentDate("yyyyMMdd");
			String FMODE = dtbHelper.getStringValue("FMODE");
			String sqlFNAME = "select fname from OA_PUB_BASECODE where "
					+ "FSCOPE ='资产入库类型' and fsequence = '" + FMODE + "'";
			DataObject data = dbBean.executeSingleQuery(sqlFNAME);
			String FNAME = data.getValue("fname");
			String sqlSource = "select fid from oa_pub_basecode where fscope='资产入库类型' and fname= '"
					+ FNAME + "'";
			DataObject dataSource = dbBean.executeSingleQuery(sqlSource);
			String FMODEID = dataSource.getValue("fid");
			String FCREATETIME = dtbHelper.getStringValue("FCREATETIME")
					.replaceAll("-", "");
			String FRESPONSEDEPTNAME = dtbHelper
					.getStringValue("FRESPONSEDEPTNAME");
			String FRESPONSEPSNNAME = dtbHelper
					.getStringValue("FRESPONSEPSNNAME");
			String FSIGNID = dtbHelper.getStringValue("FSIGNID");
			String FAMOUNT = dtbHelper.getStringValue("FAMOUNT");
			String FFZWZ = dtbHelper.getStringValue("FFZWZ");
			String FCONTRACT = dtbHelper.getStringValue("FCONTRACT");
			String FSUPPLIER = dtbHelper.getStringValue("FSUPPLIER");
			String FREMARK = dtbHelper.getStringValue("FREMARK");
			String FBUDGETNO = dtbHelper.getStringValue("FBUDGETNO");
			String PSNID = dtbHelper.getStringValue("userInfo.ACCT_ID");
			String PSNNM = dtbHelper.getStringValue("userInfo.ACCT_NM");
			String sqlStr = "insert into OA_AS_INM(FID,VERSION,FNO,FDATE,FMODE,FMODEID,FCREATETIME,"
					+ "FRESPONSEDEPTNAME,FRESPONSEPSNNAME,FSIGNID,FAMOUNT,FFZWZ,"
					+ "FCONTRACT,FSUPPLIER,FREMARK,FBUDGETNO,"
					+ "FASSETCONFIRM,FSTATE,FSTATENAME,FOUTSTATE,"
					+ "FCREATEPSNID,FCREATEPSNNAME) values (?,?,?,"
					+ "to_date(?,'yyyy-mm-dd'),?,?,to_date(?,'yyyy-mm-dd'),?,?,?,?,?,?,?,?,?,?,"
					+ "?,?,?,?,?)";
			dbBean.executeUpdate(sqlStr, FID, 0, FNO, FDATE, FNAME, FMODEID,
					FCREATETIME, FRESPONSEDEPTNAME, FRESPONSEPSNNAME, FSIGNID,
					FAMOUNT, FFZWZ, FCONTRACT, FSUPPLIER, FREMARK, FBUDGETNO,
					"未确认", "0", "未入库", "未出库", PSNID, PSNNM);

			String list = dtbHelper.getStringValue("billFID");
			String[] billFID = list.split(",");
			for (String id : billFID) {
				UUID uuid1 = UUID.randomUUID();
				String FID1 = uuid1.toString().replaceAll("-", "");
				if (id.length() > 10) {
					id = id.substring(1, 33);
					logger.info("=========" + id);
					String sql = "insert into OA_AS_AB(FID,VERSION,FASSETID,FBILLID) values (?,?,?,?)";
					dbBean.executeUpdate(sql, FID1, 0, FID, id);
				}
			}

			dbBean.executeCommit();
			flag = 1;
		} catch (Exception e) {
			logger.error("资产新增出错", e);
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

	protected int place(DTBHelper dtbHelper) {
		logger.info("-------place-------" + dtbHelper);
		int flag = 0;
		DBAccessBean dbBean = null;
		int start = Integer.valueOf(dtbHelper.getStringValue("start"));
		int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
		String fuzzysearch = "%" + dtbHelper.getStringValue("fuzzysearch")
				+ "%";
		logger.info("fuzzysearch:" + fuzzysearch);
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
			List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr,
					page, fuzzysearch, fuzzysearch, fuzzysearch, fuzzysearch,
					fuzzysearch, fuzzysearch);
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

	protected int contract(DTBHelper dtbHelper) {
		logger.info("-------contract-------" + dtbHelper);
		int flag = 0;
		DBAccessBean dbBean = null;
		int start = Integer.valueOf(dtbHelper.getStringValue("start"));
		int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
		String fuzzysearch = "%" + dtbHelper.getStringValue("fuzzysearch1")
				+ "%";
		logger.info("fuzzysearch1:" + fuzzysearch);
		try {
			dbBean = DBAccessPool.getDbBean();
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			String sqlStr = "select a.fid,a.contractid,a.ctitle,"
					+ "to_char(a.cdate,'yyyy-mm-dd') cdate,"
					+ "b.fpaystate,a.cmoney,a.fprovider "
					+ "from asset_contract a,asset_contractpay b "
					+ "where 1=1 " + "and b.contractfid = a.fid "
					+ "and (a.contractid like ? or a.ctitle like ? "
					+ " or a.fprovider like ?  or b.fpaystate like ?) ";
			logger.info("执行sql语句:" + sqlStr);
			List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr,
					page, fuzzysearch, fuzzysearch, fuzzysearch, fuzzysearch);

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
			logger.error("合同列表查询出错", e);
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

	protected int budget(DTBHelper dtbHelper) {
		logger.info("-------budget-------" + dtbHelper);
		int flag = 0;
		DBAccessBean dbBean = null;
		int start = Integer.valueOf(dtbHelper.getStringValue("start"));
		int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
		String fuzzysearch = "%" + dtbHelper.getStringValue("fuzzysearch2")
				+ "%";
		logger.info("fuzzysearch2:" + fuzzysearch);
		try {
			dbBean = DBAccessPool.getDbBean();
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			String sqlStr = "select fid,fbudgetno,fdepartmentname,fbudgetamount,"
					+ "to_char(fbudgetdate,'yyyy-mm-dd') fbudgetdate,"
					+ "fcreatepersonname "
					+ "from oa_as_budgetm "
					+ "where 1=1 "
					+ "and (fbudgetno like ? or fdepartmentname like ? "
					+ " or fcreatepersonname like ?  or fbudgetamount like ?) ";
			logger.info("执行sql语句:" + sqlStr);
			List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr,
					page, fuzzysearch, fuzzysearch, fuzzysearch, fuzzysearch);

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
			logger.error("动支单列表查询出错", e);
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

	protected int budgetd(DTBHelper dtbHelper) {
		logger.info("-------budgetd-------" + dtbHelper);
		String fbudgetno = dtbHelper.getStringValue("FBUDGETNO");
		int flag = 0;
		DBAccessBean dbBean = null;
		int start = Integer.valueOf(dtbHelper.getStringValue("start"));
		int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
		try {
			dbBean = DBAccessPool.getDbBean();
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			String sqlStr = "select fid,FBUDGETNAME,FBUDGETMONEY "
					+ "from oa_as_budgetd a " + "where a.FMAINBUDGETNO= ? ";
			logger.info("执行sql语句:" + sqlStr);
			List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr,
					page, fbudgetno);

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
			logger.error("动支单列表查询出错", e);
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

}
