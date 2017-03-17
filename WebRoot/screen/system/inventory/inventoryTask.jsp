<%@ page language="java" import="com.nantian.iwap.web.WebEnv"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>盘点任务</title>
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
</head>
<body class="iwapui center_body">
	<input type="hidden" value="${userInfo.ACCT_ID}" id="_roleid">
	<input type="hidden" value="${userInfo.ORG_ID}" id="_deptId">
	<!-- 对话框开始 -->
	<div id="divDialog" class="divDialog">
		<!-- 第一个对话框开始 详细信息-->
		<!-- <div class="bg" style="height: 100%"></div>
		<div class="dialog" id="assetDetailquery" style="width: 1030px; height: 750px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10" data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">详细信息</h4>
			</div>
			<div class="modal-body" style="width: 1025px; height: 700px;">
				<iframe style="height: 680px; width: 1010px" src="iwap.ctrl?txcode=assetDetailquery"></iframe>
			</div>
		</div> -->
		<!-- 第一个对话框END 详细信息-->
	</div>
	<!-- 对话框 END-->
	<!-- 表格工具栏　开始 -->
	<div class="col-md-12 table_nav2">
		<a href="javaScript:void(0)" id="add" onclick="refresh()">
		<img alt="" src="../iwapabc/images/icon/add.png"/> 新增</a>
		<a href="javaScript:void(0)" id="delete" onclick="refresh()">
		<img alt="" src="../iwapabc/images/icon/delete.png"/> 删除</a>
		<a href="javaScript:void(0)" id="refresh" onclick="refresh()">
		<img alt="" src="../iwapabc/images/icon/refresh.png"/> 刷新</a>
	</div>
	<!-- 表格工具栏　END -->
	<!-- 查询内容区域　开始 -->
	<div class="col-md-12">
	<div class="table_box" style="height:270px; overflow-y:auto;">
		<table id="iwapGrid"
			class="mygrid table table-bordered table-striped table-hover"
			data-iwap="grid" data-iwap-id="" data-iwap-param=""
			data-iwap-pagination="true" >
			<tr>
				<th data-grid-name="ROW_NUM" class="tl">序号</th>
				<th data-grid-name="FINISHSTATUSLABEL" class="tl">任务状态</th>
				<th data-grid-name="JOBSEQ" option="option" option-html=''>
					<span>操作</span>
					<s><a href="javaScript:void(0)"  id="inventory" onclick="doInventor(this)">完成盘点</a></s>
				</th>
				<th data-grid-name="JOBSEQ" class="tl">任务编号</th>
				<th data-grid-name="TARGETORGNAME" class="tl">盘点对象</th>
				<th data-grid-name="TARGETBUILDINGNAME" class="tl">盘点位置</th>
				<th data-grid-name="STARTDATE" class="tl">开始日期</th>
				<th data-grid-name="FINISHDATE" class="tl">完成日期</th>
				<th data-grid-name="REMARK" class="tl" style="width:400px;">备注</th>
			</tr>
		</table>
	</div>
	</div>
	<!-- 查询内容区域　END -->
	<!-- 表格工具栏　开始 -->
	<div class="table_nav2">
		<div class="col-md-2">
			<a href="javaScript:void(0)" id="refresh" onclick="refresh()">
			<img alt="" src="../iwapabc/images/icon/refresh.png"/> 刷新</a>
			<a href="javaScript:void(0)" id="search" onclick="iwapGrid1.doQuery()">
			<img alt="" src="../iwapabc/images/icon/search.png"/> 查询</a>
		</div>
		<form id="Conditions" class="clearfix">
		<div class="col-md-10">
			<div class="inputbox">
				<span>盘点状态:</span><select data-iwap-xtype="ListField" name="fstatus"
								class="select_content" id="fstatus" >
								<option value="" selected="selected">-全部-</option>
							</select>
			</div>
			<div class="inputbox">
				<span>检索条件:</span><input name="fuzzysearch" type="text"
					data-iwap-xtype="TextField" id="fuzzysearch" class="input_text_1"
					value="" >
			</div>
		</div>
	</form>
	</div>
	<!-- 表格工具栏　END -->
	<!-- 页面查询区域　END -->
	<!-- 查询内容区域　开始 -->
	<div class="col-md-12">
	<div class="table_box"  style="overflow-y:hide;height:270px;">
		<table id="iwapGrid1" class="mygrid table table-bordered table-striped table-hover"
			data-iwap="grid" data-iwap-id="" data-iwap-param="" data-iwap-pagination="true" >
			<tr>
				<th data-grid-name="ROW_NUM" class="tl">序号</th>
				<th data-grid-name="BARCODE" class="tl">条码号</th>
				<th data-grid-name="NAME" class="tl">资产名称</th>
				<th data-grid-name="USETYPE" class="tl">使用状态</th>
				<th data-grid-name="LOCATION" class="tl">资产位置</th>
				<th data-grid-name="STATUSLABEL" class="tl">盘点状态</th>
			</tr> 
		</table>
	</div>
	</div>
	<!-- 查询内容区域　END -->
</body>
<script type="text/javascript">
var actionType="", iwapGrid=null,condionForm=null,operForm=null,iwapGrid1=null;
var fData1={};
$(document).ready(function() {
	parent.document.getElementById("title").value=document.title;
	
	var fData={'actionId':'doBiz',
			   'start':'0','limit':'5','txcode':'inventoryTask'};
	iwapGrid = $.IWAP.iwapGrid({
		mode:'server',
		fData:fData,
		Url:'${ctx}/iwap.ctrl',
		grid:'grid',
		renderTo:'iwapGrid'
	});	
	
	condionForm=$.IWAP.Form({'id':'Conditions'});
	fData1={'fnum':'%','option':'bill',
			'actionId':'doBiz','start':'0','limit':'10','txcode':'inventoryTask'};
	iwapGrid1 = $.IWAP.iwapGrid({
		mode:'server',
		fData:fData1,
		Url:'${ctx}/iwap.ctrl',
		grid:'grid',
		form:condionForm,
		renderTo:'iwapGrid1'
	});
	// 初始化数据字典
	initSelectKV('{"fstatus":"INVENSTATUS"}');
	
});

function refresh(){
	iwapGrid.doReset();
	iwapGrid.doQuery();
}
function refresh1(){
	iwapGrid1.doReset();
	iwapGrid1.doQuery();
}

function doInventor(obj){
	/* var fid=iwapGrid.getCurrentRow().FID;
	condionForm=$.IWAP.Form({'id':'Conditions'});
	fData1={'fid':fid,'option':'bill',
			'actionId':'doBiz','start':'0','limit':'50','txcode':'inventoryTask'};
	iwapGrid1 = $.IWAP.iwapGrid({
		mode:'server',
		fData:fData1,
		Url:'${ctx}/iwap.ctrl',
		grid:'grid',
		form:condionForm,
		renderTo:'iwapGrid1'
	}); */
	
};

</script>
</html>