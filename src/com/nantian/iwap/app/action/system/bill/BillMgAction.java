package com.nantian.iwap.app.action.system.bill;

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
public class BillMgAction extends TransactionBizAction {

	private static Logger log = Logger.getLogger(BillMgAction.class);
	
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
		if ("detail".equals(option)) {
			return detail(dtbHelper);
		}
		return 0;
	}

	protected int query(DTBHelper dtbHelper) throws BizActionException {
		try {
			int start = Integer.valueOf(dtbHelper.getStringValue("start"));
			int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
			String fuzzySearch = "%" + dtbHelper.getStringValue("fuzzySearch") + "%";
			String fp_date = dtbHelper.getStringValue("fp_date");
			String pid1 = dtbHelper.getStringValue("pid1");
			String pid2 = dtbHelper.getStringValue("pid2");
			String str= "";
			if(fp_date.equals("1") ){
				str=" and to_char(FP_DATE,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FP_DATE,'mm')=to_char(sysdate,'mm')"
					+" and to_char(FP_DATE,'dd')=to_char(sysdate,'dd')";
			}
			if(fp_date.equals("2")){
				str=" and to_char(FP_DATE,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FP_DATE,'mm')=to_char(sysdate,'mm')"
					+" and to_char(FP_DATE,'dd')=(to_char(sysdate,'dd')-1)";
			}
			if(fp_date.equals("3")){
				str=" and to_char(FP_DATE,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FP_DATE,'iw')=to_char(sysdate,'iw')";
			}
			if(fp_date.equals("4")){
				str=" and to_char(FP_DATE,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FP_DATE,'iw')=(to_char(sysdate,'iw')-1)";
			}
			if(fp_date.equals("5")){
				str=" and to_char(FP_DATE,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FP_DATE,'mm')=to_char(sysdate,'mm')";
			}
			if(fp_date.equals("6")){
				str=" and to_char(FP_DATE,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FP_DATE,'mm')=(to_char(sysdate,'mm')-1)";
			}
			if(fp_date.equals("7")){
				str=" and to_char(FP_DATE,'yyyy')=to_char(sysdate,'yyyy')";
			}
			if(fp_date.equals("8")){
				str=" and to_char(FP_DATE,'yyyy')=(to_char(sysdate,'yyyy')-1)";
			}
			if(fp_date.equals("9")){
				str=" and FP_DATE > to_date('"+pid1+"','yyyy-mm-dd')"
						+" and FP_DATE < to_date('"+pid2+"','yyyy-mm-dd')";
			}
			String sqlStr = "select distinct fid,fp_num,"
					+ "to_char(fp_date,'yyyy-mm-dd') fp_date,"
					+ "fp_money,fmtype,fprovider,fpeople,"
					+ "fchecked,fcreatepsnname,"
					+ "frate,fcurrency,fremark,bdown "
					+ " from asset_bill "
					+ " where 1=1 "
					+ " and (fp_num like ? or fmtype like ? or fprovider like ? "
					+ " or fpeople like ? or fchecked like ? or fcreatepsnname like ? ) "
					+ str
					+ " order by fp_date desc";
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			List<Map<String,Object>> dataList = dbBean.queryForList(sqlStr,page,fuzzySearch,fuzzySearch,fuzzySearch,fuzzySearch,fuzzySearch,fuzzySearch);
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
	
	protected int detail(DTBHelper dtbHelper) throws BizActionException {
		String fid = dtbHelper.getStringValue("fid");
		log.info("------------fid:" + fid);
		String sqlStr = "select b.title,b.fmoney "
				+ " from asset_bill a,asset_bill_detail b "
				+ " where a.fid = b.fp_id "
				+ " and a.fid = '" + fid + "'";
		if (!fid.equals("")) {
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
