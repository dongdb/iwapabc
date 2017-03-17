package com.nantian.iwap.app.imp.impl;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFFormulaEvaluator;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.nantian.iwap.app.imp.DefaultValue;
import com.nantian.iwap.app.imp.IAfterProcess;
import com.nantian.iwap.app.imp.IAllowRow;
import com.nantian.iwap.app.imp.IBeforeProcess;
import com.nantian.iwap.app.imp.ImportData;
import com.nantian.iwap.app.imp.SystemVariable;
import com.nantian.iwap.common.util.StringUtil;
import com.nantian.iwap.persistence.DBAccessBean;
import com.nantian.iwap.persistence.DBAccessPool;

/**
 * 实现Excel依照配置文件导入
 * 
 * @author stormhua modify by stormhua 20140604 增加是否允许当前行数据处理
 */
@SuppressWarnings(value = { "unchecked", "rawtypes" })
public class ImportExcel implements ImportData {
	private Map config;
	private static Logger log = Logger.getLogger(ImportExcel.class);

	public void setConfig(Map config) {
		this.config = config;
	}

	/**
	 * 构建更新SQL语句
	 * 
	 * @param importId
	 * @return
	 */
	private String buildUpdateSql(String importId) {
		StringBuffer sql = new StringBuffer(200);
		List pk = getPkField(importId);
		List cfgDtl = (List) ((Map) config.get(importId)).get("dtl");
		String table = getTable(importId);
		sql.append("update ").append(table).append(" set ");
		for (int i = 0; i < cfgDtl.size(); i++) {
			Map row = (Map) cfgDtl.get(i);
			if (!pk.contains(row.get("fldNm").toString())) {
				sql.append(row.get("fldNm")).append("=?,");
			}
		}
		sql.delete(sql.length() - 1, sql.length()).append(" where ");
		for (int j = 0; j < pk.size(); j++) {
			sql.append(pk.get(j)).append("=?");
			if (j >= 0 && (j + 1) < pk.size()) {
				sql.append(" and ");
			}
		}
		return sql.toString();
	}

	/**
	 * 构建插入SQL语句
	 * 
	 * @param importId
	 * @return
	 */
	private String buildInsertSql(String importId) {
		StringBuffer sql = new StringBuffer(200);
		StringBuffer param = new StringBuffer();
		List cfgDtl = (List) ((Map) config.get(importId)).get("dtl");
		String table = getTable(importId);
		sql.append("insert into ").append(table).append("(");
		for (int i = 0; i < cfgDtl.size(); i++) {
			Map row = (Map) cfgDtl.get(i);
			sql.append(row.get("fldNm")).append(",");
			param.append("?,");
		}
		sql.delete(sql.length() - 1, sql.length()).append(") values(");
		sql.append(param.delete(param.length() - 1, param.length()).toString()).append(")");
		return sql.toString();
	}

	/**
	 * 获取配置信息对应表
	 * 
	 * @param importId
	 * @return
	 */
	private String getTable(String importId) {
		return (String) ((Map) config.get(importId)).get("tblNm");
	}

	/**
	 * 判断记录是否存在
	 * 
	 * @param dbBean
	 * @param importId
	 * @param row
	 * @return
	 */
	private boolean exitsRecord(DBAccessBean dbBean, String importId, Map row) {
		StringBuffer sql = new StringBuffer(200);
		String table = getTable(importId);
		List param = new ArrayList();
		sql.append("select count(*) from ").append(table);
		sql.append(" where ");
		List pk = getPkField(importId);
		for (int j = 0; j < pk.size(); j++) {
			sql.append(pk.get(j)).append("=?");
			if ((j + 1) < pk.size()) {// j>0&&去掉此判断条件 2014-05-06 by liyuan
				sql.append(" and ");
			}
			param.add(row.get(pk.get(j)));
		}
		return dbBean.queryForInt(sql.toString(), param.toArray()) > 0;
	}

	/**
	 * 获取导入配置主键
	 * 
	 * @param importId
	 * @return
	 */
	private List getPkField(String importId) {
		List pkList = new ArrayList();
		List cfgDtl = (List) ((Map) config.get(importId)).get("dtl");
		for (int i = 0; i < cfgDtl.size(); i++) {
			Map row = (Map) cfgDtl.get(i);
			if ("0".equals(row.get("pkFlg"))) {
				pkList.add(row.get("fldNm"));
			}
		}
		return pkList;
	}

	/**
	 * 检查配置信息
	 * 
	 * @param importId
	 * @param rst
	 */
	private void checkConfig(String importId, Map rst) {
		Map cfg = (Map) config.get(importId);
		if (cfg.get("impTp") == null) {
			rst.put("flag", false);
			rst.put("msg", "配置信息错误,未设置导入类型\r\n");
		}
	}

	/**
	 * 导入Excel2007之前版本
	 * 
	 * @param fileName
	 * @param importId
	 * @return
	 */
	private Map xlsToDb(String fileName, String importId, boolean isOverWrite) {
		String table = getTable(importId);
		StringBuffer msg = new StringBuffer(200);
		Map rst = new HashMap();
		log.info("开始导入Excel" + fileName + " table=" + table + " isOverWrite=" + isOverWrite);
		rst.put("flag", true);
		// String tmpNm=fileName.substring(fileName.lastIndexOf("/")+1);
		String sepatator = System.getProperties().getProperty("file.separator");
		String tmpNm = fileName.substring(fileName.lastIndexOf(sepatator) + 1);
		tmpNm = tmpNm.substring(0, tmpNm.lastIndexOf("."));
		Map cfg = (Map) config.get(importId);
		checkConfig(importId, rst);
		if (rst.get("flag").equals("false")) {
			return rst;
		}
		String impTp = (String) cfg.get("impTp");
		int startIdx = 0;
		int startCol = 0;
		int sheetIdx = 0;
		if (cfg.get("startIdx") != null) {
			startIdx = (Integer) cfg.get("startIdx");
		}
		if (cfg.get("startCol") != null) {
			startCol = (Integer) cfg.get("startCol");
		}
		if (cfg.get("sheetIdx") != null) {
			sheetIdx = (Integer) cfg.get("sheetIdx");
		}
		try {
			DBAccessPool.createDbBean();
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			HSSFWorkbook workbook = new HSSFWorkbook(new FileInputStream(fileName));
			Sheet sheet = workbook.getSheetAt(sheetIdx);
			rst = this.impData(dbBean, impTp, sheet, startIdx, startCol, importId, isOverWrite);
		} catch (FileNotFoundException e) {
			log.warn("导入Excel", e);
			msg.append("文件未发现\r\n");
		} catch (IOException e) {
			log.warn("导入ExcelIo异常", e);
			msg.append("读文件异常\r\n");
		} catch (InstantiationException e) {
			log.warn("服务器异常", e);
			msg.append("服务器异常\r\n");
		} catch (IllegalAccessException e) {
			log.warn("访问异常", e);
			msg.append("访问异常\r\n");
		} catch (ClassNotFoundException e) {
			log.warn("类加载失败", e);
			msg.append("类找不到\r\n");
		} finally {
			DBAccessPool.releaseDbBean();
		}
		rst.put("msg", msg);
		return rst;
	}

	/**
	 * 导入2007之后的版本
	 * 
	 * @param fileName
	 * @param importId
	 * @return
	 */
	@SuppressWarnings("deprecation")
	private Map xlsxToDb(String fileName, String importId, boolean isOverWrite) {
		String table = getTable(importId);
		StringBuffer msg = new StringBuffer(200);
		Map rst = new HashMap();
		log.info("开始导入Excel" + fileName + " table=" + table + " isOverWrite=" + isOverWrite);
		rst.put("flag", true);
		Map cfg = (Map) config.get(importId);
		checkConfig(importId, rst);
		String sepatator = System.getProperties().getProperty("file.separator");
		String tmpNm = fileName.substring(fileName.lastIndexOf(sepatator) + 1);
		tmpNm = tmpNm.substring(0, tmpNm.lastIndexOf("."));
		if (rst.get("flag").equals("false")) {
			return rst;// ${fileNm} //${sysdate}
		}
		String impTp = (String) cfg.get("impTp");
		int startIdx = 0;
		int startCol = 0;
		int sheetIdx = 0;
		if (cfg.get("startIdx") != null) {
			startIdx = (Integer) cfg.get("startIdx");
		}
		if (cfg.get("startCol") != null) {
			startCol = (Integer) cfg.get("startCol");
		}
		if (cfg.get("sheetIdx") != null) {
			sheetIdx = (Integer) cfg.get("sheetIdx");
		}
		try {
			DBAccessPool.createDbBean();
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			XSSFWorkbook workbook = new XSSFWorkbook(fileName);
			Sheet sheet = workbook.getSheetAt(sheetIdx);
			rst = this.impData(dbBean, impTp, sheet, startIdx, startCol, importId, isOverWrite);
		} catch (FileNotFoundException e) {
			log.warn("导入Excel", e);
			msg.append("文件未发现\r\n");
		} catch (IOException e) {
			log.warn("导入ExcelIo异常", e);
			msg.append("读文件异常\r\n");
		} catch (InstantiationException e) {
			log.warn("服务器异常", e);
			msg.append("服务器异常\r\n");
		} catch (IllegalAccessException e) {
			log.warn("访问异常", e);
			msg.append("访问异常\r\n");
		} catch (ClassNotFoundException e) {
			log.warn("类加载失败", e);
			msg.append("类找不到\r\n");
		} finally {
			DBAccessPool.releaseDbBean();
		}
		rst.put("msg", msg);
		return rst;
	}

	private Map impData(DBAccessBean dbBean, String impTp, Sheet sheet, int startIdx, int startCol, String importId,
			boolean isOverWrite) throws InstantiationException, IllegalAccessException, ClassNotFoundException {
		Map rst = new HashMap();
		if (((Map) config.get(importId)).get("beforeProc") != null
				&& !"".equals(((Map) config.get(importId)).get("beforeProc").toString().trim())) {
			String bProc = (String) ((Map) config.get(importId)).get("beforeProc");
			IBeforeProcess beforeProc = (IBeforeProcess) Class.forName(bProc).newInstance();
			if (!beforeProc.process((Map) config.get(importId), sheet)) {// 处理失败
				log.warn(importId + "导入前处理失败");
				rst.put("msg", "导入前处理失败");
				return rst;
			}
		}
		String insertSql = this.buildInsertSql(importId);
		String modifySql = this.buildUpdateSql(importId);
		final List updateParam = new ArrayList();
		final List insertParam = new ArrayList();
		Object allow = ((Map) config.get(importId)).get("allowRow");
		IAllowRow allowRow = null;
		if (allow != null && !"".equals(allow.toString().trim())) {
			try {
				allowRow = (IAllowRow) Class.forName(allow.toString()).newInstance();
			} catch (Exception e) {
				log.warn(importId + "配置[" + allow.toString() + "]出错", e);
				rst.put("msg", "配置[" + allow.toString() + "]出错");
				return rst;
			}
		}
		short bgClr = -1;
		short border = 0;
		if ("0".endsWith(impTp)) {// 列表形式导入
			int rowSum = sheet.getLastRowNum();
			for (; startIdx <= rowSum; startIdx++) {// 循环数据域
				Row row = sheet.getRow(startIdx);
				if (bgClr == -1) {
					bgClr = row.getCell(startCol).getCellStyle().getFillBackgroundColor();
					border = row.getCell(startCol).getCellStyle().getBorderBottom();
				} else {// 判断样式和边框是否相等
					if (row.getCell(startCol).getCellStyle().getFillBackgroundColor() != bgClr
							|| row.getCell(startCol).getCellStyle().getBorderBottom() != border) {
						break;
					}
				}
				List cfgDtl = (List) ((Map) config.get(importId)).get("dtl");
				int seq = 0;
				Map value = new HashMap();
				List p = new ArrayList();
				boolean blankCheck = true;
				for (int i = 0; i < cfgDtl.size(); i++) {// 循环字段
					Map fieldCfg = (Map) cfgDtl.get(i);
					String val = null;
					if (fieldCfg.get("defVal") != null && !"".equals(fieldCfg.get("defVal").toString())) {// 设置默认值
						String settingDefVal = (String) fieldCfg.get("defVal");
						if ("1".equals(fieldCfg.get("defValTp"))) {
							Cell cell = row.getCell(startCol + seq);
							if (cell == null) {
								val = null;
							} else {
								val = getCellValue(cell, sheet.getWorkbook());
							}
							value.put(fieldCfg.get("fldNm"), val);
							DefaultValue defValGen = (DefaultValue) Class.forName(settingDefVal).newInstance();
							val = defValGen.generateValue(value, (String) fieldCfg.get("fldNm"));
							seq++;
						} else {
							SystemVariable var = SystemVariableImpl.getInstance();
							val = var.transVariable(settingDefVal);
						}

					} else {// 直接从excel中读取
						Cell cell = row.getCell(startCol + seq);
						if (cell == null) {
							val = null;
						} else {
							val = getCellValue(cell, sheet.getWorkbook());
						}
						if (isMergedRegion(sheet, startIdx, startCol + seq)) {
							seq++;
						}
						seq++;
					}

					// 判断当前字段是否主键且非空
					if ("0".equals(fieldCfg.get("pkFlg"))) {
						if (StringUtil.isBlank(val)) {
							blankCheck = false;
							break;
						}
					}
					// 判断当前字段是否允许非空且合法
					if ("0".equals(fieldCfg.get("allowBlank"))) {
						if (StringUtil.isBlank(val)) {
							blankCheck = false;
							break;
						}
					}
					value.put(fieldCfg.get("fldNm"), val);
					p.add(val);
				}

				// 判断当前行是否通过非空判断
				if (!blankCheck) {
					continue;
				}

				// 增加当前行是否有效判断
				if (allowRow != null) {
					if (!allowRow.allow(value)) {
						continue;
					}
				}
				boolean exist = this.exitsRecord(dbBean, importId, value);
				if (exist && isOverWrite) {// 如果存在记录并允许覆盖
					// 目的是为了匹配update时参数与值能对应上 by ly
					List pk = getPkField(importId);
					List p_updateParam = new ArrayList();
					List cfgDtl_param = (List) ((Map) config.get(importId)).get("dtl");
					for (int i = 0; i < cfgDtl_param.size(); i++) {
						Map row_update_list = (Map) cfgDtl_param.get(i);
						if (!pk.contains(row_update_list.get("fldNm").toString())) {
							p_updateParam.add(value.get(row_update_list.get("fldNm").toString()));
						}
					}
					for (int j = 0; j < pk.size(); j++) {
						p_updateParam.add(value.get(pk.get(j).toString()));
					}
					updateParam.add(p_updateParam);
				} else if (!exist) {// 不存在
					int sum = 0;
					List cfgDtl_param = (List) ((Map) config.get(importId)).get("dtl");
					for (int i = 0; i < cfgDtl_param.size(); i++) {
						Map row_update_list = (Map) cfgDtl_param.get(i);
						if (value.get(row_update_list.get("fldNm").toString()) == null
								|| value.get(row_update_list.get("fldNm").toString()).equals("")) {
							sum++;
						}
					}
					if (sum < (Float.parseFloat(String.valueOf(cfgDtl_param.size()))) / 2) {
						insertParam.add(p);
					}
				} // 需要把重复记录提示的话需要在这里实现
			}
		} else {// 单表形式导入
			List cfgDtl = (List) ((Map) config.get(importId)).get("dtl");
			Map value = new HashMap();
			List p = new ArrayList();
			boolean blankCheck = true;
			for (int i = 0; i < cfgDtl.size(); i++) {// 循环字段
				Map fieldCfg = (Map) cfgDtl.get(i);
				String val = null;
				if (fieldCfg.get("defValTp") != null && !"".equals(fieldCfg.get("defVal").toString())) {// 设置默认值
					String settingDefVal = (String) fieldCfg.get("defVal");

					if ("1".equals(fieldCfg.get("defValTp"))) {
						DefaultValue defValGen = (DefaultValue) Class.forName(settingDefVal).newInstance();
						val = defValGen.generateValue(value, (String) fieldCfg.get("fldNm"));
					} else {
						SystemVariable var = SystemVariableImpl.getInstance();
						val = var.transVariable(settingDefVal);
					}
				} else {// 直接从excel中读取
					if (fieldCfg.get("defVal") != null) {
						String setVal = (String) fieldCfg.get("defVal");// getCustomID;Cont_cust_id
						int r = Integer.parseInt(setVal.substring(1)) - 1;
						setVal = setVal.toUpperCase();
						Row row = sheet.getRow(r);
						int col = (int) setVal.charAt(0) - 65;
						val = getCellValue(row.getCell(col), sheet.getWorkbook());
					} else {
						val = "";
					}
				}
				// 判断当前字段是否主键且非空
				if ("0".equals(fieldCfg.get("pkFlg"))) {
					if (StringUtil.isBlank(val)) {
						blankCheck = false;
						break;
					}
				}
				// 判断当前字段是否允许非空且合法
				if ("0".equals(fieldCfg.get("allowBlank"))) {
					if (StringUtil.isBlank(val)) {
						blankCheck = false;
						break;
					}
				}
				value.put(fieldCfg.get("fldNm"), val);
				p.add(val);

			}

			// 判断当前行是否通过非空判断
			if (!blankCheck) {
				rst.put("msg", "导入数据未能通过非空校验");
				return rst;
			}

			if (allowRow != null) {// 需要对记录进行检查
				if (!allowRow.allow(value)) {// 当前记录需要舍去
					rst.put("msg", "导入数据未能通过校验");
					return rst;
				}
			}
			boolean exist = this.exitsRecord(dbBean, importId, value);
			if (exist && isOverWrite) {// 如果存在记录并允许覆盖
				// 目的是为了匹配update时参数与值能对应上 by ly
				List pk = getPkField(importId);
				List p_updateParam = new ArrayList();
				List cfgDtl_param = (List) ((Map) config.get(importId)).get("dtl");
				for (int i = 0; i < cfgDtl_param.size(); i++) {
					Map row_update_one = (Map) cfgDtl_param.get(i);
					if (!pk.contains(row_update_one.get("fldNm").toString())) {
						p_updateParam.add(value.get(row_update_one.get("fldNm").toString()));
					}
				}
				for (int j = 0; j < pk.size(); j++) {
					p_updateParam.add(value.get(pk.get(j).toString()));
				}
				updateParam.add(p_updateParam);
			} else if (!exist) {// 不存在
				//// 添加row中，主键值都为空的情况下不给插入数据
				insertParam.add(p);
			} // 需要把重复记录提示的话需要在这里实现
		}

		// 在覆盖情况下如果新增和修改条数为0，则提示错误 by lihl 2014-05-28 15:21:14
		if (insertParam.size() + updateParam.size() == 0 && isOverWrite == true) {
			throw new RuntimeException("插入参数为空");
		}

		int succCnt = 0;
		if (insertParam.size() > 0) {
			System.out.println(insertSql);
			System.out.println(insertParam);
			succCnt += dbBean.batchUpdate(insertSql, insertParam);
		}

		if (updateParam.size() > 0) {
			System.out.println(modifySql);
			System.out.println(updateParam);
			succCnt += dbBean.batchUpdate(modifySql, updateParam);
		}
		rst.put("info", "成功导入数据" + succCnt + "条");
		log.info(importId + "成功导入数据" + succCnt + "条");
		try {
			if (((Map) config.get(importId)).get("afterProc") != null
					&& !"".equals(((Map) config.get(importId)).get("afterProc").toString().trim())) {
				String aProc = (String) ((Map) config.get(importId)).get("afterProc");
				IAfterProcess afterProc = (IAfterProcess) Class.forName(aProc).newInstance();
				if (afterProc.process((Map) config.get(importId), sheet)) {
					log.warn(importId + "导入后处理失败");
				}
			}
		} catch (Exception e) {
			log.warn(importId + "导入后处理出错", e);
		}
		return rst;
	}

	private String getCellValue(Cell cell, Workbook workbook) {
		String rst = null;
		Date dateRst = null;// 日期格式取值
		int type = cell.getCellType();
		switch (type) {
		case Cell.CELL_TYPE_STRING:
			rst = cell.getStringCellValue();
			break;
		case Cell.CELL_TYPE_NUMERIC:
			// 添加日期格式判断 by lihl 2014-05-06 10:36:16
			if (HSSFDateUtil.isCellDateFormatted(cell)) {// 若是日期格式，则先获取日期再转换成字符串
				try {
					dateRst = cell.getDateCellValue();
					rst = new SimpleDateFormat("yyyy-MM-dd").format(dateRst);
				} catch (Exception e) {
					e.printStackTrace();
				}

			} else {// 非日期格式
				Double d = cell.getNumericCellValue();
				if (d.intValue() == d.doubleValue()) {
					rst = String.valueOf(d.intValue());
				} else {
					rst = d.toString();
				}
			}
			break;
		case Cell.CELL_TYPE_FORMULA:
			if (cell instanceof HSSFCell) {
				HSSFFormulaEvaluator f = new HSSFFormulaEvaluator((HSSFWorkbook) workbook);
				try {
					rst = f.evaluate(cell).formatAsString();
				} catch (Exception e) {
					try {
						rst = String.valueOf(cell.getNumericCellValue());
					} catch (IllegalStateException e1) {
						rst = String.valueOf(cell.getRichStringCellValue());
					}
				}
			} else {
				try {
					Double d = cell.getNumericCellValue();
					if (d.intValue() == d.doubleValue()) {
						rst = String.valueOf(d.intValue());
					} else {
						rst = d.toString();
					}
				} catch (Exception e) {
					rst = String.valueOf(cell.getRichStringCellValue());
				}
			}
			break;
		default:
			rst = "";
		}
		return rst;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see load.ImportData#importData(java.lang.String, java.lang.String,
	 * boolean)
	 */
	public Map importData(String fileName, String importId, boolean isOverWrite) {
		if (fileName.endsWith("xls")) {
			return xlsToDb(fileName, importId, isOverWrite);
		} else {
			return xlsxToDb(fileName, importId, isOverWrite);
		}
	}

	/**
	 * 判断是否有单元格合并
	 * 
	 * @param sheet
	 * @param
	 * @param column
	 * @return
	 */
	public boolean isMergedRegion(Sheet sheet, int row, int column) {
		int sheetMergeCount = sheet.getNumMergedRegions();
		for (int i = 0; i < sheetMergeCount; i++) {
			CellRangeAddress ca = sheet.getMergedRegion(i);
			int firstColumn = ca.getFirstColumn();
			int lastColumn = ca.getLastColumn();
			int firstRow = ca.getFirstRow();
			int lastRow = ca.getLastRow();

			if (row >= firstRow && row <= lastRow) {
				if (column >= firstColumn && column <= lastColumn) {

					return true;
				}
			}
		}

		return false;
	}

}
