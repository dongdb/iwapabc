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
public class ContractManageAction extends TransactionBizAction {

	private static Logger log = Logger.getLogger(ContractManageAction.class);
	
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
		if ("contract".equals(option)) {
			return contract(dtbHelper);
		}
		return 0;
	}

	protected int query(DTBHelper dtbHelper) throws BizActionException {
		try {
			int start = Integer.valueOf(dtbHelper.getStringValue("start"));
			int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
			String fuzzySearch = "%" + dtbHelper.getStringValue("fuzzySearch") + "%";
			
			log.info("fuzzySeaerch:"+fuzzySearch);
			String sqlStr = "select a.fid,a.contractid,a.ctitle,"
					+ "to_char(a.cdate,'yyyy-mm-dd') cdate,a.frate,"
					+ "a.fprovider,a.cmoney,a.chavmoney,a.ctype,"
					+ "a.fcreatepsnname,b.projectid,b.pname,a.fcurrency,a.cdown,"
					+ "b.fdescription,b.ptype,b.ptypeid,a.fmtype,a.fwarnrate,"
					+ "b.fcreateognid,b.fcreateognname,b.fcreatedeptid,b.fcreatedeptname,"
					+ "b.fcreatepsnid,b.fcreatepsnfid,b.fremark BFREMARK,"
					+ "to_char(b.fcreatetime,'yyyy-mm-dd') fcreatetime,"
					+ "b.fstateid,b.fstate,a.fremark AFREMARK,"
					+ "to_char(b.cstarttime,'yyyy-mm-dd') cstarttime,"
					+ "to_char(b.cendtime,'yyyy-mm-dd') cendtime,"
					+ "to_char(b.fendtime,'yyyy-mm-dd') fendtime,"
					+ "b.fchangeid,b.fchange,b.pdown "
					+ "from Asset_Contract a,Asset_project b "
					+ " where 1=1 and a.ProjectID = b.fid "
					+ " and (a.contractid like ? or a.fprovider like ? or a.ctitle like ? "
					+ " or a.fcreatepsnname like ? ) "
					+ " order by a.CDate desc";
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
	
	protected int contract(DTBHelper dtbHelper) throws BizActionException {
		String fid = dtbHelper.getStringValue("fid");
		log.info("------------fid:" + fid);
		String sqlStr = "select distinct to_char(b.fpaydate,'yyyy-mm-dd') FPAYDATE,"
				+ "to_char(a.cdate,'yyyy-mm-dd') cdate,"
				+ "b.fmoney,b.fpaystate,b.fremark,"
				+ "b.pdown,b.fcreatepsnname "
				+ "from Asset_Contract a,Asset_ContractPay b,Asset_Bill c "
				+ "where b.contractfid = a.fid "
				+ "and c.fpid = b.fid "
				+ "and a.fid = '" + fid + "'";
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
