package com.nantian.iwap.app.common;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.nantian.iwap.app.exp.ExpDataFactory;
import com.nantian.iwap.biz.actions.TransactionBizAction;
import com.nantian.iwap.biz.flow.BizActionException;
import com.nantian.iwap.databus.DTBHelper;

/**
 * 数据导出
 * 
 * @author wjj
 *
 */
public class ExportDataAction extends TransactionBizAction {
	private static Logger log = Logger.getLogger(ImportDataAction.class);

	@SuppressWarnings("rawtypes")
	@Override
	public int actionExecute(DTBHelper dtbHelper) throws BizActionException {
		int flag = 0;
		try {
			String exportFlag = dtbHelper.getStringValue("exportFlag");
			if (!"1".equals(exportFlag)) {
				return 1;
			}

			String filetype = dtbHelper.getStringValue("filetype");
			if (filetype == null || "".equals(filetype.trim())) {
				log.error("数据导出类型为空");
				dtbHelper.setError("exportdata-err-001", "数据导出类型为空");
				return flag;
			}

			ExpDataFactory edf = ExpDataFactory.getInstance();

			if (dtbHelper.getDataTransferBus().getElement("rows") == null) {
				dtbHelper.setError("exportdata-err-002", "数据总线缺少rows对象");
				return flag;
			} else if (!(dtbHelper.getDataTransferBus().getElement("rows").getAllValues()
					.get(0) instanceof java.util.List)) {
				dtbHelper.setError("exportdata-err-003", "数据总线rows对象不是java.util.List数据类型");
				return flag;
			}
			List dList = dtbHelper.getListValue("rows");

			String titleString = dtbHelper.getStringValue("titleString");
			titleString = new String(titleString.getBytes("ISO-8859-1"),"utf-8");
			List<Map<String, String>> titleList = new ArrayList<Map<String, String>>();
			if (titleString != null && !"".equals(titleString.trim())) {
				try {
					titleList = JSONObject.parseObject(titleString, new TypeReference<List<Map<String, String>>>() {
					});
				} catch (Exception e) {
					log.warn("格式化自定义表格列名出错", e);
				}
			}else{
				log.warn("前端未传入表格字段数据titleString对象");
			}

			Map rst = edf.expData(filetype, dList, titleList);
			if (rst.get("msg") != null && !"".equals(rst.get("msg").toString().trim())) {
				log.error("导出处理类数据导出出错:" + rst.get("msg"));
				dtbHelper.setError("exportdata-err-004", "[导出处理类数据导出出错]" + rst.get("msg"));
			} else {
				dtbHelper.setRstData("info", rst.get("info"));
				flag = 1;
			}
		} catch (Exception e) {
			log.error("数据导出出错", e);
			dtbHelper.setError("exportdata-err-005", "[数据导出出错]" + e.getMessage());
		}
		return flag;
	}

}
