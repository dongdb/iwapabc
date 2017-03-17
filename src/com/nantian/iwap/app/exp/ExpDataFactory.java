package com.nantian.iwap.app.exp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

/**
 * 数据导出工厂
 * 
 * @author wjj
 *
 */
public class ExpDataFactory {
	private static Logger log = Logger.getLogger(ExpDataFactory.class);
	private static ExpDataFactory expDataFactory = null;
	private Map<String, ExportData> expProcess = new HashMap<String, ExportData>();// 导出实现类与类型配置
	public static int MAX_LINE = -1;

	private ExpDataFactory() {
	}

	public void setExpProcess(Map<String, ExportData> exp) {
		this.expProcess = exp;
	}

	public synchronized static ExpDataFactory getInstance() {
		if (expDataFactory == null) {
			expDataFactory = new ExpDataFactory();
		}
		return expDataFactory;
	}

	public void init(String maxLine, String... process) {
		try {
			if (!"".equals(maxLine)) {
				MAX_LINE = Integer.valueOf(maxLine);
			}

			Map<String, ExportData> exp = new HashMap<String, ExportData>();
			for (String p : process) {
				String[] array = p.split("_");
				if (array.length == 2) {
					Class<?> onwClass = Class.forName(array[1]);
					exp.put(array[0], (ExportData) onwClass.newInstance());
				}
			}
			ExpDataFactory impDataFactory = getInstance();
			impDataFactory.setExpProcess(exp);
		} catch (Exception e) {
			log.error("初始化导出工厂出错", e);
		}
	}

	/**
	 * 数据导出调用方法
	 * 
	 * @param fileExt
	 *            导出文件类型
	 * @param dataList
	 *            数据数列
	 * @param titleList
	 *            导出数据列名
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map expData(String fileExt, List dataList, List<Map<String, String>> titleList) {
		Map rst = new HashMap();
		ExportData expProc = expProcess.get(fileExt);
		if (expProc != null) {
			rst = expProc.exportData(fileExt, dataList, titleList);
		} else {
			rst.put("msg", "无对应导入处理");
		}
		return rst;
	}
}
