package com.nantian.iwap.app.action.system;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.log4j.Logger;

import com.nantian.iwap.app.util.PasswordEncrypt;
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
 * ClassName: UserMgAction <br/>
 * Function: 获取用户菜单<br/>
 * date: 2016年3月2日15:18:49 <br/>
 * 
 * @author wjj
 * @version
 * @since JDK 1.7 Copyright (c) 2016, 广州南天电脑系统有限公司 All Rights Reserved.
 */
public class UserMgAction extends TransactionBizAction {

	private static Logger log = Logger.getLogger(UserMgAction.class);
	private String encryptClazz = "com.nantian.iwap.app.util.DefaultEncrypt";// 默认加密方式

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
		if ("query_grant".equals(option)) {
			return query_grant(dtbHelper);
		}
		if ("save_grant".equals(option)) {
			return save_grant(dtbHelper);
		}
		return 0;
	}

	protected int query(DTBHelper dtbHelper) throws BizActionException {
		int flag = 0;
		try {
			int start = Integer.valueOf(dtbHelper.getStringValue("start"));
			int limit = Integer.valueOf(dtbHelper.getStringValue("limit"));
			String deptId = "%" + dtbHelper.getStringValue("deptId") + "%";
			String userId = "%" + dtbHelper.getStringValue("userId") + "%";
			String userNm = "%" + dtbHelper.getStringValue("userNm") + "%";
			String userStatus = "%" + dtbHelper.getStringValue("userStatus") + "%";
			String _deptid = dtbHelper.getStringValue("_orgid");
			String deptlevel = null;
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			String sqlStr = "select org_lvl from sys_org where org_id='" + _deptid + "'";
			DataObject result = dbBean.executeSingleQuery(sqlStr);
			if (result != null) {
				deptlevel = result.getValue("org_lvl");
			}

			PaginationSupport page = new PaginationSupport(start, limit, limit);
			List<Map<String, Object>> dataList = null;
			if("81".equals(_deptid)){
				_deptid = "SDIC";
			}
			
			if (deptlevel == null || "".equals(deptlevel)) {
				sqlStr = "select * from ("
						+ "select a.acct_id, a.acct_status, a.psn_login_nm, a.acct_nm,a.org_id,a.org_nm,a.dept_id,a.dept_nm,"
						+ " to_char(a.last_login_tm,'yyyy-mm-dd hh24:mi:ss') as last_login_tm,psn_card,psn_cardno,"
						+ "a.acct_phone,a.acct_addr,a.acct_zipcode,a.acct_email,a.acct_ver_nm "
						+ "from sys_person a,sys_org o "
						+ "where a.dept_id=o.org_id and a.dept_nm like ? and a.psn_login_nm like ? "
						+ "and a.acct_nm like ? and a.acct_status like ? and o.org_path like ?) t_usermgtb";
				dataList = dbBean.queryForList(sqlStr, page, deptId, userId, userNm, userStatus, "%" + _deptid + "%");
			} else {
				sqlStr = "select * from ("
						+ "select a.acct_id, a.acct_status, a.psn_login_nm, a.acct_nm,a.org_id,a.org_nm,a.dept_id,a.dept_nm, to_char(a.last_login_tm,'yyyy-mm-dd hh24:mi:ss') as last_login_tm,"
						+ "a.acct_phone,a.acct_addr,a.acct_zipcode,a.acct_email,a.acct_ver_nm,psn_card,psn_cardno "
						+ "from sys_person a,sys_org o "
						+ "where a.org_id=o.org_id and a.dept_nm like ? and a.psn_login_nm like ? "
						+ "and a.acct_nm like ? and a.acct_status like ? and o.org_path like ? and o.org_lvl >= ?) t_usermgtb";
				dataList = dbBean.queryForList(sqlStr, page, deptId, userId, userNm, userStatus, "%" + _deptid + "%",
						deptlevel);
			}

			dtbHelper.setRstData("rows", dataList);
			dtbHelper.setRstData("total", page.getTotalCount());
			flag = 1;
		} catch (Exception e) {
			log.error("用户查询出错", e);
			dtbHelper.setError("usermg-err-qry", "[用户查询出错]" + e.getMessage());
		}
		return flag;
	}

	protected int add(DTBHelper dtbHelper) throws BizActionException {
		log.info("add"+dtbHelper);
		int flag = 0;
		DBAccessBean dbBean = null;
		try {
			dbBean = DBAccessPool.getDbBean();
			dbBean.setAutoCommit(false);
			UUID uuid = UUID.randomUUID();
			String acct_id = uuid.toString().replaceAll("-", "");
			String login_nm = dtbHelper.getStringValue("PSN_LOGIN_NM");
			String psn_code = login_nm.toUpperCase();
			String acct_nm = dtbHelper.getStringValue("ACCT_NM");
			String dept_id = dtbHelper.getStringValue("ORG_ID");//部门
			String dept_nm = dtbHelper.getStringValue("ORG_NM");
			String org_id = dtbHelper.getStringValue("_orgid");//组织机构
			String org_nm = dtbHelper.getStringValue("_orgnm");
			String psn_card = dtbHelper.getStringValue("PSN_CARD");
			String psn_cardno = dtbHelper.getStringValue("PSN_CARDNO");
			String acct_phone = dtbHelper.getStringValue("acct_phone");
			String acct_addr = dtbHelper.getStringValue("acct_addr");
			String acct_zipcode = dtbHelper.getStringValue("acct_zipcode");
			String acct_email = dtbHelper.getStringValue("acct_email");
			String acct_ver_nm = dtbHelper.getStringValue("acct_ver_nm");
			String acct_status = dtbHelper.getStringValue("ACCT_STATUS");
			PasswordEncrypt encrypt = (PasswordEncrypt) Class.forName(encryptClazz).newInstance();
			String acct_pwd = encrypt.encryptPassword(login_nm, "123456");// 默认密码
			String acct_crt = dtbHelper.getStringValue("_userid");

			String sqlStr = "select psn_login_nm from sys_person where psn_login_nm = ?";
			DataObject result = dbBean.executeSingleQuery(sqlStr, login_nm);
			if (result != null) {
				dbBean.executeRollBack();
				log.warn("用户新增出错：该用户登录ID已存在!");
				dtbHelper.setError("usermg-err-add-001", "[用户新增出错]该用户登录ID已存在!");
				return flag;
			}
			
			sqlStr = "select org_path,org_fname from sys_org where org_id = ?";
			DataObject result1 = dbBean.executeSingleQuery(sqlStr, dept_id);
			String org_path = result1.getValue("org_path");
			String org_fname = result1.getValue("org_fname");
			String psn_fname = org_fname+"/"+acct_nm;
			String psn_fcode = org_path+"/"+psn_code;
			sqlStr = "INSERT INTO sys_person(acct_id,acct_pwd,acct_status,acct_nm,"
					+ "org_id,acct_phone,acct_addr,acct_zipcode,acct_email,acct_ver_nm,"
					+ "acct_crt_tm,acct_crt,"
					+ "psn_login_nm,psn_code,psn_card,psn_cardno,psn_fcode,psn_fname,org_nm,dept_id,dept_nm) "
					+ "VALUES (?,?,?,?,?,?,?,?,?,?,to_date(?,'yyyy-MM-dd HH24:mi:ss'),?,?,?,?,?,?,?,?,?,?)";
			dbBean.executeUpdate(sqlStr, acct_id, acct_pwd, acct_status, acct_nm, org_id, acct_phone, acct_addr,
					acct_zipcode, acct_email, acct_ver_nm, DateUtil.getCurrentDate("yyyy-MM-dd HH:mm:ss"), acct_crt,
					login_nm,psn_code,psn_card,psn_cardno,psn_fcode,psn_fname,org_nm,dept_id,dept_nm);

			sqlStr = "delete from sys_acct_role where acct_id=?";
			dbBean.executeUpdate(sqlStr, acct_id);

			dbBean.executeCommit();
			flag = 1;
		} catch (Exception e) {
			log.error("用户新增出错", e);
			dtbHelper.setError("usermg-err-add-002", "[用户新增出错]" + e.getMessage());
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
		log.info("save");
		int flag = 0;
		DBAccessBean dbBean = null;
		try {
			dbBean = DBAccessPool.getDbBean();
			dbBean.setAutoCommit(false);
			String acct_nm = dtbHelper.getStringValue("ACCT_NM");
			String dept_id = dtbHelper.getStringValue("ORG_ID");//部门
			String dept_nm = dtbHelper.getStringValue("ORG_NM");
			String org_id = dtbHelper.getStringValue("_orgid");
			String org_nm = dtbHelper.getStringValue("_orgnm");
			String acct_phone = dtbHelper.getStringValue("acct_phone");
			String acct_addr = dtbHelper.getStringValue("acct_addr");
			String acct_zipcode = dtbHelper.getStringValue("acct_zipcode");
			String acct_email = dtbHelper.getStringValue("acct_email");
			String acct_ver_nm = dtbHelper.getStringValue("acct_ver_nm");
			String acct_status = dtbHelper.getStringValue("ACCT_STATUS");
			String acct_mdf = dtbHelper.getStringValue("_userid");
			String login_nm = dtbHelper.getStringValue("PSN_LOGIN_NM");
			String psn_code = login_nm.toUpperCase();
			String psn_card = dtbHelper.getStringValue("PSN_CARD");
			String psn_cardno = dtbHelper.getStringValue("PSN_CARDNO");
			log.info("acct_id:"+login_nm);
			log.info("acct_mdf:"+acct_mdf);

			String sqlStr = "UPDATE sys_person set acct_status=?,acct_nm=?,dept_id=?,"
					+ "acct_phone=?,acct_addr=?,acct_zipcode=?,acct_email=?,"
					+ "dept_nm=?,psn_card=?,psn_cardno=?,"
					+ "acct_ver_nm=?,acct_mdf_tm=to_date(?,'yyyy-MM-dd HH24:mi:ss'),acct_mdf=? "
					+ "where psn_login_nm=?";
			dbBean.executeUpdate(sqlStr, acct_status, acct_nm, dept_id, acct_phone, acct_addr, acct_zipcode, acct_email,
					dept_nm,psn_card,psn_cardno,
					acct_ver_nm, DateUtil.getCurrentDate("yyyy-MM-dd HH:mm:ss"), acct_mdf, login_nm);
			dbBean.executeCommit();
			flag = 1;
		} catch (Exception e) {
			log.error("用户保存出错", e);
			dtbHelper.setError("usermg-err-sv", "[用户保存出错]" + e.getMessage());
		}
		return flag;
	}

	protected int remove(DTBHelper dtbHelper) throws BizActionException {
		int flag = 0;
		DBAccessBean dbBean = null;
		try {
			dbBean = DBAccessPool.getDbBean();
			dbBean.setAutoCommit(false);
			String userids = dtbHelper.getStringValue("userids");
			String _userid = dtbHelper.getStringValue("_userid");
			String[] userarr = userids.split(",");
			int u_cnt = 0;
			int s_cnt = 0;
			for (String user : userarr) {
				if (user == null || "".equals(user.trim())) {
					continue;
				}
				if (_userid.trim().equals(user.trim())) {
					continue;
				}
				u_cnt++;
				int i = dbBean.executeUpdate("delete from sys_person where acct_id = ?", user);
				dbBean.executeUpdate("delete from sys_acct_role where acct_id = ?", user);
				if (i == 1) {
					s_cnt++;
				}
			}
			dbBean.executeCommit();
			if (u_cnt != s_cnt) {
				log.warn("用户删除出错:删除失败" + (u_cnt - s_cnt) + "条");
				dtbHelper.setError("usermg-err-rm-001", "[用户删除出错]删除失败" + (u_cnt - s_cnt) + "条");
			} else {
				flag = 1;
			}
		} catch (Exception e) {
			log.error("用户删除出错", e);
			dtbHelper.setError("usermg-err-rm-002", "[用户删除出错]" + e.getMessage());
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

	protected int query_grant(DTBHelper dtbHelper) throws BizActionException {
		int flag = 0;
		try {
			DBAccessBean dbBean = DBAccessPool.getDbBean();
			String acct_id = dtbHelper.getStringValue("ACCT_ID");
			String sqlStr = "select role_id from sys_acct_role where acct_id = ?";
			List<Map<String, Object>> dataList = dbBean.queryForList(sqlStr, acct_id);
			dtbHelper.setRstData("grants", dataList);
			flag = 1;
		} catch (Exception e) {
			log.error("用户授权查询出错", e);
			dtbHelper.setError("usermg-err-qg", "[用户授权查询出错]" + e.getMessage());
		}
		return flag;
	}

	@SuppressWarnings("unchecked")
	protected int save_grant(DTBHelper dtbHelper) throws BizActionException {
		int flag = 0;
		DBAccessBean dbBean = null;
		try {
			dbBean = DBAccessPool.getDbBean();
			dbBean.setAutoCommit(false);
			List<String> acct_role_list = dtbHelper.getListValue("acct_role_list");
			String acct_id = dtbHelper.getStringValue("ACCT_ID");
			dbBean.executeUpdate("delete from sys_acct_role where acct_id = ?", acct_id);
			String sqlStr = "INSERT INTO sys_acct_role(role_id,acct_id) VALUES (?,?)";
			for (String role : acct_role_list) {
				if (role == null || "".equals(role.trim())) {
					continue;
				}
				dbBean.executeUpdate(sqlStr, role, acct_id);
			}
			dbBean.executeCommit();
			flag = 1;
		} catch (Exception e) {
			log.error("用户授权保存出错", e);
			dtbHelper.setError("usermg-err-sg", "[用户授权保存出错]" + e.getMessage());
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
