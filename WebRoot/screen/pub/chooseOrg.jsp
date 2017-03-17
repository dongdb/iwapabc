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
<title>选择人员</title>
</head>
<body class="iwapui center_body" style="height: 100%;">
	<input type="hidden" id="_deptId" value="${userInfo.ORG_ID}" />
	<div class="col-md-12" style="height: 100%;">
		<br>
			<!-- 表格工具栏　开始 -->
			<div class="table_nav2 col-md-12">
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
			<div class="table_box col-md-12">
				<br>
				<div id="tree"></div>
			</div>
	</div>
</body>
<script type="text/javascript">
	var grid = null;
	var personSearch = null;
	var deptName = null;
	var deptHelp = null;
	var dept_tree = null;
	var IDMark_A = "_a";
	var url = window.location.toString();
	var type = url.split('?')[1].split('=')[2];
	$(document).ready(function() {
		/* 普通文本框 */
		personSearch = $.IWAP.TextField({
			label : '模糊搜索',
			renderTo : 'personSearch',
			width : '100px',
		});

		/** 清空数据 */
		$("#prefresh").click(function() {
			$("input:not([type=hidden])").val("");
			dataLoad('', '', '', '');
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

		$("#psearch").click(function() {
			dataLoad(personSearch.getValue(), '', '', '');
		});

		dataLoad('', '', '', '');
	});

	function onClick(event, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj(treeId);
		zTree.expandNode(treeNode);
		doPerson(treeNode.id,treeNode.pId,treeNode.isDept);
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
		sendAjax(form, 'chooseOrg', 'doBiz', callFn);
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

	function doPerson(deptid,pid,isDept) {
		if("n"==isDept){
			if(type=="user"){
				parent.document.getElementById("FDUTYPSNNAME").value = deptid;
				parent.document.getElementById("FDUTYDEPTNAME").value = pid;
				$('#dutyModal',window.parent.document).find('.close').click();
			} else {
				parent.document.getElementById("FRESPONSEPSNNAME").value = deptid;
				parent.document.getElementById("FRESPONSEDEPTNAME").value = pid;
				$('#resModal',window.parent.document).find('.close').click();
			}
			
		}
		//$('#dutyModal').find('.close').click();
	}
</script>
</html>
