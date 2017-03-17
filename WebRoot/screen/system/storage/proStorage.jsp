<%@page import="com.nantian.iwap.common.util.DateUtil"%>
<%@ page language="java" import="com.nantian.iwap.web.WebEnv"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>工程结转入库</title>
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
		<div id="divDialog" class="divDialog">
			<!-- 第一个对话框开始 入库资产信息-->
			<div class="bg" style="height: 100%;"></div>
			<div class="dialog" id="assetModal" style="width: 900px; height: 500px;">
				<div class="dialog-header" style="background-color: 33AECC">
					<button type="button" class="close" id="btn_iwap-gen-10"
						data-dialog-hidden="true">
						<span>×</span>
					</button>
					<h4 class="modal-title">入库资产信息</h4>
				</div>
				<div class="col-md-12" style="width: 890px;">
				<form method="post" onsubmit="return false" id="assetIndForm">				
					<div class="col-md-4">
						<div class="inputbox" style="margin: 5px;">
							资产名称<input name="name" type="text"
								data-iwap-xtype="TextField" id="name"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 5px;">
							资产类别<input name="kind" type="text"
								data-iwap-xtype="TextField" id="kind"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 5px;">
							资产简称<input name="sname" type="text"
								data-iwap-xtype="TextField" id="sname"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 5px;">
							资产数量<input name="zcsl" type="text"
								data-iwap-xtype="TextField" id="zcsl"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 5px;">
							单   价&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="price" type="text"
								data-iwap-xtype="TextField" id="price"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 5px;">
							币  种&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="currency" type="text"
								data-iwap-xtype="TextField" id="currency"
								class="input_text_1" value="人民币" disabled="disabled">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 5px;">
							是否固定资产
							<select data-iwap-xtype="ListField"
									name="isfa" class="select_content" 
									id="isfa" style="width:105px;">
							</select>	
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 5px;">
							规格型号<input name="spectype" type="text"
								data-iwap-xtype="TextField" id="spectype"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 5px;">
							财务大类<input name="usetype" type="text"
								data-iwap-xtype="TextField" id="usetype"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 5px;">
							制 造 商&nbsp;&nbsp;<input name="factory" type="text"
								data-iwap-xtype="TextField" id="factory"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 5px;">
							出厂日期<input name="fdate" type="date"
								data-iwap-xtype="TextField" id="fdate"
								class="input_text_1" value="">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 5px;">
							购买日期<input name="bdate"  type="date"
								data-iwap-xtype="TextField" id="bdate"
								class="input_text_1" value="">	
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 5px;">
							保 修 期&nbsp;&nbsp;<input name="warn" type="text"
								data-iwap-xtype="TextField" id="warn"
								class="input_text_1" style="width:130px;">  月
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 5px;">
							保修期至<input name="wdate" type="date"
								data-iwap-xtype="TextField" id="wdate"
								class="input_text_1" value="">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 5px;">
							计量单位<input name="unit" type="text"
								data-iwap-xtype="TextField" id="unit"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-8">
						<div class="inputbox" style="margin: 5px;">
							详细配置<input name="detailInfo" type="text"
								data-iwap-xtype="TextField" id="detailInfo"
								class="input_text_1" style="width:450px; height:60px;">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 5px;">
							预算类别<input name="budget" type="text"
								data-iwap-xtype="TextField" id="budget"
								class="input_text_1" style="height:60px;">
						</div>
					</div>
					<div class="col-md-12">
						<div class="inputbox" style="margin: 5px;">
							备  注&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="remark" type="text"
								data-iwap-xtype="TextField" id="remark"
								class="input_text_1" style="width:730px; height:60px;">
						</div>
					</div>
					<div class="col-md-12">
						<div class="inputbox">
						上传附件
						<div  style="width:790px; height:60px; border:1px solid #CCCCCC;" >
							<a href="#">上传文件</a>
						</div>
						</div>
					</div>
				</form>	
				</div>
				<div class="col-md-offset-5">
						<div class="table_nav2" style=" border: 1px solid white;">
							<a href="javaScript:void(0)" id="save" onclick="doSave()">保存</a>
							<a href="javaScript:void(0)" id="reset" onclick="doReset()">清空</a>
						</div>
				</div>
			</div>
		</div>
			
	<div class="col-md-12">
		<div class="col-md-12">
				<div class="table_nav2" style="border: 1px solid white;">
					<a href="javaScript:void(0)" id="save" onclick="">
					<img alt="" src="../iwapabc/images/icon/save.png"/> 保存</a>
					<a href="javaScript:void(0)" id="doStorage" onclick="">
					<img alt="" src="../iwapabc/images/icon/storage.png"/> 结转入库</a>
				</div>
			</div>
		<div class="col-md-12" style="height: 30px; background-color: #DCDCDC;">
				<div class="col-md-8">
					<h5>基本信息：</h5>
				</div>
				<div class="col-md-offset-8">
					<h5>入库单号：<input type="text" id="FNO" name="FNO" 
								style="background-color:transparent"  disabled="disabled"
								value="ZCRK<%=DateUtil.getCurrentDate("yyyyMMddHHmmss") %>">
					</h5>
				</div>
		</div>	
		<div class="col-md-12" >
				<form method="post" onsubmit="return false" id="storageForm">		
					<div class="col-md-4">
					<div class="inputbox" style="margin: 2px;">
							责任部门<input name="FRESPONSEDEPTNAME1" type="text"
								data-iwap-xtype="TextField" id="FRESPONSEDEPTNAME1"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							责&nbsp;任&nbsp;人&nbsp;<input name="FRESPONSEPSNNAME1" type="text"
								data-iwap-xtype="TextField" id="FRESPONSEPSNNAME1"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							签报编号<input name="FSIGNID" type="text" data-iwap-xtype="TextField" id="FSIGNID"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							入库方式
							<select data-iwap-xtype="ListField" name="FMODE"
								class="select_content" id="FMODE">
								<option value="1" selected="selected">购入</option>
							</select>
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							入库日期<input name="FCREATETIME1"  type="date"
								data-iwap-xtype="TextField" id="FCREATETIME1"
								class="input_text_1" value="">	
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							入库金额<input name="FAMOUNT" type="text" data-iwap-xtype="TextField" id="FAMOUNT"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							放置位置<input name="FEXTENDSTR21" type="text"
								data-iwap-xtype="TextField" id="FEXTENDSTR21"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							合同编号<input name="FCONTRACT1" type="text"
								data-iwap-xtype="TextField" id="FCONTRACT1" class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							供&nbsp;应 &nbsp;商<input name="FSUPPLIER1" type="text"
								data-iwap-xtype="TextField" id="FSUPPLIER1" class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							备&nbsp;&nbsp;&nbsp;&nbsp;注&nbsp;&nbsp;&nbsp;<input name="FREMARK1"
								type="text" data-iwap-xtype="TextField" id="FREMARK1"
								class="input_text_1" >
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							动支单号<input name="FBUDGETNO"
								type="text" data-iwap-xtype="TextField" id="FBUDGETNO"
								class="input_text_1" >
						</div>
					</div>
				<div class="col-md-4">
					<div class="inputbox" style="margin: 2px;">
						是否关联动支单
						<input type="radio" name="radiobutton" id="yes" value="yes" checked onchange="setDZD()"/> 是
						<input type="radio" name="radiobutton" id="no" value="no" onchange="setDZD()"/>  否
					</div>
				</div>
			</form>	
		</div>
		<div class="col-md-12" style=" height: 30px; background-color: #DCDCDC;">
			<div class="col-md-8">
				<h5>资产明细：</h5>
			</div>
		</div>
		<div class="col-md-12">
			<div class="table_nav2" style="border: 1px solid white;">
				<a href="javaScript:void(0)" id="add" onclick="addAsset()">
				<img alt="" src="../iwapabc/images/icon/add.png"/> 添加</a>
				<a href="javaScript:void(0)" id="del" onclick="">
				<img alt="" src="../iwapabc/images/icon/delete.png"/> 删除</a>
				<a href="javaScript:void(0)" id="fresh" onclick="">
				<img alt="" src="../iwapabc/images/icon/refresh.png"/> 刷新</a>
			</div>
		</div>
		<div class="col-md-12" >
			<div style="height: 270px;border: 1px solid #CCCCCC;">
				<table id="iwapGrid2"
					class="mygrid table table-bordered table-striped table-hover"
					data-iwap="grid" data-iwap-id="" data-iwap-param=""
					data-iwap-pagination="true">
					<tr>
						<th>序号</th>
						<th data-grid-name="FUSETYPE" class="tl">财务大类</th>
						<th data-grid-name="FBUDGET" class="tl">预算类别</th>
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
</body>

<script type="text/javascript">
var actionType="", iwapGrid=null,condionForm=null,operForm=null,grantTree=null,orgTree= null;
var grantTreeData=null,orgTreeData=null;
var storageForm=null;

$(document).ready(function() {
	parent.document.getElementById("title").value=document.title;
	operForm=$.IWAP.Form({'id':'assetIndForm'});	
	storageForm=$.IWAP.Form({'id':'storageForm'});
	/*查询表格初始化  设置默认查询条件*/
	var fData={'actionId':'doBiz','start':'0','limit':'5',
			   'txcode':'proStorage','option':'query'};
	iwapGrid2 = $.IWAP.iwapGrid({
		mode:'server',
		fData:fData,
		Url:'${ctx}/iwap.ctrl',
		grid:'grid',
		renderTo:'iwapGrid2'
	});
	// 初始化入库方式是否启用（采用数据字典）
	initSelectKV('{"FMODE":"FMODE","isfa":"FISFA"}');

});

//是否关联动支单
function setDZD(){
	var ra=$('input[name="radiobutton"]:checked').val();
	if(ra=="yes"){		
		document.getElementById("FBUDGETNO").disabled = false;
	}
	else if(ra=="no"){		
		document.getElementById("FBUDGETNO").value = "";
		document.getElementById("FBUDGETNO").disabled = true;
	}
}

function transDef(val,row_data){	
	if(val){
		for(var p in qyzt_select){
			if(qyzt_select[p].id==val){
				return qyzt_select[p].text;
						}
					}
	}else{
		return "";
	} 
}

//增加资产明细
function addAsset(){
	//每次点击增加按钮后：入库方式是否启用设成默认值
	$('#assetModal').dialog('入库资产信息');
	option="add";
	
};

//保存
function doSave(){	
	var param=operForm.getData();
	console.info(param);
	var extParam={'option':'addInd','txcode':'proStorage','actionId':'doBiz'};	
	if($('input#name').val()==''){
		alert("资产名称不能为空");
		return ;
	}
	if($('input#kind').val()==''){
		alert("资产类别不能为空");
		return ;
	}
	if($('input#zcsl').val()==''){
		alert("资产数量不能为空");
		return ;
	}
	if($('input#price').val()==''){
		alert("资产单价不能为空");
		return ;
	}
	$.IWAP.applyIf(param,extParam);
	$.IWAP.iwapRequest("iwap.ctrl",param,function(rs){
		 $('#assetModal').find('.close').click();
		 if (rs['header']['msg']) {
		 	return alert("保存失败:"+rs['header']['msg']);
		 }else{
		 	alert("保存成功");
		 	//iwapGrid.doQuery(condionForm.getData()); 
		 }
	 },function(){
		 alert("保存失败!");
	 });
}

//清空
function doReset(){
	operForm.reset();
	document.getElementById("currency").value="人民币";
}
</script>
</html>