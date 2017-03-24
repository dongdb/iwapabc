<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>详细信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/screen/comm/header.jsp"%>
<link href="<%=path%>/css/style.css" rel="stylesheet">
<link href="<%=path%>/css/iwapui-style.css" rel="stylesheet">
<link href="<%=path%>/css/zTreeStyle.css" rel="stylesheet">
<script type="text/javascript" src="<%=path%>/js/iwapui.js"></script>
<script type='text/javascript' src="<%=path%>/js/dictionary.js"></script>
<script type='text/javascript' src="<%=path%>/js/public.js"></script>
<script type="text/javascript" src="<%=path%>/js/jquery.base64.js"></script>
<script type="text/javascript" src="<%=path%>/js/tableExport.js"></script>
<script type="text/javascript" src="<%=path%>/js/libs/base64.js"></script>
<script type="text/javascript" src="<%=path%>/js/libs/sprintf.js"></script>
<script type="text/javascript" src="<%=path%>/js/libs/jspdf.js"></script>
<style>
#uploadImg {
	font-size: 12px;
	overflow: hidden;
	position: absolute
}

#fileccc {
	position: absolute;
	z-index: 100;
	margin-left: -180px;
	font-size: 60px;
	opacity: 0;
	filter: alpha(opacity = 0);
	margin-top: -5px;
}
</style>
</head>
<body class="iwapui center_body">
	<!-- 对话框开始 -->
	<div id="divDialog" class="divDialog">
		<!-- 第一个对话框开始 入库记录-->
		<div class="bg" style="height: 100%;"></div>
		<div class="dialog" id="storageM" style="width: 930px; height: 600px;">
			<div class="dialog-header" style="background-color: 33AECC">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">入库记录</h4>
			</div>
			<div class="col-md-12"
				style="margin: 0px 5px; width: 920px; height: 30px; background-color: #d0e4ff;">
				<div class="col-md-8">
					<h5>基本信息：</h5>
				</div>
				<div class="col-md-offset-8">
					<h5>
						入库单号：<input type="text" id="FNO" name="FNO"
							style="background-color: transparent" disabled="disabled">
					</h5>
				</div>
			</div>
			<div class="col-md-12" style="width: 920px; height: 260px;">
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
						签报编号<input name="FSIGNID" type="text" data-iwap-xtype="TextField"
							id="FSIGNID" class="input_text_1">
					</div>
				</div>
				<div class="col-md-4">
					<div class="inputbox" style="margin: 2px;">
						入库方式<input name="FMODE" type="text" data-iwap-xtype="TextField"
							id="FMODE" class="input_text_1">
					</div>
				</div>
				<div class="col-md-4">
					<div class="inputbox" style="margin: 2px;">
						入库日期<input name="FCREATETIME1" type="text"
							data-iwap-xtype="TextField" id="FCREATETIME1"
							class="input_text_1">
					</div>
				</div>
				<div class="col-md-4">
					<div class="inputbox" style="margin: 2px;">
						入库金额<input name="FAMOUNT" type="text" data-iwap-xtype="TextField"
							id="FAMOUNT" class="input_text_1">
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
				<div class="col-md-12">
					<div class="inputbox" style="margin: 2px;">
						备&nbsp;&nbsp;&nbsp;&nbsp;注&nbsp;&nbsp;&nbsp;<input name="FREMARK1"
							type="text" data-iwap-xtype="TextField" id="FREMARK1"
							class="input_text_1" style="width: 775px; height: 50px;">
					</div>
				</div>
				<div class="col-md-12">
					发&nbsp;&nbsp;&nbsp;&nbsp;票&nbsp;&nbsp;
					<div
						style="overflow: scroll; margin-left: 55px; height: 110px; width: 775px; border: 1px solid #CCCCCC;">
						<table id="iwapGrid1"
							class="mygrid table table-bordered table-striped table-hover"
							data-iwap="grid" data-iwap-id="" data-iwap-param=""
							data-iwap-pagination="true">

							<tr>
								<th>序号</th>
								<th data-grid-name="FP_NUM" class="tl">发票</th>
								<th data-grid-name="FP_DATE" class="tl">开票日期</th>
								<th data-grid-name="FP_MONEY" class="tl">发票金额</th>
								<th data-grid-name="FMTYPE" class="tl">币种</th>
								<th data-grid-name="FPROVIDER" class="tl">供应商</th>
								<th data-grid-name="FPEOPLE" class="tl">经办人</th>
								<th data-grid-name="FP_NUM" class="tl">发票号码</th>
							</tr>
						</table>
					</div>
				</div>
			</div>

			<div class="col-md-12"
				style="margin: 0px 5px; width: 920px; height: 30px; background-color: #d0e4ff;">
				<div class="col-md-8">
					<h5>资产明细：</h5>
				</div>
			</div>
			<div class="col-md-12"
				style="margin: 0px 5px; width: 920px; height: 180px;">
				<div style="height: 200px; width: 900px; border: 1px solid #CCCCCC;">
					<table id="iwapGrid2"
						class="mygrid table table-bordered table-striped table-hover"
						data-iwap="grid" data-iwap-id="" data-iwap-param=""
						data-iwap-pagination="true">
						<tr>
							<th data-grid-name="FNO" class="tl">资产编号</th>
							<th data-grid-name="FCODE" class="tl">资产类别</th>
							<th data-grid-name="FNAME" class="tl">资产名称</th>
							<th data-grid-name="FSPECTYPE" class="tl">规格型号</th>
							<th data-grid-name="FPRICE" class="tl">单价</th>
							<th data-grid-name="FZCSL" class="tl">资产数量</th>
							<th data-grid-name="FISFA" class="tl">固定资产</th>
							<th data-grid-name="FREMARK" class="tl">备注</th>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 第一个对话框END 入库记录-->
		<!-- 第二个对话框开始 使用记录-->
		<div class="bg" style="height: 100%;"></div>
		<div class="dialog" id="useM" style="width: 800px; height: 500px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">使用记录</h4>
			</div>
			<div class="col-md-12">
				<div style="height: 430px; width: 770px; border: 1px solid #CCCCCC;">
					<table id="useGrid"
						class="mygrid table table-bordered table-striped table-hover"
						data-iwap="grid" data-iwap-id="" data-iwap-param=""
						data-iwap-pagination="true">
						<tr>
							<th data-grid-name="ROW_NUM" class="tl">序号</th>
							<th data-grid-name="A" class="tl">安排类型</th>
							<th data-grid-name="B" class="tl">开始日期</th>
							<th data-grid-name="C" class="tl">结束日期</th>
							<th data-grid-name="D" class="tl">使用部门</th>
							<th data-grid-name="E" class="tl">使用人</th>
							<th data-grid-name="F" class="tl">责任部门</th>
							<th data-grid-name="G" class="tl">责任人</th>
							<th data-grid-name="H" class="tl">放置位置</th>
							<th data-grid-name="I" class="tl">备注</th>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 第二个对话框END 使用记录-->
		<!-- 第三个对话框开始 维修记录-->
		<div class="bg" style="height: 100%;"></div>
		<div class="dialog" id="repairM" style="width: 800px; height: 500px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">维修记录</h4>
			</div>
			<div class="col-md-12">
				<div style="height: 430px; width: 770px; border: 1px solid #CCCCCC;">
					<table id="reGrid"
						class="mygrid table table-bordered table-striped table-hover"
						data-iwap="grid" data-iwap-id="" data-iwap-param=""
						data-iwap-pagination="true">
						<tr>
							<th data-grid-name="ROW_NUM" class="tl">序号</th>
							<th data-grid-name="REPAIRNO" class="tl">维修单号</th>
							<th data-grid-name="REPAIRTYPELABEL" class="tl">维修类型</th>
							<th data-grid-name="REPAIRAMOUNT" class="tl">维修金额</th>
							<th data-grid-name="DELIVERDATE" class="tl">送修日期</th>
							<th data-grid-name="RETURNDATE" class="tl">返还日期</th>
							<th data-grid-name="HANDLEPSNNAME" class="tl">处理人</th>
							<th data-grid-name="REMARK" class="tl">备注</th>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 第三个对话框END 维修记录-->
		<!-- 第四个对话框开始 盘点记录-->
		<div class="bg" style="height: 100%;"></div>
		<div class="dialog" id="accountM" style="width: 800px; height: 500px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">盘点记录</h4>
			</div>
			<div class="col-md-12">
				<div style="height: 430px; width: 770px; border: 1px solid #CCCCCC;">
					<table id="accGrid"
						class="mygrid table table-bordered table-striped table-hover"
						data-iwap="grid" data-iwap-id="" data-iwap-param=""
						data-iwap-pagination="true">
						<tr>
							<th data-grid-name="ROW_NUM" class="tl">序号</th>
							<th data-grid-name="STATUSLABEL" class="tl">盘点状态</th>
							<th data-grid-name="SCANTIME" class="tl">盘点日期</th>
							<th data-grid-name="RESULTLABEL" class="tl">盘点结果</th>
							<th data-grid-name="REVISIONSTATUSLABEL" class="tl">修正状态</th>
							<th data-grid-name="REVISIONUSER" class="tl">修正人员</th>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 第四个对话框END 盘点记录-->
		<!-- 第五个对话框开始 发票列表-->
		<div class="bg" style="height: 100%;"></div>
		<div class="dialog" id="billM" style="width: 1000px; height: 600px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">发票列表</h4>
			</div>
			<div class="col-md-12">
				<div
					style="overflow-x: auto; overflow-y: auto; height: 430px; width: 970px; border: 1px solid #CCCCCC;">
					<table id="billGrid"
						class="mygrid table table-bordered table-striped table-hover"
						data-iwap="grid" data-iwap-id="" data-iwap-param=""
						data-iwap-pagination="true">
						<tr>
							<th data-grid-name="ROW_NUM" class="tl">序号</th>
							<th data-grid-name="FP_NUM" class="tl">发票号码</th>
							<th data-grid-name="FPEOPLE" class="tl">经办人</th>
							<th data-grid-name="FPROVIDER" class="tl">供应商</th>
							<th data-grid-name="FP_DATE" class="tl">开票日期</th>
							<th data-grid-name="FP_MONEY" class="tl">发票金额</th>
							<th data-grid-name="FMTYPE" class="tl">币种</th>
							<th data-grid-name="BDOWN" class="tl">发票附件</th>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 第五个对话框END 发票列表-->
		<!-- 第六个对话框开始 打印资产卡片-->
		<div class="bg" style="height: 100%;"></div>
		<div class="dialog" id="printM" style="width: 800px; height: 600px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">打印资产卡片</h4>
			</div>
			<div class="table_nav2" style="border: 1px solid white;">
				<!-- <a href="javaScript:void(0)" id="set" onclick="">页面设置</a> -->
				<a href="javaScript:void(0)" id="use" onclick="doPrint1()">打印预览</a>
				<!-- <a href="javaScript:void(0)" id="print" onclick="">打印</a>  -->
				<a href="javaScript:void(0)" id="outpdf" onclick="printpdf()">导出为PDF文件</a>
				<a href="javaScript:void(0)" id="outword" onclick="printword()">导出为Word文档</a>
				<a href="javaScript:void(0)" data-iwap-dialog="" id="outexcel"
					onclick="printexcel()">导出为Excel工作簿</a>
			</div>
			<div class="col-md-12" id="mycontent">
				<div style="height: 480px; width: 770px; border: 1px solid #CCCCCC;">
					<table class="assetTable" id="assetTable">
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td colspan="4"><h4 align="center">资产卡片</h4></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td class="assetTable_title">资产条码</td>
							<td class="assetTable_content" id="code"></td>
							<td class="assetTable_title">资产名称</td>
							<td class="assetTable_content" id="name"></td>
						</tr>
						<tr>
							<td class="assetTable_title">规格型号</td>
							<td class="assetTable_content" id="type"></td>
							<td class="assetTable_title">购买日期</td>
							<td class="assetTable_content" id="date"></td>
						</tr>
						<tr>
							<td class="assetTable_title">责任人</td>
							<td class="assetTable_content" id="reper"></td>
							<td class="assetTable_title">责任机构</td>
							<td class="assetTable_content" id="redept"></td>
						</tr>
						<tr>
							<td class="assetTable_title">使用人</td>
							<td class="assetTable_content" id="useper"></td>
							<td class="assetTable_title">资产位置</td>
							<td class="assetTable_content" id="location"></td>
						</tr>
						<tr>
							<td class="assetTable_title">备注</td>
							<td class="assetTable_content" colspan="3" id="mark"></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 第六个对话框END 打印资产卡片-->
		<!-- 第七个对话框开始Begin 放置位置-->
		<div class="bg" style="height: 100%;"></div>
		<div class="dialog" id="placeModal"
			style="width: 900px; height: 450px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">选择放置位置</h4>
			</div>
			<div class="table_nav2">
				<form id="placeForm">
					<div class="col-md-2">
						<div class="inputbox" style="margin: 2px;">
							<input name="fuzzysearch" type="text" data-iwap-xtype="TextField"
								id="fuzzysearch" class="input_text_1" value="" 
							onkeypress="if(event.keyCode==13) {iwapGrid.doQuery();return false;}"
							>
						</div>
					</div>
				</form>
				<div class="col-md-10">
					<a href="javaScript:void(0)" id="search"
						onclick="iwapGrid.doQuery()"> <img alt=""
						src="../iwapabc/images/icon/search.png" /> 查询
					</a> <a href="javaScript:void(0)" id="refresh" onclick="refresh()">
						<img alt="" src="../iwapabc/images/icon/refresh.png" /> 刷新
					</a> <a href="javaScript:void(0)" id="confirm" onclick="doConfirm()">
						<img alt="" src="../iwapabc/images/icon/confirm.png" /> 确定
					</a>
				</div>

			</div>
			<div class="col-md-12">
			<div style="width:850px;height:280px;overflow-y:auto;">
				<table id="iwapGrid"
					class="mygrid table table-bordered table-striped table-hover"
					data-iwap="grid" data-iwap-id="" data-iwap-param=""
					data-iwap-pagination="true">
					<tr>
						<th data-grid-name="FCODE" primary="primary" data-order="">选择<s><input
								id="radio1" name="radio1" type="radio" selectmulti="selectmulti"
								value="{{value}}"></s></th>
						<th data-grid-name="ROW_NUM" class="tl">序号</th>
						<th data-grid-name="FJGMC" class="tl">房间名称</th>
						<th data-grid-name="FLZMC" class="tl">楼座名称</th>
						<th data-grid-name="FJGLX" class="tl">结构类型</th>
						<th data-grid-name="FJGWZ" class="tl">楼层</th>
						<th data-grid-name="FMJ" class="tl">面积（m²）</th>
						<th data-grid-name="FSYJGNAME" class="tl">使用机构</th>
						<th data-grid-name="FSYBMNAME" class="tl">使用部门</th>
					</tr>
				</table>
			</div>
			</div>
		</div>
		<!-- 第七个对话框结束 End 选择放置位置 -->
	</div>
	<!-- 对话框 END-->
	<!-- 表格工具栏　开始 -->
	<div class="table_nav2 col-md-12">
		<a href="javaScript:void(0)" id="update" onclick="doSave()">保 存</a> <a
			href="javaScript:void(0)" id="storage" onclick="doStorage()">入库记录</a>
		<a href="javaScript:void(0)" data-iwap-dialog="useM" id="use"
			onclick="doUse()">使用记录</a> <a href="javaScript:void(0)"
			data-iwap-dialog="repairM" id="repair" onclick="doRepair()">维修记录</a>
		<a href="javaScript:void(0)" data-iwap-dialog="accountM" id="account"
			onclick="doAccount()">盘点记录</a> <a href="javaScript:void(0)"
			data-iwap-dialog="billM" id="bill" onclick="doBill()">发票列表</a> <a
			href="javaScript:void(0)" data-iwap-dialog="printM" id="print"
			onclick="doPrint()">打印资产卡片</a> <a href="javaScript:void(0)" id="back"
			onclick="doReturn()">返 回</a>
	</div>
	<!-- 表格工具栏　END -->
	<form method="post" onsubmit="return false" id="dialogarea">
		<!-- form开始 -->
		<div class="col-md-10"
			style="margin-bottom: 10px; margin-left: 15px; height: 30px; background-color: #d0e4ff;">
			<div class="col-md-8">
				<h5>基本信息：</h5>
			</div>
		</div>
		<div class="col-md-10">
			<div class="col-md-8">
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>ERP编号</span> <input name="ERPCODE" type="text"
							data-iwap-xtype="TextField" id="ERPCODE" class="input_text_1"
							disabled="disabled">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>资产编号</span> <input name="FCODE" type="text"
							data-iwap-xtype="TextField" id="FCODE" class="input_text_1"
							disabled="disabled">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>财务大类</span> <select data-iwap-xtype="ListField"
							name="FUSETYPE" class="select_content" id="FUSETYPE">
						</select>
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>资产类别</span> <input name="FKIND" type="text"
							data-iwap-xtype="TextField" id="FKIND" class="input_text_1">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>资产简称</span> <input name="FSIMPLENAME" type="text"
							data-iwap-xtype="TextField" id="FSIMPLENAME" class="input_text_1">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>资产名称</span> <input name="FNAME" type="text"
							data-iwap-xtype="TextField" id="FNAME" class="input_text_1">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>规格型号</span> <input name="FSPECTYPE" type="text"
							data-iwap-xtype="TextField" id="FSPECTYPE" class="input_text_1">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>是否固定资产</span>&nbsp;<select data-iwap-xtype="ListField"
							name="FISFA" class="select_content" id="FISFA">
						</select>
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>资产原值</span>&nbsp;<input name="FORIGINVALUE" type="text"
							data-iwap-xtype="TextField" id="FORIGINVALUE"
							class="input_text_1" disabled="disabled" style="width: 50px;">币种<input
							name="FCURRENCY" type="text" data-iwap-xtype="TextField"
							id="FCURRENCY" class="input_text_1" style="width: 50px;">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>资产来源</span>&nbsp<input name="FSOURCE" type="text"
							data-iwap-xtype="TextField" id="FSOURCE" class="input_text_1"
							disabled="disabled">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>计量单位</span>&nbsp;<input name="FUNIT" type="text"
							data-iwap-xtype="TextField" id="FUNIT" class="input_text_1"
							disabled="disabled">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>资产状态</span> <input name="FSTATUSNAME" type="text"
							data-iwap-xtype="TextField" id="FSTATUSNAME" class="input_text_1"
							disabled="disabled">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>财务确认状态</span>&nbsp;<input name="FASSETCONFIRM" type="text"
							data-iwap-xtype="TextField" id="FASSETCONFIRM"
							class="input_text_1" disabled="disabled">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>是否导入财务</span> <input name="FCHECKED" type="text"
							data-iwap-xtype="TextField" id="FCHECKED" class="input_text_1"
							disabled="disabled">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						&nbsp<span>财务确认日期</span><input name="FCONFIRMDATE" type="text"
							data-iwap-xtype="TextField" id="FCONFIRMDATE"
							class="input_text_1" disabled="disabled">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>导入财务时间</span>&nbsp<input name="FIMPORTFADATE" type="text"
							data-iwap-xtype="TextField" id="FIMPORTFADATE"
							class="input_text_1" disabled="disabled">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>责任部门</span> <input name="FRESPONSEDEPTNAME" type="text"
							data-iwap-xtype="TextField" id="FRESPONSEDEPTNAME"
							class="input_text_1">
						<!-- <select data-iwap-xtype="ListField"
							name="FRESPONSEDEPTNAME" class="select_content"
							id="FRESPONSEDEPTNAME"> -->
						<!-- <option value="%">--全部--</option> -->
						</select>
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>责任人</span> <input name="FRESPONSEPSNNAME" type="text"
							data-iwap-xtype="TextField" id="FRESPONSEPSNNAME"
							class="input_text_1">
						<!-- <select data-iwap-xtype="ListField"
							name="FRESPONSEPSNNAME" class="select_content"
							id="FRESPONSEPSNNAME"> -->
						<!-- <option value="%">--全部--</option> -->
						</select>
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						&nbsp<span>使用部门</span><input name="FDUTYDEPTFNAME" type="text"
							data-iwap-xtype="TextField" id="FDUTYDEPTFNAME"
							class="input_text_1" disabled="disabled">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>使用人</span>&nbsp<input name="FDUTYPSNNAME" type="text"
							data-iwap-xtype="TextField" id="FDUTYPSNNAME"
							class="input_text_1" disabled="disabled">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						&nbsp<span>资产使用类型</span><input name="FISDEPT" type="text"
							data-iwap-xtype="TextField" id="FISDEPT" class="input_text_1"
							disabled="disabled">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>入库日期</span>&nbsp<input name="FCREATETIME" type="text"
							data-iwap-xtype="TextField" id="FCREATETIME" class="input_text_1"
							disabled="disabled">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>出厂日期</span> <input name="FFACTORYDATE" type="text"
							data-iwap-xtype="TextField" id="FFACTORYDATE"
							class="input_text_1">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>购买日期</span> <input name="FBUYDATE" type="text"
							data-iwap-xtype="TextField" id="FBUYDATE" class="input_text_1">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>保修期</span> <input name="FWARRANTYMONTH" type="text"
							data-iwap-xtype="TextField" id="FWARRANTYMONTH"
							class="input_text_1" style="width: 100px;">&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>保修期至</span> <input name="FWARRANTYDATE" type="text"
							data-iwap-xtype="TextField" id="FWARRANTYDATE"
							class="input_text_1">
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>管理单位</span> <input name="ADMINDEPT" type="text"
							data-iwap-xtype="TextField" id="ADMINDEPT" class="input_text_1">
						<!-- <select data-iwap-xtype="ListField"
							name="ADMINDEPT" class="select_content" id="ADMINDEPT"> -->
						<!-- <option value="%">--全部--</option> -->
						</select>
					</div>
				</div>
				<div class="col-md-6">
					<div class="inputbox1 pr">
						<span>放置位置</span> <input name="FEXTENDSTR2" type="text"
							data-iwap-xtype="TextField" id="FEXTENDSTR2" class="input_text_1"
							style="width:110px;"><a href="javaScript:void(0)" id="search" onclick="doSearch()">
							<img alt="" src="../iwapabc/images/icon/search.png" />
						</a>
					</div>
				</div>
				<div class="col-md-12">
					<div class="inputbox1 pr" style="padding-top: 10px;">
						<span>详细配置</span> <input name="FDETAILINFO" type="text"
							data-iwap-xtype="TextField" id="FDETAILINFO" class="input_text_1"
							style="width: 470px; height: 80px;">
					</div>
				</div>
				<div class="col-md-12">
					<div class="inputbox1 pr" style="padding-top: 10px;">
						<span>备注</span> <input name="FREMARK" type="text"
							data-iwap-xtype="TextField" id="FREMARK" class="input_text_1"
							style="width: 470px; height: 50px;">
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div style="width: 300px; height: 120px; border: 1px solid #EDEDED">
					<img id="barcode"
						src="<%=request.getContextPath()%>/barcode?msg=000000000000"
						height="120px" width=300px />
				</div>
				<div
					style="width: 300px; height: 200px; border: 1px solid #EDEDED; margin-top: 10px;">
					<p>
					<div id="localImag">
						<img id="preview" width=300 height=160 style="diplay: none" />
					</div>
					</p>
					<span id="uploadImg"> <input type=file name="fileccc"
						id="fileccc" onchange="setImagePreview()" size="10"> <input
						type="button" value="上传图片">
					</span>
				</div>
				<div class="inputbox pr" style="padding-top: 10px;">
					<span>制造商</span> <input name="FFACTORY" type="text"
						data-iwap-xtype="TextField" id="FFACTORY" class="input_text_1">
				</div>
				<div class="inputbox pr">
					<span>合同编号</span> <input name="FCONTRACT" type="text"
						data-iwap-xtype="TextField" id="FCONTRACT" class="input_text_1"
						disabled="disabled">
				</div>
				<div class="inputbox pr">
					<span>合同供应商</span> <input name="FSUPPLY" type="text"
						data-iwap-xtype="TextField" id="FSUPPLY" class="input_text_1"
						disabled="disabled">
				</div>
				<div class="inputbox pr">
					<span>所属工程</span> <input name="FPROJECTID" type="text"
						data-iwap-xtype="TextField" id="FPROJECTID" class="input_text_1"
						disabled="disabled">
				</div>
				<div class="inputbox pr">
					<span>资产净残值</span> <input name="FREMAINVALUE" type="text"
						data-iwap-xtype="TextField" id="FREMAINVALUE" class="input_text_1"
						disabled="disabled">
				</div>
				<div class="inputbox pr">
					<span>累计折旧</span> <input name="FADDDEPREVALUE" type="text"
						data-iwap-xtype="TextField" id="FADDDEPREVALUE"
						class="input_text_1" disabled="disabled">
				</div>
				<div class="inputbox pr">
					<span>折旧月</span> <input name="FBGDEPRE" type="text"
						data-iwap-xtype="TextField" id="FBGDEPRE" class="input_text_1"
						disabled="disabled" style="width: 130px;">&nbsp;&nbsp;&nbsp;&nbsp;月
					&nbsp;
				</div>
				<div class="inputbox pr" style="margin-bottom: 150px;">
					<span>折旧开始日期</span> <input name="FBGDEPREDATE" type="text"
						data-iwap-xtype="TextField" id="FBGDEPREDATE" class="input_text_1"
						disabled="disabled">
				</div>

				<div class="inputbox pr">
					<input name="FASSETINNO" type="hidden" data-iwap-xtype="TextField"
						id="FASSETINNO">
				</div>
				<div class="inputbox pr">
					<input name="FID" type="hidden" data-iwap-xtype="TextField"
						id="FID">
				</div>
			</div>
		</div>
	</form>
	<!-- form END -->
</body>
<script>
	var actionType = "",iwapGrid = null,iwapGrid2 = null;
	var useGrid = null,billGrid = null,accGrid = null,reGrid = null;
	var condionForm = null,operForm = null;
	var url = window.location.toString();
	var INTCALMTHD = url.split('?')[1].split('=')[2];
	$(document).ready(function() {
		initSelectKV('{"FCHECKED":"FCHECKED","FSTATUSNAME":"FSTATUSNAME"}');
		initSelectKV('{"CON_STATUS":"CON_STATUS","ASSET":"ASSET","ASSET_SOURCE":"ASSET_SOURCE"}');
		initSelectKV('{"FISDEPT":"FISDEPT","FCREATETIME":"FCREATETIME"}');
		initSelectKV('{"OPERATOR":"OPERATOR","FUSETYPE":"FUSETYPE","FISFA":"FISFA"}');
		
		operForm = $.IWAP.Form({'id' : 'dialogarea'});
		var callFn = function(rs) {
			var dataObj = rs['body'].rows;
			console.info(dataObj);
			//document.getElementById("FCODE").value=dataObj['FCODE'];
			operForm.setData(dataObj);
			$('select#FUSETYPE').val(dataObj['FUSETYPE']);
			$('select#FISFA').val(dataObj['FISFA']);
			var fbarcode=dataObj['FBARCODE'];
			$("#barcode").attr("src", "<%=request.getContextPath()%>/barcode?msg="	+ fbarcode);
		}
		var data = {
			'deptid' : INTCALMTHD,
			'option' : 'show'
		};
		sendAjax(data, 'assetDetail', 'doBiz', callFn);
	});
	
	//选择放置位置
	function doSearch() {
		$('#placeModal').dialog('选择放置位置');
		condionForm = $.IWAP.Form({
			'id' : 'placeForm'
		});
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '5',
			'txcode' : 'assetDetail',
			'option' : 'place'
		};
		iwapGrid = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			form : condionForm,
			renderTo : 'iwapGrid'
		});
		$(function(){document.onkeydown = function(e){
			var ev = document.all ? window.event:e;
			if(ev.keyCode==13){
				iwapGrid.doQuery();
			}
		}
		});
	}

	function doConfirm() {
		if (iwapGrid.getCheckValues() == "") {
			alert("请选择放置位置！");
		}else{
			console.info(iwapGrid.getCurrentRow());
			$('#FEXTENDSTR2').val(iwapGrid.getCurrentRow()['FLZMC']+"/"+iwapGrid.getCurrentRow()['FJGMC']);
			$('#placeModal').find('.close').click();
		}
	}
	
	function doSave() {
		var fid = document.getElementById("FID").value;
		var extParam = {
			'option' : 'save',
			'txcode' : 'assetDetail',
			'actionId' : 'doBiz',
			'fid' : fid
		};
		var param = operForm.getData();
		$.IWAP.applyIf(param, extParam);
		$.IWAP.iwapRequest("iwap.ctrl", param, function(rs) {
			if (rs['header']['msg']) {
				return alert("保存失败:" + rs['header']['msg']);
			} else {
				alert("保存成功");
				iwapGrid.doQuery();
			}
		}, function() {
			alert("保存失败!");
		});
	}

	function doStorage() {
		/*查询表格初始化  设置默认查询条件*/
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '5',
			'txcode' : 'assetDetail'
		};
		iwapGrid2 = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			renderTo : 'iwapGrid2'
		});
		//var fno=$("#FASSETINNO").val();
		var fno = document.getElementById("FASSETINNO").value;
		if (fno == "") {
			alert("该资产无入库记录！");
		} else {
			$('#storageM').dialog('入库记录');
			var fid = document.getElementById("FID").value;
			console.info("fid:" + fid);
			var form1 = {
				'fid' : fid
			};
			var fData1 = {
				'actionId' : 'doBiz',
				'start' : '0',
				'limit' : '10',
				'txcode' : 'assetDetail',
				'option' : 'bill',
				'fid' : fid
			};
			iwapGrid1 = $.IWAP.iwapGrid({
				mode : 'server',
				fData : fData1,
				Url : '${ctx}/iwap.ctrl',
				grid : 'grid',
				renderTo : 'iwapGrid1'
			});

			$.IWAP.apply(fData, form1);

			var form = {
				'fno' : fno,
				'option' : 'add'
			};
			var callFn1 = function(rs) {
				var dataObj = rs['body'].rows;
				console.info(dataObj);
				document.getElementById("FNO").value = dataObj['FNO'];
				document.getElementById("FRESPONSEDEPTNAME1").value = dataObj['FRESPONSEDEPTNAME'];
				document.getElementById("FRESPONSEPSNNAME1").value = dataObj['FRESPONSEPSNNAME'];
				document.getElementById("FSIGNID").value = dataObj['FSIGNID'];
				document.getElementById("FMODE").value = dataObj['FMODE'];
				document.getElementById("FCREATETIME1").value = dataObj['FCREATETIME'];
				document.getElementById("FAMOUNT").value = dataObj['FAMOUNT'];
				document.getElementById("FEXTENDSTR21").value = dataObj['FEXTENDSTR2'];
				document.getElementById("FCONTRACT1").value = dataObj['FCONTRACT'];
				document.getElementById("FSUPPLIER1").value = dataObj['FSUPPLIER'];
				document.getElementById("FREMARK1").value = dataObj['FREMARK'];
			}
			sendAjax(form, 'assetDetail', 'doBiz', callFn1);

		}
	}

	function doUse() {
		/*查询表格初始化  设置默认查询条件*/
		var fcode = document.getElementById("FID").value;
		console.info(fcode);
		var form = {
			'fcode' : fcode
		};
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '10',
			'txcode' : 'assetDetail',
			'option' : 'use',
			'fcode' : fcode
		};
		useGrid = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			renderTo : 'useGrid'
		});

		$.IWAP.apply(fData, form);
	}

	function doRepair() {
		/*查询表格初始化  设置默认查询条件*/
		var fcode = document.getElementById("FID").value;
		console.info(fcode);
		var form = {
			'fcode' : fcode
		};
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '10',
			'txcode' : 'assetDetail',
			'option' : 'repair',
			'fcode' : fcode
		};
		reGrid = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			renderTo : 'reGrid'
		});

		$.IWAP.apply(fData, form);
	}

	function doAccount() {
		/*查询表格初始化  设置默认查询条件*/
		var fcode = document.getElementById("FID").value;
		console.info(fcode);
		var form = {
			'fcode' : fcode
		};
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '5',
			'txcode' : 'assetDetail',
			'option' : 'account',
			'fcode' : fcode
		};
		accGrid = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			renderTo : 'accGrid'
		});

		$.IWAP.apply(fData, form);
	}

	function doBill() {
		/*查询表格初始化  设置默认查询条件*/
		var fid = document.getElementById("FID").value;
		console.info(fid);
		var form = {
			'fid' : fid
		};
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '10',
			'txcode' : 'assetDetail',
			'option' : 'bill',
			'fid' : fid
		};
		billGrid = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			renderTo : 'billGrid'
		});

		$.IWAP.apply(fData, form);
	}

	function doPrint() {
		document.getElementById("code").innerHTML = document
				.getElementById("FCODE").value;
		document.getElementById("name").innerHTML = document
				.getElementById("FNAME").value;
		document.getElementById("type").innerHTML = document
				.getElementById("FSPECTYPE").value;
		document.getElementById("date").innerHTML = document
				.getElementById("FBUYDATE").value;
		document.getElementById("reper").innerHTML = document
				.getElementById("FRESPONSEPSNNAME").value;
		document.getElementById("redept").innerHTML = document
				.getElementById("FRESPONSEDEPTNAME").value;
		document.getElementById("useper").innerHTML = document
				.getElementById("FDUTYPSNNAME").value;
		document.getElementById("location").innerHTML = document
				.getElementById("FEXTENDSTR21").value;
		document.getElementById("mark").innerHTML = document
				.getElementById("FREMARK").value;
	}

	//导出资产卡片
	function printpdf() {
		$('#assetTable').tableExport({
			type : 'pdf',
			escape : 'false'
		});
	}
	//导出资产卡片
	function printword() {
		$('#assetTable').tableExport({
			type : 'doc',
			escape : 'false'
		});
	}
	//导出资产卡片
	function printexcel() {
		$('#assetTable').tableExport({
			type : 'excel',
			escape : 'false'
		});
	}
	function doPrint1() {
		var str = "<html>";
		var article;
		var css;
		var strAdBegin = "<!--pStart-->";
		var strAdEnd = "<!--pEnd-->";
		var strdoPrint = "doPrint1()";
		var strTmp;
		css = "<style>" + "body{font-family:微软雅黑;}" + "</style>";
		str += css;
		str += '<meta http-equiv="content-type" content="text/html; charset=utf-8">';
		str += '<title>' + document.title + '</title>';
		str += "<body bgcolor=#ffffff topmargin=5 leftmargin=5 marginheight=5 marginwidth=5>";
		str += "<center><table width=760 border=0 cellspacing=0 cellpadding=0><tr><td align=right valign=bottom><a href='javascript:history.back()'>返回</a>　<a href='javascript:window.print()'>打印</a></td></tr></table>";
		str += "<table width=750 border=0 cellpadding=0 cellspacing=20 bgcolor=#FEFFFF><tr><td>";
		title = document.title;
		str += "<div align=center><font style=font-size:23px;>" + title
				+ "</font></div><br/>";
		article = document.getElementById('mycontent').innerHTML;
		if (article.indexOf(strAdBegin) != -1) {
			strTmp = article.substr(article.indexOf(strAdBegin)
					+ strAdBegin.length, article.indexOf(strAdEnd));
		} else {
			strTmp = article
		}
		strTmp = strTmp.replace(/<BR><BR>/ig, "<BR>");
		strTmp = strTmp.replace(/<script.*?>[\s\S]*<\/script>/ig, "");
		strTmp = strTmp.replace(/&nbsp;/ig, " ");
		strTmp = strTmp.replace(/<p>/ig, "<br>");
		strTmp = strTmp.replace(/<\/p>/ig, "");
		strTmp = strTmp.replace(/<br>[\s|　| ]*?<br>/ig, "<BR>");
		strTmp = strTmp.replace(/<iframe.*?>.*?<\/iframe>/ig, "");
		strTmp = strTmp.replace(/^[\s]*\n/ig, "");
		strTmp3 = strTmp.substr(strTmp.indexOf("<!--pEnd-->"), article
				.indexOf(strAdEnd));
		strTmp = strTmp.replace(strTmp3, "");
		strTmp2 = "<div id='content'></div>";
		str += strTmp2;
		str += "</td></tr></table></center>";
		str += "</body></html>";
		document.write(str);
		document.close();
		document.getElementById("content").innerHTML = strTmp;
	}

	function doReturn() {
		window.location = "${ctx}/iwap.ctrl?txcode=assetCard";
	}

	//设置上传图像
	function setImagePreview() {
		var docObj = document.getElementById("fileccc");
		var imgObjPreview = document.getElementById("preview");
		if (docObj.files && docObj.files[0]) {
			//火狐下，直接设img属性 
			imgObjPreview.style.display = 'block';
			imgObjPreview.style.width = '300px';
			imgObjPreview.style.height = '160px';
			//imgObjPreview.src = docObj.files[0].getAsDataURL(); 
			//火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式 
			imgObjPreview.src = window.URL.createObjectURL(docObj.files[0]);
		} else {
			//IE下，使用滤镜 
			docObj.select();
			var imgSrc = document.selection.createRange().text;
			var localImagId = document.getElementById("localImag");
			//必须设置初始大小 
			localImagId.style.width = "300px";
			localImagId.style.height = "160px";
			//图片异常的捕捉，防止用户修改后缀来伪造图片 
			try {
				localImagId.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
				localImagId.filters
						.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc;
			} catch (e) {
				alert("您上传的图片格式不正确，请重新选择!");
				return false;
			}
			imgObjPreview.style.display = 'none';
			document.selection.empty();
		}
		return true;
	}
</script>
</html>
