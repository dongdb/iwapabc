<%@page import="com.nantian.iwap.common.util.DateUtil"%>
<%@ page language="java" import="com.nantian.iwap.web.WebEnv"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>维修申请</title>
<meta name="description" content="">
<!-- 一般查询页面所引入的样式文件 -->
<link href="${ctx}/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/css.css" rel="stylesheet">
<link href="${ctx}/css/style.css" rel="stylesheet">
<link href="${ctx}/css/iwapui-style.css" rel="stylesheet"
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
</head>
<body class="iwapui center_body">
	<div id="divDialog" class="divDialog">
		<!-- 第一个对话框开始 资产验收入库-->
		<div class="bg" style="height: 100%;"></div>
		<div class="dialog" id="assetModal"
			style="width: 900px; height: 450px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">选择维修资产</h4>
			</div>
			<div class="table_nav2">
				<form id="assetForm">
					<div class="col-md-2">
						<div class="inputbox" style="margin: 2px;">
							<input name="fuzzysearch" type="text" data-iwap-xtype="TextField"
								id="fuzzysearch" class="input_text_1" value=""
								onkeypress="if(event.keyCode==13) {iwapGrid.doQuery();return false;}">
						</div>
					</div>
				</form>
				<div class="col-md-10">
					<a href="javaScript:void(0)" id="search"
						onclick="iwapGrid.doQuery()"> <img alt=""
						src="../iwapabc/images/icon/search.png" /> 查询
					</a> <a href="javaScript:void(0)" id="refresh" onclick="refresh()">
						<img alt="" src="../iwapabc/images/icon/refresh.png" /> 刷新
					</a> <a href="javaScript:void(0)" id="confirm" onclick="doConfirm()">
						<img alt="" src="../iwapabc/images/icon/confirm.png" /> 确定
					</a>
				</div>

			</div>
			<div class="col-md-12">
				<div style="width: 850px; height: 280px; overflow-y: auto;">
					<table id="iwapGrid"
						class="mygrid table table-bordered table-striped table-hover"
						data-iwap="grid" data-iwap-id="" data-iwap-param=""
						data-iwap-pagination="true">
						<tr>
							<th data-grid-name="FCODE" primary="primary" data-order="">选择<s><input
									id="radio1" name="radio1" type="radio"
									selectmulti="selectmulti" value="{{value}}"></s></th>
							<th data-grid-name="ROW_NUM" class="tl">序号</th>
							<th data-grid-name="FCODE" class="tl">编码</th>
							<th data-grid-name="FNAME" class="tl">名称</th>
							<th data-grid-name="FORIGINVALUE" class="tl">资产原值</th>
							<th data-grid-name="FISDEPT" class="tl">适用类型</th>
							<th data-grid-name="FEXTENDSTR2" class="tl">放置位置</th>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-12">
		<div class="table_nav2">
			<div class="col-md-4">
				<a href="javaScript:void(0)" id="returnBack" onclick="doReturn()">
					<img alt="" src="../iwapabc/images/icon/left.png" /> 回退
				</a>
				<a href="javaScript:void(0)" id="transfer" onclick="doTransfer()">
					<img alt="" src="../iwapabc/images/icon/right.png" /> 流转
				</a>
			</div>
		</div>
	</div>
	<div class="col-md-8"
		style="margin-left: 10px; margin-top: 5px; height: 30px; background-color: #d8eef0;">
		<div class="col-md-5">
			<h5>维修申请信息</h5>
		</div>
		<div class="col-md-offset-7">
			<h5>
				维修单号：<input type="text" id="reNo" name="reNO"
					style="background-color: transparent; width: 180px;"
					disabled="disabled"
					value="ZCWX<%=DateUtil.getCurrentDate("yyyyMMddHHmmss")%>">
			</h5>
		</div>
	</div>

	<form method="post" onsubmit="return false" id="repairForm">
		<div class="col-md-12">
			<div class="col-md-3">
				<div class="inputbox" >
					<span>选择资产</span><input name="FCODE" id="FCODE" type="text"
						disabled="disabled" style="background: #fff;width:110px;"
						data-iwap-xtype="TextField" class="input_text_1"> <a class="disa"
						href="javaScript:void(0)" id="search" onclick="doSearch()"> <img
						alt="" src="../iwapabc/images/icon/search.png" />
					</a>
				</div>
			</div>
			<div class="col-md-3">
				<div class="inputbox" >
					<span>资产名称</span><input name="FNAME" type="text"
						data-iwap-xtype="TextField" id="FNAME" class="input_text_1"
						disabled="disabled">
				</div>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-3">
				<div class="inputbox" >
					<span>资产原值</span><input name="FORIGINVALUE" type="text"
						disabled="disabled" data-iwap-xtype="TextField" id="FORIGINVALUE"
						class="input_text_1">
				</div>
			</div>
			<div class="col-md-3">
				<div class="inputbox" >
					<span>规格型号</span><input name="FSPECTYPE" type="text"
						disabled="disabled" data-iwap-xtype="TextField" id="FSPECTYPE"
						class="input_text_1">
				</div>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-12">
				<div class="inputbox" >
					<span>故障描述</span>
					<textarea id="FAULTDESCN" name="FAULTDESCN" data-iwap-xtype="TextField"
						style="width: 710px; height: 50px;"></textarea>
				</div>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-3">
				<div class="inputbox" >
					<span>维修类型</span><input name="REPAIRTYPELABEL" type="text"
						data-iwap-xtype="TextField" id="REPAIRTYPELABEL"
						class="input_text_1">
				</div>
			</div>
			<div class="col-md-3">
				<div class="inputbox" >
					<span>送修日期</span><input name="DELIVERDATE" type="date"
						data-iwap-xtype="TextField" id="DELIVERDATE"
						class="input_text_1">
				</div>
			</div>
			<div class="col-md-3">
				<div class="inputbox" >
					<span>交还日期</span><input name="RETURNDATE" type="date"
						data-iwap-xtype="TextField" id="RETURNDATE"
						class="input_text_1">
				</div>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-12">
				<div class="inputbox" >
					<span>备注</span>
					<textarea id="REMARK" name="REMARK" data-iwap-xtype="TextField"
						style="width: 710px; height: 50px;"></textarea>
				</div>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-3">
				<div class="inputbox" >
					<span>申请人</span><input name="CREATEPSNNAME" type="text"
						disabled="disabled" data-iwap-xtype="TextField" id="CREATEPSNNAME"
						class="input_text_1">
				</div>
			</div>
			<div class="col-md-3">
				<div class="inputbox" >
					<span>处理人</span><input name="HANDLEPSNNAME" type="text"
						disabled="disabled" data-iwap-xtype="TextField" id="HANDLEPSNNAME"
						class="input_text_1">
				</div>
			</div>
			<div class="col-md-3">
				<div class="inputbox" >
					<span>维修金额</span><input name="REPAIRAMOUNT" type="text"
						disabled="disabled" data-iwap-xtype="TextField" id="REPAIRAMOUNT"
						class="input_text_1">
				</div>
			</div>
		</div>
	</form>
	<div class="col-md-8"
		style="margin-left: 10px; margin-top: 5px; height: 30px; background-color: #d8eef0;">
		<div class="col-md-5">
			<h5>维修项目清单</h5>
		</div>
	</div>
	<div class="table_nav2">
		<div class="col-md-12">
			<a href="javaScript:void(0)" id="add" onclick="add()"> <img
				alt="" src="../iwapabc/images/icon/add.png" /> 添加
			</a> <a href="javaScript:void(0)" id="delete" onclick="delete()"> <img
				alt="" src="../iwapabc/images/icon/delete.png" /> 删除
			</a>
		</div>
	</div>
	<div class="col-md-8">
			<table id="iwapGrid1"
				class="mygrid table table-bordered table-striped table-hover"
				data-iwap="grid" data-iwap-id="" data-iwap-param=""
				data-iwap-pagination="true">
				<tr>
					<th data-grid-name="FCODE" primary="primary" data-order="">选择<s><input
							id="radio1" name="radio1" type="radio" selectmulti="selectmulti"
							value="{{value}}"></s></th>
					<th data-grid-name="ROW_NUM" class="tl">维修项目</th>
					<th data-grid-name="FCODE" class="tl">维修费用</th>
					<th data-grid-name="FNAME" class="tl">备注</th>
				</tr>
			</table>
		</div>
</body>

<script type="text/javascript">
	var actionType = "", iwapGrid = null, condionForm = null, operForm = null;

	$(document).ready(function() {
		parent.document.getElementById("title").value = document.title;
		operForm = $.IWAP.Form({
			'id' : 'repairForm'
		});
		condionForm = $.IWAP.Form({
			'id' : 'assetForm'
		});
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '5',
			'txcode' : 'repairRequest',
			'option' : 'add'
		};
		iwapGrid = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			form : condionForm,
			renderTo : 'iwapGrid'
		});
		$(function(){document.onkeydown = function(e){
			var ev = document.all ? window.event:e;
			if(ev.keyCode==13){
				iwapGrid.doQuery();
			}
		}
		});
	});

	//选择维修资产
	function doSearch() {
		return;
	}
	
	function doConfirm() {
		if (iwapGrid.getCheckValues() == "") {
			alert("请选择维修资产！");
		}else{
			console.info(iwapGrid.getCurrentRow());
			operForm.setData(iwapGrid.getCurrentRow());
			$('#divDialog').hide();
		}
	}
	//流转
	function doTransfer() {
		if ($('input#fno').val() == '') {
			alert("请选择资产");
			return;
		}

		if ($('input#fdesc').val() == '') {
			alert("请填写故障描述");
			return;
		}

		var param = operForm.getData();
		var form = {
			'data' : param,
			'option' : 'transfer'
		};
		var callFn = function(rs) {
			var dataObj = rs['body'].rows;
			console.info(dataObj);

			//document.getElementById("remark").value = dataObj['FREMARK'];
		}
		sendAjax(form, 'repairRequest', 'doBiz', callFn);

		$('#detailModal').dialog('查看入库单');
		return;
	}
	
	function refresh(){
		iwapGrid.doReset();
		iwapGrid.doQuery();
	}
</script>
</html>