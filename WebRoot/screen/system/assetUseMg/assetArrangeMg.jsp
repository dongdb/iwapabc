<%@ page language="java" import="com.nantian.iwap.web.WebEnv" pageEncoding="UTF-8"%>
<%@ page import="com.nantian.iwap.common.util.DateUtil" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>资产安排管理</title>
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
<script type="text/javascript" src="${ctx}/js/jquery.base64.js"></script>
<script type="text/javascript" src="${ctx}/js/tableExport.js"></script>
<script type="text/javascript" src="${ctx}/js/libs/base64.js"></script>
<script type="text/javascript" src="${ctx}/js/libs/sprintf.js"></script>
<script type="text/javascript" src="${ctx}/js/libs/jspdf.js"></script>
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
		<div class="dialog" id="newArrangeModal" style="width: 900px; height: 550px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10" data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">新建资产安排</h4>
			</div>
			<div class="table_nav2 col-md-12">
				<a href="javaScript:void(0)" id="arrange" onclick="doArrange()"> <img 
					alt="" src="../iwapabc/images/icon/confirm.png" /> 确认安排
				</a> <a href="javaScript:void(0)" id="refresh" onclick="clearAll()"> <img 
					alt="" src="../iwapabc/images/icon/refresh.png" /> 清空
				</a>
			</div>
			<div class="col-md-12"
				style="height: 30px; background-color: #d0e4ff;">
				<div class="col-md-8">
					<h5>安排信息：</h5>
				</div>
				<div class="col-md-offset-8">
					<h5>
						安排单号：<input type="text" id="FARRANGENO" name="FARRANGENO"
							style="background-color: transparent" disabled="disabled">
					</h5>
				</div>
			</div>
			<div class="col-md-12">
				<form method="post" onsubmit="return false" id="arrangeForm">
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>使用人员：</span><input name="FDUTYPSNNAME" type="text" disabled="disabled"
								data-iwap-xtype="TextField" id="FDUTYPSNNAME" class="input_text_1"
								style="width:110px; background-color:#fff"><a href="javaScript:void(0)" 
								id="search" onclick='dialogModal("dutyModal")'>
								<img alt="" src="../iwapabc/images/icon/search.png" /></a>
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>使用部门：</span><input name="FDUTYDEPTNAME" type="text"
								data-iwap-xtype="TextField" id="FDUTYDEPTNAME" class="input_text_1"
								disabled="disabled" style="background-color:#fff">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>安排日期：</span><input name="FARRANGEDATE1" type="date"
								data-iwap-xtype="TextField" id="FARRANGEDATE1" 
								class="input_text_1" value="<%=DateUtil.getCurrentDate("yyyy-MM-dd")%>">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>责任人员：</span><input name="FRESPONSEPSNNAME" type="text" disabled="disabled"
								data-iwap-xtype="TextField" id="FRESPONSEPSNNAME" class="input_text_1"
								style="width:110px; background-color:#fff"><a href="javaScript:void(0)" 
								id="search" onclick='dialogModal("resModal")'>
								<img alt="" src="../iwapabc/images/icon/search.png" /></a>
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>责任部门：</span><input name="FRESPONSEDEPTNAME" type="text" disabled="disabled"
								data-iwap-xtype="TextField" id="FRESPONSEDEPTNAME" class="input_text_1"
								 style="background-color:#fff">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>截止日期：</span><input name="LIMITDATE" type="date"
								data-iwap-xtype="TextField" id="LIMITDATE" class="input_text_1"
								 style="background-color:#fff">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>放置位置：</span><input name="FARRANGEROOM" type="text" disabled="disabled"
								data-iwap-xtype="TextField" id="FARRANGEROOM" class="input_text_1"
								style="width:110px; background-color:#fff"><a href="javaScript:void(0)" 
								id="search" onclick="doSearchPlace()">
								<img alt="" src="../iwapabc/images/icon/search.png" />
							</a>
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>使用类型：</span><select data-iwap-xtype="ListField" name="FUSETYPE"
								class="select_content" id="FUSETYPE">
							</select>
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>经办人员：</span><input name="FCREATEPSNNAME" type="text"
								data-iwap-xtype="TextField" id="FCREATEPSNNAME"  disabled="disabled"
								class="input_text_1" value="${userInfo.ACCT_NM}" style="background-color:#fff">
						</div>
					</div>
					<div class="col-md-12">
						<div class="inputbox" style="margin: 2px;">
							<span>备注信息：</span><input name="FREMARK" type="text"
								data-iwap-xtype="TextField" id="FREMARK" class="input_text_1"
								style="width:710px;">
						</div>
					</div>
					<div class="inputbox ">
					<input name="FGALLERYID" type="text" data-iwap-xtype="TextField" hidden="hidden"
						id="FGALLERYID" class="input_text_2" value="" disabled="disabled">
					</div>
					<div class="inputbox ">
					<input name="FROOMID" type="text" data-iwap-xtype="TextField" hidden="hidden"
						id="FROOMID" class="input_text_2" value="" disabled="disabled">
					</div>
					<!-- <th data-grid-name="FCREATETIME">提交时间</th> -->
				</form>
			</div>
			<div class="col-md-12" style="height: 30px; background-color: #d0e4ff;">
				<h5>资产信息</h5>
			</div>
			<div class="table_nav2 col-md-12">
				<a href="javaScript:void(0)" id="add" onclick="addAsset()"> <img 
					alt="" src="../iwapabc/images/icon/add.png" /> 新建
				</a> <a href="javaScript:void(0)" id="refresh"  onclick="clearAsset()"> <img
					alt="" src="../iwapabc/images/icon/refresh.png" /> 刷新
				</a>
			</div>
			<div class="col-md-12">
			<div style="height: 175px; overflow-y: auto; border: 1px solid #CCCCCC;">
				<table id="iwapGrid1"
					class="mygrid table table-bordered table-striped table-hover"
					data-iwap="grid" data-iwap-id="" data-iwap-param=""
					data-iwap-pagination="true">
					<tr>
						<th data-grid-name="ROW_NUM" class="tl">序号</th>
						<th data-grid-name="FBARCODE" class="tl">条码</th>
						<th data-grid-name="FNAME" class="tl">资产名称</th>
						<th data-grid-name="FSPECTYPE" class="tl">规格型号</th>
						<th data-grid-name="FSOURCENAME" class="tl">来源</th>
						<th data-grid-name="FORIGINVALUE" class="tl">资产原值</th>
						<th data-grid-name="FREMARK" class="tl">备注</th>
						<th data-grid-name="ROW_NUM" option="option" option-html=''><span>操作</span>
						<s><a href="javaScript:void(0)" class="editId" onclick="delOne(this)">删除</a></s></th>
					</tr>
				</table>
			</div>
			</div>
		</div>
		<!-- 第一个对话框End 新建资产安排 -->
		<!-- 第二个对话框开始Begin 放置位置-->
		<div class="bg" style="height: 100%;"></div>
		<div class="dialog" id="placeModal"
			style="width: 900px; height: 400px;">
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
							onkeypress="if(event.keyCode==13) {placeGrid.doQuery();return false;}"
							>
						</div>
					</div>
				</form>
				<div class="col-md-10">
					<a href="javaScript:void(0)" id="search"
						onclick="placeGrid.doQuery()"> <img alt=""
						src="../iwapabc/images/icon/search.png" /> 查询
					</a> <a href="javaScript:void(0)" id="refresh" onclick="placeGrid.doReset();placeGrid.doQuery()">
						<img alt="" src="../iwapabc/images/icon/refresh.png" /> 刷新
					</a> <a href="javaScript:void(0)" id="confirm" onclick="doConfirmPlace()">
						<img alt="" src="../iwapabc/images/icon/confirm.png" /> 确定
					</a>
				</div>

			</div>
			<div class="col-md-12">
			<div style="width:850px;height:280px;overflow-y:auto;">
				<table id="placeGrid"
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
		<!-- 第二个对话框结束 End 选择放置位置 -->
		<!-- 第三个对话框开始 选择添加资产 -->
		<div class="bg" id="bg" style="height: 100%;"></div>
		<div class="dialog" id="assetModal" style="width: 820px; height: 520px;">
			<div class="dialog-header" style="background-color: 33AECC">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">选择安排资产</h4>
			</div>
			<div class="table_nav2">
				<div class="col-md-2">
					<a href="javaScript:void(0)" id="query"
						onclick="assetGrid.doReset();assetGrid.doQuery()"> <img alt=""
						src="../iwapabc/images/icon/refresh.png" /> 刷新
					</a>
				</div>
				<div class="col-md-5">
					<form id="assetForm">
						<div class="inputbox">
							<input name="fuzzyAsset" type="text" data-iwap-xtype="TextField"
								id="fuzzyAsset" class="input_text_1"
								onkeypress="if(event.keyCode==13) {assetGrid.doQuery();return false;}">
						</div>
						<a href="javaScript:void(0)" id="search"
							onclick="assetGrid.doQuery()"> <img alt=""
							src="../iwapabc/images/icon/search.png" /> 搜索
						</a>
					</form>
				</div>
			</div>
			<div class="col-md-12" style="width: 810px;">
				<div
					style="height: 265px; overflow-y: auto; border: 1px solid #CCCCCC;">
					<table id="assetGrid"
						class="mygrid table table-bordered table-striped table-hover"
						data-iwap="grid" data-iwap-id="" data-iwap-param=""
						data-iwap-pagination="true">
						<tr style="overflow: scroll;">
							<th data-grid-name="FID" primary="primary" data-order="">选择
								<s><input id="radio1" name="radio1" type="radio" selectmulti="selectmulti"
									value="{{value}}"></s>
							</th>
							<th data-grid-name="FBARCODE" class="tl">条码</th>
							<th data-grid-name="FNAME" class="tl">名称</th>
							<th data-grid-name="FSPECTYPE" class="tl">规格型号</th>
							<th data-grid-name="FSOURCENAME" class="tl">来源</th>
							<th data-grid-name="FORIGINVALUE" class="tl">资产原值</th>
							<th data-grid-name="FRESPONSEPSNNAME" class="tl">责任人</th>
							<th data-grid-name="FCREATETIME" class="tl">入库日期</th>
							<th data-grid-name="FREMARK" class="tl">备注</th>
						</tr>
					</table>
				</div>
				<h5>已选列表 （共<input id="num" type="text" value="0" 
					style="width:10px;height:25px;border:none; background-color:#fff;" 
					disabled="disabled" >项）</h5>
				<div id = "list"
					style="height: 80px; overflow-y: auto; border: 1px solid #CCCCCC;">

				</div>
				<div class="col-md-6">
					<h5 style="color:red">注：本列表显示为本部门管理的所有闲置和占用的资产。</h5>
				</div>
				<div class="col-md-offset-5">
					<div class="table_nav2"
						style="border: 1px solid white; margin: 3px;">
						<a href="javaScript:void(0)" id="save" onclick="doConfirmAsset()">确定</a>
						<!-- <a href="javaScript:void(0)" id="reset" onclick="doResetBill()">清空</a> -->
					</div>
				</div>
			</div>
		</div>
		<!-- 第三个对话框结束 End 选择添加资产 -->
		<!-- 第四个对话框开始 资产安排详细信息-->
		<div class="bg" id="bg" style="height: 100%;"></div>
		<div class="dialog" id="detailArrangeModal" style="width: 900px; height: 550px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10" data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">资产安排详细信息</h4>
			</div>
			<div class="table_nav2 col-md-12">
				<a href="javaScript:void(0)" id="print" onclick="doPrint()"> <img 
					alt="" src="../iwapabc/images/icon/print.png" /> 打印安排单
				</a>
			</div>
			<div class="col-md-12"
				style="height: 30px; background-color: #d0e4ff;">
				<div class="col-md-8">
					<h5>安排信息：</h5>
				</div>
				<div class="col-md-offset-8">
					<h5>
						安排单号：<input type="text" id="fno" name="fno"
							style="background-color: transparent" disabled="disabled">
					</h5>
				</div>
			</div>
			<div class="col-md-12">
				<form method="post" onsubmit="return false" id="aForm">
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>使用人员：</span><input name="DUTYPSN" type="text"
								data-iwap-xtype="TextField" id="DUTYPSN"  disabled="disabled"
								class="input_text_1" style="background-color:#fff">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>使用部门：</span><input name="DUTYDEPT" type="text"
								data-iwap-xtype="TextField" id="DUTYDEPT" class="input_text_1"
								disabled="disabled" style="background-color:#fff">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>安排日期：</span><input name="ADATE" type="date"
								data-iwap-xtype="TextField" id="ADATE"  disabled="disabled"
								class="input_text_1" style="background-color:#fff">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>责任人员：</span><input name="RESPSN" type="text"
								data-iwap-xtype="TextField" id="RESPSN"  disabled="disabled"
								class="input_text_1" style="background-color:#fff">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>责任部门：</span><input name="RESDEPT" type="text" disabled="disabled"
								data-iwap-xtype="TextField" id="RESDEPT" class="input_text_1"
								 style="background-color:#fff">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>截止日期：</span><input name="LDATE" type="date" disabled="disabled"
								data-iwap-xtype="TextField" id="LDATE" class="input_text_1"
								 style="background-color:#fff">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>放置位置：</span><input name="PLACE" type="text" disabled="disabled"
								data-iwap-xtype="TextField" id="PLACE" class="input_text_1"
								style="background-color:#fff">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>使用类型：</span><input name="USETYPE" type="text"
								data-iwap-xtype="TextField" id="USETYPE"  disabled="disabled"
								class="input_text_1" style="background-color:#fff">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							<span>经办人员：</span><input name="CREATEPSN" type="text"
								data-iwap-xtype="TextField" id="CREATEPSN"  disabled="disabled"
								class="input_text_1" style="background-color:#fff">
						</div>
					</div>
					<div class="col-md-12">
						<div class="inputbox" style="margin: 2px;">
							<span>备注信息：</span><input name="REMARK" type="text" disabled="disabled"
								data-iwap-xtype="TextField" id="REMARK" class="input_text_1"
								style="width:710px;background-color:#fff ;" >
						</div>
					</div>
				</form>
			</div>
			<div class="col-md-12" style="height: 30px; background-color: #d0e4ff;">
				<h5>资产信息</h5>
			</div>
			<div class="col-md-12">
			<div style="height: 175px; overflow-y: auto; border: 1px solid #CCCCCC;">
				<table id="iwapGrid2"
					class="mygrid table table-bordered table-striped table-hover"
					data-iwap="grid" data-iwap-id="" data-iwap-param=""
					data-iwap-pagination="true">
					<tr>
						<th data-grid-name="ROW_NUM" class="tl">序号</th>
						<th data-grid-name="FBARCODE" class="tl">条码</th>
						<th data-grid-name="FNAME" class="tl">资产名称</th>
						<th data-grid-name="FSPECTYPE" class="tl">规格型号</th>
						<th data-grid-name="FSOURCENAME" class="tl">来源</th>
						<th data-grid-name="FORIGINVALUE" class="tl">资产原值</th>
						<th data-grid-name="FREMARK" class="tl">备注</th>
					</tr>
				</table>
			</div>
			</div>
		</div>
		<!-- 第四个对话框End 资产安排详细信息 -->
		<!-- 第五个对话框开始Begin 资产安排单 -->
		<div class="bg" style="height: 100%;"></div>
		<div class="dialog" id="printModal" style="width: 850px; height: 550px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">资产安排单</h4>
			</div>
			<div class="col-md-12 table_nav2">
				<a href="javaScript:void(0)" id="print" onclick=""> <img alt=""
					src="../iwapabc/images/icon/print.png" /> 打印
				</a> <a href="javaScript:void(0)" id="outpdf" onclick=""> <img alt=""
					src="../iwapabc/images/icon/pdf.png" /> 导出PDF
				</a> <a href="javaScript:void(0)" id="outword" onclick="printword()"> <img alt=""
					src="../iwapabc/images/icon/word.png" /> 导出Word
				</a> <a href="javaScript:void(0)" id="outexcel" onclick="printexcel()"> <img alt=""
					src="../iwapabc/images/icon/excel.png" /> 导出Excel
				</a>
			</div>
			<div class="col-md-12">
				<table class="assetTable" id="assetTable">
					<tr>
						<td colspan="8"><h4 align="center">资产安排单</h4></td>
					</tr>
					<tr>
						<td> 日期：</td>
						<td id="adate"></td>
						<td></td>
						<td> 经办人：</td>
						<td id="psn"></td>
						<td></td>
						<td> 安排单号:</td>
						<td id = "ano"></td>
					</tr>
					<tr>
						<td class="assetTable_title">使用人员</td>
						<td colspan="4" class="assetTable_content" id="use"></td>
						<td class="assetTable_title">使用类型</td>
						<td colspan="2" class="assetTable_content" id="utype"></td>
					</tr>
					<tr>
						<td class="assetTable_title">责任人员</td>
						<td colspan="4" class="assetTable_content" id="res"></td>
						<td class="assetTable_title">放置位置</td>
						<td colspan="2" class="assetTable_content" id="fzwz"></td>
					</tr>
					<tr>
						<td class="assetTable_title">备注</td>
						<td colspan="7" class="assetTable_content" id="mark"></td>
					</tr>
					<tr height="20px;">
					</tr>
					<tr>
						<td class="assetTable_title">序号</td>
						<td colspan="2" class="assetTable_title">资产条码号</td>
						<td colspan="3" class="assetTable_title">资产名称</td>
						<td class="assetTable_title">规格型号</td>
						<td class="assetTable_title">资产原值</td>
					</tr>
				</table>
			</div>
		</div>
		<!-- 第五个对话框结束 End 资产安排单 -->
		<!-- 第六个对话框开始Begin 使用人员-->
		<div class="bg" style="height: 100%;"></div>
		<div class="dialog" id="dutyModal"
			style="width: 400px; height: 500px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">选择使用人员</h4>
			</div>
			<div class="modal-body">
				<iframe style="height: 420px; width: 370px"
					src="iwap.ctrl?txcode=chooseOrg&type=user"></iframe>
			</div>
		</div>
		<!-- 第六个对话框结束 End 选择使用人员 -->
		<!-- 第七个对话框开始Begin 责任人员-->
		<div class="bg" style="height: 100%;"></div>
		<div class="dialog" id="resModal"
			style="width: 400px; height: 500px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">选择责任人员</h4>
			</div>
			<div class="modal-body">
				<iframe style="height: 420px; width: 370px"
					src="iwap.ctrl?txcode=chooseOrg&type=response"></iframe>
			</div>
		</div>
		<!-- 第七个对话框结束 End 选择责任人员 -->
	</div>
	<!-- 对话框 END-->
	
	<!-- 表格工具栏　开始 -->
	<div class="table_nav2">
		<form id="Conditions" class="col-md-12">
			<div class="inputbox">
				<div class="table_nav2" style="margin-top: -2px;">
					<a href="javaScript:void(0)" id="add" onclick="newArrange()"> <img 
						alt="" src="../iwapabc/images/icon/add.png" /> 新建
					</a> <a href="javaScript:void(0)" id="refresh" 
						onclick="iwapGrid.doReset();iwapGrid.doQuery();"> <img
						alt="" src="../iwapabc/images/icon/refresh.png" /> 刷新
					</a> <a href="javaScript:void(0)" id="exportExcel" onclick=""> <img
						alt="" src="../iwapabc/images/icon/excel.png" /> 导出
					</a> 
				</div>
			</div>
			<div class="inputbox" style="margin-top: 5px;">
				安排日期：<select data-iwap-xtype="ListField" name="FARRANGEDATE"  onchange="gradeChange()"
					id="FARRANGEDATE" class="select_content">
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
				搜索：<input name="fuzzySearch" type="text"
					data-iwap-xtype="TextField" id="fuzzySearch" class="input_text_1"
					value=""
					onkeypress="if(event.keyCode==13) {iwapGrid.doQuery();return false;}">
			</div>
			<div class="inputbox">
				<div class="table_nav2" style="margin-top: -2px;">
					<a href="javaScript:void(0)" id="search" onclick="iwapGrid.doQuery();"> <img 
						alt="" src="../iwapabc/images/icon/search.png" /> 查询
					</a>
				</div>
			</div>
		</form>
	</div>
	<!-- 表格工具栏　END -->
		<!-- 查询内容区域　开始 -->
		<div class="col-md-12">
			<div class="table_box">
				<table id="iwapGrid"
					class="mygrid table table-bordered table-striped table-hover"
					data-iwap="grid" data-iwap-id="" data-iwap-param=""
					data-iwap-pagination="true">
					<tr>
						<!-- <th data-grid-name="FID" primary="primary" data-order="">选择<s><input
								id="radio1" name="radio1" type="radio" onchange="chooseChange()"
								selectmulti="selectmulti" value="{{value}}"></s></th> -->
						<th data-grid-name="ROW_NUM">序号</th>
						<th data-grid-name="FARRANGENO" class="tl">安排单号</th>
						<th data-grid-name="FARRANGEDATE">安排日期</th>
						<th data-grid-name="FRESPONSEPSNFNAME">使用人</th>
						<th data-grid-name="FUSETYPE">使用类型</th>
						<th data-grid-name="FREMARK">备注</th>
						<th data-grid-name="FCREATEPSNNAME">经办人员</th>
						<th data-grid-name="FCREATETIME">提交时间</th>
						<th data-grid-name="FID" option="option" option-html=''><span>详细信息</span>
							<s><a href="javaScript:void(0)" id="detail" onclick="doDetail(this)"><img alt=""
								src="../iwapabc/images/icon/detail.png" /></a></s></th>
					</tr>
				</table>
			</div>
			
		</div>
		<h5 class="col-md-12" style="color:red;">注：点击【新建】按钮进行资产安排操作</h5>
		<!-- 查询内容区域　END -->
</body>
<script type="text/javascript">
	var actionType = "", iwapGrid = null, condionForm = null, operForm = null, arrangeForm = null, iwapGrid1 = null;
	var list = Array(), listNUM = Array(), listFID = Array(), cnt = 0;
	
	$(document).ready(function() {
		parent.document.getElementById("title").value = document.title;
		condionForm = $.IWAP.Form({
			'id' : 'Conditions'
		});
		arrangeForm = $.IWAP.Form({
			'id' : 'arrangeForm'
		});
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '10',
			'txcode' : 'assetArrangeMg'
		};
		iwapGrid = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			form : condionForm,
			renderTo : 'iwapGrid'
		});

		initSelectKV('{"FUSETYPE":"FISDEPT","FARRANGEDATE":"FCREATETIME"}');
		initSelectKV('{"FDUTYPSNNAME":"RESPSN","FRESPONSEPSNNAME":"RESPSN"}');
		document.getElementById("pid1").hidden=true;
    	document.getElementById("pid2").hidden=true;
	});
	
	function gradeChange(){
	    var objS = document.getElementById("FARRANGEDATE");
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
	
	//新建资产安排
	function newArrange() {
		/*查询表格初始化  设置默认查询条件*/
		$('#newArrangeModal').dialog('新建资产安排');
		$('select#FUSETYPE').val("个人使用");
		var callFn = function(rs) {
			var dataObj = rs['body'].ZCAP;
			document.getElementById("FARRANGENO").value = dataObj;
		}
		var data = {
			'option' : 'init'
		};
		sendAjax(data, 'assetArrangeMg', 'doBiz', callFn);
	};
	
	//选择使用人员
	//选择责任人员
	//选择放置位置
	function doSearchPlace() {
		$('#placeModal').dialog('选择放置位置');
		condionForm = $.IWAP.Form({
			'id' : 'placeForm'
		});
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '5',
			'txcode' : 'assetArrangeMg',
			'option' : 'place'
		};
		placeGrid = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			form : condionForm,
			renderTo : 'placeGrid'
		});
		$(function(){document.onkeydown = function(e){
			var ev = document.all ? window.event:e;
			if(ev.keyCode==13){
				placeGrid.doQuery();
			}
		}
		});
	};
	function doConfirmPlace() {
		if (placeGrid.getCheckValues() == "") {
			alert("请选择放置位置！");
		}else{
			console.info(placeGrid.getCurrentRow());
			$('#FARRANGEROOM').val(placeGrid.getCurrentRow()['FLZMC']+"/"+placeGrid.getCurrentRow()['FJGMC']);
			$('#FGALLERYID').val(placeGrid.getCurrentRow()['FLZBH']);
			$('#placeModal').find('.close').click();
		}
	};
	
	//添加资产
	function addAsset(){
		$('#assetModal').dialog('选择安排资产');
		condionForm = $.IWAP.Form({
			'id' : 'assetForm'
		});
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '6',
			'txcode' : 'assetArrangeMg',
			'option' : 'asset'
		};
		assetGrid = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			form : condionForm,
			renderTo : 'assetGrid'
		});
		$(function(){document.onkeydown = function(e){
			var ev = document.all ? window.event:e;
			if(ev.keyCode==13){
				assetGrid.doQuery();
			}
		}
		});
		$('#num').val(cnt);
		document.getElementById("list").innerHTML = listNUM;
	};	
	function clearAsset(){
		cnt = 0;
		list = null;
		list = Array();
		listNUM = null;
		listNUM = Array();
		listFID = null;
		listFID = Array();
		$('#num').val(cnt);
		document.getElementById("list").innerHTML = listNUM;
		var t = document.getElementById("iwapGrid1");
		var rowNum = t.rows.length;
		for(var i=1;i<rowNum;i++){
			t.deleteRow(i);
			rowNum --;
			i--;
		}
	};
	function delOne(obj){
		list.splice(obj,1);
		listNUM.splice(obj,1);
		listFID.splice(obj,1);
		cnt--;
		listShow();
		$('#num').val(cnt);
		document.getElementById("list").innerHTML = listNUM;
	};	
	function listShow(){
		var t = document.getElementById("iwapGrid1");
		var rowNum = t.rows.length;
		for(var i=1;i<rowNum;i++){
			t.deleteRow(i);
			rowNum --;
			i--;
		}
		for(var i=1;i<=cnt;i++){
			if(list[i]['FREMARK']==undefined){
				list[i]['FREMARK']="";
			}
			/*if(list[cnt]['spectype']==undefined){
				list[cnt]['spectype']="";
			} */
			var tablestr = "";
			var newstr = "";
			tablestr += "<tr>" + "<td style='cursor:pointer'>" + i + "</td>"
					+ "<td style='cursor:pointer'>" + list[i]['FBARCODE'] + "</td>" 
					+ "<td style='cursor:pointer'>" + list[i]['FNAME'] + "</td>" 
					+ "<td style='cursor:pointer'>" + list[i]['FSPECTYPE'] + "</td>" 
					+ "<td style='cursor:pointer'>" + list[i]['FSOURCENAME'] + "</td>" 
					+ "<td style='cursor:pointer'>" + list[i]['FORIGINVALUE'] + "</td>"
					+ "<td style='cursor:pointer'>" + list[i]['FREMARK'] + "</td>"
					+ "<td>"+"<a href='javaScript:void(0)' onclick='delOne("+i+")'>删除</a>"+"</td>"
					+ "</tr>";
			$("#iwapGrid1").append(tablestr);
		}
	};	
	function doConfirmAsset(){
		cnt++;
		list[cnt] = assetGrid.getCurrentRow();
		listNUM[cnt] = assetGrid.getCurrentRow()['FBARCODE'];
		listFID[cnt] = assetGrid.getCurrentRow()['FID'];
		//console.info(list[cnt]); 
		var tablestr = "";
		var newstr = "";
		listShow();
		$('#assetModal').find('.close').click();
	};
	
	//保存
	function doArrange() {
		if (cnt == 0){
			alert("请先添加需要安排的资产信息！");
			return;
		}
		if ($('select#FRESPONSEPSNNAME').val() == '') {
			alert("责任人不能为空");
			return;
		}
		if ($('select#FDUTYPSNNAME').val() == '') {
			alert("使用人不能为空");
			return;
		}
		if (!confirm("是否确认资产安排？")){
			return;
		}
		var FARRANGENO = document.getElementById("FARRANGENO").value;
		var param = arrangeForm.getData();
		var extParam = {
			'option' : 'save',
			'txcode' : 'assetArrangeMg',
			'actionId' : 'doBiz',
			'FARRANGENO' : FARRANGENO,
			'list':listFID
		};
		$.IWAP.applyIf(param, extParam);
		$.IWAP.iwapRequest("iwap.ctrl", param, function(rs) {
			if (rs['header']['msg']) {
				return alert("保存失败:" + rs['header']['msg']);
			} }, function() {
				alert("保存失败!");
				return;
			});
		alert("保存成功!");
		$('#newArrangeModal').find('.close').click();
	};

	function doDetail(obj){
		var fno= iwapGrid.getCurrentRow()['FARRANGENO'];
		$('#fno').val(fno);
		var fid="";
		$('#detailArrangeModal').dialog('资产安排详细信息');
		operForm = $.IWAP.Form({'id' : 'aForm'});
		var callFn = function(rs) {
			var dataObj = rs['body'].rows;
			fid = dataObj['FID'];
			operForm.setData(dataObj);
		}
		var data = {
			'fno' : fno,
			'option' : 'detail'
		};
		sendAjax(data, 'assetArrangeMg', 'doBiz', callFn);
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '5',
			'txcode' : 'assetArrangeMg',
			'option' : 'detailA',
			'fid' : fid
		};
		iwapGrid2 = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			renderTo : 'iwapGrid2'
		});
	};
	
	function doPrint(){
		$('#printModal').dialog('资产安排单');
		document.getElementById("adate").innerHTML=document.getElementById("ADATE").value;
		document.getElementById("psn").innerHTML=document.getElementById("CREATEPSN").value;
		document.getElementById("ano").innerHTML=document.getElementById("fno").value;
		document.getElementById("use").innerHTML=document.getElementById("DUTYPSN").value;
		document.getElementById("utype").innerHTML=document.getElementById("USETYPE").value;
		document.getElementById("res").innerHTML=document.getElementById("RESPSN").value;
		document.getElementById("fzwz").innerHTML=document.getElementById("PLACE").value;
		document.getElementById("mark").innerHTML=document.getElementById("REMARK").value;
		var t = document.getElementById("iwapGrid2");
		var table = document.getElementById("assetTable");
		var rowNum = table.rows.length;
		for(var i=7;i<rowNum;i++){
			table.deleteRow(i);
			rowNum --;
			i--;
		}
		for(var i=1;i<t.rows.length;i++){
			var tableInfo = "<tr><td class='assetTable_content' >" + t.rows[i].cells[0].innerHTML + "</td>"
						  + "<td colspan='2' class='assetTable_content' >" + t.rows[i].cells[1].innerHTML + "</td>"
						  + "<td colspan='3' class='assetTable_content' >" + t.rows[i].cells[2].innerHTML + "</td>"
						  + "<td class='assetTable_content' >" + t.rows[i].cells[3].innerHTML + "</td>"
						  + "<td class='assetTable_content' >" + t.rows[i].cells[5].innerHTML + "</td></tr>";
			$("#assetTable").append(tableInfo);
		}
		var tablestr="<tr height='20px;'></tr>";
		$("#assetTable").append(tablestr);
		tablestr = "<tr>"+"<td></td>"+"<td></td>"
			+"<td> 系统管理员：</td>"+"<td ></td>"
			+"<td> 库房管理员：</td>"+"<td ></td>"
			+"<td> 资产领用人：</td>"+"<td ></td>"
			+"</tr>";
		$("#assetTable").append(tablestr);
	};
	
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
	
	//对话框
	function dialogModal(id){
		$('#'+id).dialog();
	};
	//清空所有
	function clearAll(){
		clearAsset();
		$('select#FUSETYPE').val("个人使用");
		$('select#FRESPONSEPSNNAME').val("");
		$('select#FDUTYPSNNAME').val("");
		$('#FARRANGEROOM').val("");
		$('#FREMARK').val("");
		$('#FRESPONSEDEPTNAME').val("");
		$('#FDUTYDEPTNAME').val("");
		$('#LIMITDATE').val("");
	}
</script>
</html>