package com.nantian.iwap.app.action.system.base;

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
 * ClassName: BudgetTpAction <br/>
 * Function: 获取预算类别菜单<br/>
 * date: 2016年3月2日15:18:49 <br/>
 * 
 * @author zsj
 * @version
 * @since JDK 1.7 Copyright (c) 2016, 广州南天电脑系统有限公司 All Rights Reserved.
 */
public class BudgetTpAction extends TransactionBizAction {

	private static Logger log = Logger.getLogger(BudgetTpAction.class);
	
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
		return 0;
	}

	protected int query(DTBHelper dtbHelper) throws BizActionException {
		int flag = 0;
		try {
			int start = Integer.valueOf(dtbHelper.getStringValue("start"));
			int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			String fuzzySearch = "%" + dtbHelper.getStringValue("fuzzySearch") + "%";
			log.info("fuzzySearch:"+fuzzySearch);
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			List<Map<String, Object>> dataList = null;
			String sqlStr = "select FID,FYSLBID,FYSLBMC,VERSION "
						  + "from ASSETBUDGETTYPE "
						  + "where VERSION like ? or FYSLBID like ? or FYSLBMC like ? "
						  + "order by FYSLBID asc";
			dataList = dbBean.queryForList(sqlStr, page,fuzzySearch,fuzzySearch,fuzzySearch);	
			log.info(sqlStr);
			dtbHelper.setRstData("rows", dataList);
			dtbHelper.setRstData("total", page.getTotalCount());
			flag = 1;
		} catch (Exception e) {
			log.error("预算类别查询出错", e);
			dtbHelper.setError("budgettp-err-qry", "[预算类别查询出错]" + e.getMessage());
		}
		return flag;
	}

	protected int add(DTBHelper dtbHelper) throws BizActionException {
		int flag = 0;
		DBAccessBean dbBean = null;
		try {
			dbBean = DBAccessPool.getDbBean();
			dbBean.setAutoCommit(false);
			UUID uuid = UUID.randomUUID();
			String FID = uuid.toString().replaceAll("-", "");
			String FYSLBID = dtbHelper.getStringValue("FYSLBID");
			String FYSLBMC = dtbHelper.getStringValue("FYSLBMC");

			String sqlStr = "select FYSLBID from ASSETBUDGETTYPE where "
						  + "FYSLBID =? or FYSLBMC = ?";
			DataObject result = dbBean.executeSingleQuery(sqlStr, FYSLBID,FYSLBMC);
			if (result != null) {
				dbBean.executeRollBack();
				log.warn("预算类别新增出错：该预算类别已存在!");
				dtbHelper.setError("budgettp-err-add-001", "[预算类别新增出错]该预算类别已存在!");
				return flag;
			}
			sqlStr = "insert into ASSETBUDGETTYPE "
					+ "(FID,VERSION,FYSLBID,FYSLBMC) "
					+ "values (?,?,?,?)";
			dbBean.executeUpdate(sqlStr, FID, 0,FYSLBID,FYSLBMC);
			dbBean.executeCommit();
			flag = 1;
		} catch (Exception e) {
			log.error("预算类别新增出错", e);
			dtbHelper.setError("budgettp-err-add-002", "[预算类别新增出错]" + e.getMessage());
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
		int flag = 0;
		DBAccessBean dbBean = null;
		try {
			dbBean = DBAccessPool.getDbBean();
			dbBean.setAutoCommit(false);
			String FYSLBID = dtbHelper.getStringValue("FYSLBID");
			String FYSLBMC = dtbHelper.getStringValue("FYSLBMC");
			String FID = dtbHelper.getStringValue("FID");
			String VERSION = dtbHelper.getStringValue("VERSION");
			String sqlStr = "UPDATE ASSETBUDGETTYPE set "
						  + "FYSLBID=?,FYSLBMC=?,VERSION=?"
						  + " where FID=?";
			dbBean.executeUpdate(sqlStr, FYSLBID, FYSLBMC, VERSION, FID);
			dbBean.executeCommit();
			flag = 1;
		} catch (Exception e) {
			log.error("预算类别保存出错", e);
			dtbHelper.setError("budgettp-err-sv", "[预算类别保存出错]" + e.getMessage());
		}
		return flag;
	}

	protected int remove(DTBHelper dtbHelper) throws BizActionException {
		int flag = 0;
		DBAccessBean dbBean = null;
		try {
			dbBean = DBAccessPool.getDbBean();
			dbBean.setAutoCommit(false);
			String repids = dtbHelper.getStringValue("repids");
			String[] reparr = repids.split(",");
			int u_cnt = 0;
			int s_cnt = 0;
			for (String budget : reparr) {
				if (budget == null || "".equals(budget.trim())) {
					continue;
				}
				
				u_cnt++;
				int i = dbBean.executeUpdate("delete from ASSETBUDGETTYPE where FID = ?", budget);
				if (i == 1) {
					s_cnt++;
				}
			}
			dbBean.executeCommit();
			if (u_cnt != s_cnt) {
				log.warn("预算类别删除出错:删除失败" + (u_cnt - s_cnt) + "条");
				dtbHelper.setError("budgettp-err-rm-001", "[预算类别删除出错]删除失败" + (u_cnt - s_cnt) + "条");
			} else {
				flag = 1;
			}
		} catch (Exception e) {
			log.error("预算类别删除出错", e);
			dtbHelper.setError("budgettp-err-rm-002", "[预算类别删除出错]" + e.getMessage());
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
}
