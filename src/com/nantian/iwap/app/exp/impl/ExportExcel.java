package com.nantian.iwap.app.exp.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.nantian.iwap.app.exp.ExpDataFactory;
import com.nantian.iwap.app.exp.ExportData;
import com.nantian.iwap.persistence.DBAccessBean;
import com.nantian.iwap.persistence.DBAccessPool;

/**
 * 实现Excel依照数据库查询语句导出
 * 
 */
@SuppressWarnings({ "rawtypes", "unchecked" })
public class ExportExcel implements ExportData {
	private static Logger log = Logger.getLogger(ExportExcel.class);

	@Override
	public Map exportData(String fileExt, List dataList, List<Map<String, String>> titleList) {
		if (fileExt.endsWith("xls")) {
			return dbToXls(dataList, titleList);
		} else {
			return dbToXlsx(dataList, titleList);
		}
	}

	/**
	 * 获取标题数据
	 * 
	 * @param dbBean
	 * @param dataList
	 * @param titleList
	 *            [{key1:val1},{key2:val2}]
	 * @return {"titleId":List<String>,"titleNm":String[]}
	 */
	public Map getTitles(DBAccessBean dbBean, List<Map<String, Object>> dataList, List<Map<String, String>> titleList)
			throws Exception {
		Map titles = null;
		String sqlStr = "select di_id,di_title from sys_data_item where di_id in";
		List<String> titleId = new ArrayList<String>();
		String[] titleNm = null;
		try {
			StringBuffer titleBf = new StringBuffer();
			Map tnm_tl = new HashMap();
			if (titleList.size() > 0) {
				titleNm = new String[titleList.size()];
				for (Map<String, String> tMap : titleList) {
					Set keys = tMap.keySet();
					Iterator iterator = keys.iterator();
					while (iterator.hasNext()) {
						String key = iterator.next().toString();
						titleId.add(key);
						titleBf.append("?,");
						tnm_tl.put(key, tMap.get(key));
					}
				}
			} else {
				Map<String, Object> tMap = dataList.get(0);
				titleNm = new String[tMap.size()];
				Set keys = tMap.keySet();
				Iterator iterator = keys.iterator();
				while (iterator.hasNext()) {
					String key = iterator.next().toString();
					titleId.add(key);
					titleBf.append("?,");
				}
			}

			sqlStr += "(" + titleBf.substring(0, titleBf.length() - 1) + ")";
			List<Map<String, Object>> dList = dbBean.queryForList(sqlStr, titleId.toArray());
			Map tnm_dl = new HashMap();
			for (Map<String, Object> dMap : dList) {
				tnm_dl.put(dMap.get("di_id"), dMap.get("di_title"));
			}
			int i = 0;
			for (String t : titleId) {
				titleNm[i] = (tnm_dl.get(t) != null && !"".equals(tnm_dl.get(t).toString().trim()))
						? tnm_dl.get(t).toString()
						: (tnm_tl.get(t) != null && !"".equals(tnm_tl.get(t).toString().trim()))
								? tnm_tl.get(t).toString() : t;
				i++;
			}
			titles = new HashMap();
			titles.put("titleId", titleId);
			titles.put("titleNm", titleNm);
		} catch (Exception e) {
			log.error("获取标题数据出错", e);
		}
		return titles;

	}

	/**
	 * 导出2007之前的版本
	 * 
	 * @param dataList
	 * @return
	 */
	private Map dbToXls(List dataList, List<Map<String, String>> titleList) {
		Map rst = new HashMap();
		try {
			Workbook workbook = new HSSFWorkbook();
			rst = expData(workbook, dataList, titleList);
		} catch (Exception e) {
			log.error("导出Xls文件出错", e);
			rst.put("msg", "导出Xls文件出错:" + e.getMessage());
		}
		return rst;
	}

	/**
	 * 导出2007之后的版本
	 * 
	 * @param dataList
	 * @return
	 */
	private Map dbToXlsx(List dataList, List<Map<String, String>> titleList) {
		Map rst = new HashMap();
		try {
			Workbook workbook = new XSSFWorkbook();
			rst = expData(workbook, dataList, titleList);
		} catch (Exception e) {
			log.error("导出Xlsx文件出错", e);
			rst.put("msg", "导出Xlsx文件出错:" + e.getMessage());
		}
		return rst;
	}

	/**
	 * 导出数据
	 * 
	 * @param workbook
	 * @param dataList
	 * @param titleList
	 * @return
	 */
	private Map expData(Workbook workbook, List<Map<String, Object>> dataList, List<Map<String, String>> titleList) {
		Map rst = new HashMap();
		try {
			DBAccessPool.createDbBean();
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			Sheet sheet = workbook.createSheet();
			int maxLine = ExpDataFactory.MAX_LINE > dataList.size() ? dataList.size() : ExpDataFactory.MAX_LINE;
			if (dataList.size() > 0) {
				Map titles = this.getTitles(dbBean, dataList, titleList);
				String[] titleNm = null;
				List<String> titleId = null;
				if (titles == null || titles.get("titleNm") == null || titles.get("titleId") == null) {
					rst.put("msg", "导出数据出错:获取标题数据出错");
					return rst;
				} else {
					titleNm = (String[]) titles.get("titleNm");
					titleId = (List<String>) titles.get("titleId");
				}

				// 写入标题
				int cellCnt = 0;
				Row rowTitle = sheet.createRow(0);
				for (String tNm : titleNm) {
					Cell cell = rowTitle.createCell(cellCnt);
					cell.setCellValue(tNm);
					cellCnt++;
				}

				// 写入数据
				int rowCnt = 1;
				for (Map<String, Object> tmp : dataList) {
					if (rowCnt > maxLine) {
						break;
					}
					Row row = sheet.createRow(rowCnt);
					cellCnt = 0;
					for (String tId : titleId) {
						Cell cell = row.createCell(cellCnt);
						cell.setCellValue(tmp.get(tId) == null ? "" : tmp.get(tId).toString());
						cellCnt++;
					}
					rowCnt++;
				}
			}

			rst.put("info", workbook);
		} catch (Exception e) {
			log.error("导出数据出错", e);
			rst.put("msg", "导出数据出错:" + e.getMessage());
		} finally {
			DBAccessPool.releaseDbBean();
		}
		return rst;
	}

}
