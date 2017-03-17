<%@page import="com.nantian.iwap.common.util.DateUtil"%>
<%@ page language="java" import="com.nantian.iwap.web.WebEnv"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>入库管理</title>
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
		<!-- 第一个对话框开始 资产入库单详细信息-->
		<div class="bg" style="height: 100%;"></div>
		<div class="dialog" id="stoModal" style="width: 900px; height: 518px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">查看入库单</h4>
			</div>
			<div class="col-md-12"> 
			<div class="table_nav2" >
				<a class="disa" href="javaScript:void(0)" id="saveSto" onclick="saveSto()" >
				<img alt="" src="../iwapabc/images/icon/save.png"/> 保存</a>
			</div>
			</div> 
			<div class="col-md-12" style="height: 30px; background-color: #DCDCDC;">
				<div class="col-md-8">
					<h5>基本信息</h5>
				</div>
				<div class="col-md-offset-8">
					<h5>入库单号：<input type="text" id="fno" name="fno" 
						style="background-color:transparent;border:none;"  disabled="disabled" >
					</h5>
				</div>
			</div>
			<div class="col-md-12" >
				<form method="post" onsubmit="return false" id="inForm">		
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							责任部门<select data-iwap-xtype="ListField" name="resdept"
								class="select_content" id="resdept">
							</select>
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							责&nbsp;任&nbsp;人&nbsp;<select data-iwap-xtype="ListField" name="respsn"
								class="select_content" id="respsn">
							</select>
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							签报编号<input name="sign" type="text" data-iwap-xtype="TextField" id="sign"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							入库方式<input name="fmode" type="text" data-iwap-xtype="TextField" id="fmode"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							入库日期<input name="intime"  type="date"
								data-iwap-xtype="TextField" id="intime"
								class="input_text_1" value="">	
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							入库金额<input name="amount" type="text" data-iwap-xtype="TextField" id="amount"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							放置位置<input name="place" type="text"
								data-iwap-xtype="TextField" id="place"
								class="input_text_1">
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							合同编号<input name="contract" type="text"
								data-iwap-xtype="TextField" id="contract" class="input_text_1">
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							供&nbsp;应 &nbsp;商<input name="supply" type="text"
								data-iwap-xtype="TextField" id="supply" class="input_text_1">
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							备&nbsp;&nbsp;&nbsp;&nbsp;注&nbsp;&nbsp;<input name="remark"
								type="text" data-iwap-xtype="TextField" id="remark"
								class="input_text_1" >
						</div>
					</div>
					<div class="col-md-3">
						<div class="inputbox" style="margin: 2px;">
							动支单号<input name="budgetno"
								type="text" data-iwap-xtype="TextField" id="budgetno"
								class="input_text_1" >
						</div>
					</div>
				<!-- <div class="col-md-3">
					<div class="inputbox" style="margin: 2px;">
						是否关联动支单
						<input type="radio" name="radiobutton" id="yes"  value="yes"/> 是
						<input type="radio" name="radiobutton" id="no" value="no" />  否
					</div>
				</div> -->
				</form>	
				<div class="col-md-12">
					发票信息
					<div style=" margin-left: 55px; height: 110px;width:780px;border: 1px solid #CCCCCC;">
						<div class="table_nav2" style="border: 1px solid white;padding:0px;">
							<a href="javaScript:void(0)" id="addBill" class="disa" onclick="">
							<img alt="" src="../iwapabc/images/icon/add.png"/> 添加</a>
							<a href="javaScript:void(0)" id="delBill" class="disa" onclick="">
							<img alt="" src="../iwapabc/images/icon/delete.png"/> 删除</a>
						</div>
						<div id="tBill" style="height: 77px; width:779px;border: 1px solid #CCCCCC; overflow-y:auto;">
						<table id="billGrid"
								class="mygrid table table-bordered table-striped table-hover"
								data-iwap="grid" data-iwap-id="" data-iwap-param=""
								data-iwap-pagination="true" >
							<tr>
							<th data-grid-name="ROW_NUM" class="tl">序号</th>
							<th data-grid-name="FP_NUM" class="tl">发票号码</th>
							<th data-grid-name="FP_DATE" class="tl">开票日期</th>
							<th data-grid-name="FP_MONEY" class="tl">发票金额</th>
							<th data-grid-name="FRATE" class="tl">汇率</th>
							<th data-grid-name="FCURRENCY" class="tl">本位币</th>
							<th data-grid-name="FMTYPE" class="tl">币种</th>
							<th data-grid-name="FPEOPLE" class="tl">经办人</th>
							<th data-grid-name="FPROVIDER" class="tl">供应商</th>
							</tr>
						</table>
						</div>
					</div>
				</div>
				<div class="col-md-12">
				<div class="inputbox" style="margin: 2px;">
					入库附件<a href="#" ><input name="remarkfile"
						type="text" data-iwap-xtype="TextField" id="remarkfile"
						class="input_text_1 " value="上传附件" disabled="disabled"
						style="background-color:#fff;"></a>
				</div>
			</div>
			</div>
			<div class="col-md-12" style="height: 30px; background-color: #DCDCDC;">
				<div class="col-md-8">
					<h5>资产明细</h5>
				</div>
			</div>
			<div class="col-md-12"><div class="col-md-12">
			<div class="table_nav2" style="border: 1px solid white;padding:0px;">
				<a href="javaScript:void(0)" id="addAsset" class="disa" onclick="" >
				<img alt="" src="../iwapabc/images/icon/add.png"/> 添加</a>
				<a href="javaScript:void(0)" id="delAsset" class="disa" onclick="">
				<img alt="" src="../iwapabc/images/icon/delete.png"/> 删除</a>
			</div>
			</div></div>
			<div class="col-md-12" >
			<div id="tAsset" style="margin-left:15px;height: 90px; width:835px;border: 1px solid #CCCCCC; overflow-y:auto;">
				<table id="assetGrid"
					class="mygrid table table-bordered table-striped table-hover"
					data-iwap="grid" data-iwap-id="" data-iwap-param=""
					data-iwap-pagination="true">
					<tr>
						<th data-grid-name="ROW_NUM" class="tl">序号</th>
						<th data-grid-name="FUSETYPE" class="tl">财务大类</th>
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
	</div>
		

		<div class="col-md-12">
			<form id="Conditions" class="clearfix">
			<div class="inputbox">
				搜索<input name="fuzzySearch" type="text"
					data-iwap-xtype="TextField" id="fuzzySearch" class="input_text_1"
					value=""  onkeypress="if(event.keyCode==13) {iwapGrid1.doQuery();return false;}">
			</div>
			<div class="inputbox">
				入库方式
				<select data-iwap-xtype="ListField" name="mode"
					class="select_content" id="mode">
					<option value="%" selected="selected">--全部--</option>
				</select>
			</div>
			<div class="inputbox">
				入库状态
				<select data-iwap-xtype="ListField" name="statename"
					class="select_content" id="statename">
					<option value="%" selected="selected">--全部--</option>
				</select>
			</div>
			<div class="inputbox ">
				入库时间
				<select data-iwap-xtype="ListField" name="createtime"  onchange="gradeChange()"
					id="createtime" class="select_content">
					<option value="0">--全部--</option>
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
			<div class="table_nav2" >
				<a href="javaScript:void(0)" id="refresh" onclick="refresh()">
				<img alt="" src="../iwapabc/images/icon/refresh.png"/> 刷新</a>
				<a href="javaScript:void(0)" id="search" onclick="iwapGrid1.doQuery()">
				<img alt="" src="../iwapabc/images/icon/search.png"/> 查询</a>
				<a href="javaScript:void(0)" id="delete" onclick="doDelete()" >
				<img alt="" src="../iwapabc/images/icon/delete.png"/> 删除</a>
				<a href="javaScript:void(0)" id="stoDetail" onclick="stoDetail()" >
				<img alt="" src="../iwapabc/images/icon/checkDetail.png"/> 查看/修改入库单</a>
			</div>
			</form>
		</div>
		
		<div class="col-md-12" >
			<table id="iwapGrid1" class="mygrid table table-bordered table-striped table-hover"
				data-iwap="grid" data-iwap-id="" data-iwap-param="" data-iwap-pagination="true" >
				<tr>
					<th data-grid-name="FNO" primary="primary" data-order="">
					选择<s><input id="radio1" name="radio1" type="radio" 
						onchange="chooseChange()" selectmulti="selectmulti" value="{{value}}"></s></th>
					<th data-grid-name="ROW_NUM" class="tl">序号</th>
					<th data-grid-name="FSTATENAME" class="tl">入库状态</th>
					<th data-grid-name="FNO" class="tl">单据号</th>
					<th data-grid-name="FDATE" class="tl">入库日期</th>
					<th data-grid-name="FAMOUNT" class="tl">入库金额</th>
					<th data-grid-name="FMODE" class="tl">入库方式</th>
					<th data-grid-name="FCREATEDEPTNAME" class="tl">入库部门</th>
					<th data-grid-name="FCREATEPSNNAME" class="tl">入库人</th>
					<th data-grid-name="FREMARK" class="tl">备注</th>
				</tr>
			</table>
		</div>
</body>

<script type="text/javascript">
var actionType="", iwapGrid1=null,condionForm=null,operForm=null,grantTree=null,orgTree= null;
var grantTreeData=null,orgTreeData=null;
var storageForm=null;
var assetGrid=null, billGrid=null;

$(document).ready(function() {
	parent.document.getElementById("title").value=document.title;
	/*查询表格初始化  设置默认查询条件*/
	condionForm=$.IWAP.Form({'id':'Conditions'});
	var fuzzySearch = document.getElementById("fuzzySearch").value;
	var mode = document.getElementById("mode").value;
	var statename = document.getElementById("statename").value;
	var createtime = document.getElementById("createtime").value;
	var pid1 = document.getElementById("pid1").value;
	var pid2 = document.getElementById("pid2").value;
	var fData={'actionId':'doBiz','start':'0','limit':'10',
			   'txcode':'manageStorage','option':'query',
			   'fuzzySearch':fuzzySearch,'mode':mode,'statename':statename,
			   'createtime':createtime,'pid1':pid1,'pid2':pid2};
	iwapGrid1 = $.IWAP.iwapGrid({
		mode:'server',
		fData:fData,
		Url:'${ctx}/iwap.ctrl',
		grid:'grid',
		form:condionForm,
		renderTo:'iwapGrid1'
	});
	// 初始化入库方式是否启用（采用数据字典）
	initSelectKV('{"mode":"FMODE"}');
	initSelectKV('{"createtime":"FCREATETIME"}');
	initSelectKV('{"statename":"FSTATENAME"}');
	document.getElementById("pid1").hidden=true;
	document.getElementById("pid2").hidden=true;
	$(function(){document.onkeydown = function(e){
		var ev = document.all ? window.event:e;
		if(ev.keyCode==13){
			iwapGrid1.doQuery();
		}
	}
	});
	initSelectKV('{"resdept":"RESDEPT","respsn":"RESPSN"}');
	
});

function chooseChange(){
	if(iwapGrid1.getCurrentRow()["FSTATENAME"]=="已入库"){
		document.getElementById("delete").setAttribute("class", "disa");
	}else{
		document.getElementById("delete").setAttribute("class", "");
	}
}

function doDelete(){
	if(iwapGrid1.getCheckValues()=="") {
		return;
	}
	if(iwapGrid1.getCurrentRow()["FSTATENAME"]=="已入库"){
		return;
	}else{
		console.info("删除");
	}
}

function stoDetail(){
	if(iwapGrid1.getCheckValues()=="") {
		return;
	}
	var fno=iwapGrid1.getCurrentRow()["FNO"];
	var fstatename=iwapGrid1.getCurrentRow()["FSTATENAME"];
	operForm=$.IWAP.Form({'id':'inForm'});
	$('#saveSto').show();
	$('#addAsset').show();
	$('#delAsset').show();
	$('#addBill').show();
	$('#delBill').show();
	$('#tAsset').height(90);
	$('#tBill').height(77);
	operForm.enabledById("resdept,respsn,respsn,sign,fmode,intime,amount,place,contract,supply,remark,budgetno");
	if(fstatename=="已入库"){
		$('#saveSto').hide();
		$('#addAsset').hide();
		$('#delAsset').hide();
		$('#addBill').hide();
		$('#delBill').hide();
		$('#tAsset').height(120);
		$('#tBill').height(105);
		operForm.disabledById("resdept,respsn,respsn,sign,fmode,intime,amount,place,contract,supply,remark,budgetno");
	}
	var form = {
			'fno' : fno,
			'fstatename':fstatename,
			'option' : 'show'
	};
	var callFn = function(rs) {
		var dataObj = rs['body'].rows;
		console.info(dataObj);
		if(dataObj['FSIGNID']==undefined){
			dataObj['FSIGNID']="";
		}
		if(dataObj['FEXTENDSTR2']==undefined){
			dataObj['FEXTENDSTR2']="";
		}
		if(dataObj['FCONTRACT']==undefined){
			dataObj['FCONTRACT']="";
		}
		if(dataObj['FSUPPLIER']==undefined){
			dataObj['FSUPPLIER']="";
		}
		if(dataObj['FBUDGETNO']==undefined){
			dataObj['FBUDGETNO']="";
			$('input[name="radiobutton"]:checked').val("no");
		}
		if(dataObj['FREMARK']==undefined){
			dataObj['FREMARK']="";
		}
		document.getElementById("fno").value = dataObj['FNO'];
		$('select#resdept').val(dataObj['FRESPONSEDEPTNAME']);
		$('select#respsn').val(dataObj['FRESPONSEPSNNAME']);
		document.getElementById("sign").value = dataObj['FSIGNID'];
		document.getElementById("fmode").value = dataObj['FMODE'];
		document.getElementById("intime").value = dataObj['FCREATETIME'];
		document.getElementById("amount").value = dataObj['FAMOUNT'];
		document.getElementById("place").value = dataObj['FEXTENDSTR2'];
		document.getElementById("contract").value = dataObj['FCONTRACT'];
		document.getElementById("supply").value = dataObj['FSUPPLIER'];
		document.getElementById("remark").value = dataObj['FREMARK'];
		document.getElementById("budgetno").value = dataObj['FBUDGETNO'];
		if(fstatename=="未入库"){
			if(dataObj['FFZWZ']==undefined){
				dataObj['FFZWZ']="";
			}
			document.getElementById("place").value = dataObj['FFZWZ'];
		}
	}
	sendAjax(form, 'manageStorage', 'doBiz', callFn);
	
	$('#stoModal').dialog('查看入库单');
	//查看入库单中详细资产
	var fid=iwapGrid1.getCurrentRow()["FID"];
	var fData={'actionId':'doBiz','start':'0','limit':'5',
			   'txcode':'manageStorage','option':'asset',
			   'fid':fid,'fstatename':fstatename};
	assetGrid = $.IWAP.iwapGrid({
		mode:'server',
		fData:fData,
		Url:'${ctx}/iwap.ctrl',
		grid:'grid',
		renderTo:'assetGrid'
	});
	var fData1={'actionId':'doBiz','start':'0','limit':'5',
			   'txcode':'manageStorage','option':'bill',
			   'fid':fid};
	billGrid = $.IWAP.iwapGrid({
		mode:'server',
		fData:fData1,
		Url:'${ctx}/iwap.ctrl',
		grid:'grid',
		renderTo:'billGrid'
	});
	return;
}

function gradeChange(){
	var objS = document.getElementById("createtime");
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

//保存
function doSave(){	
	var param=operForm.getData();
	console.info(param);
	var extParam={'option':'addInd','txcode':'manageStorage','actionId':'doBiz'};	
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
		 $('#stoModal').find('.close').click();
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

function refresh(){
	iwapGrid1.doReset();
	iwapGrid1.doQuery();
}
</script>
</html>