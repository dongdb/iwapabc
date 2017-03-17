<%@page import="com.nantian.iwap.common.util.DateUtil"%>
<%@ page language="java" import="com.nantian.iwap.web.WebEnv"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>处置申请</title>
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
<script type="text/javascript" src="${ctx}/js/jquery.base64.js"></script>
<script type="text/javascript" src="${ctx}/js/tableExport.js"></script>
<script type="text/javascript" src="${ctx}/js/libs/base64.js"></script>
<script type="text/javascript" src="${ctx}/js/libs/sprintf.js"></script>
<script type="text/javascript" src="${ctx}/js/libs/jspdf.js"></script>

<!--Tree.js使用需同时引用   1、zTreeStyle.css  2、jquery.ztree.all-3.5.js  3、jquery.ztree.exhide-3.5.js  -->
<script type="text/javascript" src="${ctx}/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript"
	src="${ctx}/js/jquery.ztree.exhide-3.5.js"></script>
<script type="text/javascript" src="${ctx}/js/Tree.js"></script>
</head>
<body class="iwapui center_body">
	<div id="divDialog" class="divDialog">
		<!-- 第一个对话框开始 选择添加资产 -->
		<div class="bg" id="bg" style="height: 100%;"></div>
		<div class="dialog" id="assetModal" style="width: 820px; height: 520px;">
			<div class="dialog-header" style="background-color: 33AECC">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">部门资产信息</h4>
			</div>
			<div class="table_nav2">
				<div class="col-md-2">
					<a href="javaScript:void(0)" id="query"
						onclick="assetGrid.doReset();assetGrid.doQuery()"> <img alt=""
						src="../iwapabc/images/icon/refresh.png" /> 刷新
					</a>
				</div>
				<div class="col-md-5">
					<form id="assetForm">
						<div class="inputbox">
							<input name="fuzzyAsset" type="text" data-iwap-xtype="TextField"
								id="fuzzyAsset" class="input_text_1"
								onkeypress="if(event.keyCode==13) {assetGrid.doQuery();return false;}">
						</div>
						<a href="javaScript:void(0)" id="search"
							onclick="assetGrid.doQuery()"> <img alt=""
							src="../iwapabc/images/icon/search.png" /> 搜索
						</a>
					</form>
				</div>
			</div>
			<div class="col-md-12" style="width: 810px;">
				<div
					style="height: 265px; overflow-y: auto; border: 1px solid #CCCCCC;">
					<table id="assetGrid"
						class="mygrid table table-bordered table-striped table-hover"
						data-iwap="grid" data-iwap-id="" data-iwap-param=""
						data-iwap-pagination="true">
						<tr style="overflow: scroll;">
							<th data-grid-name="FID" primary="primary" data-order="">选择
								<s><input id="radio1" name="radio1" type="radio" selectmulti="selectmulti"
									value="{{value}}"></s>
							</th>
							<th data-grid-name="FBARCODE" class="tl">条码</th>
							<th data-grid-name="FNAME" class="tl">名称</th>
							<th data-grid-name="FSPECTYPE" class="tl">规格型号</th>
							<th data-grid-name="FSOURCENAME" class="tl">来源</th>
							<th data-grid-name="FORIGINVALUE" class="tl">资产原值</th>
							<th data-grid-name="FRESPONSEPSNNAME" class="tl">责任人</th>
							<th data-grid-name="FCREATETIME" class="tl">入库日期</th>
							<th data-grid-name="FREMARK" class="tl">备注</th>
						</tr>
					</table>
				</div>
				<h5>已选列表 （共<input id="num" type="text" value="0" 
					style="width:10px;height:25px;border:none; background-color:#fff;" 
					disabled="disabled" >项）</h5>
				<div id = "list"
					style="height: 80px; overflow-y: auto; border: 1px solid #CCCCCC;">

				</div>
				<div class="col-md-6">
					<h5 style="color:red">注：本列表显示为本部门管理的所有闲置和占用的资产。</h5>
				</div>
				<div class="col-md-offset-5">
					<div class="table_nav2"
						style="border: 1px solid white; margin: 3px;">
						<a href="javaScript:void(0)" id="save" onclick="doConfirmAsset()">确定</a>
						<!-- <a href="javaScript:void(0)" id="reset" onclick="doResetBill()">清空</a> -->
					</div>
				</div>
			</div>
		</div>
		<!-- 第一个对话框结束 End 选择添加资产 -->
		<!-- 第二个对话框开始 流转确认 -->
		<div class="bg" id="bg" style="height: 100%;"></div>
		<div class="dialog" id="transConfirm" style="width: 720px; height: 520px;">
			<div class="dialog-header" style="background-color: 33AECC">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">流转确认</h4>
			</div>
			<div class="col-md-12" style="width: 710px;">
				<div
					style="height: 210px; overflow-y: auto; border: 1px solid #CCCCCC;">
					<table id="confirmGrid"
						class="mygrid table table-bordered table-striped table-hover"
						data-iwap="grid" data-iwap-id="" data-iwap-param=""
						data-iwap-pagination="true">
						<tr style="overflow: scroll;">
							<th data-grid-name="FID" primary="primary" data-order="">选择
								<s><input id="radio1" name="radio1" type="radio" selectmulti="selectmulti"
									value="{{value}}"></s>
							</th>
							<th data-grid-name="FBARCODE" class="tl">环节</th>
							<th data-grid-name="FNAME" class="tl">办理人</th>
							<th data-grid-name="FID" option="option" option-html=''><span>高级选项</span>
							<s><a href="javaScript:void(0)" id="detail"
								onclick="doDetail(this)">高级选项</a></s></th>
						</tr>
					</table>
				</div>
				<h5>附言</h5>
				<textarea id="" name=""
						data-iwap-xtype="TextField" style="width: 680px; height: 180px;max-width: 680px; max-height: 180px;"></textarea>
				<div class="col-md-offset-5">
					<div class="table_nav2"
						style="border: 1px solid white; margin: 3px;">
						<a href="javaScript:void(0)" id="save" onclick="doConfirm()">确定</a>
					</div>
				</div>
			</div>
		</div>
		<!-- 第二个对话框结束 End 流转确认 -->
	</div>

	<div class="col-md-12">
		<div class="table_nav2">
			<a href="javaScript:void(0)" id="transfer" onclick="doTransfer()">
				<img alt="" src="../iwapabc/images/icon/right.png" /> 流转
			</a> <a href="javaScript:void(0)" id="confirm" onclick="doSubmit()">
				<img alt="" src="../iwapabc/images/icon/confirm.png" /> 提交
			</a>
		</div>
	</div>
	<div class="col-md-9"
		style="margin-left: 10px; margin-top: 5px; height: 30px; background-color: #d8eef0;">
		<div class="col-md-5">
			<h5>处置申请信息</h5>
		</div>
		<div class="col-md-offset-7">
			<h5>
				处置单号：<input type="text" id="reNo" name="reNo"
					style="background-color: transparent; width: 180px;"
					disabled="disabled">
			</h5>
		</div>
	</div>

	<form method="post" onsubmit="return false" id="dealForm">
		<div class="col-md-12">
			<div class="col-md-6">
				<div class="inputbox" style="margin-top: 5px;">
					<span>处置标题</span><input name="DISPOSALTITLE" id="DISPOSALTITLE"
						type="text" style="width: 420px;" data-iwap-xtype="TextField"
						class="input_text_1">
				</div>
			</div>
			<div class="col-md-3">
				<div class="inputbox" style="margin-top: 5px;">
					<span>处置时间</span><input name="DISPOSALDATETIME" type="date"
						data-iwap-xtype="TextField" id="DISPOSALDATETIME"
						class="input_text_1">
				</div>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-3">
				<div class="inputbox">
					<span>处置方式</span><input name="DISPOSALMODELABLE" type="text"
						data-iwap-xtype="TextField" id="DISPOSALMODELABLE"
						class="input_text_1">
				</div>
			</div>
			<div class="col-md-3">
				<div class="inputbox">
					<span>签报编号</span><input name="DISPOSALOANO" type="text"
						data-iwap-xtype="TextField" id="DISPOSALOANO" class="input_text_1">
				</div>
			</div>
			<div class="col-md-3">
				<div class="inputbox">
					<span>填写人</span><input name="CREATEPSNNAME" type="text"
						data-iwap-xtype="TextField" id="CREATEPSNNAME"
						class="input_text_1">
				</div>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-9">
				<div class="inputbox">
					<span>处置原因</span>
					<textarea id="CREATEPSNNAME" name="FAULTDESCN"
						data-iwap-xtype="TextField" style="width: 710px; height: 50px;"></textarea>
				</div>
			</div>
			<div class="col-md-9">
				<div class="inputbox">
					<span>备注</span>
					<textarea id="CREATEPSNNAME" name="FAULTDESCN"
						data-iwap-xtype="TextField" style="width: 710px; height: 50px;"></textarea>
				</div>
			</div>
		</div>

	</form>
	<div class="col-md-9"
		style="margin-left: 10px; margin-top: 5px;  margin-bottom: 5px; height: 30px; background-color: #d8eef0;">
		<div class="col-md-5">
			<h5>处置资产清单</h5>
		</div>
	</div>
	<div class="table_nav2">
		<div class="col-md-12">
			<a href="javaScript:void(0)" id="add" onclick="add()"> <img
				alt="" src="../iwapabc/images/icon/add.png" /> 添加
			</a> <a href="javaScript:void(0)" id="excel" onclick="printexcel()"> <img alt=""
				src="../iwapabc/images/icon/excel.png" /> 导出数据
			</a>
		</div>
	</div>
	<div class="col-md-8">
		<table id="iwapGrid1"
			class="mygrid table table-bordered table-striped table-hover"
			data-iwap="grid" data-iwap-id="" data-iwap-param=""
			data-iwap-pagination="true">
			<tr>
				<th data-grid-name="ROW_NUM" class="tl">序号</th>
				<th data-grid-name="ASSETBARCODE" class="tl">条码号</th>
				<th data-grid-name="FINANCIALCODE" class="tl">财务编号</th>
				<th data-grid-name="ASSETNAME" class="tl">资产名称</th>
				<th data-grid-name="ASSETSOURCE" class="tl">资产来源</th>
				<th data-grid-name="ASSETORIGINALVALUE" class="tl">资产原值</th>
				<th data-grid-name="ASSETSPECIFICATION" class="tl">规格型号</th>
				<th>操作</th>
			</tr>
		</table>
	</div>
</body>

<script type="text/javascript">
	var actionType = "", iwapGrid = null, condionForm = null, operForm = null;
	var list = Array(), listNUM = Array(), listFID = Array(), cnt = 0;
	
	$(document).ready(function() {
		parent.document.getElementById("title").value = document.title;
		operForm = $.IWAP.Form({
			'id' : 'dealForm'
		});
		condionForm = $.IWAP.Form({
			'id' : 'assetForm'
		});
		var callFn = function(rs) {
			var dataObj = rs['body'].ZCCZ;
			//console.info(dataObj);
			document.getElementById("reNo").value = dataObj;
		}
		var data = {
			'option' : 'init'
		};
		sendAjax(data, 'dealRequest', 'doBiz', callFn);
	});
	
	function add() {
		$('#assetModal').dialog('部门资产信息');
		condionForm = $.IWAP.Form({
			'id' : 'assetForm'
		});
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '6',
			'txcode' : 'dealRequest',
			'option' : 'asset'
		};
		assetGrid = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			form : condionForm,
			renderTo : 'assetGrid'
		});
		$(function(){document.onkeydown = function(e){
			var ev = document.all ? window.event:e;
			if(ev.keyCode==13){
				assetGrid.doQuery();
			}
		}
		});
		$('#num').val(cnt);
		document.getElementById("list").innerHTML = listNUM;
	};
	
	function clearAsset(){
		cnt = 0;
		list = null;
		list = Array();
		listNUM = null;
		listNUM = Array();
		listFID = null;
		listFID = Array();
		$('#num').val(cnt);
		document.getElementById("list").innerHTML = listNUM;
		var t = document.getElementById("iwapGrid1");
		var rowNum = t.rows.length;
		for(var i=1;i<rowNum;i++){
			t.deleteRow(i);
			rowNum --;
			i--;
		}
	};
	function delOne(obj){
		list.splice(obj,1);
		listNUM.splice(obj,1);
		listFID.splice(obj,1);
		cnt--;
		listShow();
		$('#num').val(cnt);
		document.getElementById("list").innerHTML = listNUM;
	};	
	function listShow(){
		var t = document.getElementById("iwapGrid1");
		var rowNum = t.rows.length;
		for(var i=1;i<rowNum;i++){
			t.deleteRow(i);
			rowNum --;
			i--;
		}
		for(var i=1;i<=cnt;i++){
			if(list[i]['FREMARK']==undefined){
				list[i]['FREMARK']="";
			}
			var tablestr = "";
			var newstr = "";
			tablestr += "<tr>" + "<td style='cursor:pointer'>" + i + "</td>"
					+ "<td style='cursor:pointer'>" + list[i]['FBARCODE'] + "</td>" 
					+ "<td style='cursor:pointer'>" + "" + "</td>"
					+ "<td style='cursor:pointer'>" + list[i]['FNAME'] + "</td>" 
					+ "<td style='cursor:pointer'>" + list[i]['FSOURCENAME'] + "</td>" 
					+ "<td style='cursor:pointer'>" + list[i]['FORIGINVALUE'] + "</td>"
					+ "<td style='cursor:pointer'>" + list[i]['FSPECTYPE'] + "</td>" 
					+ "<td>"+"<a href='javaScript:void(0)' onclick='delOne("+i+")'>删除</a>"+"</td>"
					+ "</tr>";
			$("#iwapGrid1").append(tablestr);
		}
	};	
	function doConfirmAsset(){
		cnt++;
		list[cnt] = assetGrid.getCurrentRow();
		listNUM[cnt] = assetGrid.getCurrentRow()['FBARCODE'];
		listFID[cnt] = assetGrid.getCurrentRow()['FID'];
		//console.info(list[cnt]); 
		var tablestr = "";
		var newstr = "";
		listShow();
		$('#assetModal').find('.close').click();
	};
	

	//选择维修资产
	function doSearch() {
		return;
	};

	function doConfirm() {
		if (iwapGrid.getCheckValues() == "") {
			alert("请选择维修资产！");
		} else {
			console.info(iwapGrid.getCurrentRow());
			operForm.setData(iwapGrid.getCurrentRow());
			$('#divDialog').hide();
		}
	};
	//流转
	function doTransfer() {
		$('#transConfirm').dialog('流转确认');
		return;
	};
	
	//导出资产卡片
	function printexcel() {
		$('#iwapGrid1').tableExport({
			type : 'excel',
			escape : 'false'
		});
	}

</script>
</html>