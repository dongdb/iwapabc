<%@page import="com.nantian.iwap.common.util.DateUtil"%>
<%@ page language="java" import="com.nantian.iwap.web.WebEnv"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>入库验收</title>
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
		<div class="dialog" id="checkModal"
			style="width: 900px; height: 500px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">资产验收入库</h4>
			</div>
			<div class="table_nav2">
				<a href="javaScript:void(0)" id="doCheck" onclick="doCheck()">
					<img alt="" src="../iwapabc/images/icon/check.png" /> 入库验收
				</a> <a href="javaScript:void(0)" id="checkSto" onclick="checkSto()">
					<img alt="" src="../iwapabc/images/icon/checkDetail.png" /> 查看入库单
				</a>
			</div>
			<div class="col-md-12"
				style="height: 30px; background-color: #DCDCDC;">
				<div class="col-md-8">
					<h5>出库信息</h5>
				</div>
				<div class="col-md-offset-8">
					<h5>
						出库单号：<input type="text" id="FOUTNO" name="FOUTNO"
							style="background-color: transparent; border: none;"
							disabled="disabled">
					</h5>
				</div>
			</div>
			<div class="col-md-12">
				<form method="post" onsubmit="return false" id="outForm">
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							委托管理部门 <select data-iwap-xtype="ListField" name="FMODE"
								class="select_content" id="FMODE" style="width: 102px;">
								<option value="1" selected="selected">购入</option>
							</select>
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							委托管理人 <select data-iwap-xtype="ListField" name="FMODE"
								class="select_content" id="FMODE" style="width: 112px;">
								<option value="1" selected="selected">购入</option>
							</select>
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							出库日期<input name="FCREATETIME1" type="date"
								data-iwap-xtype="TextField" id="FCREATETIME1"
								class="input_text_1" value="">
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							备&nbsp;&nbsp;&nbsp;&nbsp;注&nbsp;&nbsp;<input name="FREMARK1"
								type="text" data-iwap-xtype="TextField" id="FREMARK1"
								class="input_text_1">
						</div>
					</div>
				</form>
			</div>
			<div class="col-md-12"
				style="height: 30px; background-color: #DCDCDC;">
				<div class="col-md-8">
					<h5>入库信息</h5>
				</div>
				<div class="col-md-offset-8">
					<h5>
						入库单号：<input type="text" id="FOUTNO" name="FOUTNO"
							style="background-color: transparent; border: none;"
							disabled="disabled">
					</h5>
				</div>
			</div>
			<div class="col-md-12">
				<form method="post" onsubmit="return false" id="inForm">
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							责任部门<input name="FRESPONSEDEPTNAME1" type="text"
								data-iwap-xtype="TextField" id="FRESPONSEDEPTNAME1"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							责&nbsp;任&nbsp;人&nbsp;<input name="FRESPONSEPSNNAME1" type="text"
								data-iwap-xtype="TextField" id="FRESPONSEPSNNAME1"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							签报编号<input name="FSIGNID" type="text" data-iwap-xtype="TextField"
								id="FSIGNID" class="input_text_1">
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							入库方式<input name="FSIGNID" type="text" data-iwap-xtype="TextField"
								id="FSIGNID" class="input_text_1">
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							入库日期<input name="FCREATETIME1" type="date"
								data-iwap-xtype="TextField" id="FCREATETIME1"
								class="input_text_1" value="">
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							入库金额<input name="FAMOUNT" type="text" data-iwap-xtype="TextField"
								id="FAMOUNT" class="input_text_1">
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							放置位置<input name="FEXTENDSTR21" type="text"
								data-iwap-xtype="TextField" id="FEXTENDSTR21"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							合同编号<input name="FCONTRACT1" type="text"
								data-iwap-xtype="TextField" id="FCONTRACT1" class="input_text_1">
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							供&nbsp;应 &nbsp;商<input name="FSUPPLIER1" type="text"
								data-iwap-xtype="TextField" id="FSUPPLIER1" class="input_text_1">
						</div>
					</div>
					<div class="col-md-9">
						<div class="inputbox" style="margin: 2px;">
							备&nbsp;&nbsp;&nbsp;&nbsp;注&nbsp;&nbsp; <input name="FREMARK1"
								type="text" data-iwap-xtype="TextField" id="FREMARK1"
								class="input_text_1" style="width: 563px;">
						</div>
					</div>
				</form>
				<div class="col-md-12">
					发票信息
					<div
						style="margin-left: 55px; height: 90px; width: 780px; border: 1px solid #CCCCCC;">
						<table id="billGrid"
							class="mygrid table table-bordered table-striped table-hover"
							data-iwap="grid" data-iwap-id="" data-iwap-param=""
							data-iwap-pagination="true">
							<tr style="overflow: scroll;">
								<th data-grid-name="ROW_NUM" class="tl">序号</th>
								<th data-grid-name="FP_NUM" class="tl">发票号码</th>
								<th data-grid-name="FP_DATE" class="tl">开票日期</th>
								<th data-grid-name="FP_MONEY" class="tl">发票金额</th>
								<th data-grid-name="FRATE" class="tl">汇率</th>
								<th data-grid-name="FCURRENCY" class="tl">本位币</th>
								<th data-grid-name="FMTYPE" class="tl">币种</th>
								<th data-grid-name="FPEOPLE" class="tl">经办人</th>
								<th data-grid-name="FPROVIDER" class="tl">供应商</th>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<div class="col-md-12"
				style="height: 30px; background-color: #DCDCDC;">
				<div class="col-md-8">
					<h5>资产明细</h5>
				</div>
			</div>
			<div class="col-md-12">
				<div
					style="margin-left: 15px; height: 90px; width: 835px; border: 1px solid #CCCCCC;">
					<table id="assetGrid"
						class="mygrid table table-bordered table-striped table-hover"
						data-iwap="grid" data-iwap-id="" data-iwap-param=""
						data-iwap-pagination="true">
						<tr>
							<th data-grid-name="ROW_NUM" class="tl">序号</th>
							<th data-grid-name="FUSETYPE" class="tl">财务大类</th>
							<th data-grid-name="FKIND" class="tl">资产类别</th>
							<th data-grid-name="FNAME" class="tl">资产名称</th>
							<th data-grid-name="FSPECTYPE" class="tl">规格型号</th>
							<th data-grid-name="FPRICE" class="tl">单价</th>
							<th data-grid-name="FZCSL" class="tl">入库数量</th>
							<th data-grid-name="FISFA" class="tl">固定资产</th>
							<th data-grid-name="FREMARK" class="tl">备注</th>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>

	<div class="table_nav2">
		<div class="col-md-4">
			<a href="javaScript:void(0)" id="refresh" onclick="refresh()"> <img
				alt="" src="../iwapabc/images/icon/refresh.png" /> 刷新
			</a> <a href="javaScript:void(0)" id="search"
				onclick="iwapGrid1.doQuery()"> <img alt=""
				src="../iwapabc/images/icon/search.png" /> 查询
			</a> <a class="disa" href="javaScript:void(0)" id="check"
				onclick="check()"> <img alt=""
				src="../iwapabc/images/icon/check.png" /> 验收
			</a> <a class="disa" href="javaScript:void(0)" id="checkDetail"
				onclick="checkDetail()"> <img alt=""
				src="../iwapabc/images/icon/checkDetail.png" /> 查看验收单
			</a>
		</div>
		<form id="Conditions" class="clearfix">
			<div class="col-md-8">
				<div class="inputbox">
					搜索<input name="fuzzySearch" type="text" data-iwap-xtype="TextField"
						id="fuzzySearch" class="input_text_1" value=""
						onkeypress="if(event.keyCode==13) {iwapGrid1.doQuery();return false;}">
				</div>
				<div class="inputbox ">
					入库时间 <select data-iwap-xtype="ListField" name="createtime"
						onchange="gradeChange()" id="createtime" class="select_content">
						<option value="0">--全部--</option>
					</select>
				</div>
				<div class="inputbox ">
					<input name="pid1" type="date" data-iwap-xtype="TextField"
						id="pid1" class="input_text_2" value="" disabled="disabled">
				</div>

				<div class="inputbox">
					-<input name="pid2" type="date" data-date-format="mm-dd-yyyy"
						data-iwap-xtype="TextField" id="pid2" class="input_text_2"
						value="" disabled="disabled">
				</div>
			</div>
		</form>
	</div>


	<div class="col-md-12">
		<table id="iwapGrid1"
			class="mygrid table table-bordered table-striped table-hover"
			data-iwap="grid" data-iwap-id="" data-iwap-param=""
			data-iwap-pagination="true">
			<tr>
				<th data-grid-name="FNO" primary="primary" data-order="">选择<s><input
						id="radio1" name="radio1" type="radio" onchange="chooseChange()"
						selectmulti="selectmulti" value="{{value}}"></s></th>
				<th data-grid-name="ROW_NUM" class="tl">序号</th>
				<th data-grid-name="FSTATENAME" class="tl">入库状态</th>
				<th data-grid-name="FNO" class="tl">单据号</th>
				<th data-grid-name="FDATE" class="tl">入库日期</th>
				<th data-grid-name="FAMOUNT" class="tl">入库金额</th>
				<th data-grid-name="FMODE" class="tl">入库方式</th>
				<th data-grid-name="FCREATEDEPTNAME" class="tl">入库部门</th>
				<th data-grid-name="FCREATEPSNNAME" class="tl">入库人</th>
				<th data-grid-name="FCHECKDEPT" class="tl">验收部门</th>
				<th data-grid-name="FCHECKPSN" class="tl">验收人</th>
				<th data-grid-name="FCHECKDATE" class="tl">验收时间</th>
			</tr>
		</table>
	</div>
</body>

<script type="text/javascript">
	var actionType = "", iwapGrid1 = null, condionForm = null, operForm = null, grantTree = null, orgTree = null;
	var grantTreeData = null, orgTreeData = null;
	var storageForm = null;

	$(document).ready(function() {
		parent.document.getElementById("title").value = document.title;
		/*查询表格初始化  设置默认查询条件*/
		condionForm = $.IWAP.Form({
			'id' : 'Conditions'
		});
		var fuzzySearch = document.getElementById("fuzzySearch").value;
		var createtime = document.getElementById("createtime").value;
		var pid1 = document.getElementById("pid1").value;
		var pid2 = document.getElementById("pid2").value;
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '10',
			'txcode' : 'checkStorage',
			'option' : 'query',
			'fuzzySearch' : fuzzySearch,
			'createtime' : createtime,
			'pid1' : pid1,
			'pid2' : pid2
		};
		iwapGrid1 = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			form : condionForm,
			renderTo : 'iwapGrid1'
		});
		// 初始化入库方式是否启用（采用数据字典）
		initSelectKV('{"FMODE":"FMODE","isfa":"FISFA"}');
		initSelectKV('{"createtime":"FCREATETIME"}');
		document.getElementById("pid1").hidden = true;
		document.getElementById("pid2").hidden = true;
		$(function() {
			document.onkeydown = function(e) {
				var ev = document.all ? window.event : e;
				if (ev.keyCode == 13) {
					iwapGrid1.doQuery();
				}
			}
		});
	});

	//是否关联动支单
	function setDZD() {
		var ra = $('input[name="radiobutton"]:checked').val();
		if (ra == "yes") {
			document.getElementById("FBUDGETNO").disabled = false;
		} else if (ra == "no") {
			document.getElementById("FBUDGETNO").value = "";
			document.getElementById("FBUDGETNO").disabled = true;
		}
	}

	function transDef(val, row_data) {
		if (val) {
			for ( var p in qyzt_select) {
				if (qyzt_select[p].id == val) {
					return qyzt_select[p].text;
				}
			}
		} else {
			return "";
		}
	}

	function chooseChange() {
		//console.info("chooseChange");
		if (iwapGrid1.getCurrentRow()["FSTATENAME"] == "待验收") {
			document.getElementById("check").setAttribute("class", "");
			document.getElementById("checkDetail")
					.setAttribute("class", "disa");
		} else {
			document.getElementById("check").setAttribute("class", "disa");
			document.getElementById("checkDetail").setAttribute("class", "");
		}
	}

	function check() {
		if (iwapGrid1.getCheckValues() == "") {
			//alert("请先选择资产!");
			return;
		}
		if (iwapGrid1.getCurrentRow()["FSTATENAME"] != "待验收") {
			//alert("该资产已验收!");
			return;
		} else {
			$('#checkModal').dialog('资产验收入库');
			//option="add";
		}
	}

	function checkDetail() {
		if (iwapGrid1.getCheckValues() == "") {
			//alert("请先选择资产!");
			return;
		}
		if (iwapGrid1.getCurrentRow()["FSTATENAME"] == "待验收") {
			//alert("该资产还没有验收!");
			return;
		} else {
			console.info("checkDetail");

		}
	}

	function gradeChange() {
		var objS = document.getElementById("createtime");
		var grade = objS.options[objS.selectedIndex].value;
		if (grade == 9) {
			condionForm.enabledById("pid1");
			condionForm.enabledById("pid2");
			document.getElementById("pid1").hidden = false;
			document.getElementById("pid2").hidden = false;
		} else {
			document.getElementById("pid1").hidden = true;
			document.getElementById("pid2").hidden = true;
		}
	}

	//保存
	function doSave() {
		var param = operForm.getData();
		console.info(param);
		var extParam = {
			'option' : 'addInd',
			'txcode' : 'checkStorage',
			'actionId' : 'doBiz'
		};
		if ($('input#name').val() == '') {
			alert("资产名称不能为空");
			return;
		}
		if ($('input#kind').val() == '') {
			alert("资产类别不能为空");
			return;
		}
		if ($('input#zcsl').val() == '') {
			alert("资产数量不能为空");
			return;
		}
		if ($('input#price').val() == '') {
			alert("资产单价不能为空");
			return;
		}
		$.IWAP.applyIf(param, extParam);
		$.IWAP.iwapRequest("iwap.ctrl", param, function(rs) {
			$('#checkModal').find('.close').click();
			if (rs['header']['msg']) {
				return alert("保存失败:" + rs['header']['msg']);
			} else {
				alert("保存成功");
				//iwapGrid.doQuery(condionForm.getData()); 
			}
		}, function() {
			alert("保存失败!");
		});
	}

	function refresh() {
		iwapGrid1.doReset();
		iwapGrid1.doQuery();
	}
</script>
</html>