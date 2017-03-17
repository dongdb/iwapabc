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

public class DeleteStorageAction extends TransactionBizAction {
	private static Logger logger = Logger.getLogger(DeleteStorageAction.class);
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
		if ("query".equals(option)) {
			return query(dtbHelper);
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
		String createtime = dtbHelper.getStringValue("createtime");
		String pid1 = dtbHelper.getStringValue("pid1");
		String pid2 = dtbHelper.getStringValue("pid2");
		String str= "";
		if(createtime.equals("1") ){
			str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
				+" and to_char(FCREATETIME,'mm')=to_char(sysdate,'mm')"
				+" and to_char(FCREATETIME,'dd')=to_char(sysdate,'dd')";
		}
		if(createtime.equals("2")){
			str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
				+" and to_char(FCREATETIME,'mm')=to_char(sysdate,'mm')"
				+" and to_char(FCREATETIME,'dd')=(to_char(sysdate,'dd')-1)";
		}
		if(createtime.equals("3")){
			str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
				+" and to_char(FCREATETIME,'iw')=to_char(sysdate,'iw')";
		}
		if(createtime.equals("4")){
			str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
				+" and to_char(FCREATETIME,'iw')=(to_char(sysdate,'iw')-1)";
		}
		if(createtime.equals("5")){
			str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
				+" and to_char(FCREATETIME,'mm')=to_char(sysdate,'mm')";
		}
		if(createtime.equals("6")){
			str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
				+" and to_char(FCREATETIME,'mm')=(to_char(sysdate,'mm')-1)";
		}
		if(createtime.equals("7")){
			str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')";
		}
		if(createtime.equals("8")){
			str=" and to_char(FCREATETIME,'yyyy')=(to_char(sysdate,'yyyy')-1)";
		}
		if(createtime.equals("9")){
			//logger.info("pid1:"+pid1+"pid2:"+pid2);
			str=" and FCREATETIME > to_date('"+pid1+"','yyyy-mm-dd')"
				+" and FCREATETIME < to_date('"+pid2+"','yyyy-mm-dd')";
		}
		try {
			dbBean = DBAccessPool.getDbBean();
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			//String remark = dtbHelper.getStringValue("remark");			
			
			String sqlStr = "select FID,FSTATENAME,FNO,to_char(FDATE,'yyyy-mm-dd') FDATE,"
							+ "FAMOUNT,FMODE,FCREATEPSNNAME,FREMARK,FASSETCONFIRM,"
							+ "substr(fcreatedeptname,instr(fcreatedeptname,'/',-1,1)+1) fcreatedeptname "
							+ "from OA_AS_INM "
							+ "where 1=1 and FASSETCONFIRM ='未确认' "
							+ "and (FMODE like ? or FNO like ? or FSTATENAME like ? "
							+ "or FCREATEDEPTNAME like ? or FREMARK like ? or FCREATEPSNNAME like ?) "
							+ str;			
			logger.info("执行sql语句:" + sqlStr);
			List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr,page,fuzzySearch,fuzzySearch,fuzzySearch,fuzzySearch,fuzzySearch,fuzzySearch);
			
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

	protected int add(DTBHelper dtbHelper) {
		
		return 0;
	}

	protected int save(DTBHelper dtbHelper) {

		return 0;
	}

	protected int remove(DTBHelper dtbHelper) {
		int flag = 0;
		logger.info("-----remove------"+dtbHelper);
		DBAccessBean dbBean = null;
		String fid = dtbHelper.getStringValue("fid");
		List<Map<String, Object>> dataList = null;
		try {
			dbBean = DBAccessPool.getDbBean();
			dbBean.setAutoCommit(false);
			//删除入库单和入库明细
			//dbBean.executeUpdate("delete from oa_as_inm where fid = ?", fid);
			//dbBean.executeUpdate("delete from oa_as_ind where fMasterID = ?", fid);
			//删除相关资产数据和记录
			/*String sqlBudgetno="select m.fbudgetnoid from oa_as_inm m where m.fid= ?";
			logger.info("执行sql语句:" + sqlBudgetno);
			DataObject data = dbBean.executeSingleQuery(sqlBudgetno,fid);
			String budgetno = data.getValue("fbudgetno");
			String querySql = "select fid from oa_as_card where fAssetInID = ?";
			logger.info("执行sql语句:" + querySql);
			DataObject data1 = dbBean.executeSingleQuery(sqlBudgetno);
			String fid1 = data.getValue("fid");
			String sql = "delete from OA_AS_UseRecord where fAssetID = ?";
			dbBean.executeUpdate(sql, fid1);
			sql = "delete from oa_as_card where fAssetInID = ?";
			dbBean.executeUpdate(sql,fid);
			*/
			/*dataList = dbBean.queryForList(sqlStr, page, deptId, userId, userNm, userStatus, "%" + _deptid + "%",
					deptlevel);
			while (cardFid.next()) {
				String assetID = rs.getString("fid");
				sql = "delete from OA_AS_ArrangeD where fAssetID = '" + assetID + "'";
				sql = "delete from OA_AS_ReturnD where fAssetID = '" + assetID + "'";
			}
			
			
			rs = stmt.executeQuery(querySql);
			
			sql = "delete from OA_AS_OutM where fid = (select distinct(fmasterid) from OA_AS_OutD where fAssetInID = '" + id + "')";
			dstmt.addBatch(sql);
			sql = "delete from OA_AS_OutD where fAssetInID = '" + id + "'";
			dstmt.addBatch(sql);
			sql = "delete from OA_AS_InM m where m.fid = '" + id + "'";
			dstmt.addBatch(sql);
			sql = "delete from OA_AS_InD d where d.fMasterID = '" + id + "'";
			dstmt.addBatch(sql);
			sql = "delete from oa_as_card where fAssetInID = '" + id + "'";
			dstmt.addBatch(sql);
			while(rsBG.next()){
				String fbudgetNO=rsBG.getString("fbudgetnoid");
				sql= "update oa_as_budgetm m set m.fbudgetstatename='正常',m.fbudgetstateid=1 where fid='"+fbudgetNO+"'";
				System.out.println(sql);
				dstmt.addBatch(sql);
			}
			dstmt.executeBatch();*/
			dbBean.executeCommit();
			
		} catch (Exception e) {
			logger.error("资产入库单删除出错", e);
			dtbHelper.setError("usermg-err-rm-002", "[入库单删除出错]" + e.getMessage());
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

	public int show(DTBHelper dtbHelper) throws BizActionException {
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

	protected int other(DTBHelper dtbHelper) throws BizActionException {

		return 0;
	}
}
