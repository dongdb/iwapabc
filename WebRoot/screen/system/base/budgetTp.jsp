<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="height:100%;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/screen/comm/header.jsp" %>
<link href="<%=path %>/css/style.css" rel="stylesheet">
<link href="<%=path %>/css/zTreeStyle.css" rel="stylesheet">
<script type="text/javascript" src="<%=path %>/js/iwapui.js"></script>
<script type="text/javascript" src="<%=path %>/js/Tree.js"></script>
<script type='text/javascript' src="<%=path %>/js/dictionary.js"></script>
<script type='text/javascript' src="<%=path %>/js/public.js"></script>
<style type="text/css">
.t_string{
	text-align: left
}
.t_number{
	text-align: right
}
.t_date{
	text-align: center
}
</style>
<title>预算类别</title>
</head>
<body class="iwapui center_body">
	
	<!-- 对话框开始 -->
	<div id="divDialog" class="divDialog">
		<div class="bg"></div>
		<div class="dialog" id="myModal" style="width: 500px;">
			<div class="dialog-header">
				<button type="button" data-dialog-hidden="true" class="close">
					<span>×</span>
				</button>
				<h4 class="dialog-title">新增预算类别</h4>
			</div>
			<div class="modal-body">
				<form method="post" onsubmit="return false" id="dialogarea">
					<!-- form开始 -->
					<div class="col-md-12">
						<div class="inputbox pr" data-iwap="tooltipdiv"
							data-iwap-empty="false" data-iwap-tooltext="预算类别ID不能为空">
							<span>ID:</span> <input name="FYSLBID" type="text"
								data-iwap-xtype="TextField" id="FYSLBID" class="input_text">
						</div>
						<div class="inputbox pr" data-iwap="tooltipdiv"
							data-iwap-empty="false" data-iwap-tooltext="预算类别ID不能为空">
							<span>名称:</span> <input name="FYSLBMC" type="text"
								data-iwap-xtype="TextField" id="FYSLBMC" class="input_text">
						</div>
						<div class="inputbox">
							<span>版本:</span> <input name="VERSION" type="text"
								data-iwap-xtype="TextField" id="VERSION" class="input_text">
						</div>
						<input name="FID" type="text" hidden="hidden"
								data-iwap-xtype="TextField" id="FID" class="input_text">
					</div>
				</form>
				<!-- form END -->
				<div style="padding-left: 150px">
					<div class="buttonbox">
						<button data-iwap-xtype="ButtonField" id="save"
							class="btn false mr30" data-dialog-hidden="true"
							onclick="doSave()">保存</button>
					</div>
					<div id="" class="buttonbox">
						<button data-iwap-xtype="ButtonField" id="reset" class="btn false mr30">清空</button>
						<div id="" class="buttonbox">
						<button data-iwap-xtype="ButtonField" id="resetDel" class="btn false mr30">清空</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 对话框END -->
	
	<!-- 查询内容区域　开始 -->
	<div class="table_box">
		<!-- 表格工具栏　开始 -->
		<div class="table_nav2">
			<div class="col-md-3">
				<a href="javaScript:void(0)" data-iwap-dialog="myModal" id="add" onclick="add()">
				<img alt="" src="../iwapabc/images/icon/add.png"/> 新增</a>
				<a id="selectmultidel" class="" onclick="del()" href="javaScript:void(0)">
				<img alt="" src="../iwapabc/images/icon/delete.png"/> 删除</a>
				<a href="javaScript:void(0)" id="query" onclick="iwapGrid.doReset();iwapGrid.doQuery()">
				<img alt="" src="../iwapabc/images/icon/refresh.png"/> 刷新</a>
			</div>
			<div class="col-md-3">
				<form id="Conditions">
					<div class="inputbox">
						<input name="fuzzySearch" type="text"data-iwap-xtype="TextField" 
						id="fuzzySearch" class="input_text_1"
						onkeypress="if(event.keyCode==13) {iwapGrid.doQuery();return false;}">
					</div>
					<a href="javaScript:void(0)" id="search" onclick="iwapGrid.doQuery()">
					<img alt="" src="../iwapabc/images/icon/search.png"/> 搜索</a>
				</form>
			</div>
		</div>
		<!-- 表格工具栏　END -->
		<div class="col-md-12">
		<table id="iwapGrid" class="mygrid table table-bordered table-striped table-hover"
			data-iwap="grid" data-iwap-id="" data-iwap-param="" data-iwap-pagination="true">
			<tr>
				<th data-grid-name="FID" primary="primary" data-order=""><input
					type="checkbox" name="selectname" selectmulti="selectmulti"
					value=""> <s><input type="checkbox"
						selectmulti="selectmulti" value="{{value}}"></s></th>
				<th data-grid-name="ROW_NUM">编号</th>
				<th data-grid-name="FYSLBID" class="tl">预算类别ID</th>
				<th data-grid-name="FYSLBMC" class="tl">预算类别名称</th>
				<th data-grid-name="FID" option="option" ><span>操作</span>
					<s>
						<a href="javaScript:void(0)" class="editId" onclick="edit(this)">修改</a>&nbsp;|&nbsp;
					    <a href="javaScript:void(0)" class="editId" onclick="delOne(this)">删除</a>
					</s>
				</th>
			</tr>
		</table>
		</div>
	</div>
	<!-- 查询内容区域　END -->
</body>
<script type="text/javascript">
var actionType="", iwapGrid=null,condionForm=null,operForm=null;

$(document).ready(function() {
	parent.document.getElementById("title").value=document.title;
		//重置按钮事件
		operForm=$.IWAP.Form({'id':'dialogarea'});
		$('#reset').click(function() {
			operForm.reset();
			$('#VERSION').val('0');
		});
		$('#resetDel').click(function() {
			$('input').not('#YSLBID').val(''); 
			$('#VERSION').val('0');
		});
		condionForm = $.IWAP.Form({
			'id' : 'Conditions'
		});
		/*查询表格初始化  设置默认查询条件*/
		var fData={'actionId':'doBiz','start':'0','limit':'10','txcode':'budgetTp'};
		iwapGrid = $.IWAP.iwapGrid({
			mode:'server',
			fData:fData,
			Url:'iwap.ctrl',
			grid:'grid',
			form:condionForm,
			renderTo:'iwapGrid'
		});	
	
});

//增加
function add(){
	//每次点击增加按钮后：角色和状态设成默认值
	document.getElementById("reset").style.display = "block";
	document.getElementById("resetDel").style.display = "none";
	$('#myModal').dialog('新增预算类别');
	actionType="add";
	operForm.reset();
	operForm.enabledById("FYSLBID");
	operForm.enabledById("FYSLBMC");
	$('#VERSION').val('0');
};
//对话框
function dialogModal(id){
	$('#'+id).dialog();
};
//保存
function doSave(){
	var FYSLBID = document.getElementById("FYSLBID").value;
	if(FYSLBID==""){
		alert("ID：不能为空！");
		return;
	}
	var FYSLBMC = document.getElementById("FYSLBMC").value;
	if(FYSLBMC==""){
		alert("名称：不能为空！");
		return;
	}
	var extParam={'option':actionType,'txcode':'budgetTp','actionId':'doBiz'};
	var param=operForm.getData();
	$.IWAP.applyIf(param,extParam);
	$.IWAP.iwapRequest("iwap.ctrl",param,function(rs){
		 $('#myModal').find('.close').click();
		 if (rs['header']['msg']) {
		 	return alert("保存失败:"+rs['header']['msg']);
		 }else{
		 	alert("保存成功");
		 	iwapGrid.doQuery(); 
		 }
	 },function(){
		 alert("保存失败!");
	 });
}
//删除（可多个）
function del(){
	if(iwapGrid.getCheckValues()=="") {
		alert("请选择要删除的预算类别!");
		return;
	}
	console.info(iwapGrid.getCheckValues());
	if (!confirm("确定要删除吗?请确定!"))
		return;
	
	var param={'option':"remove",'txcode':"budgetTp",'repids': iwapGrid.getCheckValues(),'actionId':"doBiz"};
	$.IWAP.iwapRequest("iwap.ctrl",param,function(rs){
		 if (rs['header']['msg']) {
		 	return alert("删除失败:"+rs['header']['msg']);
		 }else{
		 	alert("删除成功");
		 	iwapGrid.doQuery(); 
		 }
	 },function(){
		 alert("删除失败!");
	 });
};
//删除（单个）
function delOne(obj){
	if (!confirm("确定要删除吗?请确定!")){
		return;
	}
	var param={'option':"remove",'txcode':"budgetTp",'repids': iwapGrid.getCurrentRow()['FID'],'actionId':"doBiz"};
	$.IWAP.iwapRequest("iwap.ctrl",param,function(rs){
		 if (rs['header']['msg']) {
		 	return alert("删除失败:"+rs['header']['msg']);
		 }else{
		 	alert("删除成功");
		 	iwapGrid.doQuery(); 
		 }
	 },function(){
		 alert("删除失败!");
	 });
} 

//编辑
function edit(obj){
	document.getElementById("reset").style.display = "none";
	document.getElementById("resetDel").style.display = "block";
	$('#myModal').dialog("修改预算类别");
	actionType="save";
	operForm.reset();
	operForm.setData(iwapGrid.getCurrentRow());
	operForm.disabledById("FYSLBID");
	operForm.disabledById("FYSLBMC");
};

</script>
</html>