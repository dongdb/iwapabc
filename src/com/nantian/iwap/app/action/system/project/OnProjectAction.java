package com.nantian.iwap.app.action.system.project;

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
public class OnProjectAction extends TransactionBizAction {

	private static Logger log = Logger.getLogger(OnProjectAction.class);
	
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
			String fState = "%" + dtbHelper.getStringValue("fState") + "%";
			String fCreateTime = dtbHelper.getStringValue("fCreateTime");
			String pid1 = dtbHelper.getStringValue("pid1");
			String pid2 = dtbHelper.getStringValue("pid2");
			String str= "";
			if(fCreateTime.equals("1") ){
				str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FCREATETIME,'mm')=to_char(sysdate,'mm')"
					+" and to_char(FCREATETIME,'dd')=to_char(sysdate,'dd')";
			}
			if(fCreateTime.equals("2")){
				str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FCREATETIME,'mm')=to_char(sysdate,'mm')"
					+" and to_char(FCREATETIME,'dd')=(to_char(sysdate,'dd')-1)";
			}
			if(fCreateTime.equals("3")){
				str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FCREATETIME,'iw')=to_char(sysdate,'iw')";
			}
			if(fCreateTime.equals("4")){
				str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FCREATETIME,'iw')=(to_char(sysdate,'iw')-1)";
			}
			if(fCreateTime.equals("5")){
				str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FCREATETIME,'mm')=to_char(sysdate,'mm')";
			}
			if(fCreateTime.equals("6")){
				str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')"
					+" and to_char(FCREATETIME,'mm')=(to_char(sysdate,'mm')-1)";
			}
			if(fCreateTime.equals("7")){
				str=" and to_char(FCREATETIME,'yyyy')=to_char(sysdate,'yyyy')";
			}
			if(fCreateTime.equals("8")){
				str=" and to_char(FCREATETIME,'yyyy')=(to_char(sysdate,'yyyy')-1)";
			}
			if(fCreateTime.equals("9")){
				str=" and FCREATETIME > to_date('"+pid1+"','yyyy-mm-dd')"
						+" and FCREATETIME < to_date('"+pid2+"','yyyy-mm-dd')";
			}
			String sqlStr = "select a.fid,a.fstate,a.projectid,"
					+ "a.ptype,a.pname,a.fcreatepsnname,"
					+ "to_char(a.cstarttime,'yyyy-mm-dd') cstarttime,"
					+ "to_char(a.fendtime,'yyyy-mm-dd') fendtime,"
					+ "to_char(a.cendtime,'yyyy-mm-dd') cendtime,"
					+ "to_char(a.fcreatetime,'yyyy-mm-dd') fcreatetime,"
					+ "a.pdown,a.fremark "
					+ " from asset_project a "
					+ " where 1=1 "
					+ " and (a.fstate like ? or a.projectid like ? or a.ptype like ? "
					+ " or a.pname like ? or a.fcreatepsnname like ? ) "
					+ " and a.fstate like ? "
					+ str
					+ " order by a.fstate,a.fcreatetime desc";
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			PaginationSupport page = new PaginationSupport(start, limit, limit);
			List<Map<String,Object>> dataList = dbBean.queryForList(sqlStr,page,fuzzySearch,fuzzySearch,fuzzySearch,fuzzySearch,fuzzySearch,fState);
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
		String fuzzyCon = "%" + dtbHelper.getStringValue("fuzzyCon") + "%";
		log.info("------------fid:" + fid);
		String sqlStr = "select distinct a.contractid,a.ctitle,"
				+ "a.cmoney,a.chavmoney,a.fprovider,"
				+ "to_char(a.cdate,'yyyy-mm-dd') cdate"
				+ " from asset_contract a,asset_project b "
				+ " where b.fid = a.projectid "
				+ " and b.fid = '" + fid + "'"
				+ " and (a.contractid like ? or a.fprovider like ? or a.ctitle like ?)";
		if (!fid.equals("")) {
			try {
				int start = Integer.valueOf(dtbHelper.getStringValue("start"));
				int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
				DBAccessBean dbBean = DBAccessPool.getDbBean();
				PaginationSupport page = new PaginationSupport(start, limit, limit);
				List<Map<String,Object>> dataList = dbBean.queryForList(sqlStr,page,fuzzyCon,fuzzyCon,fuzzyCon);
				
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
