<%@ page language="java" import="com.nantian.iwap.web.WebEnv"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>合同信息管理</title>
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
		<div class="dialog" id="contractModal"
			style="width: 900px; height: 550px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">合同详细信息</h4>
			</div>
			<div class="col-md-12"
				style="height: 30px; background-color: #d0e4ff;">
				<h5>合同信息</h5>
			</div>
			<div class="col-md-12">
				<form method="post" onsubmit="return false" id="contractForm">
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>合同编号</span><input name="CONTRACTID" type="text"
								data-iwap-xtype="TextField" id="CONTRACTID" class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>合同类型</span><select data-iwap-xtype="ListField" name="CTYPE"
								class="select_content" id="CTYPE"></select>
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>签订日期</span><input name="CDATE" type="date"
								data-iwap-xtype="TextField" id="CDATE" class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>合同金额</span><input name="CMONEY" type="text"
								data-iwap-xtype="TextField" id="CMONEY" class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>汇率</span><input name="FRATE" type="text"
								data-iwap-xtype="TextField" id="FRATE" class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>本位币金额</span><input name="FCURRENCY" type="text"
								data-iwap-xtype="TextField" id="FCURRENCY" class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>币种</span><select data-iwap-xtype="ListField" name="FMTYPE"
								class="select_content" id="FMTYPE"></select>
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>付款预警比例</span><input name="FWARNRATE" type="text"
								data-iwap-xtype="TextField" id="FWARNRATE" class="input_text_1"
								style="width: 115px;"> %
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>已付金额</span><input name="CHAVMONEY" type="text"
								data-iwap-xtype="TextField" id="CHAVMONEY" class="input_text_1">
						</div>
					</div>
					<div class="col-md-12">
						<div class="inputbox" style="margin: 2px;">
							<span>供应商</span><input name="FPROVIDER" type="text"
								data-iwap-xtype="TextField" id="FPROVIDER" class="input_text_1"
								style="width: 685px;"> <a href="javaScript:void(0)"
								id="search" onclick="provider()"> <img alt=""
								src="../iwapabc/images/icon/search.png" />
							</a>
						</div>
					</div>
					<div class="col-md-12">
						<div class="inputbox" style="margin: 2px;">
							<span>合同标题</span><input name="CTITLE" type="text"
								style="width: 710px;" data-iwap-xtype="TextField" id="CTITLE"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-12">
						<div class="inputbox" style="margin: 2px;">
							<span>备注</span><input name="AFREMARK" type="text"
								style="width: 710px;" data-iwap-xtype="TextField" id="AFREMARK"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-12">
						<div class="inputbox" style="margin: 2px;">
							<span>合同附件</span><a href="#"><input name="CDOWN"
								type="text" data-iwap-xtype="TextField" id="CDOWN"
								class="input_text_1 " value="上传文件" disabled="disabled"
								style="background-color: #fff; width: 710px;"></a>
						</div>
					</div>
				</form>
			</div>
			<div class="col-md-12"
				style="height: 30px; background-color: #d0e4ff;">
				<h5>所属工程</h5>
			</div>
			<div class="col-md-12">
				<form id="projectForm">
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>工程编号</span><input name="PROJECTID" type="text"
								disabled="disabled" data-iwap-xtype="TextField" id="PROJECTID"
								class="input_text_1" style="width: 110px;"><a
								href="javaScript:void(0)" id="search" onclick="provider()">
								<img alt="" src="../iwapabc/images/icon/search.png" />
							</a>
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>工程类型</span><input name="PTYPE" type="text"
								disabled="disabled" data-iwap-xtype="TextField" id="PTYPE"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>开始时间</span><input name="CSTARTTIME" type="date"
								disabled="disabled" data-iwap-xtype="TextField" id="CSTARTTIME"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>工程名称</span><input name="PNAME" type="text"
								disabled="disabled" data-iwap-xtype="TextField" id="PNAME"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>预计完成时间</span><input name="CENDTIME" type="date"
								disabled="disabled" data-iwap-xtype="TextField" id="CENDTIME"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-12">
						<div class="inputbox" style="margin: 2px;">
							<span>备注</span><input name="BFREMARK" type="text"
								style="width: 710px;" data-iwap-xtype="TextField" id="BFREMARK"
								class="input_text_1" disabled="disabled">
						</div>
					</div>
					<div class="col-md-12">
						<div class="inputbox" style="margin: 2px;">
							<span>工程附件</span><input name="PDOWN" type="text"
								style="width: 710px;" data-iwap-xtype="TextField" id="PDOWN" class="input_text_1">
						</div>
					</div>
				</form>
			</div>
			<div class="table_nav2 col-md-offset-5">
				<a href="javaScript:void(0)" id="confirm" onclick="confirm()"> 确定
				</a> <a href="javaScript:void(0)" id="cancle" onclick="cancle()"> 取消
				</a>
			</div>
		</div>
	</div>
	<!-- 对话框 END-->
		<!-- 页面查询区域开始 -->
		<!-- 表格工具栏　开始 -->

		<div class="col-md-12">
			<h5>说明：选择任意一条合同记录后，下方列表将显示该合同的付款信息。</h5>
		</div>
		<div class="table_nav2">
			<form id="contractConditions" class="col-md-12 clearfix">
				<div class="inputbox" style="margin-top: 5px;">
					检索条件：<input name="fuzzySearch" type="text"
						data-iwap-xtype="TextField" id="fuzzySearch" class="input_text_1"
						value=""
						onkeypress="if(event.keyCode==13) {iwapGrid.doQuery();return false;}">
				</div>
				<div class="inputbox">
					<div class="table_nav2" style="margin-top: -2px;">
						<a href="javaScript:void(0)" id="search"
							onclick="iwapGrid.doQuery()"> <img alt=""
							src="../iwapabc/images/icon/search.png" /> 查询
						</a> <a href="javaScript:void(0)" id="add" onclick="doAdd()"> <img
							alt="" src="../iwapabc/images/icon/add.png" /> 新增
						</a> <a href="javaScript:void(0)" id="delete" onclick="doDelete()">
							<img alt="" src="../iwapabc/images/icon/delete.png" /> 删除
						</a> <a href="javaScript:void(0)" id="query" onclick="refresh()">
							<img alt="" src="../iwapabc/images/icon/refresh.png" /> 刷新
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
						<th data-grid-name="CONTRACTID" primary="primary" data-order="">选择<s><input
								id="radio1" name="radio1" type="radio" onchange="chooseChange()"
								selectmulti="selectmulti" value="{{value}}"></s></th>
						<th data-grid-name="ROW_NUM">序号</th>
						<th data-grid-name="CONTRACTID" class="tl">合同编号</th>
						<th data-grid-name="CTITLE">合同标题</th>
						<th data-grid-name="CDATE">签订日期</th>
						<th data-grid-name="FPROVIDER">供应商</th>
						<th data-grid-name="CMONEY">合同金额</th>
						<th data-grid-name="CHAVMONEY">已付金额</th>
						<th data-grid-name="FCREATEPSNNAME">提交人</th>
						<th data-grid-name="CONTRACTID" option="option" option-html=''><span>详细信息</span>
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
			<h4>合同付款记录</h4>
		</div>
		<!-- 表格工具栏　END -->
		<!-- 页面查询区域　END -->
		<!-- 查询内容区域　开始 -->
		<div class="col-md-12">
			<div class="table_box" style="overflow-y: hide; height: 270px;">
				<table id="iwapGrid1"
					class="mygrid table table-bordered table-striped table-hover"
					data-iwap="grid" data-iwap-id="" data-iwap-param=""
					data-iwap-pagination="true">
					<tr>
						<th data-grid-name="FPAYDATE" class="tl">付款日期</th>
						<th data-grid-name="FMONEY" class="tl">付款金额</th>
						<th data-grid-name="FPAYSTATE" class="tl">支付状态</th>
						<th data-grid-name="AFREMARK" class="tl">备注</th>
						<th data-grid-name="PDOWN" class="tl">付款附件</th>
						<th data-grid-name="FCREATEPSNNAME" class="tl">提交人</th>
					</tr>
				</table>
			</div>
		</div>
		<!-- 查询内容区域　END -->
</body>
<script type="text/javascript">
	var actionType = "", iwapGrid = null, condionForm = null, operForm = null, iwapGrid1 = null;
	var fData1 = {};
	$(document).ready(function() {
		parent.document.getElementById("title").value = document.title;
		condionForm = $.IWAP.Form({
			'id' : 'contractConditions'
		});
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '5',
			'txcode' : 'contractManage'
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
			'option' : 'contract',
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '50',
			'txcode' : 'contractManage'
		};
		iwapGrid1 = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData1,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			renderTo : 'iwapGrid1'
		});

		initSelectKV('{"CTYPE":"CTYPE"}');
		initSelectKV('{"FMTYPE":"Currency"}');
	});

	function refresh() {
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
			'txcode' : 'contractManage',
			'actionId' : 'doBiz'
		};
		var param = operForm.getData();
		$.IWAP.applyIf(param, extParam);
		iwapGrid.doSave(param, '#myModal');
	};

	function chooseChange() {
		//console.info("chooseChange");
		doContract(this);
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
			'txcode' : 'contractManage'
		};
		iwapGrid1 = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData1,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			renderTo : 'iwapGrid1'
		});
	};

	function doDetail(obj) {
		doContract(this);
		/*查询表格初始化  设置默认查询条件*/
		$('#contractModal').dialog('合同详细信息');
		operForm = $.IWAP.Form({
			'id' : 'contractForm'
		});
		operForm.reset();
		console.info(iwapGrid.getCurrentRow());
		operForm.setData(iwapGrid.getCurrentRow());
		var operForm2 = $.IWAP.Form({
			'id' : 'projectForm'
		});
		operForm2.reset();
		operForm2.setData(iwapGrid.getCurrentRow());
		//operForm.disabledById("ACCT_ID,ORG_ID,ORG_NM");
	};
	
	function cancle(){
		$('#contractModal').hide();
		$('#bg').hide();
	}
</script>
</html>