<%@ page language="java" import="com.nantian.iwap.web.WebEnv"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>入库方式</title>
<meta name="description" content="">
<!-- 一般查询页面所引入的样式文件 -->
<link href="${ctx}/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/css.css" rel="stylesheet">
<link href="${ctx}/css/style.css" rel="stylesheet">
<link href="${ctx}/css/iwapui-style.css" rel="stylesheet" type="text/css">
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
				<h4 class="dialog-title">新增入库方式</h4>
			</div>
			<div class="modal-body">
				<form method="post" onsubmit="return false" id="dialogarea">
					<!-- form开始 -->
					<div class="col-md-12">
						<div class="inputbox pr" data-iwap="tooltipdiv"
							data-iwap-empty="false" data-iwap-tooltext="入库方式名称不能为空">
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
				<th data-grid-name="ROW_ID">编号</th>
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
var actionType="", iwapGrid=null, operForm=null;

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
			var fData={'actionId':'doBiz','start':'0','limit':'10','txcode':'storageMg'};
			iwapGrid = $.IWAP.iwapGrid({
				mode:'server',
				fData:fData,
				Url:'${ctx}/iwap.ctrl',
				grid:'grid',
				renderTo:'iwapGrid'
			});	
			// 初始化入库方式是否启用（采用数据字典）
			initSelectKV('{"FUSESTATUSNAME":"STO_ABLE" }');

});
//增加
function add(){
	//每次点击增加按钮后：入库方式是否启用设成默认值
	document.getElementById("reset").style.display = "block";
	document.getElementById("resetDel").style.display = "none";
	$('#myModal').dialog('新增入库方式');
	actionType="insert";
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
	var extParam={'actionType':actionType,'txcode':'storageMg','actionId':'doBiz'};
	var param=operForm.getData();
	$.IWAP.applyIf(param,extParam);
	iwapGrid.doSave(param,'#myModal');
}
//删除（可多个）
function del(){
	if(iwapGrid.getCheckValues()=="") {
		alert("请选择要删除的入库方式!");
		return;
	}
	
	if (!confirm("确定要删除吗?请确定!"))
		return;
	var list = iwapGrid.getCheckValues().split(",");
	var param={'actionType':"delete",'txcode':"storageMg",'list':list,'actionId':"doBiz"};
	iwapGrid.doDelete(param);
};

//删除（单个）
function delOne(obj){
	if (!confirm("确定要删除吗?请确定!")){
		return;
	}
	var list = Array();
	list[0]=iwapGrid.getCurrentRow()['FID'];
	var param={'actionType':"delete",'txcode':"storageMg",'list': list,'actionId':"doBiz"};
	iwapGrid.doDelete(param);
};

//编辑
function edit(obj){
	document.getElementById("reset").style.display = "none";
	document.getElementById("resetDel").style.display = "block";
	$('#myModal').dialog("修改入库方式");
	actionType="update";
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
		var param={'actionType':"stop",'txcode':"storageMg",'list':list,'actionId':"doBiz",'FID':FID};
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
		var param={'actionType':"restart",'txcode':"storageMg",'list':list,'actionId':"doBiz",'FID':FID};
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