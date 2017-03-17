package com.nantian.iwap.app.action.system;

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

public class AssetAccountBatisDaoAction extends BatisDaoAction {
	private static Logger log = Logger.getLogger(AssetAccountBatisDaoAction.class);
	private String querySqlId;
	private String existSqlId;
	private String updateSqlId;
	private String dtlSqlId;
	private static List<String> actionType = new ArrayList();

	static {
		actionType.add("query");
		actionType.add("update");
		actionType.add("detail");
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
				Method method = getClass().getMethod(actionType,new Class[] { DTBHelper.class });
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
				log.error("execute " + actionType + " method error!", e.getTargetException());
			}
		} else {
			log.error("unknow actionType [" + actionType + "]");
			dtbHelper.setError("SYSERROR-91002", "错误参数请求!");
		}
		return 0;
	}

	public int update(DTBHelper dtbHelper) {
		return IWAPBatisFactory.getInstance().getIwapBatisPool().update(this.updateSqlId, dtbHelper);
	}

	public int detail(DTBHelper dtbHelper) {
		Map map = IWAPBatisFactory.getInstance().getIwapBatisPool().queryForMap(this.dtlSqlId, dtbHelper);
		dtbHelper.setRstData(map);
		return map.size();
	}

	public int query(DTBHelper dtbHelper) {
		BatisAction action = new BatisAction();
		action.setSqlStr(this.querySqlId);
		return action.actionProcess(dtbHelper);
	}
	public String getQuerySqlId() {
		return this.querySqlId;
	}

	public void setQuerySqlId(String querySqlId) {
		this.querySqlId = querySqlId;
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

}