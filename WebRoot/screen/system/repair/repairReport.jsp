<%@page import="com.nantian.iwap.common.util.DateUtil"%>
<%@ page language="java" import="com.nantian.iwap.web.WebEnv"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>维修统计</title>
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
	<div class="col-md-12 table_nav2">
		<a href="javaScript:void(0)" id="set" onclick=""> <img alt=""
			src="../iwapabc/images/icon/setting.png" /> 页面设置
		</a> <a href="javaScript:void(0)" id="use" onclick=""> <img alt=""
			src="../iwapabc/images/icon/preview.png" /> 打印预览
		</a> <a href="javaScript:void(0)" id="print" onclick=""> <img alt=""
			src="../iwapabc/images/icon/print.png" /> 打印
		</a> <a href="javaScript:void(0)" id="outpdf" onclick=""> <img alt=""
			src="../iwapabc/images/icon/pdf.png" /> 导出为PDF文件
		</a> <a href="javaScript:void(0)" id="outword" onclick=""> <img alt=""
			src="../iwapabc/images/icon/word.png" /> 导出为Word文档
		</a> <a href="javaScript:void(0)" data-iwap-dialog="" id="outexcel"
			onclick="exportExcel()"> <img alt=""
			src="../iwapabc/images/icon/excel.png" /> 导出为Excel工作簿
		</a>
	</div>

	<form id="Conditions" class="clearfix">
		<div class="col-md-11">
			<div class="inputbox">
				查询条件<input name="fuzzySearch" type="text"
					data-iwap-xtype="TextField" id="fuzzySearch" class="input_text_1"
					value=""
					onkeypress="if(event.keyCode==13) {iwapGrid1.doQuery();return false;}">
			</div>

			<div class="inputbox ">
				维修时间 <select data-iwap-xtype="ListField" name="repairtime"
					onchange="gradeChange()" id="repairtime" class="select_content">
					<option value="0">--全部--</option>
				</select>
			</div>
			<div class="inputbox ">
				<input name="pid1" type="date" data-iwap-xtype="TextField" id="pid1"
					class="input_text_2" value="" disabled="disabled">
			</div>

			<div class="inputbox">
				<span style="width:10px;text-align:center" id="pid">--</span>
				<input name="pid2" type="date" data-date-format="mm-dd-yyyy"
					data-iwap-xtype="TextField" id="pid2" class="input_text_2" value=""
					disabled="disabled">
			</div>
			<div class="inputbox">
				<div class="table_nav2">
					<a href="javaScript:void(0)" id="search" onclick=""
						style="width: 92px; text-align: center;"> <img alt=""
						src="../iwapabc/images/icon/search.png" /> 查询
					</a>
				</div>
			</div>
		</div>
	</form>
	<div class="col-md-12">
		<table class="assetTable" id="assetTable">
			<tr>
				<td colspan="7"><h4 align="center">资产维修统计</h4></td>
			</tr>
			<tr>
				<td class="assetTable_title">申请部门</td>
				<td class="assetTable_title">维修单号</td>
				<td class="assetTable_title">申请时间</td>
				<td class="assetTable_title">维修资产</td>
				<td class="assetTable_title">条码</td>
				<td class="assetTable_title">维修金额</td>
				<td class="assetTable_title">处理人</td>
			</tr>
			<tr>
				<td rowspan="2" class="assetTable_content" id="dept"></td>
				<td class="assetTable_content" id="repairno"></td>
				<td class="assetTable_content" id="time"></td>
				<td class="assetTable_content" id="assetname"></td>
				<td class="assetTable_content" id="barno"></td>
				<td class="assetTable_content" id="amount"></td>
				<td class="assetTable_content" id="psnname"></td>
			</tr>
			<tr>
				<td colspan="2" class="assetTable_title1">数量合计：</td>
				<td class="assetTable_title1" id="sum_num0"></td>
				<td class="assetTable_title1">金额合计：</td>
				<td colspan="2" class="assetTable_title1" id="sum_amount0"></td>
			</tr>
			<tr>
				<td colspan="3" class="assetTable_title1">数量合计：</td>
				<td class="assetTable_title1" id="sum_num"></td>
				<td class="assetTable_title1">金额合计：</td>
				<td colspan="2" class="assetTable_title1" id="sum_amount"></td>
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
		var search = document.getElementById("search").value;
		var repairtime = document.getElementById("repairtime").value;
		var pid1 = document.getElementById("pid1").value;
		var pid2 = document.getElementById("pid2").value;
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '10',
			'txcode' : 'repairReport',
			'option' : 'query',
			'search' : search,
			'repairtime' : repairtime,
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
		initSelectKV('{"repairtime":"FCREATETIME"}');
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
		var objS = document.getElementById("repairtime");
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

	//保存
	function doSave() {
		var param = operForm.getData();
		console.info(param);
		var extParam = {
			'option' : 'addInd',
			'txcode' : 'repairReport',
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