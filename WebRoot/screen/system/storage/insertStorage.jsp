<%@page import="com.nantian.iwap.common.util.DateUtil"%>
<%@ page language="java" import="com.nantian.iwap.web.WebEnv"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>新建入库</title>
<meta name="description" content="">
<!-- 一般查询页面所引入的样式文件 -->
<link href="${ctx}/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/css.css" rel="stylesheet">
<link href="${ctx}/css/style.css" rel="stylesheet">
<link href="${ctx}/css/iwapui-style.css" rel="stylesheet"
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

</head>
<body class="iwapui center_body">
	<input type="hidden" value="${userInfo.ORG_ID}" id="_deptid">
	<input type="hidden" value="${userInfo.ACCT_ID}" id="_userid">
	<div id="divDialog" class="divDialog">
		<!-- 第一个对话框开始 入库资产信息-->
		<div class="bg" id="bg" style="height: 100%;"></div>
		<div class="dialog" id="assetModal"
			style="width: 820px; height: 460px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">入库资产信息</h4>
			</div>
			<div class="col-md-12" style="width: 890px;">
				<form method="post" onsubmit="return false" id="assetIndForm">
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							资产名称<input name="name" type="text" data-iwap-xtype="TextField"
								id="name" class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							资产类别<input name="kind" type="text" data-iwap-xtype="TextField"
								id="kind" class="input_text_1" disabled="disabled"
								style="width: 110px; background-color: #fff">
							<a href="javaScript:void(0)" id="search"
								onclick='dialogModal("classModal")'> <img alt=""
								src="../iwapabc/images/icon/search.png" /></a>
						</div>
						<div class="inputbox " >
							<input name="kindno" type="text"
								data-iwap-xtype="TextField" id="kindno" class="input_text_2"
								value="" disabled="disabled">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							资产简称<input name="sname" type="text" data-iwap-xtype="TextField"
								id="sname" class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							资产数量<input name="zcsl" type="text" data-iwap-xtype="TextField"
								id="zcsl" class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							单 价&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="price"
								type="text" data-iwap-xtype="TextField" id="price"
								class="input_text_1" onchange="setIsfa()">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							币 种&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="currency"
								type="text" data-iwap-xtype="TextField" id="currency"
								class="input_text_1" value="人民币">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							是否固定资产 <select data-iwap-xtype="ListField" name="isfa"
								class="select_content" id="isfa" style="width: 105px;">
							</select>
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							规格型号<input name="spectype" type="text"
								data-iwap-xtype="TextField" id="spectype" class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							财务大类<select data-iwap-xtype="ListField" name="usetype"
								class="select_content" id="usetype"">
							</select>
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							制 造 商&nbsp;&nbsp;<input name="factory" type="text"
								data-iwap-xtype="TextField" id="factory" class="input_text_1">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							出厂日期<input name="fdate" type="date" data-iwap-xtype="TextField"
								id="fdate" class="input_text_1" value="">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							购买日期<input name="bdate" type="date" data-iwap-xtype="TextField"
								id="bdate" class="input_text_1" value="">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							保 修 期&nbsp;&nbsp;<input name="warn" type="text"
								data-iwap-xtype="TextField" id="warn" class="input_text_1"
								style="width: 130px;"> 月
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							保修期至<input name="wdate" type="date" data-iwap-xtype="TextField"
								id="wdate" class="input_text_1" value="">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							计量单位<input name="unit" type="text" data-iwap-xtype="TextField"
								id="unit" class="input_text_1">
						</div>
					</div>
					<div class="col-md-8">
						<div class="inputbox" style="margin: 2px;">
							详细配置<input name="detailInfo" type="text"
								data-iwap-xtype="TextField" id="detailInfo" class="input_text_1"
								style="width: 450px; height: 60px;">
						</div>
					</div>
					<div class="col-md-4">
						<div class="inputbox" style="margin: 2px;">
							预算类别<input name="budget" type="text" data-iwap-xtype="TextField"
								id="budget" class="input_text_1"
								style="height: 60px; background-color: #fff;"
								disabled="disabled">
						</div>
					</div>
					<div class="col-md-12">
						<div class="inputbox" style="margin: 2px;">
							备 注&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="remark"
								type="text" data-iwap-xtype="TextField" id="remark"
								class="input_text_1" style="width: 703px; height: 60px;">
						</div>
					</div>
					<div class="col-md-12" style="margin-bottom: 10px;">
						<div class="inputbox">
							上传附件
							<div
								style="width: 760px; height: 60px; border: 1px solid #CCCCCC;">
								<a href="#">上传文件</a>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="col-md-offset-5">
				<div class="table_nav2"
					style="border: 1px solid white; margin: 10px;">
					<a href="javaScript:void(0)" id="save" onclick="doSaveAsset()">保存</a>
					<a href="javaScript:void(0)" id="reset" onclick="doReset()">清空</a>
				</div>
			</div>
		</div>
		<!-- 第一个对话框 END-->
		<!-- 第二个对话框开始 添加发票信息-->
		<div class="bg" id="bg" style="height: 100%;"></div>
		<div class="dialog" id="billModal"
			style="width: 820px; height: 520px;">
			<div class="dialog-header" style="background-color: 33AECC">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">添加发票</h4>
			</div>
			<div class="table_nav2">
				<div class="col-md-4">
					<a href="javaScript:void(0)" data-iwap-dialog="myModal" id="add"
						onclick="newBill()"> <img alt=""
						src="../iwapabc/images/icon/add.png" /> 新增
					</a> <a id="selectmultidel" class="" onclick="del()"
						href="javaScript:void(0)"> <img alt=""
						src="../iwapabc/images/icon/delete.png" /> 删除
					</a> <a href="javaScript:void(0)" id="query"
						onclick="billGrid.doReset();billGrid.doQuery()"> <img alt=""
						src="../iwapabc/images/icon/refresh.png" /> 刷新
					</a>
				</div>
				<div class="col-md-5">
					<form id="Conditions">
						<div class="inputbox">
							<input name="fuzzySearch" type="text" data-iwap-xtype="TextField"
								id="fuzzySearch" class="input_text_1"
								onkeypress="if(event.keyCode==13) {iwapGrid.doQuery();return false;}">
						</div>
						<a href="javaScript:void(0)" id="search"
							onclick="billGrid.doQuery()"> <img alt=""
							src="../iwapabc/images/icon/search.png" /> 搜索
						</a>
					</form>
				</div>
			</div>
			<div class="col-md-12" style="width: 810px;">
				<div
					style="height: 265px; overflow-y: auto; border: 1px solid #CCCCCC;">
					<table id="billGrid"
						class="mygrid table table-bordered table-striped table-hover"
						data-iwap="grid" data-iwap-id="" data-iwap-param=""
						data-iwap-pagination="true">
						<tr style="overflow: scroll;">
							<th data-grid-name="FP_NUM" primary="primary" data-order="">选择
								<s><input id="radio1" name="radio1" type="radio"
									selectmulti="selectmulti" value="{{value}}"></s>
							</th>
							<th data-grid-name="ROW_NUM" class="tl">序号</th>
							<th data-grid-name="FP_NUM" class="tl">发票号码</th>
							<th data-grid-name="FP_DATE" class="tl">开票日期</th>
							<th data-grid-name="FP_MONEY" class="tl">发票金额</th>
							<th data-grid-name="FMTYPE" class="tl">币种</th>
							<th data-grid-name="FPEOPLE" class="tl">经办人</th>
							<th data-grid-name="FPROVIDER" class="tl">供应商</th>
							<th data-grid-name="FREMARK" class="tl">备注</th>
						</tr>
					</table>
				</div>
				<h5>
					已选列表 （共<input id="num" type="text" value="0"
						style="width: 10px; height: 25px; border: none; background-color: #fff;"
						disabled="disabled">项）
				</h5>
				<div id="blist"
					style="height: 80px; overflow-y: auto; border: 1px solid #CCCCCC;">

				</div>
				<div class="col-md-offset-5">
					<div class="table_nav2"
						style="border: 1px solid white; margin: 3px;">
						<a href="javaScript:void(0)" id="save" onclick="doSaveBill()">保存</a>
						<!-- <a href="javaScript:void(0)" id="reset" onclick="doResetBill()">清空</a> -->
					</div>
				</div>
			</div>
		</div>
		<!-- 第二个对话框 END-->
		<!-- 第三个对话框（对话框中打开对话框） -->
		<div class="bg"></div>
		<div class="dialog" id="addBill" style="width: 780px; height: 350px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">新建发票信息</h4>
			</div>
			<div class="modal-body">
				<div class="col-md-12">
					<form method="post" onsubmit="return false" id="billForm">
						<div class="col-md-9">

							<div class="col-md-6">
								<div class="inputbox" style="margin: 3px;">
									<span>发票号码</span><input name="FP_NUM" type="text"
										data-iwap-xtype="TextField" id="FP_NUM" class="input_text_1">
								</div>
							</div>
							<div class="col-md-6">
								<div class="inputbox" style="margin: 3px;">
									<span>开票日期</span><input name="FP_DATE" type="date"
										data-iwap-xtype="TextField" id="FP_DATE" class="input_text_1">
								</div>
							</div>
							<div class="col-md-6">
								<div class="inputbox" style="margin: 3px;">
									<span>币种</span><select data-iwap-xtype="ListField"
										name="FMTYPE" class="select_content" id="FMTYPE">
										<option value=""></option>
									</select>
								</div>
							</div>
							<div class="col-md-6">
								<div class="inputbox" style="margin: 3px;">
									<span>供应商</span><input name="FPROVIDER" type="text"
										data-iwap-xtype="TextField" id="FPROVIDER"
										class="input_text_1">
								</div>
							</div>
							<div class="col-md-6">
								<div class="inputbox" style="margin: 3px;">
									<span>发票金额</span><input name="FP_MONEY" type="text"
										data-iwap-xtype="TextField" id="FP_MONEY" class="input_text_1">
								</div>
							</div>
							<div class="col-md-6">
								<div class="inputbox" style="margin: 3px;">
									<span>汇率</span><input name="FRATE" type="text"
										data-iwap-xtype="TextField" id="FRATE" class="input_text_1">
								</div>
							</div>
							<div class="col-md-6">
								<div class="inputbox" style="margin: 3px;">
									<span>本位币金额</span><input name="FCURRENCY" type="text"
										data-iwap-xtype="TextField" id="FCURRENCY"
										class="input_text_1">
								</div>
							</div>
							<div class="col-md-6">
								<div class="inputbox" style="margin: 3px;">
									<span>经办人</span><input name="FPEOPLE" type="text"
										data-iwap-xtype="TextField" id="FPEOPLE" class="input_text_1">
								</div>
							</div>
							<div class="col-md-12">
								<div class="inputbox" style="margin: 3px;">
									<span>备注</span><input name="FREMARK2" type="text"
										data-iwap-xtype="TextField" id="FREMARK2" class="input_text_1"
										style="width: 390px;">
								</div>
							</div>
							<div class="col-md-12">
								<div class="inputbox" style="margin: 3px;">
									<span>发票附件</span><input name="BDOWN" type="text"
										data-iwap-xtype="TextField" id="BDOWN" class="input_text_1"
										style="width: 390px;">
								</div>
							</div>

						</div>
						<div class="col-md-offset-9">
							<div
								style="width: 200px; height: 220px; border: 1px solid #bcbcbc;">
								<div class="table_box" style="overflow-y: hide; height: 270px;">
									<table id="Grid"
										class="mygrid table table-bordered table-striped table-hover"
										data-iwap="grid" data-iwap-id="" data-iwap-param=""
										data-iwap-pagination="true">
										<tr>
											<th data-grid-name="TITLE" class="tl">科目类型</th>
											<th data-grid-name="FMONEY" class="tl">科目金额</th>
										</tr>
										<tr>
											<th>应交税费</th>
											<th><input style="width: 50px; height: 20px;"
												type="text" value="0.00" /></th>
										</tr>
										<tr>
											<th>计算机系统运行费</th>
											<th><input style="width: 50px; height: 20px;"
												type="text" value="0.00" /></th>
										</tr>
										<tr>
											<th>在建工程</th>
											<th><input style="width: 50px; height: 20px;"
												type="text" value="0.00" /></th>
										</tr>
										<tr>
											<th>低值易耗品</th>
											<th><input style="width: 50px; height: 20px;"
												type="text" value="0.00" /></th>
										</tr>
										<tr>
											<th>固定资产</th>
											<th><input style="width: 50px; height: 20px;"
												type="text" value="0.00" /></th>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="col-md-12">
					<div style="color: red">说明：发票金额请在右侧表格中分类填写。</div>
				</div>
				<div class="col-md-offset-5">
					<div class="table_nav2"
						style="border: 1px solid white; margin: 3px;">
						<a href="javaScript:void(0)" id="save" onclick="doSaveNewBill()">保存</a>
						<a href="javaScript:void(0)" id="reset" onclick="doResetNewBill()">清空</a>
					</div>
				</div>
			</div>
		</div>
		<!-- 第三个对话框 END-->
		<!-- 第四个对话框开始Begin 放置位置-->
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
								onkeypress="if(event.keyCode==13) {placeGrid.doQuery();return false;}">
						</div>
					</div>
				</form>
				<div class="col-md-10">
					<a href="javaScript:void(0)" id="search"
						onclick="placeGrid.doQuery()"> <img alt=""
						src="../iwapabc/images/icon/search.png" /> 查询
					</a> <a href="javaScript:void(0)" id="refresh"
						onclick="placeGrid.doReset();placeGrid.doQuery()"> <img alt=""
						src="../iwapabc/images/icon/refresh.png" /> 刷新
					</a> <a href="javaScript:void(0)" id="confirm" onclick="doConfirm()">
						<img alt="" src="../iwapabc/images/icon/confirm.png" /> 确定
					</a>
				</div>

			</div>
			<div class="col-md-12">
				<div style="width: 850px; height: 280px; overflow-y: auto;">
					<table id="placeGrid"
						class="mygrid table table-bordered table-striped table-hover"
						data-iwap="grid" data-iwap-id="" data-iwap-param=""
						data-iwap-pagination="true">
						<tr>
							<th data-grid-name="FCODE" primary="primary" data-order="">选择<s><input
									id="radio1" name="radio1" type="radio"
									selectmulti="selectmulti" value="{{value}}"></s></th>
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
		<!-- 第四个对话框结束 End 选择放置位置 -->
		<!-- 第五个对话框开始Begin 选择合同-供应商-->
		<div class="bg" style="height: 100%;"></div>
		<div class="dialog" id="contractModal"
			style="width: 900px; height: 450px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">合同列表</h4>
			</div>
			<div class="table_nav2">
				<form id="contractForm">
					<div class="col-md-2">
						<div class="inputbox" style="margin: 2px;">
							<input name="fuzzysearch1" type="text"
								data-iwap-xtype="TextField" id="fuzzysearch1"
								class="input_text_1" value=""
								onkeypress="if(event.keyCode==13) {contractGrid.doQuery();return false;}">
						</div>
					</div>
				</form>
				<div class="col-md-10">
					<a href="javaScript:void(0)" id="search"
						onclick="contractGrid.doQuery()"> <img alt=""
						src="../iwapabc/images/icon/search.png" /> 查询
					</a> <a href="javaScript:void(0)" id="refresh"
						onclick="contractGrid.doReset();contractGrid.doQuery()"> <img
						alt="" src="../iwapabc/images/icon/refresh.png" /> 刷新
					</a> <a href="javaScript:void(0)" id="confirm" onclick="doConfirm1()">
						<img alt="" src="../iwapabc/images/icon/confirm.png" /> 确定
					</a>
				</div>

			</div>
			<div class="col-md-12">
				<div style="width: 850px; height: 280px; overflow-y: auto;">
					<table id="contractGrid"
						class="mygrid table table-bordered table-striped table-hover"
						data-iwap="grid" data-iwap-id="" data-iwap-param=""
						data-iwap-pagination="true">
						<tr>
							<th data-grid-name="FID" primary="primary" data-order="">选择<s><input
									id="radio1" name="radio1" type="radio"
									selectmulti="selectmulti" value="{{value}}"></s></th>
							<th data-grid-name="ROW_NUM" class="tl">序号</th>
							<th data-grid-name="CONTRACTID" class="tl">合同编号</th>
							<th data-grid-name="CTITLE" class="tl">合同标题</th>
							<th data-grid-name="CDATE" class="tl">签订日期</th>
							<th data-grid-name="FPAYSTATE" class="tl">付款情况</th>
							<th data-grid-name="CMONEY" class="tl">合同金额</th>
							<th data-grid-name="FPROVIDER" class="tl">供应商</th>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 第五个对话框结束 End 选择合同-供应商 -->
		<!-- 第六个对话框开始Begin 选择动支单 -->
		<div class="bg" style="height: 100%;"></div>
		<div class="dialog" id="budgetModal"
			style="width: 900px; height: 550px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">动支单列表</h4>
			</div>
			<div class="table_nav2">
				<form id="contractForm">
					<div class="col-md-2">
						<div class="inputbox" style="margin: 2px;">
							<input name="fuzzysearch2" type="text"
								data-iwap-xtype="TextField" id="fuzzysearch2"
								class="input_text_1" value=""
								onkeypress="if(event.keyCode==13) {budgetGrid.doQuery();return false;}">
						</div>
					</div>
				</form>
				<div class="col-md-10">
					<a href="javaScript:void(0)" id="search"
						onclick="budgetGrid.doQuery()"> <img alt=""
						src="../iwapabc/images/icon/search.png" /> 查询
					</a> <a href="javaScript:void(0)" id="refresh"
						onclick="budgetGrid.doReset();budgetGrid.doQuery()"> <img
						alt="" src="../iwapabc/images/icon/refresh.png" /> 刷新
					</a> <a href="javaScript:void(0)" id="confirm" onclick="doConfirm2()">
						<img alt="" src="../iwapabc/images/icon/confirm.png" /> 确定
					</a>
				</div>

			</div>
			<div class="col-md-12">
				<div style="width: 850px; height: 280px; overflow-y: auto;">
					<table id="budgetGrid"
						class="mygrid table table-bordered table-striped table-hover"
						data-iwap="grid" data-iwap-id="" data-iwap-param=""
						data-iwap-pagination="true">
						<tr>
							<th data-grid-name="FID" primary="primary" data-order="">选择<s><input
									id="radio1" name="radio1" type="radio"
									selectmulti="selectmulti" value="{{value}}"
									onchange="budgetChange()"></s></th>
							<th data-grid-name="ROW_NUM" class="tl">序号</th>
							<th data-grid-name="FBUDGETNO" class="tl">动支单号</th>
							<th data-grid-name="FDEPARTMENTNAME" class="tl">所属部门</th>
							<th data-grid-name="FBUDGETAMOUNT" class="tl">总金额</th>
							<th data-grid-name="FBUDGETDATE" class="tl">创建时间</th>
							<th data-grid-name="FCREATEPERSONNAME" class="tl">提单人姓名</th>
						</tr>
					</table>
				</div>
			</div>
			<div class="col-md-12">
				<div style="width: 850px; height: 120px; overflow-y: auto;">
					<table id="budgetGrid1"
						class="mygrid table table-bordered table-striped table-hover"
						data-iwap="grid" data-iwap-id="" data-iwap-param=""
						data-iwap-pagination="true">
						<tr>
							<th data-grid-name="ROW_NUM" class="tl">序号</th>
							<th data-grid-name="FBUDGETMONEY" class="tl">预算金额</th>
							<th data-grid-name="FBUDGETNAME" class="tl">预算类别名称</th>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<!-- 第六个对话框结束 End 动支单号 -->
		<!-- 第七个对话框开始Begin 资产入库确认 -->
		<div class="bg" style="height: 100%;"></div>
		<div class="dialog" id="assetConfirm"
			style="width: 850px; height: 700px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">资产入库确认</h4>
			</div>
			<div class="col-md-12 table_nav2">
				<a href="javaScript:void(0)" id="set" onclick=""> <img alt=""
					src="../iwapabc/images/icon/setting.png" /> 页面设置
				</a> <a href="javaScript:void(0)" id="use" onclick=""> <img alt=""
					src="../iwapabc/images/icon/preview.png" /> 打印预览
				</a> <a href="javaScript:void(0)" id="print" onclick=""> <img alt=""
					src="../iwapabc/images/icon/print.png" /> 打印
				</a> <a href="javaScript:void(0)" id="outpdf" onclick=""> <img
					alt="" src="../iwapabc/images/icon/pdf.png" /> 导出PDF
				</a> <a href="javaScript:void(0)" id="outword" onclick="printword()">
					<img alt="" src="../iwapabc/images/icon/word.png" /> 导出Word
				</a> <a href="javaScript:void(0)" id="outexcel" onclick="printexcel()">
					<img alt="" src="../iwapabc/images/icon/excel.png" /> 导出Excel
				</a> <a href="javaScript:void(0)" id="sto" onclick="doSave()"> <img
					alt="" src="../iwapabc/images/icon/storage.png" /> 入库
				</a>
			</div>
			<div class="col-md-12">
				<table class="assetTable" id="assetTable">
					<tr>
						<td colspan="7"><h4 align="center">资产入库确认</h4></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td>入库单号:</td>
						<td id="stono"></td>
					</tr>
					<tr>
						<td class="assetTable_title">签报号</td>
						<td colspan="2" class="assetTable_content" id="sign"></td>
						<td class="assetTable_title">入库方式</td>
						<td class="assetTable_content" id="stomode"></td>
						<td class="assetTable_title">入库日期</td>
						<td class="assetTable_content" id="time"></td>
					</tr>
					<tr>
						<td class="assetTable_title">责任部门</td>
						<td colspan="2" class="assetTable_content" id="resdept"></td>
						<td class="assetTable_title">责任人</td>
						<td class="assetTable_content" id="respsn"></td>
						<td class="assetTable_title">总金额</td>
						<td class="assetTable_content" id="amount"></td>
					</tr>
					<tr>
						<td class="assetTable_title">供应商</td>
						<td colspan="2" class="assetTable_content" id="supplier"></td>
						<td class="assetTable_title">合同编号</td>
						<td class="assetTable_content" id="contractid"></td>
						<td class="assetTable_title">放置位置</td>
						<td class="assetTable_content" id="fplace"></td>
					</tr>
					<tr>
						<td class="assetTable_title">备注</td>
						<td colspan="4" class="assetTable_content" id="fremark"></td>
						<td class="assetTable_title">动支单号</td>
						<td class="assetTable_content" id="budgetno"></td>
					</tr>
					<tr height="20px;">
					</tr>
					<tr>
						<td class="assetTable_title">预算类别</td>
						<td class="assetTable_title">资产类别</td>
						<td class="assetTable_title">资产名称</td>
						<td class="assetTable_title">规格型号</td>
						<td class="assetTable_title">资产数量</td>
						<td class="assetTable_title">单价</td>
						<td class="assetTable_title">备注</td>
					</tr>
				</table>
			</div>
		</div>
		<!-- 第七个对话框结束 End 入库资产确认 -->
		<!-- 第七个对话框开始Begin 资产分类 -->
		<div class="bg" style="height: 100%;"></div>
		<div class="dialog" id="classModal"
			style="width: 800px; height: 450px;">
			<div class="dialog-header">
				<button type="button" class="close" id="btn_iwap-gen-10"
					data-dialog-hidden="true">
					<span>×</span>
				</button>
				<h4 class="modal-title">选择资产分类</h4>
			</div>
			<div class="modal-body">
				<iframe style="height: 380px; width: 770px"
					src="iwap.ctrl?txcode=chooseClass"></iframe>
			</div>
		</div>
		<!-- 第八个对话框结束 End 资产分类 -->
	</div>

	<div class="col-md-12">
		<div class="col-md-12">
			<div class="table_nav2" style="border: 1px solid white;">
				<a href="javaScript:void(0)" id="saveAll" onclick="assetConfirm()">
					<img alt="" src="../iwapabc/images/icon/save.png" /> 保存
				</a> <a href="javaScript:void(0)" id="doStorage"
					onclick="assetConfirm()"> <img alt=""
					src="../iwapabc/images/icon/storage.png" /> 资产入库
				</a> <a href="javaScript:void(0)" id="doCommit" onclick="assetConfirm()">
					<img alt="" src="../iwapabc/images/icon/storage.png" /> 提交
				</a>
			</div>
		</div>
		<div class="col-md-12"
			style="height: 30px; background-color: #d0e4ff;">
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
		<div class="col-md-12">
			<form method="post" onsubmit="return false" id="storageForm">
				<div class="col-md-4">
					<div class="inputbox" style="margin: 2px;">
						责任部门<select data-iwap-xtype="ListField" name="FRESPONSEDEPTNAME"
							class="select_content" id="FRESPONSEDEPTNAME">
						</select>
					</div>
				</div>
				<div class="col-md-4">
					<div class="inputbox" style="margin: 2px;">
						责&nbsp;任&nbsp;人&nbsp;<select data-iwap-xtype="ListField"
							name="FRESPONSEPSNNAME" class="select_content"
							id="FRESPONSEPSNNAME">
							<option value="${userInfo.ACCT_ID }" selected="selected">${userInfo.ACCT_NM }</option>
						</select>
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
						入库方式<select data-iwap-xtype="ListField" name="FMODE"
							class="select_content" id="FMODE">
						</select>
					</div>
				</div>
				<div class="col-md-4">
					<div class="inputbox" style="margin: 2px;">
						入库日期<input name="FCREATETIME" type="date"
							data-iwap-xtype="TextField" id="FCREATETIME" class="input_text_1"
							value="<%=DateUtil.getCurrentDate("yyyy-MM-dd")%>">
					</div>
				</div>
				<div class="col-md-4">
					<div class="inputbox" style="margin: 2px;">
						入库金额<input name="FAMOUNT" type="number"
							data-iwap-xtype="TextField" id="FAMOUNT" class="input_text_1"
							disabled="disabled" value="0" style="text-align: right;">
					</div>
				</div>
				<div class="col-md-4">
					<div class="inputbox" style="margin: 2px;">
						放置位置<input name="FFZWZ" type="text" disabled="disabled"
							data-iwap-xtype="TextField" id="FFZWZ" class="input_text_1"
							style="width: 110px; background-color: #fff"><a
							href="javaScript:void(0)" id="search" onclick="doSearch()"> <img
							alt="" src="../iwapabc/images/icon/search.png" />
						</a>
					</div>
				</div>
				<div class="col-md-4">
					<div class="inputbox" style="margin: 2px;">
						合同编号<input name="FCONTRACT" type="text" disabled="disabled"
							value="" data-iwap-xtype="TextField" id="FCONTRACT"
							class="input_text_1" style="width: 110px; background-color: #fff"><a
							href="javaScript:void(0)" id="search" onclick="doSearch1()">
							<img alt="" src="../iwapabc/images/icon/search.png" />
						</a>
					</div>
				</div>
				<div class="col-md-4">
					<div class="inputbox" style="margin: 2px;">
						供&nbsp;应 &nbsp;商 <input name="FSUPPLIER" type="text"
							disabled="disabled" data-iwap-xtype="TextField" id="FSUPPLIER"
							class="input_text_1">
					</div>
				</div>
				<div class="col-md-4">
					<div class="inputbox" style="margin: 2px;">
						备&nbsp;&nbsp;&nbsp;&nbsp;注&nbsp;&nbsp;&nbsp;<input name="FREMARK"
							type="text" data-iwap-xtype="TextField" id="FREMARK"
							class="input_text_1">
					</div>
				</div>
				<div class="col-md-4">
					<div class="inputbox" style="margin: 2px;">
						动支单号<input name="FBUDGETNO" type="text" disabled="disabled"
							data-iwap-xtype="TextField" id="FBUDGETNO" class="input_text_1"
							style="width: 110px; background-color: #fff"> <a
							href="javaScript:void(0)" id="searchBudget" onclick="doSearch2()">
							<img alt="" src="../iwapabc/images/icon/search.png" />
						</a>
					</div>
				</div>
				<div class="col-md-4">
					<div class="inputbox" style="margin: 2px;">
						是否关联动支单 <input type="radio" name="radiobutton" id="yes"
							value="yes" checked onchange="setDZD()" /> 是 <input type="radio"
							name="radiobutton" id="no" value="no" onchange="setDZD()" /> 否
					</div>
				</div>
			</form>
			<div class="col-md-12">
				<div class="col-md-1" style="width: 40px;">发 票</div>
				<div class="col-md-11">
					<div style="height: 125px; border: 1px solid #CCCCCC;">
						<div class="table_nav2"
							style="border: 1px solid white; padding: 0px;">
							<a href="javaScript:void(0)" id="add" onclick="addBill()"> <img
								alt="" src="../iwapabc/images/icon/add.png" /> 添加
							</a> <a href="javaScript:void(0)" id="fresh" onclick="clearBill()">
								<img alt="" src="../iwapabc/images/icon/refresh.png" /> 清空
							</a>
						</div>
						<div style="height: 92px; overflow-y: auto;">
							<table id="iwapGrid1"
								class="mygrid table table-bordered table-striped table-hover"
								data-iwap="grid" data-iwap-id="" data-iwap-param=""
								data-iwap-pagination="true">
								<tr style="overflow: scroll;">
									<th data-grid-name="ROW_NUM" class="tl">序号</th>
									<th data-grid-name="FP_NUM" class="tl">发票号码</th>
									<th data-grid-name="FP_DATE" class="tl">开票日期</th>
									<th data-grid-name="FP_MONEY" class="tl">发票金额</th>
									<th data-grid-name="FMTYPE" class="tl">币种</th>
									<th data-grid-name="FPEOPLE" class="tl">经办人</th>
									<th data-grid-name="FPROVIDER" class="tl">供应商</th>
									<th data-grid-name="BDOWN" class="tl">发票附件</th>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-12">
				<div class="inputbox" style="margin: 2px;">
					入库附件<a href="#"><input name="FREMARK1" type="text"
						data-iwap-xtype="TextField" id="FREMARK1" class="input_text_1 "
						value="上传附件" disabled="disabled" style="background-color: #fff;"></a>
				</div>
			</div>
		</div>
		<div class="col-md-12"
			style="height: 30px; background-color: #d0e4ff;">
			<div class="col-md-8">
				<h5>资产明细：</h5>
			</div>
		</div>
		<div class="col-md-12">
			<div class="table_nav2"
				style="border: 1px solid white; padding: 0px;">
				<a href="javaScript:void(0)" id="add" onclick="addAsset()"> <img
					alt="" src="../iwapabc/images/icon/add.png" /> 添加
				</a> <a href="javaScript:void(0)" id="fresh" onclick="clearAsset()">
					<img alt="" src="../iwapabc/images/icon/refresh.png" /> 清空
				</a>
			</div>
		</div>
		<div class="col-md-12">
			<div
				style="height: 125px; overflow-y: auto; border: 1px solid #CCCCCC;">
				<table id="iwapGrid2"
					class="mygrid table table-bordered table-striped table-hover"
					data-iwap="grid" data-iwap-id="" data-iwap-param=""
					data-iwap-pagination="true">
					<tr>
						<th data-grid-name="ROW_NUM" class="tl">序号</th>
						<th data-grid-name="FUSETYPE" class="tl">财务大类</th>
						<th data-grid-name="FBUDGET" class="tl">预算类别</th>
						<th data-grid-name="FKIND" class="tl">资产类别</th>
						<th data-grid-name="FNAME" class="tl">资产名称</th>
						<th data-grid-name="FSPECTYPE" class="tl">规格型号</th>
						<th data-grid-name="FPRICE" class="tl">单价</th>
						<th data-grid-name="FZCSL" class="tl">入库数量</th>
						<th data-grid-name="FISFA" class="tl">固定资产</th>
						<th data-grid-name="FREMARK" class="tl">备注</th>
						<th data-grid-name="ROW_NUM" option="option" option-html=''><span>操作</span><s>
								<a href="javaScript:void(0)" class="editId" onclick="edit(this)"
								id="editOne">修改</a>&nbsp;|&nbsp; <a href="javaScript:void(0)"
								class="editId" onclick="delOne(this)">删除</a>
						</s></th>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	var actionType = "", iwapGrid = null, condionForm = null, operForm = null, grantTree = null, orgTree = null;
	var grantTreeData = null, orgTreeData = null;
	var storageForm = null;
	var list = Array(), cnt = 0, billList = Array(), billCNT = 0;
	var org_nm;
	var stoPrice = 0, isEdit = 0;
	var billFID = Array(), billNUM = Array();
	var BudgetAmount = parseFloat(0);
	var object = new Object();
	var count = parseInt(0);

	$(document)
			.ready(
					function() {
						parent.document.getElementById("title").value = document.title;
						document.getElementById("kindno").hidden=true;
						initSelectKV('{"FMODE":"FMODE","isfa":"FISFA"}');
						initSelectKV('{"FRESPONSEDEPTNAME":"RESDEPT","FRESPONSEPSNNAME":"RESPSN"}');
						initSelectKV('{"usetype":"FUSETYPE"}');

						operForm = $.IWAP.Form({
							'id' : 'assetIndForm'
						});
						storageForm = $.IWAP.Form({
							'id' : 'storageForm'
						});
						condionForm = $.IWAP.Form({
							'id' : 'Conditions'
						});

						var callFn = function(rs) {
							var dataObj = rs['body'].ZCRK;
							document.getElementById("FNO").value = dataObj;
						}
						var data = {
							'option' : 'init'
						};
						sendAjax(data, 'insertStorage', 'doBiz', callFn);
						// 初始化入库方式是否启用（采用数据字典）
						$('select#FRESPONSEDEPTNAME').val(
								document.getElementById("_deptid").value);
					});

	//是否关联动支单
	function setDZD() {
		var ra = $('input[name="radiobutton"]:checked').val();
		if (ra == "yes") {
			document.getElementById("searchBudget").hidden = false;
		} else if (ra == "no") {
			document.getElementById("FBUDGETNO").value = "";
			document.getElementById("searchBudget").hidden = true;
		}
	};

	//单价控制是否固定资产
	function setIsfa() {
		if ($('#price').val() > 2000) {
			$('select#isfa').val('是');
		} else {
			$('select#isfa').val('否');
		}
	};

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
			'txcode' : 'insertStorage',
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
		$(function() {
			document.onkeydown = function(e) {
				var ev = document.all ? window.event : e;
				if (ev.keyCode == 13) {
					placeGrid.doQuery();
				}
			}
		});
	};

	function doConfirm() {
		if (placeGrid.getCheckValues() == "") {
			alert("请选择放置位置！");
		} else {
			console.info(placeGrid.getCurrentRow());
			$('#FFZWZ').val(
					placeGrid.getCurrentRow()['FLZMC'] + "/"
							+ placeGrid.getCurrentRow()['FJGMC']);
			$('#placeModal').find('.close').click();
		}
	};

	//选择合同
	function doSearch1() {
		if (billCNT != 0) {
			alert("只有清空了入库单关联的发票信息后，才能添加合同信息！");
			return;
		}
		$('#contractModal').dialog('合同列表');
		condionForm = $.IWAP.Form({
			'id' : 'contractForm'
		});
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '5',
			'txcode' : 'insertStorage',
			'option' : 'contract'
		};
		contractGrid = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			form : condionForm,
			renderTo : 'contractGrid'
		});
		$(function() {
			document.onkeydown = function(e) {
				var ev = document.all ? window.event : e;
				if (ev.keyCode == 13) {
					contractGrid.doQuery();
				}
			}
		});
	};

	function doConfirm1() {
		if (contractGrid.getCheckValues() == "") {
			alert("请选择合同！");
		} else {
			console.info(contractGrid.getCurrentRow());
			$('#FCONTRACT').val(contractGrid.getCurrentRow()['CONTRACTID']);
			$('#FSUPPLIER').val(contractGrid.getCurrentRow()['FPROVIDER']);
			$('#contractModal').find('.close').click();
		}
	};

	//选择动支单
	function doSearch2() {
		$('#budgetModal').dialog('动支单列表');
		condionForm = $.IWAP.Form({
			'id' : 'budgetForm'
		});
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '5',
			'txcode' : 'insertStorage',
			'option' : 'budget'
		};
		budgetGrid = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			form : condionForm,
			renderTo : 'budgetGrid'
		});
		$(function() {
			document.onkeydown = function(e) {
				var ev = document.all ? window.event : e;
				if (ev.keyCode == 13) {
					budgetGrid.doQuery();
				}
			}
		});
	};

	function budgetChange() {
		var fno = budgetGrid.getCurrentRow()['FBUDGETNO'];
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '5',
			'txcode' : 'insertStorage',
			'option' : 'budgetd',
			'FBUDGETNO' : fno
		};
		budgetGrid1 = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			renderTo : 'budgetGrid1'
		});
	};

	function doConfirm2() {
		if (budgetGrid.getCheckValues() == "") {
			alert("请选择动支单！");
		} else {
			$('#FBUDGETNO').val(budgetGrid.getCurrentRow()['FBUDGETNO']);
			BudgetAmount = parseFloat(budgetGrid.getCurrentRow()['FBUDGETAMOUNT']);
			$('#budgetModal').find('.close').click();
		}
	};

	//增加资产明细
	function addAsset() {
		//每次点击增加按钮后：入库方式是否启用设成默认值
		$('#assetModal').dialog('入库资产信息');
		option = "add";
		operForm.reset();
		operForm.disabledById("currency");
		$('#zcsl').val('1');
		$('#currency').val('人民币');
		$('select#usetype').val('使用');
	};

	function edit(obj) {
		$('#assetModal').dialog("入库资产信息");
		operForm.setData(list[obj]);
		object[list[obj]['budget']] = parseFloat(0);
		isEdit = obj;
	};

	function delOne(obj) {
		list.splice(obj, 1);
		cnt--;
		listShow();
	};

	function clearAsset() {
		cnt = 0;
		list = null;
		list = Array();
		var t = document.getElementById("iwapGrid2");
		var rowNum = t.rows.length;
		for (var i = 1; i < rowNum; i++) {
			t.deleteRow(i);
			rowNum--;
			i--;
			object[t.rows[i].cells[2].innerHTML] = parseFloat(0);
		}
		stoPrice = parseFloat(0);
		count = parseInt(0);
		$('#FAMOUNT').val(stoPrice);
	};

	function listShow() {
		var t = document.getElementById("iwapGrid2");
		var rowNum = t.rows.length;
		for (var i = 1; i < rowNum; i++) {
			t.deleteRow(i);
			rowNum--;
			i--;
		}
		stoPrice = parseFloat(0);
		count = parseInt(0);
		for (var i = 1; i <= cnt; i++) {
			object[list[i]['budget']] = parseFloat(0);
		}
		for (var i = 1; i <= cnt; i++) {
			var tablestr = "";
			var newstr = "";
			if (list[i]['budget'] == undefined) {
				list[i]['budget'] = "";
			}
			if (list[i]['remark'] == undefined) {
				list[i]['remark'] = "";
			}
			if (list[i]['spectype'] == undefined) {
				list[i]['spectype'] = "";
			}
			tablestr += "<tr>" + "<td style='cursor:pointer'>" + i + "</td>"
					+ "<td style='cursor:pointer'>" + list[i]['usetype']
					+ "</td>" + "<td style='cursor:pointer'>"
					+ list[i]['budget'] + "</td>"
					+ "<td style='cursor:pointer'>" + list[i]['kind'] + "</td>"
					+ "<td style='cursor:pointer'>" + list[i]['name'] + "</td>"
					+ "<td style='cursor:pointer'>" + list[i]['spectype']
					+ "</td>" + "<td style='cursor:pointer'>"
					+ list[i]['price'] + "</td>"
					+ "<td style='cursor:pointer'>" + list[i]['zcsl'] + "</td>"
					+ "<td style='cursor:pointer'>" + list[i]['isfa'] + "</td>"
					+ "<td style='cursor:pointer'>" + list[i]['remark']
					+ "</td>" + "<td>"
					+ "<a href='javaScript:void(0)' onclick='edit(" + i
					+ ")'>修改</a>" + "&nbsp;|&nbsp;"
					+ "<a href='javaScript:void(0)' onclick='delOne(" + i
					+ ")'>删除</a>" + "</td>" + "</tr>";
			$("#iwapGrid2").append(tablestr);
			var price = parseFloat(0);
			for (var j = 1; j <= list[i]['zcsl']; j++) {
				price += parseFloat(list[i]['price']);
				stoPrice += parseFloat(list[i]['price']);
			}
			if (object[list[i]['budget']] == 0) {
				count++;
			}
			object[list[i]['budget']] += price;
		}
		$('#FAMOUNT').val(stoPrice.toFixed(2));
	}

	function doSaveAsset() {
		if ($('input#name').val() == '') {
			alert("资产名称不能为空");
			return;
		}
		if ($('input#kind').val() == '') {
			alert("资产类别不能为空");
			return;
		}
		if ($('input#zcsl').val() == '') {
			alert("资产数量不能为空");
			return;
		}
		if ($('input#price').val() == '') {
			alert("资产单价不能为空");
			return;
		}
		var param = operForm.getData();
		if (isEdit == 0) {
			cnt++;
			list[cnt] = param;
		} else {
			list[isEdit] = param;
			isEdit = 0;
		}
		//console.info(list[cnt]); 
		listShow();
		$('#assetModal').find('.close').click();
	}

	//增加发票
	function addBill() {
		//每次点击增加按钮后：入库方式是否启用设成默认值
		condionForm = $.IWAP.Form({
			'id' : 'Conditions'
		});
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '5',
			'txcode' : 'insertStorage'
		};
		billGrid = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			form : condionForm,
			renderTo : 'billGrid'
		});
		var temp = document.getElementById("FCONTRACT").value;
		if (temp != "") {
			alert("只有清空了入库单关联的合同信息后，才能添加发票信息！");
			return;
		}
		$('#billModal').dialog('添加发票');
		$('#num').val(billCNT);
		document.getElementById("blist").innerHTML = billNUM;
	};

	//新建发票
	function newBill() {
		$('#addBill').dialog('新建发票');
		/* condionForm = $.IWAP.Form({
			'id' : 'Conditions'
		});
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '5',
			'txcode' : 'insertStorage'
		};
		billGrid = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : '${ctx}/iwap.ctrl',
			grid : 'grid',
			form : condionForm,
			renderTo : 'billGrid'
		}); */
	};

	function clearBill() {
		billCNT = 0;
		billList = null;
		billList = Array();
		billNUM = null;
		billNUM = Array();
		billFID = null;
		billFID = Array();
		$('#num').val(cnt);
		document.getElementById("list").innerHTML = listNbUM;
		var t = document.getElementById("iwapGrid1");
		var rowNum = t.rows.length;
		for (var i = 1; i < rowNum; i++) {
			t.deleteRow(i);
			rowNum--;
			i--;
		}
	};

	function doSaveBill() {
		console.info(billGrid.getCurrentRow());
		billCNT++;
		billList[billCNT] = billGrid.getCurrentRow();
		billFID[billCNT] = billGrid.getCurrentRow()['FID'];
		billNUM[billCNT] = billGrid.getCurrentRow()['FP_NUM'];
		//console.info(list[cnt]); 
		var tablestr = "";
		var newstr = "";
		/* if(list[cnt]['budget']==undefined){*/
		billList[billCNT]['BDOWN'] = "";
		/*}
		if(list[cnt]['remark']==undefined){
			list[cnt]['remark']="";
		}
		if(list[cnt]['spectype']==undefined){
			list[cnt]['spectype']="";
		} */

		tablestr += "<tr>" + "<td style='cursor:pointer'>" + billCNT + "</td>"
				+ "<td style='cursor:pointer'>" + billList[billCNT]['FP_NUM']
				+ "</td>" + "<td style='cursor:pointer'>"
				+ billList[billCNT]['FP_DATE'] + "</td>"
				+ "<td style='cursor:pointer'>" + billList[billCNT]['FP_MONEY']
				+ "</td>" + "<td style='cursor:pointer'>"
				+ billList[billCNT]['FMTYPE'] + "</td>"
				+ "<td style='cursor:pointer'>" + billList[billCNT]['FPEOPLE']
				+ "</td>" + "<td style='cursor:pointer'>"
				+ billList[billCNT]['FPROVIDER'] + "</td>"
				+ "<td style='cursor:pointer'>" + billList[billCNT]['BDOWN']
				+ "</td>" + "</tr>";
		$("#iwapGrid1").append(tablestr);
		$('#billModal').find('.close').click();
	};

	function doSaveNewBill() {

		$('#addBill').find('.close').click();
	};

	function assetConfirm() {
		if ($('#saveAll').hasClass('disa')) {
			alert("该入库单已入库");
			return;
		}
		if ($('#doStorage').hasClass('disa')) {
			alert("该入库单已入库");
			return;
		}
		if ($('#doCommit').hasClass('disa')) {
			alert("该入库单已入库");
			return;
		}

		if (cnt == 0) {
			alert("请先添加需要入库的资产信息！");
			return;
		}
		if ($('input#FRESPONSEDEPTNAME').val() == '') {
			alert("责任部门不能为空");
			return;
		}
		if ($('input#FRESPONSEPSNNAME').val() == '') {
			alert("责任人不能为空");
			return;
		}
		if ($('input#FBUDGETNO').val() == '') {
			if ($('input[name="radiobutton"]:checked').val() == "yes") {
				alert("关联动支单后,动支单号不能为空");
				return;
			}
		}
		if (billCNT == 0) {
			if (!confirm("还未添加发票，确定要入库吗？")) {
				return;
			}
		}
		if (Number($('input#FAMOUNT').val()) > 2000) {
			if ($('input#FBUDGETNO').val() == '') {
				alert("入库资产金额>2000必须关联动支单");
				return;
			}
		}
		//console.info(BudgetAmount);
		if (!$('input#FBUDGETNO').val() == '') {
			if ($('input#FAMOUNT').val() != BudgetAmount.toFixed(2)) {
				alert("入库资产金额与关联动支单不匹配");
				return;
			}
			var object1 = new Object();
			var bg = document.getElementById("budgetGrid1");
			var bgNum = bg.rows.length;
			if ((bgNum - 1) != count) {
				alert("入库资产信息与关联动支单不匹配");
				return;
			}
			for (var i = 1; i < bgNum; i++) {
				var tmp = bg.rows[i].cells[2].innerHTML;
				object1[tmp] = Number(bg.rows[i].cells[1].innerHTML);
				if (object[tmp].toFixed(2) != parseFloat(bg.rows[i].cells[1].innerHTML).toFixed(2)) {
					alert(tmp + " 金额与关联动支单不匹配");
					return;
				}
			}
		}
		$('#assetConfirm').dialog("资产入库确认");
		document.getElementById("stono").innerHTML = document
				.getElementById("FNO").value;
		document.getElementById("sign").innerHTML = document
				.getElementById("FSIGNID").value;
		document.getElementById("stomode").innerHTML = document
				.getElementById("FMODE").value;
		document.getElementById("time").innerHTML = document
				.getElementById("FCREATETIME").value;
		document.getElementById("resdept").innerHTML = document
				.getElementById("FRESPONSEDEPTNAME").value;
		document.getElementById("respsn").innerHTML = document
				.getElementById("FRESPONSEPSNNAME").value;
		document.getElementById("amount").innerHTML = document
				.getElementById("FAMOUNT").value;
		document.getElementById("supplier").innerHTML = document
				.getElementById("FSUPPLIER").value;
		document.getElementById("contractid").innerHTML = document
				.getElementById("FCONTRACT").value;
		document.getElementById("fplace").innerHTML = document
				.getElementById("FFZWZ").value;
		document.getElementById("fremark").innerHTML = document
				.getElementById("FREMARK").value;
		document.getElementById("budgetno").innerHTML = document
				.getElementById("FBUDGETNO").value;

		for (var i = 1; i <= cnt; i++) {
			var tablestr = "";
			var newstr = "";
			if (list[i]['budget'] == undefined) {
				list[i]['budget'] = "";
			}
			if (list[i]['remark'] == undefined) {
				list[i]['remark'] = "";
			}
			if (list[i]['spectype'] == undefined) {
				list[i]['spectype'] = "";
			}
			tablestr += "<tr>"
					+ "<td class='assetTable_content' style='cursor:pointer'>"
					+ list[i]['budget'] + "</td>"
					+ "<td class='assetTable_content' style='cursor:pointer'>"
					+ list[i]['kind'] + "</td>"
					+ "<td class='assetTable_content' style='cursor:pointer'>"
					+ list[i]['name'] + "</td>"
					+ "<td class='assetTable_content' style='cursor:pointer'>"
					+ list[i]['spectype'] + "</td>"
					+ "<td class='assetTable_content' style='cursor:pointer'>"
					+ list[i]['zcsl'] + "</td>"
					+ "<td class='assetTable_content' style='cursor:pointer'>"
					+ list[i]['price'] + "</td>"
					+ "<td class='assetTable_content' style='cursor:pointer'>"
					+ list[i]['remark'] + "</td>" + "</tr>";
			$("#assetTable").append(tablestr);
		}
		var tablestr = "<tr height='20px;'>" + "</tr>";
		$("#assetTable").append(tablestr);
		tablestr = "<tr>" + "<td class='assetTable_title'>发票号码</td>"
				+ "<td class='assetTable_title'>经办人</td>"
				+ "<td class='assetTable_title'>开票日期</td>"
				+ "<td class='assetTable_title'>发票金额</td>"
				+ "<td colspan='3' class='assetTable_title'>供应商</td>" + "</tr>";
		$("#assetTable").append(tablestr);
		for (var i = 1; i <= billCNT; i++) {
			var tablestr = "";
			var newstr = "";
			tablestr += "<tr>"
					+ "<td class='assetTable_content' style='cursor:pointer'>"
					+ billList[billCNT]['FP_NUM']
					+ "</td>"
					+ "<td class='assetTable_content' style='cursor:pointer'>"
					+ billList[billCNT]['FPEOPLE']
					+ "</td>"
					+ "<td class='assetTable_content' style='cursor:pointer'>"
					+ billList[billCNT]['FP_DATE']
					+ "</td>"
					+ "<td class='assetTable_content' style='cursor:pointer'>"
					+ billList[billCNT]['FP_MONEY']
					+ "</td>"
					+ "<td colspan='3' class='assetTable_content' style='cursor:pointer'>"
					+ billList[billCNT]['FPROVIDER'] + "</td>" + "</tr>";
			$("#assetTable").append(tablestr);
		}
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

	//保存
	function doSave() {
		if (!confirm("资产入库后，入库单将不能更改，是否确定入库？")) {
			return;
		}
		var FNO = document.getElementById("FNO").value;
		var param = storageForm.getData();
		//console.info(billFID);
		var extParam = {
			'option' : 'addInm',
			'txcode' : 'insertStorage',
			'actionId' : 'doBiz',
			'FNO' : FNO,
			'billFID' : billFID
		};
		$.IWAP.applyIf(param, extParam);
		$.IWAP.iwapRequest("iwap.ctrl", param, function(rs) {
			if (rs['header']['msg']) {
				return alert("保存失败:" + rs['header']['msg']);
			} else {
				//添加入库明细、资产卡片
				for (var i = 1; i <= cnt; i++) {
					var param = list[i];
					var extParam = {
						'option' : 'addInd',
						'txcode' : 'insertStorage',
						'actionId' : 'doBiz',
						'FNO' : FNO,
						'billFID' : billFID
					};
					$.IWAP.applyIf(param, extParam);
					$.IWAP.iwapRequest("iwap.ctrl", param, function(rs) {
						if (rs['header']['msg']) {
							return alert("保存失败:" + rs['header']['msg']);
						}
					}, function() {
						alert("保存失败!");
						return;
					});
				}
			}
		}, function() {
			alert("保存失败!");
			return;
		});
		alert("保存成功!");
		$('#assetConfirm').find('.close').click();
		document.getElementById("saveAll").setAttribute("class", "disa");
		document.getElementById("doStorage").setAttribute("class", "disa");
		document.getElementById("doCommit").setAttribute("class", "disa");
	};

	//清空
	function doReset() {
		operForm.reset();
		$('#zcsl').val('1');
		$('#currency').val('人民币');
		operForm.disabledById("currency");
	};

	//对话框
	function dialogModal(id) {
		$('#' + id).dialog();
	};
</script>
</html>