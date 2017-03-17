package com.nantian.iwap.app.action.system;

import java.util.List;
import java.util.Map;

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
 * ClassName: ContractTpAction <br/>
 * Function: 获取预算类别菜单<br/>
 * date: 2016年3月2日15:18:49 <br/>
 * 
 * @author wjj
 * @version
 * @since JDK 1.7 Copyright (c) 2016, 广州南天电脑系统有限公司 All Rights Reserved.
 */
public class AssetQueryAction extends TransactionBizAction {

	private static Logger log = Logger.getLogger(AssetQueryAction.class);
	
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
		if ("bill".equals(option)) {
			return bill(dtbHelper);
		}
		return 0;
	}

	protected int query(DTBHelper dtbHelper) throws BizActionException {
		try {
			int start = Integer.valueOf(dtbHelper.getStringValue("start"));
			int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
			String FASSETCONFIRM = "%" + dtbHelper.getStringValue("assetConfirm") + "%";
			String FCODE = "%" + dtbHelper.getStringValue("fcode") + "%";
			String FCREATETIME = dtbHelper.getStringValue("createTime") ;
			log.info("---FASSETCONFIRM:"+FASSETCONFIRM);
			log.info("---FCREATETIME:"+FCREATETIME);
			log.info("---FCODE:"+FCODE);
			String pid1 = dtbHelper.getStringValue("pid1");
			String pid2 = dtbHelper.getStringValue("pid2");
			String str= "";
			if(FCREATETIME.equals("1") ){
				str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FCREATETIME,'mm')=to_char(sysdate,'mm')"
					+" and to_char(FCREATETIME,'dd')=to_char(sysdate,'dd')";
			}
			if(FCREATETIME.equals("2")){
				str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FCREATETIME,'mm')=to_char(sysdate,'mm')"
					+" and to_char(FCREATETIME,'dd')=(to_char(sysdate,'dd')-1)";
			}
			if(FCREATETIME.equals("3")){
				str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FCREATETIME,'iw')=to_char(sysdate,'iw')";
			}
			if(FCREATETIME.equals("4")){
				str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FCREATETIME,'iw')=(to_char(sysdate,'iw')-1)";
			}
			if(FCREATETIME.equals("5")){
				str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FCREATETIME,'mm')=to_char(sysdate,'mm')";
			}
			if(FCREATETIME.equals("6")){
				str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FCREATETIME,'mm')=(to_char(sysdate,'mm')-1)";
			}
			if(FCREATETIME.equals("7")){
				str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')";
			}
			if(FCREATETIME.equals("8")){
				str=" and to_char(FCREATETIME,'yyyy')=(to_char(sysdate,'yyyy')-1)";
			}
			if(FCREATETIME.equals("9")){
				str=" and FCREATETIME > to_date('"+pid1+"','yyyy-mm-dd')"
						+" and FCREATETIME < to_date('"+pid2+"','yyyy-mm-dd')";
			}
			String sqlStr = "select FID,FCODE,FNAME,"
					+ "FSPECTYPE,FISFA,FORIGINVALUE,"
					+ "FSTATUSNAME,FASSETCONFIRM,FCHECKED,"
					+ "TO_CHAR(FIMPORTFADATE,'yyyy-mm-dd') AS FIMPORTFADATE,"
					+ "FBARCODE,FASSETINNO from OA_AS_CARD"
					+ " where 1=1 and FASSETCONFIRM like ? "
					+ " and (FCODE like ? or FNAME like ? or FSTATUSNAME like ? "
					+ " or FASSETINNO like ? or FSPECTYPE like ?)"
					+ str;
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			List<Map<String,Object>> dataList = dbBean.queryForList(sqlStr,page,FASSETCONFIRM,
																FCODE,FCODE,FCODE,FCODE,FCODE);
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

	protected int add(DTBHelper dtbHelper) throws BizActionException {
		int flag = 0;
		return flag;
	}

	protected int save(DTBHelper dtbHelper) throws BizActionException {
		int flag = 0;
		return flag;
	}

	protected int remove(DTBHelper dtbHelper) throws BizActionException {
		int flag = 0;
		return flag;
	}
	
	protected int bill(DTBHelper dtbHelper) throws BizActionException {
		String fid = dtbHelper.getStringValue("fid");
		String fnum = "%" +dtbHelper.getStringValue("fnum")+"%";
		log.info("------------fid:" + fid);
		String sqlStr = "select b.FP_NUM,b.FPEOPLE,b.FPROVIDER,"
				+ "to_char(b.FP_DATE,'yyyy-mm-dd') FP_DATE,"
				+ "b.FP_MONEY,b.FMTYPE,"
				+ "b.FRATE,b.FCURRENCY,b.FCHECKED,"
				+ "b.FCREATEPSNNAME,b.FREMARK"
				+ " from oa_as_card a,asset_bill b,oa_as_cardbill c"
				+ " where a.fid=c.fcode and b.fid=c.fbillid"
				+ " and a.fid='" + fid + "'"
				+ " and b.FP_NUM like '" + fnum + "'";
		if (!fid.equals("")) {
			log.info("------------sqlStr:" + sqlStr);
			try {
				int start = Integer.valueOf(dtbHelper.getStringValue("start"));
				int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
				DBAccessBean dbBean = DBAccessPool.getDbBean();
				PaginationSupport page = new PaginationSupport(start, limit, limit);
				List<Map<String,Object>> dataList = dbBean.queryForList(sqlStr,page);
				

				log.info("执行sql语句:" + sqlStr);

				if (dataList.size() > 0) {
					dtbHelper.setRstData("rows", dataList);
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
}
