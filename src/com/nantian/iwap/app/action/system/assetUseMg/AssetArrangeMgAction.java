package com.nantian.iwap.app.action.system.assetUseMg;

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
 * ClassName: AsserArrangeMgAction <br/>
 * Function: 资产安排管理<br/>
 * date: 2016年11月24日15:18:49 <br/>
 * 
 * @author ZSJ
 * @version
 * @since JDK 1.7 Copyright (c) 2016, 广州南天电脑系统有限公司 All Rights Reserved.
 */
public class AssetArrangeMgAction extends TransactionBizAction {

	private static Logger log = Logger.getLogger(AssetArrangeMgAction.class);
	
	public int actionExecute(DTBHelper dtbHelper) throws BizActionException {
		String option = dtbHelper.getStringValue("option");
		if (StringUtil.isBlank(option)) {
			return query(dtbHelper);
		}
		if ("place".equals(option)) {
			return place(dtbHelper);
		}
		if ("asset".equals(option)) {
			return asset(dtbHelper);
		}
		if ("init".equals(option)) {
			return init(dtbHelper);
		}
		if ("save".equals(option)) {
			return save(dtbHelper);
		}
		if ("detail".equals(option)) {
			return detail(dtbHelper);
		}
		if ("detailA".equals(option)) {
			return detailA(dtbHelper);
		}
		
		return 0;
	}

	protected int query(DTBHelper dtbHelper) throws BizActionException {
		try {
			int start = Integer.valueOf(dtbHelper.getStringValue("start"));
			int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
			String fuzzySearch = "%" + dtbHelper.getStringValue("fuzzySearch") + "%";
			String createtime = dtbHelper.getStringValue("FARRANGEDATE");
			String pid1 = dtbHelper.getStringValue("pid1");
			String pid2 = dtbHelper.getStringValue("pid2");
			String str= "";
			if(createtime.equals("1") ){
				str=" and to_char(FARRANGEDATE,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FARRANGEDATE,'mm')=to_char(sysdate,'mm')"
					+" and to_char(FARRANGEDATE,'dd')=to_char(sysdate,'dd')";
			}
			if(createtime.equals("2")){
				str=" and to_char(FARRANGEDATE,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FARRANGEDATE,'mm')=to_char(sysdate,'mm')"
					+" and to_char(FARRANGEDATE,'dd')=(to_char(sysdate,'dd')-1)";
			}
			if(createtime.equals("3")){
				str=" and to_char(FARRANGEDATE,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FARRANGEDATE,'iw')=to_char(sysdate,'iw')";
			}
			if(createtime.equals("4")){
				str=" and to_char(FARRANGEDATE,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FARRANGEDATE,'iw')=(to_char(sysdate,'iw')-1)";
			}
			if(createtime.equals("5")){
				str=" and to_char(FARRANGEDATE,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FARRANGEDATE,'mm')=to_char(sysdate,'mm')";
			}
			if(createtime.equals("6")){
				str=" and to_char(FARRANGEDATE,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FARRANGEDATE,'mm')=(to_char(sysdate,'mm')-1)";
			}
			if(createtime.equals("7")){
				str=" and to_char(FARRANGEDATE,'yyyy')=to_char(sysdate,'yyyy')";
			}
			if(createtime.equals("8")){
				str=" and to_char(FARRANGEDATE,'yyyy')=(to_char(sysdate,'yyyy')-1)";
			}
			if(createtime.equals("9")){
				//log.info("pid1:"+pid1+"pid2:"+pid2);
				str=" and FARRANGEDATE > to_date('"+pid1+"','yyyy-mm-dd')"
					+" and FARRANGEDATE < to_date('"+pid2+"','yyyy-mm-dd')";
			}
			log.info("fuzzySeaerch:"+fuzzySearch);
			String sqlStr = "select a.farrangeno,"
					+ "to_char(a.FARRANGEDATE,'yyyy-mm-dd') FARRANGEDATE,"
					+ "a.fresponsepsnfname,a.fusetype,a.fremark,a.fcreatepsnname,"
					+ "to_char(a.FCREATETIME,'yyyy-mm-dd') FCREATETIME"
					+ " from oa_as_arrangem a "
					+ " where 1=1 "+str
					+ " and (a.farrangeno like ? or a.fresponsepsnfname like ? or a.fcreatepsnname like ? "
					+ " or a.fusetype like ? ) "
					+ " order by FARRANGEDATE desc ";
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			List<Map<String,Object>> dataList = dbBean.queryForList(sqlStr,page,fuzzySearch,fuzzySearch,fuzzySearch,fuzzySearch);
			log.info("执行sql语句:" + sqlStr);
			
			if (dataList.size() > 0) {
				dtbHelper.setRstData("rows", dataList);
				dtbHelper.setRstData("total", page.getTotalCount());
			} else {
				dtbHelper.setError("depmg-err-s", "[数据库显示失败!]" );
				DBAccessPool.releaseDbBean();
				return 0;
			}
		} catch (Exception e) {
			log.error("数据库访问异常!", e);
			dtbHelper.setError("depmg-err-s", "[数据库访问异常!]" );
		}finally {
			DBAccessPool.releaseDbBean();
		}
		return 0;
	}
	
	protected int init(DTBHelper dtbHelper) throws BizActionException {
		try {
			String ZCAP = "ZCAP";
			String date = DateUtil.getCurrentDate("yyyyMMdd");
			ZCAP += date;
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			String sql="select zcap_seq.nextval seq from dual ";
			DataObject data = dbBean.executeSingleQuery(sql);
			String seq  = data.getValue("seq");
			int length = 6;
			while (seq.length() < length){
				seq = "0" + seq;
			}
			ZCAP += seq;
			log.info("资产安排单号："+ZCAP);
			dtbHelper.setRstData("ZCAP", ZCAP);
		} catch (Exception e) {
			log.error("数据库访问异常!", e);
			dtbHelper.setError("depmg-err-s", "[数据库访问异常!]");
		} finally {
			DBAccessPool.releaseDbBean();
		}
		return 0;
	}
	
	protected int place(DTBHelper dtbHelper) {
		log.info("-------place-------"+dtbHelper);
		int flag = 0;
		DBAccessBean dbBean = null;
		int start = Integer.valueOf(dtbHelper.getStringValue("start"));
		int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
		String fuzzysearch = "%" + dtbHelper.getStringValue("fuzzysearch") + "%";
		log.info("fuzzysearch:"+fuzzysearch);
		try {
			dbBean = DBAccessPool.getDbBean();
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			String sqlStr = "select FID,FJGMC,FLZMC,"
							+ "FJGLX,FJGWZ,FMJ,FSYJGNAME,FSYBMNAME,"
							+ "FLZBH "
							+ "from ASSET_FWDYJG where 1=1 "
							+ "and (FJGMC like ? or FLZMC like ? "
							+ " or FJGLX like ?  or FJGWZ like ? "
							+ " or FSYJGNAME like ?  or FSYBMNAME like ? )";
			log.info("执行sql语句:" + sqlStr);
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
			log.error("资产列表查询出错", e);
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
	protected int asset(DTBHelper dtbHelper) {
		log.info("-------asset-------"+dtbHelper);
		int flag = 0;
		DBAccessBean dbBean = null;
		int start = Integer.valueOf(dtbHelper.getStringValue("start"));
		int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
		String fuzzysearch = "%" + dtbHelper.getStringValue("fuzzyAsset") + "%";
		log.info("fuzzysearch:"+fuzzysearch);
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
			log.info("执行sql语句:" + sqlStr);
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
			log.error("资产列表查询出错", e);
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
	

	protected int save(DTBHelper dtbHelper) throws BizActionException {
		log.info("-------add资产安排ArrangeM-------" + dtbHelper);
		int flag = 0;
		DBAccessBean dbBean = null;
		try {
			dbBean = DBAccessPool.getDbBean();
			dbBean.setAutoCommit(false);
			UUID uuid = UUID.randomUUID();
			String FID = uuid.toString().replaceAll("-", "");
			String FARRANGENO = dtbHelper.getStringValue("FARRANGENO");
			String FARRANGEDATE = dtbHelper.getStringValue("FARRANGEDATE1").replaceAll("-","");
			String FLIMITDATE = dtbHelper.getStringValue("FLIMITDATE").replaceAll("-","");
			String FUSETYPE = dtbHelper.getStringValue("FUSETYPE");
			String FARRANGEROOM = dtbHelper.getStringValue("FARRANGEROOM");
			String FGALLERYID = dtbHelper.getStringValue("FGALLERYID");
			String FROOMID = dtbHelper.getStringValue("FROOMID");
			String FREMARK = dtbHelper.getStringValue("FREMARK");
			/*FDUTYOGNID FDUTYOGNNAME
			FDUTYDEPTID 
			FDUTYDEPTFID FDUTYDEPTFNAME
			FDUTYPSNID 
			FDUTYPSNFID FDUTYPSNFNAME
			FRESPONSEDEPTID 
			FRESPONSEDEPTFID FRESPONSEDEPTFNAME
			FRESPONSEPSNID 
			FRESPONSEPSNFID FRESPONSEPSNFNAME
			FCREATEOGNID FCREATEOGNNAME
			FCREATEPSNFID FCREATEPSNFNAME*/
			String FDUTYDEPTNAME = dtbHelper.getStringValue("FDUTYDEPTNAME");
			String FDUTYPSNNAME = dtbHelper.getStringValue("FDUTYPSNNAME");
			String FRESPONSEDEPTNAME = dtbHelper.getStringValue("FRESPONSEDEPTNAME");
			String FRESPONSEPSNNAME = dtbHelper.getStringValue("FRESPONSEPSNNAME");
			String PSNID = dtbHelper.getStringValue("userInfo.ACCT_ID");
			String PSNNM = dtbHelper.getStringValue("userInfo.ACCT_NM");
			String DEPTID = dtbHelper.getStringValue("userInfo.ORG_ID");
			String sqlDEPTnm = "select ORG_NM from SYS_ORG where ORG_ID = ? ";
			DataObject dataDEPT = dbBean.executeSingleQuery(sqlDEPTnm,DEPTID);
			String ORGNM = dataDEPT.getValue("org_nm");
			String FCREATETIME= DateUtil.getCurrentDate("yyyyMMdd");
			String sqlStr = "insert into OA_AS_ArrangeM"
					+ "(FID,VERSION,FARRANGENO,FARRANGEDATE,FUSETYPE,"
					+ "FARRANGEROOM,FGALLERYID,FROOMID,FREMARK,"
					+ "FRESPONSEDEPTNAME,FRESPONSEPSNNAME,"
					+ "FDUTYDEPTNAME,FDUTYPSNNAME,"
					+ "FCREATEDEPTID,FCREATEDEPTNAME,FCREATEPSNID,FCREATEPSNNAME,"
					+ "FCREATETIME,FLIMITDATE ) values (?,?,?,to_date(?,'yyyy-mm-dd'),?,"
					+ "?,?,?,?,?,?,?,?,?,?,?,?,to_date(?,'yyyy-mm-dd'),to_date(?,'yyyy-mm-dd'))";
			dbBean.executeUpdate(sqlStr, FID, 0, FARRANGENO, FARRANGEDATE, FUSETYPE,
					FARRANGEROOM, FGALLERYID, FROOMID, FREMARK, 
					FRESPONSEDEPTNAME, FRESPONSEPSNNAME, FDUTYDEPTNAME, FDUTYPSNNAME, 
					DEPTID, ORGNM, PSNID, PSNNM, FCREATETIME, FLIMITDATE);

			String list = dtbHelper.getStringValue("list");
			String[] listFID = list.split(",");
			for(String id : listFID){
				UUID uuid1 = UUID.randomUUID();
				String FID1 = uuid1.toString().replaceAll("-", "");
				if(id.length()>10){
					id = id.substring(1, 33);
					log.info("========="+id);
					String sqlData = "select ERPCODE, FBARCODE, FSTATUSNAME, FKIND, FNAME,"
							  + "FSPECTYPE, FSOURCENAME, FORIGINVALUE "
							  + "from OA_AS_CARD where fid = ? ";
					DataObject data = dbBean.executeSingleQuery(sqlData,id);
					String ERPCODE = data.getValue("erpcode");
					String FBARCODE = data.getValue("fbarcode");
					String FSTATUSNAME = data.getValue("fstatusname");
					String FKIND = data.getValue("fkind");
					String FNAME = data.getValue("fname");
					String FSPECTYPE = data.getValue("fspectype");
					String FSOURCENAME = data.getValue("fsourcename");
					String FORIGINVALUE = data.getValue("foriginvalue");
					
					String sql = "insert into OA_AS_ArrangeD"
							+ "(FID,FMAINID,VERSION,FASSETID,"
							+ "ERPCODE,FBARCODE,FSTATUSNAME,FKIND,FNAME,"
							+ "FSPECTYPE,FSOURCENAME,FORIGINVALUE,FREMARK) "
							+ "values (?,?,?,?,"
							+ "?,?,?,?,?,"
							+ "?,?,?,?)";
					dbBean.executeUpdate(sql, FID1, FID, 0, id,
							ERPCODE, FBARCODE, FSTATUSNAME, FKIND, FNAME,
							FSPECTYPE, FSOURCENAME, FORIGINVALUE, FREMARK);
					UUID uuid2 = UUID.randomUUID();
					String FID2 = uuid2.toString().replaceAll("-", "");
					String sqlUse = "insert into OA_AS_USERECORD "
							+ "(FID,VERSION,FASSETID,FBEGINDATE,FENDDATE,"
							+ "FLIMITDATE,FDUTYDEPTFNAME,FDUTYPSNNAME,"
							+ "FRESPONSEDEPTFNAME,FRESPONSEPSNNAME,"
							+ "FCREATEDEPTID,FCREATEDEPTNAME,FCREATEPSNID,FCREATEPSNNAME,"
							+ "FROOM,FISDEPT,FREMARK) "
							+ "values (?,?,?,"
							+ "to_date(?,'yyyy-mm-dd'),"
							+ "to_date(?,'yyyy-mm-dd'),"
							+ "to_date(?,'yyyy-mm-dd'),"
							+ "?,?,?,?,?,?,?,?,"
							+ "?,?,?)";
					dbBean.executeUpdate(sqlUse, FID2, 0, id,
							FARRANGEDATE, FLIMITDATE, FLIMITDATE, 
							FRESPONSEDEPTNAME, FRESPONSEPSNNAME, FDUTYDEPTNAME, FDUTYPSNNAME,
							DEPTID, ORGNM, PSNID, PSNNM, 
							FARRANGEROOM, FUSETYPE, FREMARK);
					String sqlCard = "update OA_AS_CARD set "
							+ "FARRANGEDATE = to_date(?,'yyyy-mm-dd'),"
							+ "FRESPONSEDEPTFNAME = ?,"
							+ "FRESPONSEPSNNAME = ?,"
							+ "FDUTYDEPTFNAME = ?,"
							+ "FDUTYPSNNAME = ?,"
							+ "FCREATEDEPTID = ?,"
							+ "FCREATEDEPTNAME = ?,"
							+ "FCREATEPSNID = ?,"
							+ "FCREATEPSNNAME = ? "
							+ " where FBARCODE = ? ";
							
					dbBean.executeUpdate(sqlCard,FARRANGEDATE,
							FRESPONSEDEPTNAME,FRESPONSEPSNNAME, FDUTYDEPTNAME, FDUTYPSNNAME,
							DEPTID, ORGNM, PSNID, PSNNM,FBARCODE);
				}
			}

			dbBean.executeCommit();
			flag = 1;
		} catch (Exception e) {
			log.error("安排新增出错", e);
			dtbHelper.setError("usermg-err-add-002",
					"[安排新增出错]" + e.getMessage());
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
	
	protected int detail(DTBHelper dtbHelper) throws BizActionException {
		log.info("-------detail资产安排详细信息-------" + dtbHelper);
		// TODO Auto-generated method stub
		String fno = dtbHelper.getStringValue("fno");
		log.info("------------FARRANGENO:" + fno);
		String sqlStr = "select FID,FDUTYPSNNAME dutypsn,FDUTYDEPTNAME dutydept,"
				+ "FRESPONSEPSNNAME respsn,FRESPONSEDEPTNAME resdept,"
				+ "to_char(FARRANGEDATE,'yyyy-mm-dd') adate,"
				+ "FARRANGEROOM place,FUSETYPE usetype,"
				+ "to_char(FLIMITDATE,'yyyy-mm-dd') ldate,"
				+ "FCREATEPSNNAME createpsn,FREMARK remark "
				+ "from oa_as_arrangeM "
				+ "where FARRANGENO ='"+fno+"'";
			
		if (!fno.equals("")) {
			try {
				DBAccessBean dbBean = DBAccessPool.getDbBean();
				List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr);
				log.info("执行sql语句:" + sqlStr);
				if (dataList.size() > 0) {
					dtbHelper.setRstData("rows", dataList.get(0));
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
		}
		return 0;
	}
	protected int detailA(DTBHelper dtbHelper) throws BizActionException {
		try {
			int start = Integer.valueOf(dtbHelper.getStringValue("start"));
			int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
			String fid = dtbHelper.getStringValue("fid");
			String sqlStr = "select a.FBARCODE,a.FNAME,a.FSPECTYPE,"
					+ "a.FREMARK,a.FORIGINVALUE,a.FSOURCENAME "
					+ " from oa_as_arranged a "
					+ " where a.FMAINID = ? ";
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			List<Map<String,Object>> dataList = dbBean.queryForList(sqlStr,page,fid);
			log.info("执行sql语句:" + sqlStr);
			
			if (dataList.size() > 0) {
				dtbHelper.setRstData("rows", dataList);
				dtbHelper.setRstData("total", page.getTotalCount());
			} else {
				dtbHelper.setError("depmg-err-s", "[数据库显示失败!]" );
				DBAccessPool.releaseDbBean();
				return 0;
			}
		} catch (Exception e) {
			log.error("数据库访问异常!", e);
			dtbHelper.setError("depmg-err-s", "[数据库访问异常!]" );
		}finally {
			DBAccessPool.releaseDbBean();
		}
		return 0;
	}
	
}
