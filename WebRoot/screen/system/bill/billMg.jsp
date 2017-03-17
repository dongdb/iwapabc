<%@ page language="java" import="com.nantian.iwap.web.WebEnv"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>发票管理</title>
<meta name="description" content="">
<!-- 一般查询页面所引入的样式文件 -->
<link href="${ctx}/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/css.css" rel="stylesheet">
<link href="${ctx}/css/style.css" rel="stylesheet">
<link href="${ctx}/css/iwapui-style.css" rel="stylesheet"
	type="text/css">
<link href="${ctx}/css/lyz.calendar.css" rel="stylesheet"
	type="text/css">
<link href="${ctx}/css/zTreeStyle.css" rel="stylesheet">
<!-- JQ必须在最JS上面 -->
<script src="${ctx}/js/jquery.min.js"></script>
<script src="${ctx}/js/UtilTool.js"></script>
<script src="${ctx}/js/Form.js"></script>
<script src="${ctx}/js/TextField.js"></script>
<script src="${ctx}/js/ListField.js"></script>
<script type="text/javascript" src="${ctx}/js/iwapGrid.js"></script>
<script type="text/javascript" src="${ctx}/js/iwapui.js"></script>
<script type='text/javascript' src="${ctx}/js/String.js"></script>
<script type='text/javascript' src="${ctx}/js/dictionary.js"></script>
<script type='text/javascript' src="${ctx}/js/public.js"></script>
<!--Tree.js使用需同时引用   1、zTreeStyle.css  2、jquery.ztree.all-3.5.js  3、jquery.ztree.exhide-3.5.js  -->
<script type="text/javascript" src="${ctx}/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript"
	src="${ctx}/js/jquery.ztree.exhide-3.5.js"></script>
<script type="text/javascript" src="${ctx}/js/Tree.js"></script>
<script type="text/javascript" src="${ctx}/js/lyz.calendar.min.js"></script>
</head>
<body class="iwapui center_body">
	<input type="hidden" value="${userInfo.ACCT_ID}" id="_roleid">
	<input type="hidden" value="${userInfo.ORG_ID}" id="_deptId">
	<!-- 对话框开始 -->
	<div id="divDialog" class="divDialog">
		<!-- 第一个对话框开始 详细信息-->
		<div class="bg" id="bg" style="height: 100%;"></div>
		<div class="dialog" id="projectModal"
			style="width: 500px; height: 300px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">供应商列表</h4>
			</div>
			<div class="col-md-12">
				<form method="post" onsubmit="return false" id="projectForm">
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>工程编号</span><input name="PROJECTID" type="text"
								data-iwap-xtype="TextField" id="PROJECTID" class="input_text_1">
						</div>
					</div>
				</form>
			</div>
			<div class="table_nav2 col-md-offset-5">
				<a href="javaScript:void(0)" id="confirm" onclick="confirm()">
					确定 </a> <a href="javaScript:void(0)" id="cancle" onclick="cancle()">
					取消 </a>
			</div>
		</div>
	</div>
	<!-- 对话框 END-->
	<!-- 页面查询区域开始 -->
	<!-- 表格工具栏　开始 -->

	<div class="table_nav2">
		<form id="billConditions" class="col-md-12 clearfix">
			<div class="inputbox" style="margin-top: 5px;">
				开票日期： <select data-iwap-xtype="ListField" name="fp_date"
					onchange="gradeChange()" id="fp_date" class="select_content"
					onkeypress="if(event.keyCode==13) {iwapGrid.doQuery();return false;}">
					<option value="0">--全部--</option>
				</select>
			</div>
			<div class="inputbox ">
				<input name="pid1" type="date" data-iwap-xtype="TextField" id="pid1"
					class="input_text_2" value="" disabled="disabled"
					style="margin-top: 5px;">
			</div>
			<div class="inputbox">
				<span style="width: 10px; text-align: center" id="pid">--</span> <input
					name="pid2" type="date" data-date-format="mm-dd-yyyy"
					data-iwap-xtype="TextField" id="pid2" class="input_text_2" value=""
					disabled="disabled" style="margin-top: 5px;">
			</div>
			<div class="inputbox" style="margin-top: 5px;">
				模糊搜索：<input name="fuzzySearch" type="text"
					data-iwap-xtype="TextField" id="fuzzySearch" class="input_text_1"
					value=""
					onkeypress="if(event.keyCode==13) {iwapGrid.doQuery();return false;}">
			</div>
			<div class="inputbox">
				<div class="table_nav2" style="margin-top: -2px;">
					<a href="javaScript:void(0)" id="search"
						onclick="iwapGrid.doQuery()"> <img alt=""
						src="../iwapabc/images/icon/search.png" /> 查询
					</a> <a href="javaScript:void(0)" id="query" onclick="refresh()"> <img
						alt="" src="../iwapabc/images/icon/refresh.png" /> 刷新
					</a>
				</div>
			</div>
		</form>
	</div>
	<!-- 表格工具栏　END -->
	<!-- 页面查询区域　END -->
	<!-- 查询内容区域　开始 -->
	<div class="col-md-12">
		<div class="table_box" style="overflow-y: hide; height: 270px;">
			<table id="iwapGrid"
				class="mygrid table table-bordered table-striped table-hover"
				data-iwap="grid" data-iwap-id="" data-iwap-param=""
				data-iwap-pagination="true">
				<tr>
					<th data-grid-name="ROW_NUM">序号</th>
					<th data-grid-name="FP_NUM" class="tl">发票号码</th>
					<th data-grid-name="FP_DATE" class="tl">开票日期</th>
					<th data-grid-name="FP_MONEY">发票金额</th>
					<th data-grid-name="FMTYPE">币种</th>
					<th data-grid-name="FPROVIDER">供应商</th>
					<th data-grid-name="FPEOPLE">经办人</th>
					<th data-grid-name="FCHECKED">已导财务</th>
					<th data-grid-name="FCREATEPSNNAME">提交人</th>
					<th data-grid-name="FID" option="option" option-html=''><span>详细信息</span>
						<s><a href="javaScript:void(0)" id="detail"
							onclick="doDetail(this)"><img alt=""
								src="../iwapabc/images/icon/detail.png" /></a></s></th>
				</tr>
			</table>
		</div>
	</div>
	<!-- 查询内容区域　END -->
	<!-- 表格工具栏　开始 -->
	<div class="col-md-12">
		<div class="table_nav2" style="margin-top: -2px;">
			<a href="javaScript:void(0)" id="add" onclick="doAddBill()"> <img
				alt="" src="../iwapabc/images/icon/add.png" /> 新增
			</a> <a href="javaScript:void(0)" id="delete" onclick="doDeleteBill()">
				<img alt="" src="../iwapabc/images/icon/delete.png" /> 删除
			</a> <a href="javaScript:void(0)" id="save" onclick="doSave()"
				class="disa"> <img alt="" src="../iwapabc/images/icon/save.png" />
				保存
			</a>
		</div>
	</div>
	<div class="col-md-12">
		<form method="post" onsubmit="return false" id="billForm">
			<div class="col-md-7">

				<div class="col-md-6">
					<div class="inputbox" style="margin: 3px;">
						<span>发票号码</span><input name="FP_NUM" type="text"
							data-iwap-xtype="TextField" id="FP_NUM" class="input_text_1">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox" style="margin: 3px;">
						<span>开票日期</span><input name="FP_DATE" type="date"
							data-iwap-xtype="TextField" id="FP_DATE" class="input_text_1">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox" style="margin: 3px;">
						<span>币种</span><select data-iwap-xtype="ListField" name="FMTYPE"
							class="select_content" id="FMTYPE">
							<option value=""></option>
						</select>
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox" style="margin: 3px;">
						<span>供应商</span><input name="FPROVIDER" type="text"
							data-iwap-xtype="TextField" id="FPROVIDER" class="input_text_1">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox" style="margin: 3px;">
						<span>发票金额</span><input name="FP_MONEY" type="text"
							data-iwap-xtype="TextField" id="FP_MONEY" class="input_text_1">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox" style="margin: 3px;">
						<span>汇率</span><input name="FRATE" type="text"
							data-iwap-xtype="TextField" id="FRATE" class="input_text_1">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox" style="margin: 3px;">
						<span>本位币金额</span><input name="FCURRENCY" type="text"
							data-iwap-xtype="TextField" id="FCURRENCY" class="input_text_1">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox" style="margin: 3px;">
						<span>经办人</span><input name="FPEOPLE" type="text"
							data-iwap-xtype="TextField" id="FPEOPLE" class="input_text_1">
					</div>
				</div>
				<div class="col-md-12">
					<div class="inputbox" style="margin: 3px;">
						<span>备注</span><input name="FREMARK" type="text"
							data-iwap-xtype="TextField" id="FREMARK" class="input_text_1"
							style="width: 430px;">
					</div>
				</div>
				<div class="col-md-12">
					<div class="inputbox" style="margin: 3px;">
						<span>发票附件</span><input name="BDOWN" type="text"
							data-iwap-xtype="TextField" id="BDOWN" class="input_text_1"
							style="width: 430px;">
					</div>
				</div>

			</div>
			<div class="col-md-offset-7">
				<div style="width: 400px; height: 220px; border: 1px solid #bcbcbc;">
					<div class="table_box" style="overflow-y: hide; height: 270px;">
						<table id="iwapGrid1"
							class="mygrid table table-bordered table-striped table-hover"
							data-iwap="grid" data-iwap-id="" data-iwap-param=""
							data-iwap-pagination="true">
							<tr>
								<th data-grid-name="TITLE" class="tl">科目类型</th>
								<th data-grid-name="FMONEY" class="tl">科目金额</th>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</form>
	</div>
	<!-- 表格工具栏　END -->
	<!-- 查询内容区域　开始 -->
	<div class="col-md-12"></div>
	<!-- 查询内容区域　END -->
</body>
<script type="text/javascript">
	var actionType = "", iwapGrid = null, condionForm = null, operForm = null, iwapGrid1 = null;
	var fData1 = {};
	$(document).ready(function() {
		parent.document.getElementById("title").value = document.title;
		condionForm = $.IWAP.Form({
			'id' : 'billConditions'
		});
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '5',
			'txcode' : 'BillMg'
		};
		iwapGrid = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			form : condionForm,
			renderTo : 'iwapGrid'
		});
		
		fData1 = {
				'fid' :'',
				'actionId' : 'doBiz',
				'start' : '0',
				'limit' : '20',
				'option' : 'detail',
				'txcode' : 'BillMg'
			};
			iwapGrid1 = $.IWAP.iwapGrid({
				mode : 'server',
				fData : fData1,
				Url : '${ctx}/iwap.ctrl',
				grid : 'grid',
				renderTo : 'iwapGrid1'
			});

		document.getElementById("pid1").hidden = true;
		document.getElementById("pid2").hidden = true;

		initSelectKV('{"fp_date":"FCREATETIME"}');
		initSelectKV('{"FMTYPE":"Currency"}');

		$(function() {
			document.onkeydown = function(e) {
				var ev = document.all ? window.event : e;
				if (ev.keyCode == 13) {
					iwapGrid.doQuery();
				}
			}
		});
	});

	function refresh() {
		operForm = $.IWAP.Form({
			'id' : 'billForm'
		});
		operForm.reset();
		iwapGrid.doReset();
		iwapGrid.doQuery();
	}

	function refresh1() {
		iwapGrid1.doReset();
		iwapGrid1.doQuery();
	}

	//保存
	function doSave() {
		var extParam = {
			'actionType' : actionType,
			'txcode' : 'BillMg',
			'actionId' : 'doBiz'
		};
		var param = operForm.getData();
		$.IWAP.applyIf(param, extParam);
		iwapGrid.doSave(param, '#myModal');
	};

	function gradeChange() {
		var objS = document.getElementById("fp_date");
		var grade = objS.options[objS.selectedIndex].value;
		if (grade == 9) {
			condionForm.enabledById("pid1");
			condionForm.enabledById("pid2");
			document.getElementById("pid1").hidden = false;
			document.getElementById("pid2").hidden = false;
			document.getElementById("pid").hidden = false;
		} else {
			document.getElementById("pid1").hidden = true;
			document.getElementById("pid2").hidden = true;
			document.getElementById("pid").hidden = true;
		}
	}

	function doContract(obj) {
		/*查询表格初始化  设置默认查询条件*/
		var fid = iwapGrid.getCurrentRow().FID;
		fData1 = {
			'fid' : fid,
			'option' : 'contract',
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '50',
			'txcode' : 'BillMg'
		};
		var conForm = $.IWAP.Form({
			'id' : 'conConditions'
		});
		iwapGrid1 = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData1,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			form : conForm,
			renderTo : 'iwapGrid1'
		});
	};

	function doDetail(obj) {
		operForm = $.IWAP.Form({
			'id' : 'billForm'
		});
		operForm.reset();
		console.info(iwapGrid.getCurrentRow());
		operForm.setData(iwapGrid.getCurrentRow());
		//$('select#').val(iwapGrid.getCurrentRow()['']);
		//operForm.disabledById("ACCT_ID,ORG_ID,ORG_NM");
		var fid = iwapGrid.getCurrentRow().FID;
		fData1 = {
				'fid': fid,
				'actionId' : 'doBiz',
				'start' : '0',
				'limit' : '20',
				'option' : 'detail',
				'txcode' : 'BillMg'
			};
			iwapGrid1 = $.IWAP.iwapGrid({
				mode : 'server',
				fData : fData1,
				Url : '${ctx}/iwap.ctrl',
				grid : 'grid',
				renderTo : 'iwapGrid1'
			});
	};

	function doDetail1(obj) {
		doContract(this);
		/*查询表格初始化  设置默认查询条件*/
		$('#projectModal').dialog('在建工程');
		operForm = $.IWAP.Form({
			'id' : 'projectForm'
		});
		operForm.reset();
		console.info(iwapGrid.getCurrentRow());
		operForm.setData(iwapGrid.getCurrentRow());
		//$('select#').val(iwapGrid.getCurrentRow()['']);
		//operForm.disabledById("ACCT_ID,ORG_ID,ORG_NM");
		
	};

	function cancle() {
		$('#projectModal').hide();
		$('#bg').hide();
	}
</script>
</html>