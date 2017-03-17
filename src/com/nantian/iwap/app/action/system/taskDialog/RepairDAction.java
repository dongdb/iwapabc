package com.nantian.iwap.app.action.system.taskDialog;

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

public class RepairDAction extends TransactionBizAction {
	private static Logger logger = Logger.getLogger(RepairDAction.class);
	private String encryptClazz = "com.nantian.iwap.app.util.DefaultEncrypt";// 默认加密方式

	public int actionExecute(DTBHelper dtbHelper) throws BizActionException {
		String option = dtbHelper.getStringValue("option");
		if (StringUtil.isBlank(option)) {
			return query(dtbHelper);
		}
		if ("transfer".equals(option)) {
			return transfer(dtbHelper);
		}
		if ("init".equals(option)) {
			return init(dtbHelper);
		}
		return 0;
	}
	

	protected int init(DTBHelper dtbHelper) throws BizActionException {
		try {
			String sdata1 = dtbHelper.getStringValue("sdata1");
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			String sqlStr="select FID,REPAIRNO,ASSETBARCODE,ASSETNAME,"
					+ "CREATEPSNNAME,FAULTDESCN,ASSETSPEC,ASSETCOST "
					+ " from OA_ASSET_REPAIR_PARENT"
					+ " where FID = ? ";
			logger.info("执行sql语句:" + sqlStr);
			List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr,sdata1);

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
		return 0;
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

	public int transfer(DTBHelper dtbHelper) throws BizActionException {
		logger.info("-------add维修申请-------" + dtbHelper);
		int flag = 0;
		DBAccessBean dbBean = null;
		try {
			dbBean = DBAccessPool.getDbBean();
			dbBean.setAutoCommit(false);
			UUID uuid = UUID.randomUUID();
			String FID = uuid.toString().replaceAll("-", "");
			String reNo = dtbHelper.getStringValue("reNo");
			String CREATEDATETIME = DateUtil.getCurrentDate("yyyyMMdd");
			String PSNID = dtbHelper.getStringValue("userInfo.ACCT_ID");
			String PSNNM = dtbHelper.getStringValue("userInfo.ACCT_NM");
			String DEPTID = dtbHelper.getStringValue("userInfo.ORG_ID");
			String sqlDEPTnm = "select ORG_NM from SYS_ORG where ORG_ID = ? ";
			DataObject dataDEPT = dbBean.executeSingleQuery(sqlDEPTnm,DEPTID);
			String ORGNM = dataDEPT.getValue("org_nm");
			String FCODE = dtbHelper.getStringValue("FCODE");
			String sqlFID = "select FID from OA_AS_CARD where FCODE = ? ";
			DataObject dataFID = dbBean.executeSingleQuery(sqlFID,FCODE);
			String aFID = dataFID.getValue("fid");
			String FNAME = dtbHelper.getStringValue("FNAME");
			String FCOST = dtbHelper.getStringValue("FORIGINVALUE");
			String FSPEC = dtbHelper.getStringValue("FSPECTYPE");
			String FDESC = dtbHelper.getStringValue("fdesc");
			
			String sqlStr = "insert into OA_ASSET_REPAIR_PARENT(FID,VERSION,REPAIRNO,"
					+ "CREATEDATETIME,CREATEPSNNAME,CREATEPSNID,"
					+ "CREATEDEPTNAME,CREATEDEPTID,CREATEOGNNAME,CREATEOGNID,"
					+ "ASSETID,ASSETBARCODE,ASSETNAME,ASSETCOST,ASSETSPEC,FAULTDESCN,REPAIRAMOUNT,"
					+ "HANDLEDEPTNAME,HANDLEDEPTID) values (?,?,?,"
					+ "to_date(?,'yyyy-mm-dd'),?,?,?,?,?,?,"
					+ "?,?,?,?,?,?,?,?,?)";
			dbBean.executeUpdate(sqlStr, FID, 0, reNo, CREATEDATETIME, PSNNM, PSNID,
					ORGNM,DEPTID,ORGNM,DEPTID,
					aFID, FCODE, FNAME, FCOST, FSPEC, FDESC, 0, ORGNM, DEPTID);
			UUID uusid = UUID.randomUUID();
			String SID = uusid.toString().replaceAll("-", "");
			String sqlSEXECUTORNAMES = "select wm_concat(acct_nm) acct_nm from sys_person where org_id = '"+DEPTID+"'"; 
			DataObject dataNAMES = dbBean.executeSingleQuery(sqlSEXECUTORNAMES);
			String SEXECUTORNAMES = dataNAMES.getValue("acct_nm");
			String sqlSA = "insert into SA_TASK (SID,SNAME,SFLOWID,SCATALOGID,SKINDID,STYPENAME,"
					+ "SPROCESS,SCREATETIME,SLASTMODIFYTIME,SEXPECTSTARTTIME,SACTUALSTARTTIME,"
					+ "SCREATORPERSONID,SCREATORPERSONNAME,SCREATORDEPTID,SCREATORDEPTNAME,"
					+ "SCREATOROGNID,SCREATOROGNNAME,SCREATORFID,SCREATORFNAME,"
					+ "SEXECUTORNAMES,SACTIVITYNAMES,SDATA1,SSTATUSID,SSTATUSNAME,SPROCESSNAME,"
					+ "SEURL) "
					+ "values (?,?,?,?,?,?,?,"
					+ "to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),"
					+ "to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),"
					+ "?,?,?,?,?,?,?,?,"
					+ "?,?,?,?,?,?,?)";
			dbBean.executeUpdate(sqlSA,SID,"维修申请",SID,"tsProcess","tkProcessInstance","维修申请",
					"repairRequestProcess",CREATEDATETIME,CREATEDATETIME,CREATEDATETIME,CREATEDATETIME,
					PSNID,PSNNM,DEPTID,ORGNM,DEPTID,ORGNM,DEPTID+"/"+PSNID,ORGNM+"/"+PSNNM,
					SEXECUTORNAMES,"维修处理",FID,"tesExecuting","正在处理","维修申请","./screen/system/taskDialog/repairD.jsp");
			UUID usid = UUID.randomUUID();
			String SID1 = usid.toString().replaceAll("-", "");
			String sqlSA1 = "insert into SA_TASK (SID,SPARENTID,SNAME,SFLOWID,"
					+ "SEXECUTEMODE,SPREEMPTMODE,SCATALOGID,SKINDID,STYPENAME,SPROCESS,SACTIVITY,"
					+ "SCREATETIME,SLASTMODIFYTIME,SEXPECTSTARTTIME,SACTUALSTARTTIME,"
					+ "SEXPECTFINISHTIME,SACTUALFINISHTIME,"
					+ "SCREATORPERSONID,SCREATORPERSONNAME,SCREATORDEPTID,SCREATORDEPTNAME,"
					+ "SCREATOROGNID,SCREATOROGNNAME,SCREATORFID,SCREATORFNAME,"
					+ "SEXECUTORPERSONID,SEXECUTORPERSONNAME,SEXECUTORDEPTID,SEXECUTORDEPTNAME,"
					+ "SEXECUTOROGNID,SEXECUTOROGNNAME,SEXECUTORFID,SEXECUTORFNAME,"
					+ "SEXECUTORNAMES,SRESPONSIBLE,SDATA1,SSTATUSID,SSTATUSNAME,"
					+ "SAIID,SAISTATUSID,SPROCESSNAME,SACTIVITYNAME,SEURL) "
					+ "values (?,?,?,?,"
					+ "?,?,?,?,?,?,?,"
					+ "to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),"
					+ "to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),"
					+ "to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),"
					+ "?,?,?,?,?,?,?,?,"
					+ "?,?,?,?,?,?,?,?,"
					+ "?,?,?,?,?,?,?,?,?,?)";
			dbBean.executeUpdate(sqlSA1,SID1,SID,"维修申请:维修申请",SID,
					"temPreempt","tpmOpen","tsProcess","tkTask","维修申请",
					"repairRequestProcess","repairFillForm",
					CREATEDATETIME,CREATEDATETIME,
					CREATEDATETIME,CREATEDATETIME,CREATEDATETIME,CREATEDATETIME,
					PSNID,PSNNM,DEPTID,ORGNM,DEPTID,ORGNM,DEPTID+"/"+PSNID,ORGNM+"/"+PSNNM,
					PSNID,PSNNM,DEPTID,ORGNM,DEPTID,ORGNM,DEPTID+"/"+PSNID,ORGNM+"/"+PSNNM,
					PSNNM,"false",FID,"tesFinished","已完成",SID1,"end","维修申请","维修申请",
					"./screen/system/taskDialog/repairD.jsp");
			UUID usid2 = UUID.randomUUID();
			String SID2 = usid2.toString().replaceAll("-", "");
			String sqlSA2 = "insert into SA_TASK (SID,SPARENTID,SNAME,SFLOWID,"
					+ "SEXECUTEMODE,SPREEMPTMODE,SCATALOGID,SKINDID,STYPENAME,SPROCESS,SACTIVITY,"
					+ "SCREATETIME,SLASTMODIFYTIME,SEXPECTSTARTTIME,SACTUALSTARTTIME,"
					+ "SCREATORPERSONID,SCREATORPERSONNAME,SCREATORDEPTID,SCREATORDEPTNAME,"
					+ "SCREATOROGNID,SCREATOROGNNAME,SCREATORFID,SCREATORFNAME,"
					+ "SEXECUTORNAMES,SDATA1,SSTATUSID,SSTATUSNAME,"
					+ "SAIID,SAISTATUSID,SPROCESSNAME,SACTIVITYNAME,SEURL) "
					+ "values (?,?,?,?,"
					+ "?,?,?,?,?,?,?,"
					+ "to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),"
					+ "to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),"
					+ "?,?,?,?,?,?,?,?,"
					+ "?,?,?,?,?,?,?,?,?)";
			dbBean.executeUpdate(sqlSA2,SID2,SID,"维修处理:维修申请",SID,
					"temPreempt","tpmOpen","tsProcess","tkTask",
					"维修申请","repairRequestProcess","repairHandle",
					CREATEDATETIME,CREATEDATETIME,CREATEDATETIME,CREATEDATETIME,
					PSNID,PSNNM,DEPTID,ORGNM,DEPTID,ORGNM,DEPTID+"/"+PSNID,ORGNM+"/"+PSNNM,
					SEXECUTORNAMES,FID,"tesReady","尚未处理",SID2,"run","维修申请","维修处理",
					"./screen/system/taskDialog/repairD.jsp");
			String[] names = SEXECUTORNAMES.split(",");
			for(int i=0;i<names.length;i++){
				String name = names[i];
				String sql = "insert into SA_TASK (SID,SPARENTID,SNAME,SFLOWID,"
						+ "SEXECUTEMODE,SPREEMPTMODE,SCATALOGID,SKINDID,STYPENAME,SPROCESS,SACTIVITY,"
						+ "SCREATETIME,SLASTMODIFYTIME,SEXPECTSTARTTIME,SACTUALSTARTTIME,"
						+ "SCREATORPERSONID,SCREATORPERSONNAME,SCREATORDEPTID,SCREATORDEPTNAME,"
						+ "SCREATOROGNID,SCREATOROGNNAME,SCREATORFID,SCREATORFNAME,"
						//+ "SEXECUTORPERSONID,SEXECUTORPERSONNAME,SEXECUTORDEPTID,SEXECUTORDEPTNAME,"
						//+ "SEXECUTOROGNID,SEXECUTOROGNNAME,SEXECUTORFID,SEXECUTORFNAME,"
						+ "SEXECUTORNAMES,SRESPONSIBLE,SDATA1,SSTATUSID,SSTATUSNAME,"
						+ "SPROCESSNAME,SACTIVITYNAME,SEURL) "
						+ "values (?,?,?,?,"
						+ "?,?,?,?,?,?,?,"
						+ "to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),"
						+ "to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'),"
						+ "?,?,?,?,?,?,?,?,"
						//+ "?,?,?,?,?,?,?,?,"
						+ "?,?,?,?,?,?,?,?)";
				dbBean.executeUpdate(sql,UUID.randomUUID().toString().replaceAll("-", ""),SID2,"维修处理:维修申请",SID,
						"temPreempt","tpmOpen","tsProcess","tkExecutor","维修申请","repairRequestProcess","repairHandle",
						CREATEDATETIME,CREATEDATETIME,CREATEDATETIME,CREATEDATETIME,
						PSNID,PSNNM,DEPTID,ORGNM,DEPTID,ORGNM,DEPTID+"/"+PSNID,ORGNM+"/"+PSNNM,
						name,"false",FID,"tesReady","尚未处理","维修申请","维修处理","./screen/system/taskDialog/repairD.jsp");
			}
			
			dbBean.executeCommit();
			flag = 1;
		} catch (Exception e) {
			logger.error("维修申请出错", e);
			dtbHelper.setError("usermg-err-add-002",
					"[维修申请出错]" + e.getMessage());
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

	protected int other(DTBHelper dtbHelper) throws BizActionException {

		return 0;
	}
}
