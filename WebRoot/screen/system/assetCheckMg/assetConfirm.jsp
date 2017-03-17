<%@ page language="java" import="com.nantian.iwap.web.WebEnv"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>资产确认</title>
<meta name="description" content="">
<!-- 一般查询页面所引入的样式文件 -->
<link href="${ctx}/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/css.css" rel="stylesheet">
<link href="${ctx}/css/style.css" rel="stylesheet">
<link href="${ctx}/css/iwapui-style.css" rel="stylesheet"
	type="text/css">
<link href="${ctx}/css/lyz.calendar.css" rel="stylesheet"
	type="text/css">
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
<script type="text/javascript"
	src="${ctx}/js/jquery.ztree.exhide-3.5.js"></script>
<script type="text/javascript" src="${ctx}/js/Tree.js"></script>
<script type="text/javascript" src="${ctx}/js/lyz.calendar.min.js"></script>
</head>
<body class="iwapui center_body">
	<input type="hidden" value="${userInfo.ACCT_ID}" id="_roleid">
	<input type="hidden" value="${userInfo.ORG_ID}" id="_deptId">
	<!-- 对话框开始 -->
	<div id="divDialog" class="divDialog">
		<!-- 第一个对话框开始 详细信息-->
		<div class="bg" id="bg" style="height: 100%;"></div>
		<div class="dialog" id="stoModal" style="width: 900px; height: 550px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">资产确认</h4>
			</div>
			<div class="col-md-12"
				style="height: 30px; background-color: #DCDCDC;">
				<h5>资产入库单</h5>
			</div>
			
		</div>
		<!-- 第一个对话框结束 详细信息-->
	</div>
	<!-- 对话框 END-->
	<!-- 表格工具栏　开始 -->
	<div class="table_nav2">
		<form id="Conditions" class="col-md-12">
			<div class="inputbox" style="margin-top: 5px;">
				入库日期：<select data-iwap-xtype="ListField" name="FCREATETIME"  onchange="gradeChange()"
					id="FCREATETIME" class="select_content">
					<option value="0">--全部--</option>
				</select>
			</div>
			<div class="inputbox " style="margin-top: 5px;">
			<input name="pid1" type="date"
				data-iwap-xtype="TextField" id="pid1" class="input_text_2"
				value="" disabled="disabled">
			</div>
			<div class="inputbox" style="margin-top: 5px;">
			-
			<input name="pid2" type="date" data-date-format="mm-dd-yyyy"
				data-iwap-xtype="TextField" id="pid2" class="input_text_2"
				value="" disabled="disabled" >
			</div>
			<div class="inputbox" style="margin-top: 5px;">
				确认状态：<select data-iwap-xtype="ListField" name="FASSETCONFIRM"
					class="select_content" id="FASSETCONFIRM">
					<option value="">--全部--</option>
				</select>
			</div>
			<div class="inputbox" style="margin-top: 5px;">
				搜索：<input name="fuzzySearch" type="text"
					data-iwap-xtype="TextField" id="fuzzySearch" class="input_text_1"
					value=""
					onkeypress="if(event.keyCode==13) {iwapGrid.doQuery();return false;}">
			</div>
			<div class="inputbox">
				<div class="table_nav2" style="margin-top: -2px;">
					<a href="javaScript:void(0)" id="search" onclick="iwapGrid.doQuery()"> <img 
						alt="" src="../iwapabc/images/icon/search.png" /> 查询
					</a> <a href="javaScript:void(0)" id="aconfirm" onclick="doConfirm()"> <img
						alt="" src="../iwapabc/images/icon/confirm.png" /> 资产确认
					</a> <a href="javaScript:void(0)" id="query" 
						onclick="iwapGrid.doReset();iwapGrid.doQuery();"> <img
						alt="" src="../iwapabc/images/icon/refresh.png" /> 刷新
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
					<th data-grid-name="FID" primary="primary" data-order="">选择<s><input
							id="radio1" name="radio1" type="radio" onchange="chooseChange()"
							selectmulti="selectmulti" value="{{value}}"></s></th>
					<th data-grid-name="ROW_NUM">序号</th>
					<th data-grid-name="FASSETCONFIRM" class="tl">资产确认</th>
					<th data-grid-name="FNO" class="tl">单据号</th>
					<th data-grid-name="FSIGNID" class="tl">签报号</th>
					<th data-grid-name="FDATE" class="tl">入库日期</th>
					<th data-grid-name="FMODE" class="tl">入库方式</th>
					<th data-grid-name="FAMOUNT" class="tl">入库金额</th>
					<th data-grid-name="FRESPONSEDEPTFNAME" class="tl">责任部门</th>
					<th data-grid-name="FRESPONSEPSNNAME" class="tl">责任人</th>
					<th data-grid-name="FREMARK" class="tl" style="width:20%;">备注</th>
					<th data-grid-name="FID" option="option" option-html=''><span>详细信息</span>
						<s><a href="javaScript:void(0)" id="detail" onclick="doDetail(this)"><img alt=""
								src="../iwapabc/images/icon/detail.png" /></a></s></th>
				</tr>
			</table>
		</div>
	</div>
	<!-- 查询内容区域　END -->
	<!-- 表格工具栏　开始 -->
	<div class="table_nav2">
		<form id="billConditions" class="col-md-12">
			<div class="inputbox" style="margin-top: 5px;">
				搜索：<input name="fuzzySearch1" type="text"
					data-iwap-xtype="TextField" id="fuzzySearch1" class="input_text_1"
					value=""
					onkeypress="if(event.keyCode==13) {iwapGrid1.doQuery();return false;}">
			</div>
			<div class="inputbox">
				<div class="table_nav2" style="margin-top: -2px;">
					<a href="javaScript:void(0)" id="search" onclick="iwapGrid1.doQuery()"> <img 
						alt="" src="../iwapabc/images/icon/search.png" /> 查询
					</a> <a href="javaScript:void(0)" id="query" 
						onclick="iwapGrid1.doReset();iwapGrid1.doQuery()"> <img
						alt="" src="../iwapabc/images/icon/refresh.png" /> 刷新
					</a>
				</div>
			</div>
		</form>
	</div>
	<!-- 表格工具栏　END -->
	<!-- 页面查询区域　END -->
	<!-- 查询内容区域　开始 -->
	<div class="col-md-12">
		<div class="table_box" style="overflow-y: hide; height: 270px;">
			<table id="iwapGrid1"
				class="mygrid table table-bordered table-striped table-hover"
				data-iwap="grid" data-iwap-id="" data-iwap-param=""
				data-iwap-pagination="true">
				<tr>
					<th data-grid-name="ROW_NUM" class="tl">序号</th>
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
					<th data-grid-name="BDOWN" class="tl">发票附件</th>
				</tr>
			</table>
		</div>
	</div>
	<!-- 查询内容区域　END -->
</body>
<script type="text/javascript">
	var actionType = "", iwapGrid = null, condionForm = null, operForm = null, iwapGrid1 = null;
	var fData1 = {};
	$(document).ready(function() {
		parent.document.getElementById("title").value = document.title;
		condionForm = $.IWAP.Form({
			'id' : 'Conditions'
		});
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '5',
			'txcode' : 'assetConfirm'
		};
		iwapGrid = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			form : condionForm,
			renderTo : 'iwapGrid'
		});

		initSelectKV('{"FASSETCONFIRM":"FASSETCONFIRM","FCREATETIME":"FCREATETIME"}');
		document.getElementById("pid1").hidden=true;
    	document.getElementById("pid2").hidden=true;
    	document.getElementById("aconfirm").setAttribute("class", "disa");
	});
	
	function gradeChange(){
	    var objS = document.getElementById("FCREATETIME");
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

	function chooseChange() {
		//console.info("chooseChange");
		var state = iwapGrid.getCurrentRow()['FASSETCONFIRM'];
		if (state =="未确认"){
			document.getElementById("aconfirm").setAttribute("class", "");
		}else{
			document.getElementById("aconfirm").setAttribute("class", "disa");
		}
		var fid = iwapGrid.getCurrentRow()['FID'];
		var condionForm1 = $.IWAP.Form({
			'id' : 'billConditions'
		});
		var fData = {
				'actionId' : 'doBiz',
				'start' : '0',
				'limit' : '5',
				'txcode' : 'assetConfirm',
				'option' : 'bill',
				'fid' : fid
			};
		iwapGrid1 = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			form : condionForm1,
			renderTo : 'iwapGrid1'
		});
	}

	function doConfirm(obj) {
		/*查询表格初始化  设置默认查询条件*/
		if(iwapGrid.getCheckValues()==""){
			return;
		}
		var state = iwapGrid.getCurrentRow()['FASSETCONFIRM'];
		if (state =="已确认"){
			return;
		}else{
			var fid = iwapGrid.getCurrentRow().FID;
			var param={'option':"confirm",'txcode':"assetConfirm",'fid':fid,'actionId':"doBiz"};
			$.IWAP.iwapRequest("iwap.ctrl",param,function(data){
				 if (data.body.ERROR) {
				 	return alert("资产确认失败:"+data.body.ERROR);
				 }
			 },function(){
				 alert("资产确认失败!");
			 });
		}
		alert("资产确认成功！");
		$('#fuzzySearch').val(iwapGrid.getCurrentRow().FNO);
		iwapGrid.doQuery();
	};

	function doDetail(obj) {
		doContract(this);
		/*查询表格初始化  设置默认查询条件*/
		$('#contractModal').dialog('合同详细信息');
		operForm = $.IWAP.Form({
			'id' : 'contractForm'
		});
		operForm.reset();
		console.info(iwapGrid.getCurrentRow());
		operForm.setData(iwapGrid.getCurrentRow());
		var operForm2 = $.IWAP.Form({
			'id' : 'projectForm'
		});
		operForm2.reset();
		operForm2.setData(iwapGrid.getCurrentRow());
		//operForm.disabledById("ACCT_ID,ORG_ID,ORG_NM");
	};
	
</script>
</html>