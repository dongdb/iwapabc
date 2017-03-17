<%@ page language="java" import="com.nantian.iwap.web.WebEnv"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>资产查询</title>
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
	<!-- 页面查询区域开始 -->
	<!-- 表格工具栏　开始 -->
	<div class="col-md-12">
	<div class="table_nav2">
		<div class="col-md-2">
			<a href="javaScript:void(0)" id="query" onclick="refresh()">
			<img alt="" src="../iwapabc/images/icon/refresh.png"/> 刷新</a>
			<a href="javaScript:void(0)" id="query" onclick="iwapGrid.doQuery()">
			<img alt="" src="../iwapabc/images/icon/search.png"/> 查询</a>
		</div>
		<form id="AssetConditions" class="clearfix">
		<div class="col-md-10">
			<div class="inputbox">
				<span>确认状态:</span><select data-iwap-xtype="ListField" name="assetConfirm"
					class="select_content" id="assetConfirm" style="width: 100px;">
					<option value="">--全部--</option>
				</select>
			</div>
			<div class="inputbox">
				<span>检索条件:</span><input name="fcode" type="text"
					data-iwap-xtype="TextField" id="fcode" class="input_text_1"
					value="" style="width: 100px;">
			</div>
			<div class="inputbox">
				<span>入库时间:</span><select data-iwap-xtype="ListField" name="createTime"  onchange="gradeChange()"
					id="createTime" class="select_content" style="width: 100px;">
					<option value="">--全部--</option>
				</select>
			</div>			
			<div class="inputbox " >
			<input name="pid1" type="date"
				data-iwap-xtype="TextField" id="pid1" class="input_text_2"
				value="" disabled="disabled">
			</div>		
			<div class="inputbox" >
				-<input name="pid2" type="date" data-date-format="mm-dd-yyyy"
				data-iwap-xtype="TextField" id="pid2" class="input_text_2"
				value="" disabled="disabled" >
			</div>	
		</div>
	</form>
	</div>
	</div>
	<!-- 表格工具栏　END -->
	<!-- 页面查询区域　END -->
	<!-- 查询内容区域　开始 -->
	<div class="col-md-12">
	<div class="table_box" style="overflow-y:hide;height:270px;">
		<table id="iwapGrid"
			class="mygrid table table-bordered table-striped table-hover"
			data-iwap="grid" data-iwap-id="" data-iwap-param=""
			data-iwap-pagination="true">
			<tr>
				<th data-grid-name="ROW_NUM" class="tl">序号</th>
				<th data-grid-name="FCODE" class="tl">资产编号</th>
				<th data-grid-name="FNAME" class="tl">名称</th>
				<th data-grid-name="FSPECTYPE" class="tl">规格型号</th>
				<th data-grid-name="FSTATUSNAME" class="tl">状态</th>
				<th data-grid-name="FORIGINVALUE" class="tl">资产原值</th>
				<th data-grid-name="FISFA" class="tl">固定资产</th>
				<th data-grid-name="FCHECKED" class="tl">导入财务</th>
				<th data-grid-name="FIMPORTFADATE" class="tl">导入时间</th>
				<th data-grid-name="FASSETINNO" class="tl">入库单号</th>
				<th data-grid-name="FCODE" option="option" option-html=''>
					<span>发票查询</span>
					<s><a href="javaScript:void(0)"  id="bill" onclick="doBill(this)">发票查询</a></s>
				</th><th data-grid-name="FCODE" option="option" option-html=''>
					<span>详细信息</span>
					<s ><a href="javaScript:void(0)"  id="detail" onclick="detail(this)"><img alt=""
				src="../iwapabc/images/icon/detail.png" /></a></s>
				</th>
			</tr>
		</table>
	</div>
	</div>
	<!-- 查询内容区域　END -->
	<!-- 表格工具栏　开始 -->
	<div class="col-md-12">
	<div class="table_nav2">
		<div class="col-md-2">
			<a href="javaScript:void(0)" id="fresh" onclick="doBill(this)">
			<img alt="" src="../iwapabc/images/icon/refresh.png"/> 刷新</a>
			<a href="javaScript:void(0)" id="query" onclick="iwapGrid1.doQuery()">
			<img alt="" src="../iwapabc/images/icon/search.png"/> 查询</a>
		</div>
		<form id="BillConditions" class="clearfix">
		<div class="col-md-10">
			<div class="inputbox">
				<span>检索条件:</span><input name="fnum" type="text"
					data-iwap-xtype="TextField" id="fnum" class="input_text_1"
					value="" style="width: 150px;">
			</div>
		</div>
	</form>
	</div>
	</div>
	<!-- 表格工具栏　END -->
	<!-- 页面查询区域　END -->
	<!-- 查询内容区域　开始 -->
	<div class="col-md-12">
	<div class="table_box"  style="overflow-y:hide;height:270px;">
		<table id="iwapGrid1" class="mygrid table table-bordered table-striped table-hover"
			data-iwap="grid" data-iwap-id="" data-iwap-param="" data-iwap-pagination="true" >
			<tr>
				<th>序号</th>
				<th data-grid-name="FP_NUM" class="tl">发票号码</th>
				<th data-grid-name="FP_DATE" class="tl">开票日期</th>
				<th data-grid-name="FP_MONEY" class="tl">发票金额</th>
				<th data-grid-name="FMTYPE" class="tl">币种</th>
				<th data-grid-name="FRATE" class="tl">汇率</th>
				<th data-grid-name="FCURRENCY" class="tl">本位币</th>
				<th data-grid-name="FPEOPLE" class="tl">经办人</th>
				<th data-grid-name="FCHECKED" class="tl">导入财务</th>
				<th data-grid-name="FPROVIDER" class="tl">供应商</th>
				<th data-grid-name="FCREATEPSNNAME" class="tl">提交人员</th>
				<th data-grid-name="FREMARK" class="tl">备注</th>
			</tr> 
		</table>
	</div>
	</div>
	<!-- 查询内容区域　END -->
</body>
<script type="text/javascript">
var actionType="", iwapGrid=null,condionForm=null,operForm=null,iwapGrid1=null;var billForm=null;
var fData1={};
$(document).ready(function() {
	parent.document.getElementById("title").value=document.title;
	
	condionForm=$.IWAP.Form({'id':'AssetConditions'});
	var createTime = document.getElementById("createTime").value;
	var pid1 = document.getElementById("pid1").value;
	var pid2 = document.getElementById("pid2").value;
	var fData={'assetConfirm':'%','createTime':createTime,'pid1':pid1,'pid2':pid2,'fcode':'%',
			'actionId':'doBiz','start':'0','limit':'5','txcode':'assetQuery'};
	iwapGrid = $.IWAP.iwapGrid({
		mode:'server',
		fData:fData,
		Url:'${ctx}/iwap.ctrl',
		grid:'grid',
		form:condionForm,
		renderTo:'iwapGrid'
	});
	
	
	billForm=$.IWAP.Form({'id':'BillConditions'});
	fData1={'fnum':'%','option':'bill',
			'actionId':'doBiz','start':'0','limit':'10','txcode':'assetQuery'};
	iwapGrid1 = $.IWAP.iwapGrid({
		mode:'server',
		fData:fData1,
		Url:'${ctx}/iwap.ctrl',
		grid:'grid',
		form:billForm,
		renderTo:'iwapGrid1'
	});
	// 初始化数据字典
	initSelectKV('{"assetConfirm":"FASSETCONFIRM"}');
	initSelectKV('{"createTime":"FCREATETIME"}');
	document.getElementById("pid1").hidden=true;
	document.getElementById("pid2").hidden=true;
});

function refresh(){
	iwapGrid.doReset();
	iwapGrid.doQuery();
}

function refresh1(){
	iwapGrid1.doReset();
	iwapGrid1.doQuery();
}

function gradeChange(){
    var objS = document.getElementById("createTime");
    var grade = objS.options[objS.selectedIndex].value;
    if(grade==9){
    	condionForm.enabledById("pid1");
    	condionForm.enabledById("pid2");
    	document.getElementById("pid1").hidden=false;
    	document.getElementById("pid2").hidden=false;
    }else{
    	document.getElementById("pid1").hidden=true;
    	document.getElementById("pid2").hidden=true;
    }
}
//对话框
function dialogModal(id){
	$('#'+id).dialog();
};

//保存
function doSave(){
	var extParam={'actionType':actionType,'txcode':'assetQuery','actionId':'doBiz'};
	var param=operForm.getData();
	$.IWAP.applyIf(param,extParam);
	iwapGrid.doSave(param,'#myModal');
};

//编辑
function detail(obj){
	//$('#assetDetail').dialog("资产详细信息:"+iwapGrid.getCurrentRow().FCODE);
	window.location="${ctx}/iwap.ctrl?txcode=assetDetailquerya&assetQuery="+iwapGrid.getCurrentRow().FCODE; 
};

function doBill(obj){
	/*查询表格初始化  设置默认查询条件*/
	var fid=iwapGrid.getCurrentRow().FID;
	billForm=$.IWAP.Form({'id':'BillConditions'});
	fData1={'fid':fid,'option':'bill',
			'actionId':'doBiz','start':'0','limit':'50','txcode':'assetQuery'};
	iwapGrid1 = $.IWAP.iwapGrid({
		mode:'server',
		fData:fData1,
		Url:'${ctx}/iwap.ctrl',
		grid:'grid',
		form:billForm,
		renderTo:'iwapGrid1'
	});
	
};

</script>
</html>