package com.nantian.iwap.app.action.system.base;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.nantian.iwap.action.common.CRUDAction;
import com.nantian.iwap.biz.flow.BizActionException;
import com.nantian.iwap.common.util.DateUtil;
import com.nantian.iwap.databus.DTBHelper;
import com.nantian.iwap.persistence.DBAccessBean;
import com.nantian.iwap.persistence.DBAccessPool;
import com.nantian.iwap.persistence.DataObject;
import com.nantian.iwap.persistence.SequenceHelper;

public class AssetClassifyAction extends CRUDAction {
	private static Logger logger = Logger.getLogger(AssetClassifyAction.class);

	@Override
	protected int query(DTBHelper dtbHelper) {
		String menuName = dtbHelper.getStringValue("menuName");
		String sql = "select fid,ac_node_type,ac_parent,ac_name,ac_code,ac_unit,"
				+ "ffinancecategory,fyslb,fyslbname,ac_bp,ac_description "
				+ "from ASSET_CLASSIFICATION where 1=1 "
				+ "and (ac_name like ? or ac_code like ?) ORDER BY ac_order asc";
		
		System.out.println("-----"+sql);
		try {
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			List<DataObject> resultList = dbBean.executeQuery(sql,menuName,menuName);
			logger.info("执行sql语句:" + sql);
			String zNodes = "";
			for (DataObject tmp : resultList) {
				zNodes += String.format("{id:'%s',ac_node_type:'%s', PID:'%s', ac_name:'%s',ac_code:%s,ac_unit:'%s',ffinancecategory:'%s',fyslb:'%s',fyslbname:'%s',ac_bp:'%s',ac_description:'%s'},",
						tmp.getValue("fid"), tmp.getValue("ac_node_type"), tmp.getValue("ac_parent"), tmp.getValue("ac_name"),
						tmp.getValue("ac_code"), tmp.getValue("ac_unit"), tmp.getValue("ffinancecategory"), 
						tmp.getValue("fyslb"),tmp.getValue("fyslbname"), tmp.getValue("ac_bp"), tmp.getValue("ac_description")
						);
			}
			if (zNodes.length() > 0) {
				zNodes = zNodes.substring(0, zNodes.length() - 1);
				zNodes = "[" + zNodes + "]";
			}else {
				dtbHelper.setError("menumg-err-zNodes", "[菜单内无对应数据!]" );
				return 0;
			}
			dtbHelper.setRstData("zNodes", zNodes);
		} catch (Exception e) {
			logger.error("菜单查询出错", e);
			dtbHelper.setError("menumg-err-qry", "[菜单查询出错]"+e.getMessage());
			return 0;
		}
		return 1;
	}

	@Override
	protected int add(DTBHelper dtbHelper) {
		String opcode = dtbHelper.getStringValue("OPCODE");
		String module_nm = dtbHelper.getStringValue("MODULE_NM");
		String pmodule_id = dtbHelper.getStringValue("PMODULE_ID");
		String module_valid = dtbHelper.getStringValue("MODULE_VALID");
		String module_hide = dtbHelper.getStringValue("MODULE_HIDE");
		String module_type = dtbHelper.getStringValue("MODULE_TYPE");
		String help_title = dtbHelper.getStringValue("HELP_TITLE");
		String help_page = dtbHelper.getStringValue("HELP_PAGE");
		String module_order = dtbHelper.getStringValue("MODULE_ORDER");
		String param_opcode = dtbHelper.getStringValue("PARAM_OPCODE");
		
		try {
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			String sql = "";
			
			if(Integer.valueOf(module_type)==0){//增加分类
				//pmodule_id = "";
			}else{
				sql = "select * from sys_module where module_id =  ? ";
				DataObject data = dbBean.executeSingleQuery(sql, pmodule_id);
				String _moduleType  = data.getValue("module_type");
			
				if ("2".equals(_moduleType)) {
					dtbHelper.setError("menumg-err-add-001", "该菜单没有子菜单!");
					return 0;
				}
				
				if(!"1".equals(_moduleType)){
					if(_moduleType==null){
						dtbHelper.setError("menumg-err-add-002", "该上级模块不存在!");
						return 0;
					}else{
						if (Integer.valueOf(module_type) <= Integer.valueOf(_moduleType)) {
							dtbHelper.setError("menumg-err-add-003", "模块类型不能高于或等于上级模块类型!");
							return 0;
						}
					}
				}
			}
			
			sql = "select * from sys_module where module_order =  ?";
			DataObject obj = dbBean.executeSingleQuery(sql, module_order);
			if(obj != null){
				dtbHelper.setError("menumg-err-add-004", "该模块排序值已存在,请重新输入");
				return 0;
			}
			//String module_id = SequenceHelper.generate("module_id");//序列号
			String module_id = DateUtil.getCurrentDate("yyyyMMdd00HHmmss");
			sql = "insert into sys_module(module_id,module_opcode,module_nm,pmodule_id,module_type,module_valid,help_page,help_title,module_order,module_hide,param_opcode)values(?,?,?,?,?,?,?,?,?,?,?)";
			dbBean.executeUpdate(sql, module_id, opcode, module_nm, pmodule_id,
					module_type, module_valid, help_page,help_title,module_order,module_hide,param_opcode);
			logger.info("执行sql语句:" + sql);
		} catch (Exception e) {
			logger.error("菜单新增出错", e);
			dtbHelper.setError("menumg-err-add-005", "菜单新增出错");
			return 0;
		}
		return 1;
	}

	@Override
	protected int save(DTBHelper dtbHelper) {
		String fid = dtbHelper.getStringValue("fid");
		String ac_name = dtbHelper.getStringValue("acname");
		String ac_code = dtbHelper.getStringValue("code");
		String ac_unit = dtbHelper.getStringValue("unit");
		String fyslb = dtbHelper.getStringValue("fyslb");
		String ffinancecategory = dtbHelper.getStringValue("cwlx");
		String ac_bp = dtbHelper.getStringValue("bp");
		String ac_description = dtbHelper.getStringValue("desc");
		
		try {
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			String name="select fyslbmc from ASSETBUDGETTYPE where fyslbid = ?";
			DataObject data = dbBean.executeSingleQuery(name,fyslb);
			String fyslbname  = data.getValue("fyslbmc");
			String sql = "update ASSET_CLASSIFICATION set ac_name=?,ac_code=?,ac_unit=?,"
					+ "fyslbname=?,fyslb=?,ffinancecategory=?,ac_bp=?,ac_description=? where fid=?";
			dbBean.executeUpdate(sql, ac_name,ac_code, ac_unit,fyslbname,fyslb,ffinancecategory,ac_bp,ac_description,fid);
			logger.info("执行sql语句:" + sql);
		} catch (Exception e) {
			logger.error("菜单修改出错", e);
			dtbHelper.setError("msg-err-sv", "菜单修改出错");
			return 0;
		}
		return 1;
	}

	@Override
	protected int remove(DTBHelper dtbHelper) {
		String module_id = dtbHelper.getStringValue("module_id");
		String sql = "delete from sys_module where module_id=?";
		
		try {
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			dbBean.executeUpdate(sql, module_id);
			logger.info("执行sql语句:" + sql);
		} catch (Exception e) {
			logger.error("菜单删除出错", e);
			dtbHelper.setError("munumg-err-rm", "菜单删除出错"+e.getMessage());
			return 0;
		}
		return 1;
	}

	@Override
	protected int show(DTBHelper dtbHelper) throws BizActionException {
		String module_id = dtbHelper.getStringValue("_moduleId");
		String sql = "select * from sys_module where module_id =  ?";
		
		try {
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			List<Map<String,Object>> dataList = dbBean.queryForList(sql,module_id);
			logger.info("执行sql语句:" + sql);
			
			if (dataList.size() > 0) {
				dtbHelper.setRstData("rows", dataList.get(0));
			} else {
				dtbHelper.setError("menumg-err-show-001", "该菜单模块没有数据");
				return 0;
			}
		} catch (Exception e) {
			logger.error("菜单查询明细出错", e);
			dtbHelper.setError("menumg-err-show-002", "菜单查询明细出错");
			return 0;
		}
		return 1;
	}

	@Override
	protected int other(DTBHelper dtbHelper) throws BizActionException {
		return 0;
	}
	
}
