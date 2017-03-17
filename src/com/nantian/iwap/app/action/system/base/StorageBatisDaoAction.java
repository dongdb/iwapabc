package com.nantian.iwap.app.action.system.base;

import com.nantian.iwap.app.common.PubAction;
import com.nantian.iwap.biz.actions.BatisAction;
import com.nantian.iwap.biz.actions.BatisDaoAction;
import com.nantian.iwap.biz.flow.BizActionException;
import com.nantian.iwap.common.util.StringUtil;
import com.nantian.iwap.databus.DTBHelper;
import com.nantian.iwap.ibatis.IWAPBatisFactory;
import com.nantian.iwap.persistence.DBAccessBean;
import com.nantian.iwap.persistence.DBAccessPool;
import com.nantian.iwap.persistence.DataObject;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import java.util.UUID;

import com.nantian.iwap.common.util.DateUtil;

import java.text.ParseException;
import java.text.SimpleDateFormat;

public class StorageBatisDaoAction extends BatisDaoAction {
	private static Logger log = Logger.getLogger(StorageBatisDaoAction.class);
	private String querySqlId;
	private String deleteSqlId;
	private String insertSqlId;
	private String existSqlId;
	private String updateSqlId;
	private String dtlSqlId;
	private String startSqlId;
	private String stopSqlId;
	private String countSqlId;
	
	private static List<String> actionType = new ArrayList();

	static {
		actionType.add("query");
		actionType.add("delete");
		actionType.add("update");
		actionType.add("insert");
		actionType.add("detail");
		actionType.add("restart");
		actionType.add("stop");
	}

	public int actionExecute(DTBHelper dtbHelper) throws BizActionException {
		String actionType = dtbHelper.getStringValue("actionType");
		if (StringUtil.isBlank(actionType)) {
			actionType = "query";
			log.warn("actionType not set then default [query]");
		}
		actionType = actionType.toLowerCase();
		if (actionType.contains(actionType)) {
			try {
				Method method = getClass().getMethod(actionType,
						new Class[] { DTBHelper.class });
				Object ret = method.invoke(this, new Object[] { dtbHelper });
				return Integer.parseInt(ret.toString());
			} catch (NoSuchMethodException e) {
				log.error("unknow actionType [" + actionType + "]", e);
			} catch (SecurityException e) {
				log.error("SecurityException:", e);
			} catch (IllegalAccessException e) {
				log.error("IllegalAccessException:", e);
			} catch (IllegalArgumentException e) {
				log.error("IllegalArgumentException:", e);
			} catch (InvocationTargetException e) {
				log.error("execute " + actionType + " method error!",
						e.getTargetException());
			}
		} else {
			log.error("unknow actionType [" + actionType + "]");
			dtbHelper.setError("SYSERROR-91002", "错误参数请求!");
		}
		return 0;
	}

	public int insert(DTBHelper dtbHelper) {
		// 改写
		UUID uuid = UUID.randomUUID();
		dtbHelper.setStringValue("FID", uuid.toString().replaceAll("-", ""));
		Map map1 = IWAPBatisFactory.getInstance().getIwapBatisPool()
				.queryForList(this.countSqlId, dtbHelper).get(0);
		Map map = IWAPBatisFactory.getInstance().getIwapBatisPool()
				.queryForList(this.existSqlId, dtbHelper).get(0);
		
		
		String status = dtbHelper.getStringValue("FUSESTATUSNAME");
		if(status.equals("启用")){
			dtbHelper.setStringValue("FUSESTATUS", "1");
		}else{
			dtbHelper.setStringValue("FUSESTATUS", "0");
		}
		dtbHelper.setStringValue("PSNID", dtbHelper.getStringValue("userInfo.ACCT_ID"));
		dtbHelper.setStringValue("PSNNM", dtbHelper.getStringValue("userInfo.ACCT_NM"));
		dtbHelper.setStringValue("ORGID", dtbHelper.getStringValue("userInfo.ORG_ID"));
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time= DateUtil.getCurrentDate("yyyy-MM-dd HH:mm:ss");
		try {
			java.util.Date passUtilDate = date.parse(time);
			dtbHelper.setObjectValue("FCREATETIME", passUtilDate);
			if (String.valueOf(map.get("CNT")).equals("0")) {
				dtbHelper.setStringValue("FSEQUENCE", String.valueOf(map1.get("CNT")));
				return IWAPBatisFactory.getInstance().getIwapBatisPool()
						.insert(this.insertSqlId, dtbHelper);
			} else {
				dtbHelper.setError("ADD-Storage-ERR", "入库方式已存在!");
				return -1;
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	public int update(DTBHelper dtbHelper) {
		Map map = IWAPBatisFactory.getInstance().getIwapBatisPool()
				.queryForList(this.existSqlId, dtbHelper).get(0);
		String status = dtbHelper.getStringValue("FUSESTATUSNAME");
		if(status.equals("启用")){
			dtbHelper.setStringValue("FUSESTATUS", "1");
		}else{
			dtbHelper.setStringValue("FUSESTATUS", "0");
		}
		dtbHelper.setStringValue("PSNID", dtbHelper.getStringValue("userInfo.ACCT_ID"));
		dtbHelper.setStringValue("PSNNM", dtbHelper.getStringValue("userInfo.ACCT_NM"));
		
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time= DateUtil.getCurrentDate("yyyy-MM-dd HH:mm:ss");
		try {
			java.util.Date passUtilDate = date.parse(time);
			dtbHelper.setObjectValue("FUPDATETIME", passUtilDate);
			return IWAPBatisFactory.getInstance().getIwapBatisPool()
					.update(this.updateSqlId, dtbHelper);
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	public int delete(DTBHelper dtbHelper) {
		// 改写
		return IWAPBatisFactory.getInstance().getIwapBatisPool()
				.delete(this.deleteSqlId, dtbHelper);
	}

	public int detail(DTBHelper dtbHelper) {
		Map map = IWAPBatisFactory.getInstance().getIwapBatisPool()
				.queryForMap(this.dtlSqlId, dtbHelper);
		dtbHelper.setRstData(map);
		return map.size();
	}

	public int query(DTBHelper dtbHelper) {
		BatisAction action = new BatisAction();
		action.setSqlStr(this.querySqlId);
		return action.actionProcess(dtbHelper);
	}
	
	public int restart(DTBHelper dtbHelper) {
		// 改写
		dtbHelper.setStringValue("PSNID", dtbHelper.getStringValue("userInfo.ACCT_ID"));
		dtbHelper.setStringValue("PSNNM", dtbHelper.getStringValue("userInfo.ACCT_NM"));
		dtbHelper.setStringValue("FID", dtbHelper.getStringValue("FID"));
		
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time= DateUtil.getCurrentDate("yyyy-MM-dd HH:mm:ss");
		try {
			java.util.Date passUtilDate = date.parse(time);
			dtbHelper.setObjectValue("FUPDATETIME", passUtilDate);
			return IWAPBatisFactory.getInstance().getIwapBatisPool()
					.delete(this.startSqlId, dtbHelper);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}
	
	public int stop(DTBHelper dtbHelper) {
		// 改写
		dtbHelper.setStringValue("PSNID", dtbHelper.getStringValue("userInfo.ACCT_ID"));
		dtbHelper.setStringValue("PSNNM", dtbHelper.getStringValue("userInfo.ACCT_NM"));
		dtbHelper.setStringValue("FID", dtbHelper.getStringValue("FID"));

		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time= DateUtil.getCurrentDate("yyyy-MM-dd HH:mm:ss");
		try {
			java.util.Date passUtilDate = date.parse(time);
			dtbHelper.setObjectValue("FUPDATETIME", passUtilDate);
			return IWAPBatisFactory.getInstance().getIwapBatisPool()
					.delete(this.stopSqlId, dtbHelper);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	public String getQuerySqlId() {
		return this.querySqlId;
	}

	public void setQuerySqlId(String querySqlId) {
		this.querySqlId = querySqlId;
	}

	public String getDeleteSqlId() {
		return this.deleteSqlId;
	}

	public void setDeleteSqlId(String deleteSqlId) {
		this.deleteSqlId = deleteSqlId;
	}

	public String getInsertSqlId() {
		return this.insertSqlId;
	}

	public void setInsertSqlId(String insertSqlId) {
		this.insertSqlId = insertSqlId;
	}

	public String getUpdateSqlId() {
		return this.updateSqlId;
	}

	public void setUpdateSqlId(String updateSqlId) {
		this.updateSqlId = updateSqlId;
	}

	public String getExistSqlId() {
		return existSqlId;
	}
	
	public void setExistSqlId(String existSqlId) {
		this.existSqlId = existSqlId;
	}
	public void setStartSqlId(String startSqlId) {
		this.startSqlId = startSqlId;
	}
	
	public String getStartSqlId() {
		return startSqlId;
	}
	
	public String getStoptSqlId() {
		return stopSqlId;
	}

	public void setStopSqlId(String stopSqlId) {
		this.stopSqlId = stopSqlId;
	}

	public String getCountSqlId() {
		return countSqlId;
	}

	public void setCountSqlId(String countSqlId) {
		this.countSqlId = countSqlId;
	}
	
	

}