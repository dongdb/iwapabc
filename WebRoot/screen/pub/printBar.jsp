<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>资产信息条码打印</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/screen/comm/header.jsp"%>
<link href="<%=path%>/css/style.css" rel="stylesheet">
<link href="<%=path%>/css/iwapui-style.css" rel="stylesheet">
<link href="<%=path%>/css/zTreeStyle.css" rel="stylesheet">
<script type="text/javascript" src="<%=path%>/js/iwapui.js"></script>
<script type='text/javascript' src="<%=path%>/js/dictionary.js"></script>
<script type='text/javascript' src="<%=path%>/js/public.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.base64.js"></script>
<script type="text/javascript" src="<%=path%>/js/tableExport.js"></script>
<script type="text/javascript" src="<%=path%>/js/libs/base64.js"></script>
<script type="text/javascript" src="<%=path%>/js/libs/sprintf.js"></script>
<script type="text/javascript" src="<%=path%>/js/libs/jspdf.js"></script>
<style>
#uploadImg {
	font-size: 12px;
	overflow: hidden;
	position: absolute
}

#fileccc {
	position: absolute;
	z-index: 100;
	margin-left: -180px;
	font-size: 60px;
	opacity: 0;
	filter: alpha(opacity = 0);
	margin-top: -5px;
}
</style>
</head>
<body class="iwapui center_body">
	<div class="modal-body">
		<!-- 对话框开始 -->
		<div id="divDialog" class="divDialog">
			<!-- 第六个对话框开始 打印资产卡片-->
			<div class="bg" style="height: 100%;"></div>
			<div class="dialog" id="printM" style="width: 800px; height: 600px;">
				<div class="dialog-header">
					<button type="button" class="close" id="btn_iwap-gen-10"
						data-dialog-hidden="true">
						<span>×</span>
					</button>
					<h4 class="modal-title">打印资产卡片</h4>
				</div>
				<div class="table_nav2" style="border: 1px solid white;">
					<!-- <a href="javaScript:void(0)" id="set" onclick="">页面设置</a> -->
					<a href="javaScript:void(0)" id="use" onclick="doPrint1()">打印预览</a>
					<!-- <a href="javaScript:void(0)" id="print" onclick="">打印</a>  -->
					<a href="javaScript:void(0)" id="outpdf" onclick="printpdf()">导出为PDF文件</a>
					<a href="javaScript:void(0)" id="outword" onclick="printword()">导出为Word文档</a>
					<a href="javaScript:void(0)" data-iwap-dialog="" id="outexcel"
						onclick="printexcel()">导出为Excel工作簿</a>
				</div>
				<div class="col-md-12" id="mycontent">
					<div
						style="height: 480px; width: 770px; border: 1px solid #CCCCCC;">
						<table class="assetTable" id="assetTable">
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td colspan="4"><h4 align="center">资产卡片</h4></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td class="assetTable_title">资产条码</td>
								<td class="assetTable_content" id="code"></td>
								<td class="assetTable_title">资产名称</td>
								<td class="assetTable_content" id="name"></td>
							</tr>
							<tr>
								<td class="assetTable_title">规格型号</td>
								<td class="assetTable_content" id="type"></td>
								<td class="assetTable_title">购买日期</td>
								<td class="assetTable_content" id="date"></td>
							</tr>
							<tr>
								<td class="assetTable_title">责任人</td>
								<td class="assetTable_content" id="reper"></td>
								<td class="assetTable_title">责任机构</td>
								<td class="assetTable_content" id="redept"></td>
							</tr>
							<tr>
								<td class="assetTable_title">使用人</td>
								<td class="assetTable_content" id="useper"></td>
								<td class="assetTable_title">资产位置</td>
								<td class="assetTable_content" id="location"></td>
							</tr>
							<tr>
								<td class="assetTable_title">备注</td>
								<td class="assetTable_content" colspan="3" id="mark"></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<!-- 第六个对话框END 打印资产卡片-->
		</div>
		<!-- 对话框 END-->
		<!-- 表格工具栏　开始 -->
		<div class="table_nav2" style="padding-left: 50px;">
			<a href="javaScript:void(0)" data-iwap-dialog="printM" id="print"
				onclick="doPrint()">打印资产卡片</a>
		</div>
		<!-- 表格工具栏　END -->
		<form method="post" onsubmit="return false" id="dialogarea">
			<!-- form开始 -->
			<div class="col-md-12">
				<div class="col-md-6">
					<div class="inputbox pr">
						<span>资产编号</span> <input name="FCODE" type="text"
							data-iwap-xtype="TextField" id="FCODE" class="input_text_1"
							disabled="disabled">
					</div>
					<div class="inputbox pr">
						<span>资产类别</span> <input name="FKIND" type="text"
							data-iwap-xtype="TextField" id="FKIND" class="input_text_1">
					</div>
					<div class="inputbox pr">
						<span>资产名称</span> <input name="FNAME" type="text"
							data-iwap-xtype="TextField" id="FNAME" class="input_text_1">
					</div>
					<div class="inputbox pr">
						<span>是否固定资产</span>&nbsp;<input name="FISFA" type="text"
							data-iwap-xtype="TextField" id="FISFA" class="input_text_1">
						</select>
					</div>
					<div class="inputbox pr">
						<span>放置位置</span> <input name="FEXTENDSTR2" type="text"
							data-iwap-xtype="TextField" id="FEXTENDSTR2" class="input_text_1">
					</div>
				</div>
				<div class="col-md-4">
					<div style="width: 300px; height: 120px; border: 1px solid #EDEDED">
						<img id="barcode"
							src="<%=request.getContextPath()%>/barcode?msg=000000000000"
							height="120px" width=300px />
					</div>
					<div class="inputbox pr">
						<input name="FASSETINNO" type="hidden" data-iwap-xtype="TextField"
							id="FASSETINNO">
					</div>
					<div class="inputbox pr">
						<input name="FID" type="hidden" data-iwap-xtype="TextField"
							id="FID">
					</div>
				</div>
			</div>
		</form>
		<!-- form END -->
	</div>
</body>
<script>
	
	var actionType = "",condionForm = null,operForm = null;
	var url = window.location.toString();
	var INTCALMTHD = url.split('?')[1].split('=')[2];
	console.info("FID:"+INTCALMTHD);
	$(document).ready(function() {
		operForm = $.IWAP.Form({'id' : 'dialogarea'});
		var callFn = function(rs) {
		var dataObj = rs['body'].rows;
			console.info(dataObj);
			operForm.setData(dataObj);
			var fbarcode=dataObj['FBARCODE'];
			$("#barcode").attr("src", "<%=request.getContextPath()%>/barcode?msg=" + fbarcode);
		}
		var data = {
			'fid' : INTCALMTHD,
			'option' : 'show'
		};
		sendAjax(data, 'printBar', 'doBiz', callFn);
		initSelectKV('{"FCHECKED":"FCHECKED","FSTATUSNAME":"FSTATUSNAME"}');
		initSelectKV('{"CON_STATUS":"CON_STATUS","ASSET":"ASSET","ASSET_SOURCE":"ASSET_SOURCE"}');
		initSelectKV('{"FISDEPT":"FISDEPT","FCREATETIME":"FCREATETIME"}');
		initSelectKV('{"OPERATOR":"OPERATOR"}');
	});
	function doPrint() {
		document.getElementById("code").innerHTML = document
				.getElementById("FCODE").value;
		document.getElementById("name").innerHTML = document
				.getElementById("FNAME").value;
		document.getElementById("type").innerHTML = document
				.getElementById("FSPECTYPE").value;
		document.getElementById("date").innerHTML = document
				.getElementById("FBUYDATE").value;
		document.getElementById("reper").innerHTML = document
				.getElementById("FRESPONSEPSNNAME").value;
		document.getElementById("redept").innerHTML = document
				.getElementById("FRESPONSEDEPTNAME").value;
		document.getElementById("useper").innerHTML = document
				.getElementById("FDUTYPSNNAME").value;
		document.getElementById("location").innerHTML = document
				.getElementById("FEXTENDSTR21").value;
		document.getElementById("mark").innerHTML = document
				.getElementById("FREMARK").value;
	}
	//导出资产卡片
	function printpdf() {
		$('#assetTable').tableExport({
			type : 'pdf',
			escape : 'false'
		});
	}
	//导出资产卡片
	function printword() {
		$('#assetTable').tableExport({
			type : 'doc',
			escape : 'false'
		});
	}
	//导出资产卡片
	function printexcel() {
		$('#assetTable').tableExport({
			type : 'excel',
			escape : 'false'
		});
	}
	function doPrint1() {
		var str = "<html>";
		var article;
		var css;
		var strAdBegin = "<!--pStart-->";
		var strAdEnd = "<!--pEnd-->";
		var strdoPrint = "doPrint1()";
		var strTmp;
		css = "<style>" + "body{font-family:微软雅黑;}" + "</style>";
		str += css;
		str += '<meta http-equiv="content-type" content="text/html; charset=utf-8">';
		str += '<title>' + document.title + '</title>';
		str += "<body bgcolor=#ffffff topmargin=5 leftmargin=5 marginheight=5 marginwidth=5>";
		str += "<center><table width=760 border=0 cellspacing=0 cellpadding=0><tr><td align=right valign=bottom><a href='javascript:history.back()'>返回</a>　<a href='javascript:window.print()'>打印</a></td></tr></table>";
		str += "<table width=750 border=0 cellpadding=0 cellspacing=20 bgcolor=#FEFFFF><tr><td>";
		title = document.title;
		str += "<div align=center><font style=font-size:23px;>" + title
				+ "</font></div><br/>";
		article = document.getElementById('mycontent').innerHTML;
		if (article.indexOf(strAdBegin) != -1) {
			strTmp = article.substr(article.indexOf(strAdBegin)
					+ strAdBegin.length, article.indexOf(strAdEnd));
		} else {
			strTmp = article
		}
		strTmp = strTmp.replace(/<BR><BR>/ig, "<BR>");
		strTmp = strTmp.replace(/<script.*?>[\s\S]*<\/script>/ig, "");
		strTmp = strTmp.replace(/&nbsp;/ig, " ");
		strTmp = strTmp.replace(/<p>/ig, "<br>");
		strTmp = strTmp.replace(/<\/p>/ig, "");
		strTmp = strTmp.replace(/<br>[\s|　| ]*?<br>/ig, "<BR>");
		strTmp = strTmp.replace(/<iframe.*?>.*?<\/iframe>/ig, "");
		strTmp = strTmp.replace(/^[\s]*\n/ig, "");
		strTmp3 = strTmp.substr(strTmp.indexOf("<!--pEnd-->"), article
				.indexOf(strAdEnd));
		strTmp = strTmp.replace(strTmp3, "");
		strTmp2 = "<div id='content'></div>";
		str += strTmp2;
		str += "</td></tr></table></center>";
		str += "</body></html>";
		document.write(str);
		document.close();
		document.getElementById("content").innerHTML = strTmp;
	}
</script>
</html>
