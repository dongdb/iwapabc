<%@ page language="java" import="com.nantian.iwap.web.WebEnv"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>公司资产台账</title>
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
<%-- <script type="text/javascript" src="${ctx}/js/jquery-1.5.1.js"></script> --%>
<script type="text/javascript" src="${ctx}/js/lyz.calendar.min.js"></script>
</head>
<body class="iwapui center_body">
	<input type="hidden" value="${userInfo.ACCT_ID}" id="_roleid">
	<input type="hidden" value="${userInfo.ORG_ID}" id="_deptId">
	<!-- 页面查询区域开始 -->
	<form id="Conditions" class="clearfix">
		<div class="col-md-3 fl">
			<div class="inputbox">
				<span>资产类别：</span><input type="text" name="all" id="all"
					data-iwap-xtype="TextField" class="input_text_1"
					value="--全部--" disabled="disabled">
			</div>
		</div>
		<div class="col-md-3 fl">
			<div class="selectbox inputbox">
				<span>资产状态：</span><select data-iwap-xtype="ListField" name="FSTATUSNAME"
					class="select_content" id="FSTATUSNAME">
					<option value="">--全部--</option>
				</select>
			</div>
		</div>
		<div class="col-md-3 fl">
			<div class="inputbox">
				<span>使用部门：</span><input name="FDUTYDEPTNAME" type="text"
					data-iwap-xtype="TextField" id="FDUTYDEPTNAME" class="input_text_1"
					value="">
			</div>
		</div>
		<div class="col-md-3 fl">
			<div class="inputbox">
				<span>责任部门：</span><input name="FRESPONSEDEPTNAME" type="text"
					data-iwap-xtype="TextField" id="FRESPONSEDEPTNAME" class="input_text_1"
					value="">
			</div>
		</div>
		<div class="col-md-3 fl">
			<div class="inputbox">
				<span>固定资产：</span><select data-iwap-xtype="ListField" name="FISFA"
					class="select_content" id="FISFA">
					<option value="">--全部--</option>
				</select>
			</div>
		</div>
		<div class="col-md-3 fl">
			<div class="inputbox">
				<span>确认状态：</span><select data-iwap-xtype="ListField" name="FASSETCONFIRM"
					class="select_content" id="FASSETCONFIRM">
					<option value="">--全部--</option>
				</select>
			</div>
		</div>
		<div class="col-md-3 fl">
			<div class="inputbox">
				<span>资产来源：</span><select data-iwap-xtype="ListField" name="FSOURCENAME"
					class="select_content" id="FSOURCENAME">
					<option value="">--全部--</option>
				</select>
			</div>
		</div>
		<div class="col-md-3 fl">
			<div class="inputbox">
				<span>使用人：</span><input name="FDUTYPSNNAME" type="text"
					data-iwap-xtype="TextField" id="FDUTYPSNNAME" class="input_text_1"
					value="">
			</div>
		</div>
		<div class="col-md-3 fl">
			<div class="inputbox">
				<span>责任人：</span><input name="FRESPONSEPSNNAME" type="text"
					data-iwap-xtype="TextField" id="FRESPONSEPSNNAME" class="input_text_1"
					value="">
			</div>
		</div>
		<div class="col-md-3 fl">
			<div class="inputbox">
				<span>导入财务：</span><select data-iwap-xtype="ListField" name="FCHECKED"
					class="select_content" id="FCHECKED">
					<option value="">--全部--</option>
				</select>
			</div>
		</div>
		<div class="col-md-3 fl">
			<div class="inputbox">
				<span>使用类型：</span><select data-iwap-xtype="ListField" name="FISDEPT"
					class="select_content" id="FISDEPT">
					<option value="">--全部--</option>
				</select>
			</div>
		</div>
		<div class="col-md-3 fl">
			<div class="inputbox">
				<span>入库时间：</span><select data-iwap-xtype="ListField" name="FCREATETIME"  onchange="gradeChange()"
					id="FCREATETIME" class="select_content">
					<option value="0">--全部--</option>
				</select>
			</div>
		</div>
		<div class="col-md-3 fl">
			<div class="inputbox">
				<span>资产原值：</span><select data-iwap-xtype="ListField" name="OPERATOR"
					class="select_content" id="OPERATOR1" style="width: 70px;">
					<option value="">-全部-</option>
				</select>
				<input name="FORIGINVALUE" type="text"
					data-iwap-xtype="TextField" id="FORIGINVALUE" class="input_text_1"
					value="" style="width: 52px;">
			</div>
		</div>
		<div class="col-md-3 fl">
			<div class="inputbox">
				<span>净残值：</span><select data-iwap-xtype="ListField" name="OPERATOR"
					class="select_content" id="OPERATOR2" style="width: 70px;">
					<option value="">-全部-</option>
				</select>
				<input name="FREMAINVALUE" type="text"
					data-iwap-xtype="TextField" id="FREMAINVALUE" class="input_text_1"
					value="" style="width: 52px;">
			</div>
		</div>
		<div class="col-md-3 fl">
			<div class="inputbox">
				<span>检索条件：</span><input name="FCODE" type="text"
					data-iwap-xtype="TextField" id="FCODE" class="input_text_1"
					value="">
			</div>
		</div>
		<div class="inputbox " >
			<input style=" width:110px;" name="pid1" type="date"
				data-iwap-xtype="TextField" id="pid1" class="input_text_2"
				value="" disabled="disabled">
		</div>
		<div class="inputbox" >
			-
			<input style=" width:110px;" name="pid2" type="date" data-date-format="mm-dd-yyyy"
				data-iwap-xtype="TextField" id="pid2" class="input_text_2"
				value="" disabled="disabled" >
		</div>
	</form>
	<!-- 表格工具栏　开始 -->
	<div class="col-md-12">
	<div class="table_nav2">
		<a href="javaScript:void(0)" id="query" onclick="iwapGrid.doQuery()">
		<img alt="" src="../iwapabc/images/icon/search.png"/> 查询</a>
		<a href="javaScript:void(0)" id="btn_clear" onclick="iwapGrid.doReset();">
		<img alt="" src="../iwapabc/images/icon/empty.png"/> 清空</a>
		<a href="javaScript:void(0)" id="query" onclick="iwapGrid.doReset();iwapGrid.doQuery()">
		<img alt="" src="../iwapabc/images/icon/refresh.png"/> 刷新</a>
		<a href="javaScript:void(0)" id="query" onclick="doPrintBar()">
		<img alt="" src="../iwapabc/images/icon/print.png"/> 打印条码</a>
		<a href="javaScript:void(0)" id="query" onclick="exportData()">
		<img alt="" src="../iwapabc/images/icon/export.png"/> 导出数据</a>
	</div>
	</div>
	<!-- 表格工具栏　END -->
	<!-- 页面查询区域　END -->
	<!-- 查询内容区域　开始 -->
	<div class="col-md-12">
	<div class="table_box">
		<table id="iwapGrid"
			class="mygrid table table-bordered table-striped table-hover"
			data-iwap="grid" data-iwap-id="" data-iwap-param=""
			data-iwap-pagination="true">
			<tr>
				<th data-grid-name="CRAD_ID" primary="primary" data-order=""><input
					type="checkbox" name="selectname" selectmulti="selectmulti"
					value=""> <s><input type="checkbox"
						selectmulti="selectmulti" value="{{value}}"></s></th>
				<th data-grid-name="ROW_ID" class="tl">序号</th>
				<th data-grid-name="FSTATUSNAME" class="tl">状态</th>
				<th data-grid-name="FCODE" class="tl">资产编号</th>
				<th data-grid-name="FNAME" class="tl">名称</th>
				<th data-grid-name="FCHECKED" class="tl">导入财务</th>
				<th data-grid-name="FSPECTYPE" class="tl">规格型号</th>
				<th data-grid-name="FORIGINVALUE" class="tl">资产原值</th>
				<th data-grid-name="FEXTENDSTR2" class="tl">资产位置</th>
				<th data-grid-name="FDUTYPSNNAME" class="tl">使用人</th>
				<th data-grid-name="FCREATETIME" class="tl">入库时间</th>
				<th data-grid-name="FCODE" option="option" option-html=''>
					<span>详细信息</span>
					<s ><a href="javaScript:void(0)"  id="detail" onclick="detail(this)"><img alt=""
				src="../iwapabc/images/icon/detail.png" /></a></s>
				</th>
			</tr>
		</table>
	</div>
	</div>
	<!-- 查询内容区域　END -->
</body>
<script type="text/javascript">
var actionType="", iwapGrid=null,condionForm=null,operForm=null,grantTree=null,orgTree= null;
var grantTreeData=null,orgTreeData=null;
$(document).ready(function() {
			//重置按钮事件
			parent.document.getElementById("title").value=document.title;
			condionForm=$.IWAP.Form({'id':'Conditions'});
			$('#reset').click(function() {
				operForm.reset();
			});
			$('#resetDel').click(function() {
				$('input').not('#FCODE').val('');
			});
			
			/*查询表格初始化  设置默认查询条件*/
			var fData={'actionId':'doBiz','start':'0','limit':'10','txcode':'assetAccount'};
			iwapGrid = $.IWAP.iwapGrid({
				mode:'server',
				fData:fData,
				Url:'${ctx}/iwap.ctrl',
				grid:'grid',
				form:condionForm,
				renderTo:'iwapGrid'
			});	
			// 初始化数据字典
			initSelectKV('{"FCHECKED":"FCHECKED","FSTATUSNAME":"FSTATUSNAME"}');
			initSelectKV('{"FASSETCONFIRM":"FASSETCONFIRM","FISFA":"FISFA","FSOURCENAME":"FSOURCENAME"}');
			initSelectKV('{"FISDEPT":"FISDEPT","FCREATETIME":"FCREATETIME"}');
			initSelectKV('{"OPERATOR1":"OPERATOR","OPERATOR2":"OPERATOR"}');
			document.getElementById("pid1").hidden=true;
	    	document.getElementById("pid2").hidden=true;
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
//对话框
function dialogModal(id){
	$('#'+id).dialog();
};

//导出数据
function exportData(){
	var data = {'exportFlag':'1','filetype':'xls',
			//'actionType':'expdata',
			'txcode':'assetAccount','actionId':'doBiz','start':'0','limit':'30000'};
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
	console.info(param);
	var iframe = $('<iframe name="iwapdownload">');
	iframe.css("display", "none");
	iframe.attr("src", "download.ctrl?" + param);
	$('body').prepend(iframe);
}

//编辑
function detail(obj){
	window.location="${ctx}/iwap.ctrl?txcode=assetDetailquery&deptid="+iwapGrid.getCurrentRow().FCODE; 
};

//打印条码
function doPrintBar(){
	if (iwapGrid.getCheckValues() == "") {
		alert("请先选择要打印的资产!");
		return;
	}
	var openUrl = "${ctx}/iwap.ctrl?txcode=printBar&fid="+iwapGrid.getCurrentRow().FID;
	var iHeight = 400;
	var iWidth = 600;
	var iTop = (window.screen.availHeight-iHeight)/2;
	var iLeft = (window.screen.availWidth-iWidth)/2; 
	window.open(openUrl,"打印条码","height="+iHeight+",width="+iWidth+",top="+iTop+",left="+iLeft);
}
</script>
</html>