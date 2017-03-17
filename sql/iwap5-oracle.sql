CREATE TABLE SYS_ACCOUNT (
  acct_id varchar2(64)  NOT NULL,
  acct_pwd varchar2(256)  DEFAULT NULL,
  acct_status char(1)  DEFAULT NULL,
  acct_inv_dt date DEFAULT NULL,
  acct_nm varchar2(32)  DEFAULT NULL,
  org_id varchar2(64)  DEFAULT NULL,
  acct_phone varchar2(11)  DEFAULT NULL,
  acct_addr varchar2(256)  DEFAULT NULL,
  acct_zipcode varchar2(6)  DEFAULT NULL,
  acct_email varchar2(256)  DEFAULT NULL,
  acct_ver_nm varchar2(128)  DEFAULT NULL,
  last_login_tm date DEFAULT NULL,
  acct_crt_tm date DEFAULT NULL,
  acct_crt varchar2(64)  DEFAULT NULL,
  acct_mdf_tm date DEFAULT NULL,
  acct_mdf varchar2(64)  DEFAULT NULL,
  acct_ext1 varchar2(32)  DEFAULT NULL,
  acct_ext2 varchar2(64)  DEFAULT NULL,
  acct_ext3 varchar2(128)  DEFAULT NULL,
  acct_ext4 varchar2(256)  DEFAULT NULL,
  acct_ext5 varchar2(256)  DEFAULT NULL,
  pwd_err_count number(11) DEFAULT NULL,
  last_mdf_pwd_dt date DEFAULT NULL,
  PRIMARY KEY (acct_id)
);
INSERT INTO SYS_ACCOUNT VALUES ('admin', 'cfa33edb77656627f1a0b4c71ce545ca', '1', null, 'admin', '0001', null, null, null, null, null, null, null, null, to_date('2016-01-11','yyyy-MM-dd'), 'admin', null, null, null, null, null, '0', to_date('2016-01-11','yyyy-MM-dd'));
INSERT INTO SYS_ACCOUNT VALUES ('test', '3343dda304429f74ad78783de8437829', '1', null, 'test', '0002', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO SYS_ACCOUNT VALUES ('test2', '3ae3ac3987040f4e6ca9d1c1e61e66ad', '1', null, 'test2', '0001', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO SYS_ACCOUNT VALUES  ('test3', '1786bacdebf3460ccaec95c179052b0e', '1', null, 'test3', '0002', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO SYS_ACCOUNT VALUES ('test4', '410fc251e810063dbd6b967f979bf2fd', '1', null, 'test4', '0002', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO SYS_ACCOUNT VALUES ('test5', '4ef2d89d46bf386a1636cc4927643ada', '1', null, 'test5', '0002', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO SYS_ACCOUNT VALUES  ('test6', 'f51b08213cf641b5326bf8eb83f61c59', '1', null, 'test6', '0002', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO SYS_ACCOUNT VALUES ('test7', 'fbbc1ad203f8b9926e9a1aef3384b875', '1', null, 'test7', '0002', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '0', null);
INSERT INTO SYS_ACCOUNT VALUES ('test8', 'e901f7a0ea778ad7f56c3c243475833c', '1', null, 'test8', '0002', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '0', null);
CREATE TABLE SYS_ACCT_PREFRC (
  acct_id varchar2(64)  NOT NULL,
  prefrc_category varchar2(32)  NOT NULL,
  setting_key varchar2(128)  NOT NULL,
  setting_val varchar2(512)  NOT NULL,
  remark varchar2(512)  DEFAULT NULL,
  remark1 varchar2(512)  DEFAULT NULL,
  remark2 varchar2(512)  DEFAULT NULL,
  remark3 varchar2(512)  DEFAULT NULL,
  PRIMARY KEY (acct_id,prefrc_category,setting_key)
);
INSERT INTO sys_acct_prefrc VALUES ('admin', '1', '1', '1', null, null, null, null);
INSERT INTO sys_acct_prefrc VALUES ('test1', '1', '1', '1', null, null, null, null);

CREATE TABLE sys_acct_role (
  role_id varchar2(64)  NOT NULL,
  acct_id varchar2(64)  NOT NULL,
  PRIMARY KEY (role_id,acct_id)
);
INSERT INTO sys_acct_role VALUES ('admin', 'admin');
CREATE TABLE sys_data_item (
  di_id varchar2(64)  NOT NULL,
  di_title varchar2(64)  DEFAULT NULL,
  di_comment varchar2(128)  DEFAULT NULL,
  di_def_val varchar2(64)  DEFAULT NULL,
  di_type varchar2(10)  DEFAULT NULL,
  di_length number(11) DEFAULT NULL,
  di_desc varchar2(128)  DEFAULT NULL,
  di_precision number(11) DEFAULT NULL,
  di_editor varchar2(512)  DEFAULT NULL,
  PRIMARY KEY (di_id)
);
CREATE TABLE sys_dict (
  dict_id varchar2(64)  NOT NULL,
  tab_name varchar2(64)  NOT NULL,
  col_name varchar2(32)  DEFAULT NULL,
  dict_key varchar2(32)  DEFAULT NULL,
  dict_val varchar2(32)  DEFAULT NULL,
  order_val number(11) DEFAULT NULL,
  enable_flag char(1)  DEFAULT NULL,
  PRIMARY KEY (dict_id)
);
CREATE TABLE sys_imp_cfg (
  imp_id varchar2(64) NOT NULL,
  imp_nm varchar2(32) DEFAULT NULL,
  tbl_en_nm varchar2(32) DEFAULT NULL,
  imp_tp varchar2(1) DEFAULT '0',
  start_pt varchar2(11) DEFAULT '1',
  sheet_idx number(11) DEFAULT NULL,
  start_col number(11) DEFAULT NULL ,
  allow_row varchar2(128) DEFAULT NULL,
  before_proc varchar2(128) DEFAULT NULL,
  after_proc varchar2(128) DEFAULT NULL,
  PRIMARY KEY (imp_id)
);
INSERT INTO sys_imp_cfg (imp_id, imp_nm, tbl_en_nm, imp_tp, start_pt, sheet_idx, start_col, allow_row, before_proc, after_proc) VALUES ('000001', '用户数据导入', 'sys_account', '0', '1', NULL, '0', NULL, 'com.nantian.iwap.app.imp.impl.UserBeforeProcess', NULL);
INSERT INTO sys_imp_cfg (imp_id, imp_nm, tbl_en_nm, imp_tp, start_pt, sheet_idx, start_col, allow_row, before_proc, after_proc) VALUES ('000002', '用户数据导入', 'sys_account', '1', NULL, NULL, NULL, NULL, 'com.nantian.iwap.app.imp.impl.UserBeforeProcess', NULL);

CREATE TABLE sys_imp_cfg_dtl (
  imp_id varchar2(64) DEFAULT NULL,
  dtl_id varchar2(64) NOT NULL,
  fld_nm varchar2(30) DEFAULT NULL,
  fld_caption varchar2(64) DEFAULT NULL,
  PK_Flg char(1) DEFAULT NULL,
  Sort_Val number(11) DEFAULT NULL,
  data_tp char(1) DEFAULT NULL,
  def_val varchar2(128) DEFAULT NULL,
  def_val_tp char(1) DEFAULT NULL,
  allow_blank char(1) DEFAULT NULL,
  PRIMARY KEY (dtl_id)
) ;
INSERT INTO sys_imp_cfg_dtl (imp_id, dtl_id, fld_nm, fld_caption, PK_Flg, Sort_Val, data_tp, def_val, def_val_tp, allow_blank) VALUES ('000001', '000001', 'acct_id', '用户ID', '0', '0', '0', NULL, NULL, '0');
INSERT INTO sys_imp_cfg_dtl (imp_id, dtl_id, fld_nm, fld_caption, PK_Flg, Sort_Val, data_tp, def_val, def_val_tp, allow_blank) VALUES ('000001', '000002', 'acct_pwd', '用户密码', '1', '1', '0', NULL, NULL, '0');
INSERT INTO sys_imp_cfg_dtl (imp_id, dtl_id, fld_nm, fld_caption, PK_Flg, Sort_Val, data_tp, def_val, def_val_tp, allow_blank) VALUES ('000001', '000003', 'acct_nm', '用户名称', '1', '2', '0', NULL, NULL, '0');
INSERT INTO sys_imp_cfg_dtl (imp_id, dtl_id, fld_nm, fld_caption, PK_Flg, Sort_Val, data_tp, def_val, def_val_tp, allow_blank) VALUES ('000001', '000004', 'org_id', '机构ID', '1', '3', '0', NULL, NULL, '0');
INSERT INTO sys_imp_cfg_dtl (imp_id, dtl_id, fld_nm, fld_caption, PK_Flg, Sort_Val, data_tp, def_val, def_val_tp, allow_blank) VALUES ('000001', '000005', 'acct_crt', '创建人', '1', '4', '0', '${ACCT_ID}', '0', '0');
INSERT INTO sys_imp_cfg_dtl (imp_id, dtl_id, fld_nm, fld_caption, PK_Flg, Sort_Val, data_tp, def_val, def_val_tp, allow_blank) VALUES ('000001', '000006', 'acct_crt_tm', '创建时间', '1', '5', '0', '${systime}', '0', '0');
INSERT INTO sys_imp_cfg_dtl (imp_id, dtl_id, fld_nm, fld_caption, PK_Flg, Sort_Val, data_tp, def_val, def_val_tp, allow_blank) VALUES ('000001', '000007', 'acct_status', '用户状态', '1', '6', '0', '1', '0', '0');
INSERT INTO sys_imp_cfg_dtl (imp_id, dtl_id, fld_nm, fld_caption, PK_Flg, Sort_Val, data_tp, def_val, def_val_tp, allow_blank) VALUES ('000002', '000008', 'acct_id', '用户ID', '0', '0', '0', 'B1', NULL, '0');
INSERT INTO sys_imp_cfg_dtl (imp_id, dtl_id, fld_nm, fld_caption, PK_Flg, Sort_Val, data_tp, def_val, def_val_tp, allow_blank) VALUES ('000002', '000009', 'acct_pwd', '用户密码', '1', '1', '0', 'B2', NULL, '0');
INSERT INTO sys_imp_cfg_dtl (imp_id, dtl_id, fld_nm, fld_caption, PK_Flg, Sort_Val, data_tp, def_val, def_val_tp, allow_blank) VALUES ('000002', '000010', 'acct_nm', '用户名称', '1', '2', '0', 'D1', NULL, '0');
INSERT INTO sys_imp_cfg_dtl (imp_id, dtl_id, fld_nm, fld_caption, PK_Flg, Sort_Val, data_tp, def_val, def_val_tp, allow_blank) VALUES ('000002', '000011', 'org_id', '机构ID', '1', '3', '0', 'D2', NULL, '0');
INSERT INTO sys_imp_cfg_dtl (imp_id, dtl_id, fld_nm, fld_caption, PK_Flg, Sort_Val, data_tp, def_val, def_val_tp, allow_blank) VALUES ('000002', '000012', 'acct_crt', '创建人', '1', '4', '0', '${ACCT_ID}', '0', '0');
INSERT INTO sys_imp_cfg_dtl (imp_id, dtl_id, fld_nm, fld_caption, PK_Flg, Sort_Val, data_tp, def_val, def_val_tp, allow_blank) VALUES ('000002', '000013', 'acct_crt_tm', '创建时间', '1', '5', '0', '${systime}', '0', '0');
INSERT INTO sys_imp_cfg_dtl (imp_id, dtl_id, fld_nm, fld_caption, PK_Flg, Sort_Val, data_tp, def_val, def_val_tp, allow_blank) VALUES ('000002', '000014', 'acct_status', '用户状态', '1', '6', '0', '1', '0', '0');

CREATE TABLE sys_no (
  no_id varchar2(64)  NOT NULL,
  no_name varchar2(64)  DEFAULT NULL,
  no_length number(11) DEFAULT NULL,
  prefix varchar2(64)  DEFAULT NULL,
  postfix varchar2(64)  DEFAULT NULL,
  next_id number(18,0) DEFAULT NULL,
  year_reset char(1)  DEFAULT NULL,
  month_reset char(1)  DEFAULT NULL,
  day_reset char(1)  DEFAULT NULL,
  cache_size number(11) DEFAULT NULL,
  no_status char(1)  DEFAULT NULL,
  PRIMARY KEY (no_id)
);
CREATE TABLE sys_org (
  org_id varchar2(64)  NOT NULL,
  org_nm varchar2(64)  DEFAULT NULL,
  org_ful_nm varchar2(128)  DEFAULT NULL,
  org_pid varchar2(64)  DEFAULT NULL,
  org_path varchar2(1024)  DEFAULT NULL,
  org_lvl number(11) DEFAULT NULL,
  org_status char(1)  DEFAULT NULL,
  org_rmk varchar2(512)  DEFAULT NULL,
  org_order number(11) DEFAULT NULL,
  org_crt_dt date DEFAULT NULL,
  org_inv_dt date DEFAULT NULL,
  org_rmk1 varchar2(512)  DEFAULT NULL,
  org_rmk2 varchar2(512)  DEFAULT NULL,
  org_rmk3 varchar2(512)  DEFAULT NULL,
  PRIMARY KEY (org_id)
);
INSERT INTO sys_org VALUES ('0005', '越秀行', '越秀行', '0002', '0001.0002.0005', '3', '1', null, null, null, null, null, null, null);
INSERT INTO sys_org VALUES ('0002', '广州行', '广州行', '0001', '0001.0002', '2', '1', null, null, null, null, null, null, null);
INSERT INTO sys_org VALUES ('0001', '省行', '省行', '', '0001', '1', '1', null, null, null, null, null, null, null);
INSERT INTO sys_org VALUES ('0003', '深圳行', '深圳行', '0001', '0001.0003', '2', '1', null, null, null, null, null, null, null);
INSERT INTO sys_org VALUES ('0004', '佛山行', '佛山行', '0001', '0001.0004', '2', '1', null, null, null, null, null, null, null);
COMMIT;
CREATE TABLE sys_org_his (
  org_id varchar2(64)  NOT NULL,
  org_nm varchar2(64)  DEFAULT NULL,
  org_ful_nm varchar2(128)  DEFAULT NULL,
  org_pid varchar2(64)  DEFAULT NULL,
  org_path varchar2(1024)  DEFAULT NULL,
  org_lvl number(11) DEFAULT NULL,
  org_status char(1)  DEFAULT NULL,
  org_rmk varchar2(512)  DEFAULT NULL,
  org_order number(11) DEFAULT NULL,
  org_crt_dt date DEFAULT NULL,
  org_inv_dt date NOT NULL,
  org_rmk1 varchar2(512)  DEFAULT NULL,
  org_rmk2 varchar2(512)  DEFAULT NULL,
  org_rmk3 varchar2(512)  DEFAULT NULL,
  PRIMARY KEY (org_id,org_inv_dt)
);

CREATE TABLE sys_param (
  param_en_nm varchar2(64)  NOT NULL,
  param_zh_nm varchar2(128)  DEFAULT NULL,
  param_val varchar2(256)  DEFAULT NULL,
  enable_flag char(1)  DEFAULT NULL,
  crt_date date DEFAULT NULL,
  crt_usr varchar2(64)  DEFAULT NULL,
  mdf_date date DEFAULT NULL,
  mdf_usr varchar2(64)  DEFAULT NULL,
  remark1 varchar2(256)  DEFAULT NULL,
  remark2 varchar2(256)  DEFAULT NULL,
  remark3 varchar2(256)  DEFAULT NULL,
  PRIMARY KEY (param_en_nm)
);

INSERT INTO sys_param VALUES ('11', 'test11111', '1234', '0', to_date('2015-12-11 16:15:28','yyyy-MM-dd HH24:mi:ss'), 'admin', to_date('2015-12-11 16:15:28','yyyy-MM-dd HH24:mi:ss'), 'admin', null, null, null); 
INSERT INTO sys_param VALUES('1111', '222', '33', '1', to_date('2015-12-21 09:39:52','yyyy-MM-dd HH24:mi:ss'), 'admin', to_date('2015-12-21 09:39:52','yyyy-MM-dd HH24:mi:ss'), 'admin', null, null, null);
INSERT INTO sys_param VALUES('11111', '2221', '33', '1', to_date('2015-12-21 09:39:58','yyyy-MM-dd HH24:mi:ss'), 'admin', to_date('2015-12-21 09:39:58','yyyy-MM-dd HH24:mi:ss'), 'admin', null, null, null);
INSERT INTO sys_param VALUES('111111', '22211', '33', '1', to_date('2015-12-21 09:40:03','yyyy-MM-dd HH24:mi:ss'), 'admin', to_date('2015-12-21 09:40:03','yyyy-MM-dd HH24:mi:ss'), 'admin', null, null, null);
INSERT INTO sys_param VALUES('1111111', '222111', '33', '1', to_date('2015-12-21 09:40:08','yyyy-MM-dd HH24:mi:ss'), 'admin', to_date('2015-12-21 09:40:08','yyyy-MM-dd HH24:mi:ss'), 'admin', null, null, null);
INSERT INTO sys_param VALUES('11111111', '2221111', '33', '1', to_date('2015-12-21 09:40:13','yyyy-MM-dd HH24:mi:ss'), 'admin', to_date('2015-12-21 09:40:13','yyyy-MM-dd HH24:mi:ss'), 'admin', null, null, null);
INSERT INTO sys_param VALUES('111111111', '22211111', '33', '1', to_date('2015-12-21 09:40:18','yyyy-MM-dd HH24:mi:ss'), 'admin', to_date('2015-12-21 09:40:18','yyyy-MM-dd HH24:mi:ss'), 'admin', null, null, null);
INSERT INTO sys_param VALUES('1111111111', '222111111', '33', '1', to_date('2015-12-21 09:40:23','yyyy-MM-dd HH24:mi:ss'), 'admin', to_date('2015-12-21 09:40:23','yyyy-MM-dd HH24:mi:ss'), 'admin', null, null, null);
INSERT INTO sys_param VALUES('11111111111', '2221111111', '33', '1', to_date('2015-12-21 09:40:28','yyyy-MM-dd HH24:mi:ss'), 'admin', to_date('2015-12-21 09:40:28','yyyy-MM-dd HH24:mi:ss'), 'admin', null, null, null);
commit;
CREATE TABLE sys_role (
  role_id varchar2(64)  NOT NULL,
  role_nm varchar2(64)  DEFAULT NULL,
  role_desc varchar2(128)  DEFAULT NULL,
  role_type varchar2(1)  DEFAULT '0',
  role_enabled varchar2(1)  DEFAULT '1',
  role_extend varchar2(64)  DEFAULT NULL,
  role_exclude varchar2(512)  DEFAULT NULL,
  org_id varchar2(64)  DEFAULT NULL,
  PRIMARY KEY (role_id)
);


INSERT INTO sys_role VALUES ('admin', '超级管理员', '超级管理员', '0', '1', null, null,'0001');
INSERT INTO sys_role VALUES ('test2', 'test2', 'test2', '0', '1', null, null, '0001');

COMMIT;
CREATE TABLE sys_role_module (
  module_id varchar2(128)  NOT NULL,
  role_id varchar2(64)  NOT NULL,
  PRIMARY KEY (module_id,role_id)
);

INSERT INTO sys_role_module VALUES ('2016030300000001', 'admin');
INSERT INTO sys_role_module VALUES ('2016030300000002', 'admin');
INSERT INTO sys_role_module VALUES ('2016030300000004', 'admin');
INSERT INTO sys_role_module VALUES ('2016030900000001', 'admin');
INSERT INTO sys_role_module VALUES ('2016030900000002', 'admin');
INSERT INTO sys_role_module VALUES ('2016030900000003', 'admin');
INSERT INTO sys_role_module VALUES ('2016030900000004', 'admin');
INSERT INTO sys_role_module VALUES ('2016030900000006', 'admin');
INSERT INTO sys_role_module VALUES ('2016030900000007', 'admin');
INSERT INTO sys_role_module VALUES ('2016030900000008', 'admin');
INSERT INTO sys_role_module VALUES ('2016030900000009', 'admin');
INSERT INTO sys_role_module VALUES ('2016030900000010', 'admin');
INSERT INTO sys_role_module VALUES ('2016030900000011', 'admin');
INSERT INTO sys_role_module VALUES ('2016030900000012', 'admin');
INSERT INTO sys_role_module VALUES ('2016030900000013', 'admin');
INSERT INTO sys_role_module VALUES ('2016030900000015', 'admin');
INSERT INTO sys_role_module VALUES ('2016030900000017', 'admin');
INSERT INTO sys_role_module VALUES ('2016030900000018', 'admin');
INSERT INTO sys_role_module VALUES ('2016031000000002', 'admin');
INSERT INTO sys_role_module VALUES ('2016031100000001', 'admin');
INSERT INTO sys_role_module VALUES ('2016031100000002', 'admin');
INSERT INTO sys_role_module VALUES ('2016031100000003', 'admin');
INSERT INTO sys_role_module VALUES ('2016031100000004', 'admin');
INSERT INTO sys_role_module VALUES ('2016031100000005', 'admin');
INSERT INTO sys_role_module VALUES ('2016031100000006', 'admin');
INSERT INTO sys_role_module VALUES ('2016031100000009', 'admin');
INSERT INTO sys_role_module VALUES ('2016031100000010', 'admin');
INSERT INTO sys_role_module VALUES ('2016031100000011', 'admin');
INSERT INTO sys_role_module VALUES ('2016031100000012', 'admin');
INSERT INTO sys_role_module VALUES ('2016031200000001', 'admin');
INSERT INTO sys_role_module VALUES ('2016031500000002', 'admin');
INSERT INTO sys_role_module VALUES ('2016031100000013', 'admin');
INSERT INTO sys_role_module VALUES ('2016031100000014', 'admin');

CREATE TABLE sys_tx_conf (
  tx_cd varchar2(20)  NOT NULL,
  tx_nm varchar2(40)  DEFAULT NULL,
  login_flag char(1)  DEFAULT NULL,
  token_flag char(1)  DEFAULT NULL,
  flow_num number(11) DEFAULT NULL,
  log_flag char(1)  DEFAULT NULL,
  disest_flag char(1)  DEFAULT NULL,
  disest_clazz varchar2(256)  DEFAULT NULL,
  op_code varchar2(32)  NOT NULL,
  param_opcode varchar2(10)  DEFAULT NULL,
  tx_rmk1 varchar2(256)  DEFAULT NULL,
  tx_rmk2 varchar2(256)  DEFAULT NULL,
  tx_rmk3 varchar2(256)  DEFAULT NULL,
  PRIMARY KEY (tx_cd,op_code)
);
INSERT INTO sys_tx_conf VALUES ('sysParam', '新增系统参数', null, null, null, '1', null, null, 'insert', 'actionType', null, null, null);
INSERT INTO sys_tx_conf VALUES ('sysParam', '删除系统参数', null, null, null, '1', null, null, 'delete', 'actionType', null, null, null);
INSERT INTO sys_tx_conf VALUES ('sysParam', '修改系统参数', null, null, null, '1', null, null, 'update', 'actionType', null, null, null);
INSERT INTO sys_tx_conf VALUES ('menuMg', '新增菜单', null, null, null, '1', null, null, 'add', 'option', null, null, null);
INSERT INTO sys_tx_conf VALUES ('menuMg', '删除菜单', null, null, null, '1', null, null, 'remove', 'option', null, null, null);
INSERT INTO sys_tx_conf VALUES ('menuMg', '修改菜单', null, null, null, '1', null, null, 'save', 'option', null, null, null);
INSERT INTO sys_tx_conf VALUES ('roleMg', '新增角色', null, null, null, '1', null, null, 'insert', 'actionType', null, null, null);
INSERT INTO sys_tx_conf VALUES ('roleMg', '删除角色', null, null, null, '1', null, null, 'delete', 'actionType', null, null, null);
INSERT INTO sys_tx_conf VALUES ('roleMg', '修改角色', null, null, null, '1', null, null, 'update', 'actionType', null, null, null);
INSERT INTO sys_tx_conf VALUES ('userMg', '新增用户', null, null, null, '1', null, null, 'add', 'option', null, null, null);
INSERT INTO sys_tx_conf VALUES ('userMg', '删除用户', null, null, null, '1', null, null, 'remove', 'option', null, null, null);
INSERT INTO sys_tx_conf VALUES ('userMg', '修改用户', null, null, null, '1', null, null, 'save', 'option', null, null, null);
INSERT INTO sys_tx_conf VALUES ('userMg', '用户授权', null, null, null, '1', null, null, 'save_grant', 'option', null, null, null);
INSERT INTO sys_tx_conf VALUES ('department', '新增机构', null, null, null, '1', null, null, 'add', 'option', null, null, null);
INSERT INTO sys_tx_conf VALUES ('department', '删除机构', null, null, null, '1', null, null, 'remove', 'option', null, null, null);
INSERT INTO sys_tx_conf VALUES ('department', '修改机构', null, null, null, '1', null, null, 'save', 'option', null, null, null);
CREATE TABLE sys_tx_dtl (
  tx_id varchar2(64)  NOT NULL,
  tx_cd varchar2(64)  DEFAULT NULL,
  op_code	varchar2(64),
  tx_flag char(1)  DEFAULT NULL,
  err_code	varchar2(32),
  err_msg	varchar2(256),
  tx_rmk varchar2(256)  DEFAULT NULL,
  tx_dt date DEFAULT NULL,
  acct_id varchar2(64)  DEFAULT NULL,
  req_tm date DEFAULT NULL,
  resp_tm date DEFAULT NULL,
  tx_dtl_rmk1 varchar2(256)  DEFAULT NULL,
  tx_dtl_rmk2 varchar2(256)  DEFAULT NULL,
  tx_dtl_rmk3 varchar2(256)  DEFAULT NULL,
  PRIMARY KEY (tx_id)
);

CREATE TABLE sys_module (
  module_id varchar2(128)  NOT NULL,
  module_opcode varchar2(64)  DEFAULT NULL,
  module_nm varchar2(64)  DEFAULT NULL,
  pmodule_id varchar2(128)  DEFAULT NULL,
  module_url varchar2(128)  DEFAULT NULL,
  module_type char(1)  DEFAULT NULL,
  module_valid char(1)  DEFAULT NULL,
  big_icon varchar2(128)  DEFAULT NULL,
  small_icon varchar2(128)  DEFAULT NULL,
  help_page varchar2(128)  DEFAULT NULL,
  help_title varchar2(128)  DEFAULT NULL,
  module_order number(11) DEFAULT NULL,
  module_hide char(1)  DEFAULT NULL,
  module_target varchar2(10)  DEFAULT NULL,
  param_opcode varchar2(10)  DEFAULT NULL,
  PRIMARY KEY (module_id)
);
INSERT INTO sys_module VALUES ('2016030900000001', 'sysParam', '系统参数管理', '2016030300000001', null, '1', '0', null, null, '', '', '200', '0', null, '');
INSERT INTO sys_module VALUES ('2016030900000002', 'insert', '新增系统参数', '2016030900000001', null, '2', '0', null, null, '', '', '210', '0', null, 'actionType');
INSERT INTO sys_module VALUES ('2016030300000002', 'menuMg', '菜单管理', '2016030300000001', null, '1', '0', null, null, null, null, '300', '0', null, '');
INSERT INTO sys_module VALUES ('2016030900000003', 'delete', '删除系统参数', '2016030900000001', null, '2', '0', null, null, '', '', '220', '0', null, 'actionType');
INSERT INTO sys_module VALUES ('2016030900000004', 'update', '修改系统参数', '2016030900000001', null, '2', '0', null, null, '', '', '230', '0', null, 'actionType');
INSERT INTO sys_module VALUES ('2016030900000006', 'add', '新增菜单', '2016030300000002', null, '2', '0', null, null, '', '', '320', '0', null, 'option');
INSERT INTO sys_module VALUES ('2016030300000001', null, '系统管理', null, null, '0', '0', null, null, null, null, '100', '0', null, null);
INSERT INTO sys_module VALUES ('2016030900000007', 'remove', '删除菜单', '2016030300000002', null, '2', '0', null, null, '', '', '330', '0', null, 'option');
INSERT INTO sys_module VALUES ('2016030900000008', 'save', '修改菜单', '2016030300000002', null, '2', '0', null, null, '', '', '340', '0', null, 'option');
INSERT INTO sys_module VALUES ('2016030900000009', 'roleMg', '角色管理', '2016030300000001', null, '1', '0', null, null, '', '', '400', '0', null, '');
INSERT INTO sys_module VALUES ('2016030900000010', 'insert', '新增角色', '2016030900000009', null, '2', '0', null, null, '', '', '410', '0', null, 'actionType');
INSERT INTO sys_module VALUES ('2016030900000011', 'delete', '删除角色', '2016030900000009', null, '2', '0', null, null, '', '', '420', '0', null, 'actionType');
INSERT INTO sys_module VALUES ('2016030900000012', 'update', '修改角色', '2016030900000009', null, '2', '0', null, null, '', '', '430', '0', null, 'actionType');
INSERT INTO sys_module VALUES ('2016030900000013', 'userMg', '用户管理', '2016030300000001', null, '1', '0', null, null, '', '', '500', '0', null, '');
INSERT INTO sys_module VALUES ('2016030900000017', 'add', '新增用户', '2016030900000013', null, '2', '0', null, null, '', '', '510', '0', null, 'option');
INSERT INTO sys_module VALUES ('2016030900000015', 'remove', '删除用户', '2016030900000013', null, '2', '0', null, null, '', '', '520', '0', null, 'option');
INSERT INTO sys_module VALUES ('2016030900000018', 'save', '修改用户', '2016030900000013', null, '2', '0', null, null, '', '', '530', '0', null, 'option');
INSERT INTO sys_module VALUES ('2016030300000004', 'show', '查看菜单', '2016030300000002', null, '2', '0', null, null, null, null, '350', '0', null, 'option');
INSERT INTO sys_module VALUES ('2016031000000002', 'logQry', '日志查询', '2016030300000001', null, '1', '0', null, null, '', '', '700', '0', null, '');
INSERT INTO sys_module VALUES ('2016031100000001', 'query_grant', '授权查询', '2016030900000013', null, '2', '0', null, null, '', '', '540', '0', null, 'option');
INSERT INTO sys_module VALUES ('2016031100000002', 'save_grant', '授权保存', '2016030900000013', null, '2', '0', null, null, '', '', '550', '0', null, 'option');
INSERT INTO sys_module VALUES ('2016031100000003', 'department', '机构管理', '2016030300000001', null, '1', '0', null, null, '', '', '600', '0', null, '');
INSERT INTO sys_module VALUES ('2016031100000004', 'add', '新增机构', '2016031100000003', null, '2', '0', null, null, '', '', '610', '0', null, 'option');
INSERT INTO sys_module VALUES ('2016031100000005', 'remove', '删除机构', '2016031100000003', null, '2', '0', null, null, '', '', '620', '0', null, 'option');
INSERT INTO sys_module VALUES ('2016031100000006', 'save', '修改机构', '2016031100000003', null, '2', '0', null, null, '', '', '630', '0', null, 'option');
INSERT INTO sys_module VALUES ('2016031100000009', 'query_grant', '查询模块授权', '2016030900000009', null, '2', '0', null, null, '', '', '450', '0', null, 'actionType');
INSERT INTO sys_module VALUES ('2016031200000001', 'prefrcMg', '用户偏好管理', '2016030300000001', null, '1', '0', null, null, '', '', '800', '0', null, '');
INSERT INTO sys_module VALUES ('2016031500000002', 'query_sys_org', '查询机构树', '2016030900000009', null, '2', '0', null, null, '', '', '560', '0', null, 'actionType');
INSERT INTO sys_module VALUES ('2016031100000010', 'save_grant', '保存模块授权', '2016030900000009', null, '2', '0', null, null, null, null, '460', '0', null, 'actionType');
INSERT INTO sys_module VALUES ('2016031100000011', 'query_sys_module', '查询系统模块树', '2016030900000009', null, '2', '0', null, null, null, null, '470', '0', null, 'actionType');
INSERT INTO sys_module VALUES ('2016031100000012', 'query_sys_org', '查询机构树', '2016030900000009', null, '2', '0', null, null, null, null, '480', '0', null, 'actionType');
INSERT INTO sys_module VALUES ('00000000000000000001', 'remove', '删除用户偏好', '2016031200000001', NULL, '2', '0', NULL, NULL, '', '', '810', '0', NULL, 'option');
INSERT INTO sys_module VALUES ('2016031100000013', 'importData', '数据导入', '2016030300000001', NULL, '1', '0', NULL, NULL, NULL, NULL, '800', '1', NULL, NULL);
INSERT INTO sys_module VALUES ('2016031100000014', 'exportData', '数据导出', '2016030300000001', NULL, '1', '0', NULL, NULL, NULL, NULL, '900', '1', NULL, NULL);
commit;