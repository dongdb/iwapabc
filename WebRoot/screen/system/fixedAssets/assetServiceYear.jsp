<%@ page language="java" import="com.nantian.iwap.web.WebEnv"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>资产使用年限统计</title>
<meta name="description" content="">
<!-- 一般查询页面所引入的样式文件 -->
<link href="${ctx}/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/css.css" rel="stylesheet">
<link href="${ctx}/css/style.css" rel="stylesheet">
<link href="${ctx}/css/iwapui-style.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/lyz.calendar.css" rel="stylesheet" type="text/css">
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
<script type="text/javascript" src="${ctx}/js/jquery.ztree.exhide-3.5.js"></script>
<script type="text/javascript" src="${ctx}/js/Tree.js"></script>
<script type="text/javascript" src="${ctx}/js/lyz.calendar.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.base64.js"></script>
<script type="text/javascript" src="${ctx}/js/tableExport.js"></script>
<script type="text/javascript" src="${ctx}/js/libs/base64.js"></script>
<script type="text/javascript" src="${ctx}/js/libs/sprintf.js"></script>
<script type="text/javascript" src="${ctx}/js/libs/jspdf.js"></script>

</head>
<body class="iwapui center_body">
	<input type="hidden" value="${userInfo.ACCT_ID}" id="_roleid">
	<input type="hidden" value="${userInfo.ORG_ID}" id="_deptId">
	<!-- 表格工具栏　开始 -->
	<div class="col-md-12">
		<div class="table_nav2">
			<a href="javaScript:void(0)" id="set" onclick=""> <img alt=""
				src="../iwapabc/images/icon/setting.png" /> 页面设置
			</a> <a href="javaScript:void(0)" id="use" onclick="doPrint1()"> <img alt=""
				src="../iwapabc/images/icon/preview.png" /> 打印预览
			</a> <a href="javaScript:void(0)" id="print" onclick=""> <img alt=""
				src="../iwapabc/images/icon/print.png" /> 打印
			</a> <a href="javaScript:void(0)" id="outpdf" onclick="printpdf()"> <img alt=""
				src="../iwapabc/images/icon/pdf.png" /> 导出为PDF文件
			</a> <a href="javaScript:void(0)" id="outword" onclick="printword()"> <img
				alt="" src="../iwapabc/images/icon/word.png" /> 导出为Word文档
			</a> <a href="javaScript:void(0)" data-iwap-dialog="" id="outexcel"
				onclick="exportData()"> <img alt=""
				src="../iwapabc/images/icon/excel.png" /> 导出为Excel工作簿
			</a>
		</div>
	</div>
	<div class="col-md-12">
		<form id="Conditions">
			<div class="inputbox" style="margin-top:5px;">
				<span>模糊查询：</span><input name="fuzzySearch" type="text" value=""
					data-iwap-xtype="TextField" id="fuzzySearch" class="input_text_1"
					onkeypress="if(event.keyCode==13) {iwapGrid.doQuery();return false;}">
			</div>
			<div class="inputbox" style="margin-top:5px;">
				<span>统计周期：</span><select data-iwap-xtype="ListField"
					name="FBUYDATE" onchange="gradeChange()" id="FBUYDATE"
					class="select_content">
					<option value="">--全部--</option>
				</select>
			</div>
			<div class="inputbox " style="margin-top:5px;">
				<input name="pid1" type="date" data-iwap-xtype="TextField" id="pid1"
					class="input_text_2" value="" disabled="disabled">
			</div>
			<div class="inputbox" style="margin-top:5px;">
				-<input name="pid2" type="date" data-date-format="mm-dd-yyyy"
					data-iwap-xtype="TextField" id="pid2" class="input_text_2" value=""
					disabled="disabled">
			</div>
			<div class="inputbox">
				<div class="table_nav2">
					<a href="javaScript:void(0)" id="search" onclick="iwapGrid.doQuery()"
						style="width:100px;text-align:center;">
					 <img alt=""src="../iwapabc/images/icon/search.png" /> 查询
					</a> <a href="javaScript:void(0)" id="refresh" 
						onclick="iwapGrid.doReset();iwapGrid.doQuery()"
						style="width:100px;text-align:center;">
					 <img alt=""src="../iwapabc/images/icon/refresh.png" /> 刷新
					</a>
				</div>
			</div>
		</form>
	</div>
	<!-- 表格工具栏　END -->
	<!-- 查询内容区域　开始 -->
	<div class="col-md-12">
		<div class="table_box" style="overflow-y: hide; height: 270px;">
			<table id="iwapGrid"
				class="mygrid table table-bordered table-striped table-hover"
				data-iwap="grid" data-iwap-id="" data-iwap-param=""
				data-iwap-pagination="true">
				<tr>
					<th data-grid-name="ROW_NUM" class="tl">序号</th>
					<th data-grid-name="FCODE" class="tl">条码</th>
					<th data-grid-name="FNAME" class="tl">资产名称</th>
					<th data-grid-name="FKIND" class="tl">资产类型</th>
					<th data-grid-name="FSTATUSNAME" class="tl">资产状态</th>
					<th data-grid-name="FBUYDATE" class="tl">购买时间</th>
					<th data-grid-name="FYEAR" class="tl">使用年数</th>
				</tr>
			</table>
		</div>
	</div>
	<!-- 查询内容区域　END -->
</body>
<script type="text/javascript">
	var iwapGrid = null, condionForm = null, operForm = null;
	$(document).ready(function() {
		parent.document.getElementById("title").value = document.title;
		condionForm = $.IWAP.Form({
			'id' : 'Conditions'
		});
		var FBUYDATE = document.getElementById("FBUYDATE").value;
		var pid1 = document.getElementById("pid1").value;
		var pid2 = document.getElementById("pid2").value;
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '10',
			'txcode' : 'assetServiceYear'
		};
		iwapGrid = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			form : condionForm,
			renderTo : 'iwapGrid'
		});
		// 初始化数据字典
		initSelectKV('{"FBUYDATE":"FCREATETIME"}');
		document.getElementById("pid1").hidden = true;
		document.getElementById("pid2").hidden = true;
		$(function(){document.onkeydown = function(e){
			var ev = document.all ? window.event:e;
			if(ev.keyCode==13){
				iwapGrid.doQuery();
			}
		}
		});
	});

	function refresh() {
		iwapGrid.doReset();
		iwapGrid.doQuery();
	}

	function gradeChange() {
		var objS = document.getElementById("FBUYDATE");
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
	
	//对话框
	function dialogModal(id) {
		$('#' + id).dialog();
	};
	
	//导出资产卡片
	function printpdf() {
		$('#iwapGrid').tableExport({
			type : 'pdf',
			escape : 'false'
		});
	}
	//导出资产卡片
	function printword() {
		$('#iwapGrid').tableExport({
			type : 'doc',
			escape : 'false'
		});
	}
	//导出资产卡片
	function exportData() {
		var data = {'exportFlag':'1','filetype':'xlsx','txcode':'assetServiceYear','actionId':'doBiz','start':'0','limit':'30000'};
		var form = condionForm.getData();
		$.IWAP.apply(data,form);
		
		var titleString = [];
		$("table#iwapGrid tbody tr:eq(0) th").each(function(){
			if($(this).hasClass("tl")){
				var titleMap = {};
				titleMap[$(this).attr("data-grid-name")]=$(this).html();
				titleString.push(titleMap);
			}
		});
		
		titleString = JSON.stringify(titleString);
		data.titleString=titleString;
		
		var param="";

		for (var key in data) {
			param += key + "=" + data[key] + "&";
		}
		param = param.substr(0,param.length-1);
		var iframe = $('<iframe name="iwapdownload">');
		iframe.css("display", "none");
		iframe.attr("src", "download.ctrl?" + param);
		$('body').prepend(iframe);
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