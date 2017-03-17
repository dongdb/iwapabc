package com.nantian.iwap.app.exp;

import java.util.List;
import java.util.Map;

/**
 * 导出数据接口，实现该类须实现某一类型文件数据导出
 * 
 * @author stormhua
 *
 */
@SuppressWarnings("rawtypes")
public interface ExportData {

	/**
	 * 实现数据导出功能
	 * 
	 * @param fileExt
	 *            导出文件类型
	 * @param dataList
	 *            数据数列
	 * @param titleList
	 *            导出数据列名
	 * @return
	 */
	public Map exportData(String fileExt, List dataList, List<Map<String, String>> titleList);

}
