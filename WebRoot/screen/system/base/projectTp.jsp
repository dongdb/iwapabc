<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
<title>工程类型</title>
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
				<h4 class="dialog-title">新增工程类型</h4>
			</div>
			<div class="modal-body">
				<form method="post" onsubmit="return false" id="dialogarea">
					<!-- form开始 -->
					<div class="col-md-12">
						<div class="inputbox pr" data-iwap="tooltipdiv"
							data-iwap-empty="false" data-iwap-tooltext="工程类型名称不能为空">
							<span>名称:</span> <input name="FNAME" type="text"
								data-iwap-xtype="TextField" id="FNAME" class="input_text">
						</div>
						<div class="inputbox">
							<span>版本:</span> <input name="VERSION" type="text"
								data-iwap-xtype="TextField" id="VERSION" class="input_text">
						</div>
						<div class="inputbox">
							<span>描述:</span> <input name="FDESCRIPTION" type="text"
								data-iwap-xtype="TextField" id="FDESCRIPTION" class="input_text">
						</div>
						<div class="selectbox mr60 inputbox" id="ctx_iwap-gen-7">
							<span>是否启用:</span> <select data-iwap-xtype="ListField"
								id="FUSESTATUSNAME" name="FUSESTATUSNAME" class="select_btn "
								style="width:50px;height:25px;margin-top:3px;">
							</select>
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
	<div class="col-md-12">
	<div class="table_box">
		<!-- 表格工具栏　开始 -->
		<div class="table_nav2">
			<a href="javaScript:void(0)" data-iwap-dialog="myModal" id="add" onclick="add()">
			<img alt="" src="../iwapabc/images/icon/add.png"/> 新增</a>
			<a id="selectmultidel" class="" onclick="del()" href="javaScript:void(0)">
			<img alt="" src="../iwapabc/images/icon/delete.png"/> 删除</a>
			<a href="javaScript:void(0)" id="query" onclick="iwapGrid.doQuery()">
			<img alt="" src="../iwapabc/images/icon/refresh.png"/> 刷新</a>
			<a href="javaScript:void(0)" id="stop" onclick="stop()" class="disa">
			<img alt="" src="../iwapabc/images/icon/setting.png"/> 停用</a>
			<a href="javaScript:void(0)" id="restart" onclick="start()" class="disa">
			<img alt="" src="../iwapabc/images/icon/setting.png"/> 启用</a>
		</div>
		<!-- 表格工具栏　END -->
		<table id="iwapGrid" class="mygrid table table-bordered table-striped table-hover"
			data-iwap="grid" data-iwap-id="" data-iwap-param="" data-iwap-pagination="true">
			<tr>
				<th data-grid-name="FID" primary="primary" data-order="">选择<s><input
						id="radio1" name="radio1" type="radio" onchange="chooseChange()"
						selectmulti="selectmulti" value="{{value}}"></s></th>
				<th data-grid-name="ROW_NUM">编号</th>
				<th data-grid-name="FNAME" class="tl">名称</th>
				<th data-grid-name="FDESCRIPTION" class="tl">描述</th>
				<th data-grid-name="FUSESTATUSNAME" class="tl" >启用状态</th>
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
			$('select#FUSESTATUSNAME').val('启用');
		});
		$('#resetDel').click(function() {
			$('input').not('#FNAME').val(''); 
			$('#VERSION').val('0');
				$('select#FUSESTATUSNAME').val('启用');
		});
		
		/*查询表格初始化  设置默认查询条件*/
		var fData={'actionId':'doBiz','start':'0','limit':'10','txcode':'projectTp'};
		iwapGrid = $.IWAP.iwapGrid({
			mode:'server',
			fData:fData,
			Url:'iwap.ctrl',
			grid:'grid',
			renderTo:'iwapGrid'
		});	
	
	// 初始化角色,状态（采用数据字典）
	initSelectKV('{"FUSESTATUSNAME":"STO_ABLE"}');
	
});

//增加
function add(){
	//每次点击增加按钮后：角色和状态设成默认值
	document.getElementById("reset").style.display = "block";
	document.getElementById("resetDel").style.display = "none";
	$('#myModal').dialog('新增工程类型');
	actionType="add";
	operForm.reset();
	operForm.enabledById("FNAME");
	$('select#FUSESTATUSNAME').val('启用');
	$('#VERSION').val('0');
};
//对话框
function dialogModal(id){
	$('#'+id).dialog();
};
//保存
function doSave(){
	var FNAME = document.getElementById("FNAME").value;
	if(FNAME==""){
		alert("名称：不能为空！");
		return;
	}
	var extParam={'option':actionType,'txcode':'projectTp','actionId':'doBiz'};
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
		alert("请选择要删除的工程类型!");
		return;
	}
	console.info(iwapGrid.getCheckValues());
	if (!confirm("确定要删除吗?请确定!"))
		return;
	
	var param={'option':"remove",'txcode':"projectTp",'repids': iwapGrid.getCheckValues(),'actionId':"doBiz"};
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
	var param={'option':"remove",'txcode':"projectTp",'repids': iwapGrid.getCurrentRow()['FID'],'actionId':"doBiz"};
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
	$('#myModal').dialog("修改工程类型");
	actionType="save";
	operForm.reset();
	operForm.setData(iwapGrid.getCurrentRow());
	operForm.disabledById("FNAME");
	$('select#FUSESTATUSNAME').val(iwapGrid.getCurrentRow()['FUSESTATUSNAME']);
};

function chooseChange() {
	//console.info("chooseChange");
	if (iwapGrid.getCurrentRow()["FUSESTATUSNAME"] == "停用") {
		document.getElementById("stop").setAttribute("class", "disa");
		document.getElementById("restart").setAttribute("class", "");
	} else {
		document.getElementById("stop").setAttribute("class", "");
		document.getElementById("restart").setAttribute("class", "disa");
	}
}


//停用（单个）
function stop(){
	if(iwapGrid.getCheckValues()=="") {
		return;
	}
	var FID = iwapGrid.getCurrentRow()["FID"];
	var list = Array();
	if (iwapGrid.getCurrentRow()["FUSESTATUSNAME"] == "启用"){
		var param={'option':"stop",'txcode':"projectTp",'list':list,'actionId':"doBiz",'FID':FID};
		$.IWAP.iwapRequest("iwap.ctrl",param,function(data){
			 if (data.body.ERROR) {
			 	return alert("停用失败:"+data.body.ERROR);
			 }else{
			 	alert("停用成功");
			 	tdloding();
			 }
		 },function(){
			 alert("停用失败!");
		 });
	}else if (iwapGrid.getCurrentRow()["FUSESTATUSNAME"] == "停用"){
		return;
	}
	document.getElementById("stop").setAttribute("class", "disa");
	document.getElementById("restart").setAttribute("class", "disa");
	iwapGrid.doQuery();
};
//启用（单个）
function start(){
	if(iwapGrid.getCheckValues()=="") {
		return;
	}
	var FID = iwapGrid.getCurrentRow()["FID"];
	var list = Array();
	if (iwapGrid.getCurrentRow()["FUSESTATUSNAME"] == "启用"){
		return;
	}else if (iwapGrid.getCurrentRow()["FUSESTATUSNAME"] == "停用"){
		var param={'option':"restart",'txcode':"projectTp",'list':list,'actionId':"doBiz",'FID':FID};
		$.IWAP.iwapRequest("iwap.ctrl",param,function(data){
			 if (data.body.ERROR) {
			 	return alert("启用失败:"+data.body.ERROR);
			 }else{
			 	alert("启用成功");
			 	tdloding();
			 }
		 },function(){
			 alert("启用失败!");
		 });
	}
	document.getElementById("stop").setAttribute("class", "disa");
	document.getElementById("restart").setAttribute("class", "disa");
	iwapGrid.doQuery();
	
};
</script>
</html>