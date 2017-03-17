<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html style="height:100%;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/screen/comm/header.jsp"%>
<link rel="stylesheet" href="${ctx}/css/zTreeStyle.css">
<link href="${ctx}/css/font-awesomecss/font-awesome.css"
	rel="stylesheet" type="text/css">
<link href="${ctx}/css/font-awesomecss/font-awesome-ie7.min.css"
	rel="stylesheet" type="text/css">
<link href="${ctx}/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/style.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/css.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/iwapui-style.css" rel="stylesheet"
	type="text/css">
<!-- 公共 -->
<script src="${ctx}/js/jquery.min.js"></script>
<script src="${ctx}/js/UtilTool.js"></script>
<script src="${ctx}/js/bootstrap.min.js"></script>
<!-- 以下为组件JS -->
<script src="${ctx}/js/iwapui.js"></script>
<script src="${ctx}/js/iwapGrid.js"></script>
<script src="${ctx}/js/TextField.js"></script>
<script src="${ctx}/js/ButtonField.js"></script>
<script src="${ctx}/js/public.js"></script>
<!-- 对话框 -->
<script src="${ctx}/js/dialog.js"></script>
<!-- tree -->
<script type="text/javascript" src="${ctx}/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript"
	src="${ctx}/js/jquery.ztree.exhide-3.5.js"></script>
<script src="${ctx}/js/Tree.js"></script>
<!-- 文件上传 -->
<script type="text/javascript" src="${ctx}/js/FileUpload.js"></script>
<title>组织管理</title>
</head>
<body class="iwapui center_body" style="height: 100%;">
	<input type="hidden" id="_deptId" value="${userInfo.ORG_ID}" />
	<%-- <div class="col-md-12">
		<ul class="linelist">
			<li class="clearfix">
				<table>
					<tr>
						<td>
							<div class="inputbox pr" id="departmentid"></div>
						</td>
						<td>
							<div class="inputbox pr" id="deptName"></div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="selectbox">
								<label class="select_label">级别:</label> <select name="deptLevel"
									class="select_content" id="deptLevel">
									<option value="">--全部--</option>
								</select>
							</div>
						</td>
						<td>
							<div class="selectbox">
								<label class="select_label">状态:</label> <select name="state"
									class="select_content" id="state">
									<option value="">--全部--</option>
								</select>
							</div>
						</td>
					<tr>
				</table>
			</li>
		</ul>
	</div>
	<div class="search_btn">
		<a href="javaScript:void(0)" class="btn btn-primary mr30" id="btn_query">查询</a>
		<a href="javaScript:void(0)" class="btn btn-primary mr30" id="btn_clear">清空</a>
		<a href="${ctx}/iwap.ctrl?txcode=addDepartment" class="btn btn-primary" id="btn_add">新增</a>
		<a href="javaScript:void(0)" id="upfile" style="display: none;"></a>
	</div> 
	<hr>--%>
	<div class="col-md-12" style="height: 100%;">
		<br>
		<div class="col-md-4" style="height: 100%; border: 1px solid #a6bfe0;">
			<!-- 表格工具栏　开始 -->
			<div class="table_nav2">
				<form id="Conditions">
					<div class="inputbox pr" id="fuzzySearch" style="margin-top: 5px;">
					</div>
					<div class="inputbox">
						<div class="table_nav2" style="margin-top: -2px;">
							<a href="javaScript:void(0)" id="search"> <img alt=""
								src="../iwapabc/images/icon/search.png" /> 查询
							</a>
						</div>
					</div>
					<div class="inputbox">
						<div class="table_nav2" style="margin-top: -2px;">
							<a href="javaScript:void(0)" id="refresh"> <img alt=""
								src="../iwapabc/images/icon/refresh.png" /> 刷新
							</a>
						</div>
					</div>
				</form>
			</div>
			<!-- 表格工具栏　END -->
			<div class="table_box col-md-12" style="height:100%;">
				<br>
				<div style="height:80%; overflow-y:auto;" id="tree"></div>
				
			</div>
		</div>
		<div class="col-md-8" style="height: 100%; border: 1px solid #a6bfe0;">
			<!-- 表格工具栏　开始 -->
			<div class="table_nav2">
				<form id="pConditions">
					<div class="inputbox pr" id="personSearch" style="margin-top: 5px;">
					</div>
					<div class="inputbox">
						<div class="table_nav2" style="margin-top: -2px;">
							<a href="javaScript:void(0)" id="psearch"> <img alt=""
								src="../iwapabc/images/icon/search.png" /> 查询
							</a>
						</div>
					</div>
					<div class="inputbox">
						<div class="table_nav2" style="margin-top: -2px;">
							<a href="javaScript:void(0)" id="prefresh"> <img alt=""
								src="../iwapabc/images/icon/refresh.png" /> 刷新
							</a>
						</div>
					</div>
				</form>
			</div>
			<!-- 表格工具栏　END -->
			<div class="table_box" style="height:80%;">
				<table id="iwapGrid"
					class="mygrid table table-bordered table-striped table-hover"
					data-iwap="grid" data-iwap-id="" data-iwap-param=""
					data-iwap-pagination="true">
					<tr>
						<th data-grid-name="ACCT_ID" primary="primary" data-order="" style="width:45px;">选择<s><input
								id="radio1" name="radio1" type="radio"
								selectmulti="selectmulti" value="{{value}}"></s></th>
						<th data-grid-name="ROW_NUM">序号</th>
						<th data-grid-name="ACCT_NM" class="tl">名称</th>
						<th data-grid-name="ACCT_ID" class="tl">编码</th>
						<th data-grid-name="PSN_SEX" class="tl">性别</th>
						<th data-grid-name="PSN_CARDNO" class="tl">身份证号</th>
						<th data-grid-name="ORG_NM" class="tl">机构</th>
						<th data-grid-name="DEPT_NM" class="tl">部门</th>
						<th data-grid-name="PSN_TITLE" class="tl">岗位</th>
						<th data-grid-name="PSN_FNAME" class="tl">全路径名</th>
						<th data-grid-name="ACCT_ID" option="option" option-html=''><span>详细信息</span>
							<s><a href="javaScript:void(0)" id="detail"
								onclick="doDetail(this)"><img alt=""
									src="../iwapabc/images/icon/detail.png" /></a></s></th>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	var grid = null;
	var fuzzySearch = null;
	var deptName = null;
	var deptHelp = null;
	var dept_tree = null;
	var IDMark_A = "_a";
	var iwapGrid = null;
	parent.document.getElementById("title").value = document.title;
	$(document).ready(function() {
		/* 普通文本框 */
		fuzzySearch = $.IWAP.TextField({
			label : '模糊搜索',
			renderTo : 'fuzzySearch',
			width : '100px',
		});
		personSearch = $.IWAP.TextField({
			label : '模糊搜索',
			renderTo : 'personSearch',
			width : '100px',
		});

		/** 清空数据 */
		$("#refresh").click(function() {
			$("input:not([type=hidden])").val("");
			dataLoad('', '', '', '');
		});
		$("#prefresh").click(function() {
			$("input:not([type=hidden])").val("");
			doPerson("");
		});

		$("#deptHelp").click(function() {
			/* 初始化对话框 */
			deptHelp = $.IWAP.Dialog({
				title : '请选择机构',
				buttons : [ '查询', '确定' ],
				height : 400,
				width : 500,
				listeners : {
					afterClose : function() {//关闭后回调的函数
					}
				}
			});
		});

		$("#search").click(function() {
			dataLoad(fuzzySearch.getValue(), '', '', '');
		});
		$("#psearch").click(function() {
			var fData = {
				'actionId' : 'doBiz',
				'start' : '0',
				'limit' : '10',
				'txcode' : 'orgMg',
				'option' : 'person',
				'deptid' : "",
				'psearch' : personSearch.getValue()
			};
			iwapGrid = $.IWAP.iwapGrid({
				mode : 'server',
				fData : fData,
				Url : 'iwap.ctrl',
				grid : 'grid',
				renderTo : 'iwapGrid'
			});
		});

		dataLoad('', '', '', '');
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '10',
			'txcode' : 'orgMg',
			'option' : 'person',
			'deptid' : "",
			'psearch' : personSearch.getValue()
		};
		iwapGrid = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : 'iwap.ctrl',
			grid : 'grid',
			renderTo : 'iwapGrid'
		});

		/* 文件上传 */
		fileUpload = $.IWAP.FileUpload({
			label : '导入',
			isMultiSelect : false,
			beforeUpload : function() {
				return true
			}, //文件上传之前的触发事件，只有当返回值为true时，才会进行文件上传操作
			afterUpload : function() {
			},//文件上传之后的触发事件，不管上传是否成功都会执行
			url : 'upload/?sign=1',
			fileType : [ 'xlsx' ],
			size : 200, //允许上传的单个文件大小，是以byte为单位
			success : function(res) {
				//alert("文件上传成功");
				var json = JSON.parse(res.target.response);
				alert(json.msg);
				console.log(json.uploadfilelist);

			},//上传成功后的回调函数
			failed : function() {
				alert('上传失败');
			},//上传失败后的回调函数
			renderTo : 'upfile'
		});

		$("#upfile").change(function() {
			fileUpload.upload();
		});

	});

	function onClick(event, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj(treeId);
		zTree.expandNode(treeNode);
		doPerson(treeNode.id);
		//doEdit(treeNode.id);
		//dept_tree.Load(data,append);
	}

	function dataLoad(departmentid, deptName, deptLevel, state) {
		var callFn = function(rs) {
			//判断是否出错
			if (rs['header']['msg']) {
				alert("查询无结果:" + rs['header']['msg']);
			} else {
				$('#tree').html("");
				var zNodes = rs['body']['zNodes'];
				zNodes = eval("(" + zNodes + ")");
				if (zNodes.length <= 0) {
					alert("权限内无对应数据！");
				} else {
					dept_tree = $.IWAP.Tree({
						onClick : onClick,
						//addDiyDom:addDiyDom,
						disabled : false,
						hidden : false,
						value : [],
						checked : false,
						data : zNodes,
						mode : 'local',
						isOrg : true,
						/* btn2 : true,
						btn2Text : "修改",
						btn2style : "b_blue",
						btn3 : true,
						btn3Text : "删除",
						btn3style : "b_red", */
						renderTo : 'tree'
					});
					dept_tree.hiddenRmenu();
					$.IWAP.Tree.addbtn2 = function(btnId, treeId, treeNode) {
						doEdit(treeNode.id);
					}

					$.IWAP.Tree.addbtn3 = function(btnId, treeId, treeNode) {
						doRemove(treeNode.id);
					}
				}
			}
		}
		var form = {
			'departmentid' : departmentid,
			'deptName' : deptName,
			'deptLevel' : deptLevel,
			'state' : state,
			'_deptId' : $('#_deptId').val()
		};
		sendAjax(form, 'orgMg', 'doBiz', callFn);
	}

	function doEdit(deptid) {
		window.location = "${ctx}/iwap.ctrl?txcode=showDepartment&deptid="
				+ deptid;
	}

	function doRemove(deptid) {
		if (!confirm("确定要删除吗?请确定!"))
			return;
		var callFn = function(rs) {
			if (rs['header']['msg']) {
				alert("机构显示出错:" + rs['header']['msg']);
			} else {
				alert("删除成功");
			}
		}
		var form = {
			'deptid' : "" + deptid,
			'option' : 'remove'
		};

		sendAjax(form, 'orgMg', 'doBiz', callFn);
		window.location = "${ctx}/iwap.ctrl?txcode=orgMg&deptid=" + deptid;
	}

	window.onload = function() {
		var callFn = function(rs) {
			var deptLevel = rs['body'].Dept_Level;
			var state = rs['body'].Dept_State;

			/** 填充状态 */
			$.each(deptLevel, function() {
				$("<option/>").val(this.id).text(this.name).appendTo(
						"#deptLevel");
			});
			$.each(state, function() {
				$("<option/>").val(this.id).text(this.name).appendTo("#state");
			})
		}
		var form = {
			'dictNm' : 'Dept_Level,Dept_State'
		};
		sendAjax(form, 'dictionary', 1, callFn);
	}

	function doPerson(deptid) {
		var fData = {
			'actionId' : 'doBiz',
			'start' : '0',
			'limit' : '10',
			'txcode' : 'orgMg',
			'option' : 'person',
			'deptid' : deptid
		};
		iwapGrid = $.IWAP.iwapGrid({
			mode : 'server',
			fData : fData,
			Url : 'iwap.ctrl',
			grid : 'grid',
			renderTo : 'iwapGrid'
		});
	}
</script>
</html>
