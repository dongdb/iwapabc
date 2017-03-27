<%@ page language="java" import="com.nantian.iwap.web.WebEnv"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>首页 </title>
<meta name="description" content="">
<!-- 一般查询页面所引入的样式文件 -->
<link href="${ctx}/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/css.css" rel="stylesheet">
<link href="${ctx}/css/style.css" rel="stylesheet">
<link href="${ctx}/css/iwapui-style.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/zTreeStyle.css" rel="stylesheet">
<link href="${ctx}/css/easyui.css" rel="stylesheet">
<!-- JQ必须在最JS上面 -->

<script src="${ctx}/js/jquery.min.js"></script>
<script src="${ctx}/js/jquery-3.2.0.min.js"></script>
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

</head>
<body class="iwapui center_body">
	<div class="col-md-12" style="margin-top:10px;">
		<div style="border: 1px solid #d0e4ff; width:100%; height:250px;">
			<div style="border:none; background-color: #d0e4ff; height:23px; font-size:15px;">
				&nbsp;&nbsp; 待 办 任 务
			</div>
			<div style="height:225px; overflow-y:auto;">
			<table id="tesReady" style="width:100%;
				border-collapse:separate; border-spacing:10px; font-size:14px;">
			</table>
			</div>
		</div>
	</div>
	<div class="col-md-12" style="margin-top:10px;">
		<div style="border: 1px solid #d0e4ff; width:100%; height:250px;">
			<div style="border:none; background-color: #d0e4ff; height:23px; font-size:15px;">
				 &nbsp;&nbsp; 提 交 任 务
			</div>
			<div style="height:225px; overflow-y:auto;">
			<table id="finished" style="width:100%; 
				border-collapse:separate; border-spacing:10px; font-size:14px;"">
			</table></div>
		</div>
	</div>
</body>

<script type="text/javascript">
var dataObj = Array(), dataObj1 = Array();
$(document).ready(function() {
	parent.document.getElementById("title").value=document.title;
	var callFn = function(rs) {
		dataObj = rs['body'].rows;
		var length = rs['body'].total;
		for(var i=0;i<length;i++){
			var tablestr = "";
			var newstr = "";
			tablestr += "<tr>" + "<td width='80%'>"
					+ "<a href='javaScript:void(0)' style='color:#1f3a87' "
					+ "onclick='edit(" + i + ")'>"
					+ dataObj[i]['SNAME'] + "</a>" + "</td>" 
					+ "<td width='10%'>" + dataObj[i]['SCREATORPERSONNAME'] + "</td>" 
					+ "<td width='10%'>" + dataObj[i]['SCREATETIME'] + "</td>" 
					+ "</tr>";
			$("#tesReady").append(tablestr);
		}
		dataObj1 = rs['body'].rows1;
		var length1 = rs['body'].total1;
		for(var i=0;i<length1;i++){
			var tablestr = "";
			var newstr = "";
			tablestr +=  "<tr>" + "<td width='80%' >"
					+ "<a href='javaScript:void(0)' "
					+ "style='color:#1f3a87' onclick='edit("
					+ dataObj1[i]['SEURL'] + ")'>"
					+ dataObj1[i]['SNAME'] + "</a>" + "</td>" 
					+ "<td width='10%'>" + dataObj1[i]['SEXECUTORNAMES'] + "</td>" 
					+ "<td width='10%'>" + dataObj1[i]['SCREATETIME'] + "</td>" 
					+ "</tr>";
			$("#finished").append(tablestr);
		}
	}
	var data = {
		'option' : 'init'
	};
	sendAjax(data, 'homePage', 'doBiz', callFn);
	
});

function edit(obj){
	var url = dataObj[obj]['SEURL'];
	window.location=url+"?sdata="+dataObj[obj]['SDATA1']+"&fid="+dataObj[obj]['SPARENTID'];
};

</script>
</html>