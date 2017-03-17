<%@ page language="java" import="com.nantian.iwap.web.WebEnv"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>在建工程</title>
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
			style="width: 900px; height: 250px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">在建工程</h4>
			</div>
			<div class="col-md-12">
				<form method="post" onsubmit="return false" id="projectForm">
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>工程编号</span><input name="PROJECTID" type="text"
								data-iwap-xtype="TextField" id="PROJECTID" class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>工程类型</span><select data-iwap-xtype="ListField" name="PTYPE"
								class="select_content" id="PTYPE"></select>
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>开始时间</span><input name="CSTARTTIME" type="date"
								data-iwap-xtype="TextField" id="CSTARTTIME" class="input_text_1">
						</div>
					</div>
					<div class="col-md-8">
						<div class="inputbox" style="margin: 2px;">
							<span>工程名称</span><input name="PNAME" type="text"
								data-iwap-xtype="TextField" id="PNAME" class="input_text_1"
								style="width:420px;">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span style="width:75px;">预计完成时间</span><input name="CENDTIME" type="date"
								data-iwap-xtype="TextField" id="CENDTIME" class="input_text_1"
								style="width:120px;">
						</div>
					</div>
					<div class="col-md-12">
						<div class="inputbox" style="margin: 2px;">
							<span>备注</span><input name="FREMARK" type="text"
								style="width: 710px;" data-iwap-xtype="TextField" id="FREMARK"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-12">
						<div class="inputbox" style="margin: 2px;">
							<span>附件</span><a href="#"><input name="PDOWN"
								type="text" data-iwap-xtype="TextField" id="PDOWN"
								class="input_text_1 " value="上传文件" disabled="disabled"
								style="background-color: #fff; width: 710px;"></a>
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
			<h5>说明：选择任意一条在建工程记录后，下方列表将显示该工程的合同信息。</h5>
		</div>
		<div class="table_nav2">
			<form id="projectConditions" class="col-md-12 clearfix">
				<div class="inputbox" style="margin-top: 5px;">
					工程状态：<select data-iwap-xtype="ListField" name="fState"
						id="fState" class="select_content"
						onkeypress="if(event.keyCode==13) {iwapGrid.doQuery();return false;}">
						<option value="%">--全部--</option>
					</select>
				</div>
				<div class="inputbox" style="margin-top: 5px;">
					创建日期： <select data-iwap-xtype="ListField" name="fCreateTime"
						onchange="gradeChange()" id="fCreateTime" class="select_content"
						onkeypress="if(event.keyCode==13) {iwapGrid.doQuery();return false;}">
						<option value="0">--全部--</option>
					</select>
				</div>
				<div class="inputbox ">
					<input name="pid1" type="date" data-iwap-xtype="TextField"
						id="pid1" class="input_text_2" value="" disabled="disabled"
						style="margin-top: 5px;">
				</div>
				<div class="inputbox">
					<span style="width: 10px; text-align: center" id="pid">--</span> <input
						name="pid2" type="date" data-date-format="mm-dd-yyyy"
						data-iwap-xtype="TextField" id="pid2" class="input_text_2"
						value="" disabled="disabled" style="margin-top: 5px;">
				</div>
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
						<th data-grid-name="PROJECTID" primary="primary" data-order="">选择<s><input
								id="radio1" name="radio1" type="radio" onchange="chooseChange()"
								selectmulti="selectmulti" value="{{value}}"></s></th>
						<th data-grid-name="ROW_NUM">序号</th>
						<th data-grid-name="FSTATE" class="tl">工程状态</th>
						<th data-grid-name="PROJECTID" class="tl">工程编号</th>
						<th data-grid-name="PTYPE">工程类型</th>
						<th data-grid-name="PNAME">工程名称</th>
						<th data-grid-name="CSTARTTIME">开始时间</th>
						<th data-grid-name="FENDTIME">完成时间</th>
						<th data-grid-name="FCREATEPSNNAME">提交人员</th>
						<th data-grid-name="PROJECTID" option="option" option-html=''><span>竣工操作</span>
							<s><a href="javaScript:void(0)" id="detail"
								onclick="doDetail(this)">竣工<!-- <img alt=""
									src="../iwapabc/images/icon/detail.png" /> --></a></s></th>
						<th data-grid-name="PROJECTID" option="option" option-html=''><span>详细信息</span>
							<s><a href="javaScript:void(0)" id="detail"
								onclick="doDetail(this)"><img alt=""
									src="../iwapabc/images/icon/detail.png" /></a></s></th>
					</tr>
				</table>
			</div>
		</div>
		<!-- 查询内容区域　END -->
		<!-- 表格工具栏　开始 -->
		<div class="table_nav2">
			<form id="conConditions" class="col-md-12 clearfix">
				<div class="inputbox" style="margin-top: 5px;">
					检索条件：<input name="fuzzyCon" type="text"
						data-iwap-xtype="TextField" id="fuzzyCon" class="input_text_1"
						value=""
						onkeypress="if(event.keyCode==13) {iwapGrid1.doQuery();return false;}">
				</div>
				<div class="inputbox">
					<div class="table_nav2" style="margin-top: -2px;">
						<a href="javaScript:void(0)" id="search"
							onclick="iwapGrid1.doQuery()"> <img alt=""
							src="../iwapabc/images/icon/search.png" /> 查询
						</a> <a href="javaScript:void(0)" id="add" onclick="doAddBill()">
							<img alt="" src="../iwapabc/images/icon/add.png" /> 新增
						</a> <a href="javaScript:void(0)" id="delete" onclick="doDeleteBill()">
							<img alt="" src="../iwapabc/images/icon/delete.png" /> 删除
						</a> <a href="javaScript:void(0)" id="query" onclick="refresh1()">
							<img alt="" src="../iwapabc/images/icon/refresh.png" /> 刷新
						</a>
					</div>
				</div>
			</form>
		</div>
		<!-- 表格工具栏　END -->
		<!-- 查询内容区域　开始 -->
		<div class="col-md-12">
			<div class="table_box" style="overflow-y: hide; height: 270px;">
				<table id="iwapGrid1"
					class="mygrid table table-bordered table-striped table-hover"
					data-iwap="grid" data-iwap-id="" data-iwap-param=""
					data-iwap-pagination="true">
					<tr>
						<th data-grid-name="CONTRACTID" class="tl">合同编号</th>
						<th data-grid-name="CTITLE" class="tl">合同标题</th>
						<th data-grid-name="CDATE" class="tl">签订日期</th>
						<th data-grid-name="CMONEY" class="tl">合同金额</th>
						<th data-grid-name="CHAVMONEY" class="tl">已付金额</th>
						<th data-grid-name="FPROVIDER" class="tl">供应商</th>
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
			'id' : 'projectConditions'
		});
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '5',
			'txcode' : 'onProject'
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
			'option' : 'project',
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '50',
			'txcode' : 'onProject'
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
		
		document.getElementById("pid1").hidden = true;
		document.getElementById("pid2").hidden = true;
		
		initSelectKV('{"fState":"PSTATE"}');
		initSelectKV('{"fCreateTime":"FCREATETIME"}');
		initSelectKV('{"PTYPE":"PTYPE"}');
		
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
			'txcode' : 'onProject',
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

	function gradeChange() {
		var objS = document.getElementById("fCreateTime");
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
			'txcode' : 'onProject'
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
	
	function cancle(){
		$('#projectModal').hide();
		$('#bg').hide();
	}
</script>
</html>