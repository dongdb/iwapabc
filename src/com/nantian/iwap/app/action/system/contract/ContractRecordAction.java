package com.nantian.iwap.app.action.system.contract;

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
public class ContractRecordAction extends TransactionBizAction {

	private static Logger log = Logger.getLogger(ContractRecordAction.class);
	
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
			String fuzzySearch = "%" + dtbHelper.getStringValue("fuzzySearch") + "%";
			String fPayState = "%" +  dtbHelper.getStringValue("fPayState") + "%";
			String fPayDate = dtbHelper.getStringValue("fPayDate");
			String pid1 = dtbHelper.getStringValue("pid1");
			String pid2 = dtbHelper.getStringValue("pid2");
			String str= "";
			if(fPayDate.equals("1") ){
				str=" and to_char(FPAYDATE,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FPAYDATE,'mm')=to_char(sysdate,'mm')"
					+" and to_char(FPAYDATE,'dd')=to_char(sysdate,'dd')";
			}
			if(fPayDate.equals("2")){
				str=" and to_char(FPAYDATE,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FPAYDATE,'mm')=to_char(sysdate,'mm')"
					+" and to_char(FPAYDATE,'dd')=(to_char(sysdate,'dd')-1)";
			}
			if(fPayDate.equals("3")){
				str=" and to_char(FPAYDATE,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FPAYDATE,'iw')=to_char(sysdate,'iw')";
			}
			if(fPayDate.equals("4")){
				str=" and to_char(FPAYDATE,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FPAYDATE,'iw')=(to_char(sysdate,'iw')-1)";
			}
			if(fPayDate.equals("5")){
				str=" and to_char(FPAYDATE,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FPAYDATE,'mm')=to_char(sysdate,'mm')";
			}
			if(fPayDate.equals("6")){
				str=" and to_char(FPAYDATE,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FPAYDATE,'mm')=(to_char(sysdate,'mm')-1)";
			}
			if(fPayDate.equals("7")){
				str=" and to_char(FPAYDATE,'yyyy')=to_char(sysdate,'yyyy')";
			}
			if(fPayDate.equals("8")){
				str=" and to_char(FPAYDATE,'yyyy')=(to_char(sysdate,'yyyy')-1)";
			}
			if(fPayDate.equals("9")){
				str=" and FPAYDATE > to_date('"+pid1+"','yyyy-mm-dd')"
						+" and FPAYDATE < to_date('"+pid2+"','yyyy-mm-dd')";
			}
			String sqlStr = "select a.fid,a.fpaystate,a.fcreatepsnname,"
					+ "to_char(a.fpaydate,'yyyy-mm-dd') fpaydate,"
					+ "b.ctitle,b.fcurrency,b.chavmoney,a.fmoney,"
					+ "b.cdown,b.fmtype,b.fwarnrate,b.frate,b.contractid,"
					+ "b.ctype,b.cmoney,b.fremark AFREMARK,b.fprovider,"
					+ "to_char(b.cdate,'yyyy-mm-dd') cdate,"
					+ "a.pdown,a.fremark BFREMARK,"
					+ "c.fremark FREMARK "
					+ " from Asset_ContractPay a,Asset_Contract b,Asset_Bill c "
					+ " where 1=1 and c.fpid = a.fid "
					+ " and a.contractfid = b.fid "
					+ " and (b.ctitle like ? or a.fcreatepsnname like ? ) "
					+ " and a.fpaystateid like ? "
					+ str
					+ " order by a.fpaystate,a.fpaydate desc";
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			List<Map<String,Object>> dataList = dbBean.queryForList(sqlStr,page,fuzzySearch,fuzzySearch,fPayState);
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
		String fuzzyBill = "%" + dtbHelper.getStringValue("fuzzyBill") + "%";
		log.info("------------fid:" + fid);
		String sqlStr = "select distinct c.fp_num,c.fp_money,c.fmtype,"
				+ " to_char(c.fp_date,'yyyy-mm-dd') fp_date,"
				+ "c.fprovider,c.fpeople,c.bdown,c.fremark "
				+ " from Asset_ContractPay a,Asset_Bill c"
				+ " where c.fpid = a.fid "
				+ " and a.fid = '" + fid + "'"
				+ " and (c.fp_num like ? or c.fprovider like ? or c.fpeople like ?)";
		if (!fid.equals("")) {
			try {
				int start = Integer.valueOf(dtbHelper.getStringValue("start"));
				int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
				DBAccessBean dbBean = DBAccessPool.getDbBean();
				PaginationSupport page = new PaginationSupport(start, limit, limit);
				List<Map<String,Object>> dataList = dbBean.queryForList(sqlStr,page,fuzzyBill,fuzzyBill,fuzzyBill);
				
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
