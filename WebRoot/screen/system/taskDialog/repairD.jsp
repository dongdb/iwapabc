<%@page import="com.nantian.iwap.common.util.DateUtil"%>
<%@ page language="java" import="com.nantian.iwap.web.WebEnv"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>维修处理</title>
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
		<!-- 第一个对话框开始 新增维修项目-->
		<div class="bg" style="height: 100%;"></div>
		<div class="dialog" id="itemModal"
			style="width: 430px; height: 250px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">新增维修项目</h4>
			</div>
			<form method="post" onsubmit="return false" id="itemForm">
				<br>
				<div class="col-md-12">
					<div class="inputbox">
						<span>维修项目：</span><input name="name" id="name" type="text"
							style="width: 260px;" data-iwap-xtype="TextField"
							class="input_text_1">
					</div>
				</div>
				<div class="col-md-12">
					<div class="inputbox">
						<span>维修费用：</span><input name="cost" type="text"
							data-iwap-xtype="TextField" id="cost" class="input_text_1"
							style="width: 260px;">
					</div>
				</div>
				<div class="col-md-12">
					<div class="inputbox">
						<span>备注：</span>
						<textarea id="remark" name="remark" data-iwap-xtype="TextField"
							style="width: 260px; height: 60px; max-height: 85px; max-width: 325px;"></textarea>
					</div>
				</div>
				<br>
			</form>

			<div class="col-md-offset-5">
				<div class="table_nav2"
					style="border: 1px solid white; margin: 10px;">
					<a href="javaScript:void(0)" id="save" onclick="doSaveItem()">保存</a>
				</div>
			</div>
		</div>
	</div>


	<div class="col-md-12">
		<div class="table_nav2">
			<div class="col-md-4">
				<a href="javaScript:void(0)" id="returnBack" onclick="doReturn()">
					<img alt="" src="/iwapabc/images/icon/left.png" /> 回退
				</a> <a href="javaScript:void(0)" id="transfer" onclick="doTransfer()">
					<img alt="" src="/iwapabc/images/icon/right.png" /> 流转
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
				维修单号：<input type="text" id="REPAIRNO" name="REPAIRNO"
					style="background-color: transparent; width: 180px;"
					disabled="disabled"
					value="ZCWX<%=DateUtil.getCurrentDate("yyyyMMddHHmmss")%>">
			</h5>
		</div>
	</div>

	<form method="post" onsubmit="return false" id="repairForm">
		<div class="col-md-12">
			<div class="col-md-3">
				<div class="inputbox">
					<span>选择资产</span><input name="ASSETBARCODE" id="ASSETBARCODE"
						type="text" disabled="disabled" style="background: #fff;"
						data-iwap-xtype="TextField" class="input_text_1">
				</div>
			</div>
			<div class="col-md-3">
				<div class="inputbox">
					<span>资产名称</span><input name="ASSETNAME" type="text"
						data-iwap-xtype="TextField" id="ASSETNAME" class="input_text_1"
						disabled="disabled">
				</div>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-3">
				<div class="inputbox">
					<span>资产原值</span><input name="ASSETCOST" type="text"
						disabled="disabled" data-iwap-xtype="TextField" id="ASSETCOST"
						class="input_text_1">
				</div>
			</div>
			<div class="col-md-3">
				<div class="inputbox">
					<span>规格型号</span><input name="ASSETSPEC" type="text"
						disabled="disabled" data-iwap-xtype="TextField" id="ASSETSPEC"
						class="input_text_1">
				</div>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-12">
				<div class="inputbox">
					<span>故障描述</span>
					<textarea id="FAULTDESCN" name="FAULTDESCN"
						data-iwap-xtype="TextField" style="width: 710px; height: 50px;"></textarea>
				</div>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-3">
				<div class="inputbox">
					<span>维修类型</span><select data-iwap-xtype="ListField"
						name="REPAIRTYPELABEL" class="select_content" id="REPAIRTYPELABEL"></select>
				</div>
			</div>
			<div class="col-md-3">
				<div class="inputbox">
					<span>送修日期</span><input name="DELIVERDATE" type="date"
						data-iwap-xtype="TextField" id="DELIVERDATE" class="input_text_1">
				</div>
			</div>
			<div class="col-md-3">
				<div class="inputbox">
					<span>交还日期</span><input name="RETURNDATE" type="date"
						data-iwap-xtype="TextField" id="RETURNDATE" class="input_text_1">
				</div>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-12">
				<div class="inputbox">
					<span>备注</span>
					<textarea id="REMARK" name="REMARK" data-iwap-xtype="TextField"
						style="width: 710px; height: 50px;"></textarea>
				</div>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-3">
				<div class="inputbox">
					<span>申请人</span><input name="CREATEPSNNAME" type="text"
						disabled="disabled" data-iwap-xtype="TextField" id="CREATEPSNNAME"
						class="input_text_1">
				</div>
			</div>
			<div class="col-md-3">
				<div class="inputbox">
					<span>处理人</span><input name="HANDLEPSNNAME" type="text"
						disabled="disabled" data-iwap-xtype="TextField" id="HANDLEPSNNAME"
						class="input_text_1" value="${userInfo.ACCT_NM}">
				</div>
			</div>
			<div class="col-md-3">
				<div class="inputbox">
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
			<a href="javaScript:void(0)" id="add" onclick="addItem()"> <img
				alt="" src="/iwapabc/images/icon/add.png" /> 添加
			</a> <a href="javaScript:void(0)" id="clear" onclick="clearItem()"> <img
				alt="" src="/iwapabc/images/icon/refresh.png" /> 清空
			</a>
		</div>
	</div>
	<div class="col-md-8">
		<table id="iwapGrid"
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
				<th data-grid-name="EDIT" class="tl">编辑</th>
			</tr>
		</table>
	</div>
</body>

<script type="text/javascript">
	var actionType = "", iwapGrid = null, condionForm = null, operForm = null;
	var url = window.location.toString();
	var sdata1 = url.split('?')[1].split('=')[1].split('&')[0];
	var sparentid = url.split('?')[1].split('=')[2];
	var isEdit = 0, cnt = 0, rePrice = 0, list = Array();
	$(document).ready(function() {
		//parent.document.getElementById("title").value = title;
		operForm = $.IWAP.Form({
			'id' : 'itemForm'
		});
		var callFn = function(rs) {
			var dataObj = rs['body'].rows;
			condionForm = $.IWAP.Form({
				'id' : 'repairForm'
			});
			condionForm.setData(dataObj);
			document.getElementById("REPAIRNO").value = dataObj['REPAIRNO'];
		}
		var data = {
			'sparentid' : sparentid,
			'sdata1' : sdata1,
			'option' : 'init'
		};
		sendAjax(data, 'repairD', 'doBiz', callFn);

		initSelectKV('{"REPAIRTYPELABEL":"REPAIRTYPE"}');
		/* REPAIRTYPEID 维修类型ID */
	});

	//增加维修项目
	function addItem() {
		$('#itemModal').dialog('新增维修项目');
		operForm.reset();
		$('input#cost').val("0");
	};

	function edit(obj) {
		$('#itemModal').dialog("修改维修项目");
		operForm.setData(list[obj]);
		isEdit = obj;
	};

	function delOne(obj) {
		list.splice(obj, 1);
		cnt--;
		listShow();
	};

	function clearItem() {
		cnt = 0;
		list = null;
		list = Array();
		var t = document.getElementById("iwapGrid");
		var rowNum = t.rows.length;
		for (var i = 1; i < rowNum; i++) {
			t.deleteRow(i);
			rowNum--;
			i--;
		}
		rePrice = parseFloat(0).toFixed(2);
		$('#REPAIRAMOUNT').val(rePrice);
	};

	function listShow() {
		var t = document.getElementById("iwapGrid");
		var rowNum = t.rows.length;
		for (var i = 1; i < rowNum; i++) {
			t.deleteRow(i);
			rowNum--;
			i--;
		}
		rePrice = parseFloat(0);
		for (var i = 1; i <= cnt; i++) {
			var tablestr = "";
			var newstr = "";
			if (list[i]['remark'] == undefined) {
				list[i]['remark'] = "";
			}
			tablestr += "<tr>" + "<td>" + i + "</td>" + "<td>"
					+ list[i]['name'] + "</td>" + "<td>" + list[i]['cost']
					+ "</td>" + "<td>" + list[i]['remark'] + "</td>" + "<td>"
					+ "<a href='javaScript:void(0)' onclick='edit(" + i
					+ ")'>修改</a>" + "&nbsp;|&nbsp;"
					+ "<a href='javaScript:void(0)' onclick='delOne(" + i
					+ ")'>删除</a>" + "</td>" + "</tr>";
			$("#iwapGrid").append(tablestr);
			rePrice += parseFloat(list[i]['cost']);
		}
		$('#REPAIRAMOUNT').val(rePrice.toFixed(2));
	};

	function doSaveItem() {
		if ($('input#name').val() == '') {
			alert("项目名称不能为空");
			return;
		}
		if ($('input#cost').val() == '') {
			alert("维修费用不能为空");
			return;
		}
		var test = $('input#cost').val();
		if (!test.match(/^\d+$/)) {
			alert("请输入正确格式的维修费用");
			return;
		}
		var param = operForm.getData();
		if (isEdit == 0) {
			cnt++;
			list[cnt] = param;
		} else {
			list[isEdit] = param;
			isEdit = 0;
		}
		//console.info(list[cnt]); 
		listShow();
		$('#itemModal').find('.close').click();
	};

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
		sendAjax(form, 'repairD', 'doBiz', callFn);

		$('#detailModal').dialog('查看入库单');
		return;
	}
</script>
</html>