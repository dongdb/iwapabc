<%@page import="com.nantian.iwap.common.util.DateUtil"%>
<%@ page language="java" import="com.nantian.iwap.web.WebEnv"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>资产分类</title>
<meta name="description" content="">
<!-- 一般查询页面所引入的样式文件 -->
<link href="${ctx}/css/font-awesomecss/font-awesome.css"
	rel="stylesheet" type="text/css">
<link href="${ctx}/css/font-awesomecss/font-awesome-ie7.min.css"
	rel="stylesheet" type="text/css">
<link href="${ctx}/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/css.css" rel="stylesheet">
<link href="${ctx}/css/style.css" rel="stylesheet">
<link href="${ctx}/css/iwapui-style.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/zTreeStyle.css" rel="stylesheet">
<link href="${ctx}/css/TreeGrid.css" rel="stylesheet" type="text/css">
<!-- JQ必须在最JS上面 -->
<script src="${ctx}/js/jquery.min.js"></script>
<script src="${ctx}/js/jquery-1.3.2.min.js"></script>
<script src="${ctx}/js/UtilTool.js"></script>
<script src="${ctx}/js/Form.js"></script>
<script src="${ctx}/js/TextField.js"></script>
<script src="${ctx}/js/ListField.js"></script>
<script src="${ctx}/js/ButtonField.js"></script>
<script type="text/javascript" src="${ctx}/js/iwapGrid.js"></script>
<script type="text/javascript" src="${ctx}/js/Grid.js"></script>
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
<script type="text/javascript" src="${ctx}/js/jquery.ztree.exhide-3.5.js"></script>
<script type="text/javascript" src="${ctx}/js/Tree.js"></script>
<script type="text/javascript" src="${ctx}/js/TreeGrid.js"></script>
</head>
<body class="iwapui center_body">
	<!-- 对话框开始 -->
	<div id="divDialog" class="divDialog">
		<div class="bg"></div>
		<div class="dialog" id="myModal" style="width: 500px;height:300px;">
			<div class="dialog-header">
				<button type="button" id="btn_iwap-gen-10"
				data-dialog-hidden="true" class="close">
					<span>×</span>
				</button>
				<h4 class="modal-title">编辑</h4>
			</div>
			<div class="modal-body">
				<form method="post" onsubmit="return false" id="dialogarea">
					<!-- form开始 -->
					<div class="col-md-12">
						<div class="inputbox">
							<span>名称：</span><input name="acname" type="text"
								data-iwap-xtype="TextField" id="acname" class="input_text_1"
								value="">
						</div>
						<div class="inputbox">
							<span>编码：</span><input name="code" type="text"
								data-iwap-xtype="TextField" id="code" class="input_text_1"
								value="">
						</div>
						<div class="inputbox">
							<span>资产单位：</span><input name="unit" type="text"
								data-iwap-xtype="TextField" id="unit" class="input_text_1"
								value="">
						</div>
						<div class="inputbox">
							<span>财务类型：</span><select data-iwap-xtype="ListField" name="cwlx"
								class="select_content" id="cwlx">
							</select>
						</div>
						<div class="inputbox">
							<span>预算类别：</span><select data-iwap-xtype="ListField" name="yslb"
								class="select_content" id="yslb">
								<option value=""></option>
							</select>
						</div>
						<div class="inputbox">
							<span>预算单价：</span><input name="bp" type="text"
								data-iwap-xtype="TextField" id="bp" class="input_text_1"
								value="">
						</div>
						<div class="inputbox">
							<span>描述：</span>
							<textarea id="desc" name="desc" data-iwap-xtype="TextField"
							style="width: 335px; height: 100px;
							max-width:335px;max-height:100px"></textarea>
						</div>
					</div>
				</form>
				<!-- form END -->
				<div class="col-md-offset-4">
					<div class="table_nav2">
						<a href="javaScript:void(0)" id="save" onclick="doSave()">
							<img alt="" src="../iwapabc/images/icon/save.png"/> 保存</a>
						<a href="javaScript:void(0)" id="reset" onclick="doReset();">
							<img alt="" src="../iwapabc/images/icon/refresh.png"/> 还原</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 对话框END -->

	<!-- 查询内容区域　开始 -->

	<div class="table_box">
		<!-- 表格工具栏　开始 -->
		<div class="table_nav2">
			<div class="col-md-9">
				<a id="selectmultidel" class="" onclick="del()"
					href="javaScript:void(0)"> <img alt=""
					src="../iwapabc/images/icon/delete.png" /> 删除
				</a> <a href="javaScript:void(0)" id="query"
					onclick="dataLoad('');trans();"> <img alt=""
					src="../iwapabc/images/icon/refresh.png" /> 刷新
				</a> <a href="javaScript:void(0)" id="add" onclick="add()"> <img
					alt="" src="../iwapabc/images/icon/add.png" /> 新建子
				</a> <a href="javaScript:void(0)" id="add" onclick="add()"> <img
					alt="" src="../iwapabc/images/icon/add.png" /> 新建同级
				</a> <a href="javaScript:void(0)" id="add" onclick="add()"> <img
					alt="" src="../iwapabc/images/icon/add.png" /> 新建根
				</a> <a href="javaScript:void(0)" id="add" onclick="expandThis('Y')">
					<img alt="" src="../iwapabc/images/icon/add.png" /> 展开当前
				</a> <a href="javaScript:void(0)" id="add" onclick="expandAll('Y')">
					<img alt="" src="../iwapabc/images/icon/add.png" /> 展开所有
				</a> <a href="javaScript:void(0)" id="add" onclick="expandThis('N')">
					<img alt="" src="../iwapabc/images/icon/add.png" /> 收缩当前
				</a> <a href="javaScript:void(0)" id="add" onclick="expandAll('N')">
					<img alt="" src="../iwapabc/images/icon/add.png" /> 收缩所有
				</a> <a href="javaScript:void(0)" id="excel" onclick="printexcel()"> <img alt=""
					src="../iwapabc/images/icon/excel.png" /> 导出数据
				</a>
			</div>
			<div class="col-md-3">
				<form id="Conditions">
					<div class="inputbox">
						<input name="menuName" type="text" data-iwap-xtype="TextField"
							id="menuName" class="input_text_1"
							onkeypress="if(event.keyCode==13) {doQuery();return false;}">
					</div>
					<a href="javaScript:void(0)" id="search" onclick="doQuery()"> <img
						alt="" src="../iwapabc/images/icon/search.png" /> 搜索
					</a>
				</form>
			</div>
		</div>
	</div>
	<div class="col-md-12" style="height: 520px; overflow-y: auto;">
		<div id="div1" style="margin-top: 7px;"></div>
	</div>
</body>
<script type="text/javascript">
	var param={};
	/*将一般的JSON格式转为EasyUI TreeGrid树控件的JSON格式 
	 * @param rows:json数据对象 
	 * @param idFieldName:表id的字段名 
	 * @param pidFieldName:表父级id的字段名 
	 * @param fileds:要显示的字段,多个字段用逗号分隔 
	 */
	function ConvertToTreeGridJson(rows, idFieldName, pidFieldName, fileds) {
		function exists(rows, ParentId) {
			for (var i = 0; i < rows.length; i++) {
				if (rows[i][idFieldName] == ParentId)
					return true;
			}
			return false;
		}
		var nodes = [];
		// get the top level nodes  
		for (var i = 0; i < rows.length; i++) {
			var row = rows[i];
			if (!exists(rows, row[pidFieldName])) {
				var data = {
					id : row[idFieldName]
				}
				var arrFiled = fileds.split(",");
				for (var j = 0; j < arrFiled.length; j++) {
					if (arrFiled[j] != idFieldName)
						data[arrFiled[j]] = row[arrFiled[j]];
				}
				nodes.push(data);
			}
		}

		var toDo = [];
		for (var i = 0; i < nodes.length; i++) {
			toDo.push(nodes[i]);
		}
		while (toDo.length) {
			var node = toDo.shift(); // the parent node  
			// get the children nodes  
			for (var i = 0; i < rows.length; i++) {
				var row = rows[i];
				if (row[pidFieldName] == node.id) {
					var child = {
						id : row[idFieldName]
					};
					var arrFiled = fileds.split(",");
					for (var j = 0; j < arrFiled.length; j++) {
						if (arrFiled[j] != idFieldName) {
							child[arrFiled[j]] = row[arrFiled[j]];
						}
					}
					if (node.children) {
						node.children.push(child);
					} else {
						node.children = [ child ];
					}
					toDo.push(child);
				}
			}
		}
		return nodes;
	};
	parent.document.getElementById("title").value = document.title;
	var menu_tree = null;
	var gridtreedata3 = [ {} ];
	//要显示的字段  
	//var fileds = "name,code";  
	//获取已转为符合treegrid的json的对象  
	//var nodes = ConvertToTreeGridJson(gridtreedata1, "id", "PID", fileds);  
	//json即为treegrid需要的json格式数据  
	//var gridtreedata = JSON.stringify(nodes);  
	//console.info(gridtreedata);
	var treeGrid = null;
	$(document).ready(function() {
		dataLoad($('#menuName').val());
		trans();
		//console.info(gridtreedata3);
		//var gridtreedata33=eval(gridtreedata3);
		initSelectKV('{"cwlx":"FFINANCECATEGORY","yslb":"BTYPE"}');
	});
	function trans() {
		//要显示的字段  
		var fileds = "ac_node_type,ac_name,ac_code,ac_unit,ffinancecategory,fyslb,fyslbname,ac_bp,ac_description";
		//获取已转为符合treegrid的json的对象  
		var nodes = ConvertToTreeGridJson((eval(gridtreedata3)), "id", "PID",
				fileds);
		//console.info(nodes);
		//json即为treegrid需要的json格式数据  
		var gridtreedata11 = JSON.stringify(nodes);
		var gridtreedata = eval(gridtreedata11);
		//console.info(gridtreedata);

		var config = {
			id : "tg1",
			width : "95%",
			renderTo : "div1",
			headerAlign : "left",
			headerHeight : "30",
			dataAlign : "left",
			indentation : "20",
			folderOpenIcon : "images/folderOpen.gif",
			folderCloseIcon : "images/folderClose.gif",
			defaultLeafIcon : "images/defaultLeaf.gif",
			hoverRowBackground : "false",
			folderColumnIndex : "1",
			itemClick : "itemClickEvent",
			expandLayer : "1",
			columns : [ {
				headerText : "",
				headerAlign : "center",
				dataAlign : "center",
				width : "20",
				handler : "customCheckBox"
			}, {
				headerText : "名称",
				dataField : "ac_name",
				headerAlign : "center",
				handler : "customOrgName"
			}, {
				headerText : "编码",
				dataField : "ac_code",
				headerAlign : "center",
				dataAlign : "center",
				width : "100"
			}, {
				headerText : "资产单位",
				dataField : "ac_unit",
				headerAlign : "center",
				dataAlign : "center",
				width : "100"
			}, {
				headerText : "财务类型",
				dataField : "ffinancecategory",
				headerAlign : "center",
				dataAlign : "center",
				width : "110"
			}, {
				headerText : "预算类别名称",
				dataField : "fyslbname",
				headerAlign : "center",
				dataAlign : "center",
				width : "100"
			}, {
				headerText : "预算单价",
				dataField : "ac_bp",
				headerAlign : "center",
				dataAlign : "center",
				width : "100"
			}, {
				headerText : "描述",
				dataField : "ac_description",
				headerAlign : "center",
				dataAlign : "center",
				width : "100"
			}, {
				headerText : "编辑",
				headerAlign : "center",
				dataAlign : "center",
				width : "50",
				handler : "customLook"
			} ],
			data : gridtreedata
		};
		//console.info(config);
		treeGrid = new TreeGrid(config);
		treeGrid.show();
	};

	/*
	单击数据行后触发该事件
	id：行的id
	index：行的索引。
	data：json格式的行数据对象。
	 */
	function itemClickEvent(id, index, data) {
		//jQuery("#fuzzySearch").val(id + ", " + index + ", " + TreeGrid.json2str(data));
		//console.info(data["ac_code"]);
	};

	/*
	 通过指定的方法来自定义栏数据
	 */
	function customCheckBox(row, col) {
		return "<input type='checkbox'>";
	};

	function customOrgName(row, col) {
		var name = row[col.dataField] || "";
		return name;
	};

	function customLook(row, col) {
		return "<a href='javaScript:void(0)' onclick='doEdit()'  style='color:blue;'>"
				+ "<img alt='' src='../iwapabc/images/icon/detail.png' />"
				+ "</a>";
	};
	//创建一个组件对象

	/*
	 展开、关闭所有节点。
	 isOpen=Y表示展开，isOpen=N表示关闭
	 */
	function expandAll(isOpen) {
		treeGrid.expandAll(isOpen);
	};

	function expandThis(isOpen) {
		//var trid = this.trid || this.getAttribute("trid");
		//console.info("------------trid:"+trid);
		var trid = treeGrid.getSelectedItem().id;
		showHiddenNode(trid, isOpen);
	};

	/*
	 取得当前选中的行，方法返回TreeGridItem对象
	 */
	function selectedItem() {
		var treeGridItem = treeGrid.getSelectedItem();
		if (treeGridItem != null) {
			//获取数据行属性值
			//alert(treeGridItem.id + ", " + treeGridItem.index + ", " + treeGridItem.data.name);

			//获取父数据行
			var parent = treeGridItem.getParent();
			if (parent != null) {
				//jQuery("#currentRow").val(parent.data.name);
			}

			//获取子数据行集
			var children = treeGridItem.getChildren();
			if (children != null && children.length > 0) {
				//jQuery("#currentRow").val(children[0].data.name);
			}
		}
	};

	function doQuery() {
		dataLoad($('#menuName').val());
		trans();
	};

	function onClick(event, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj(treeId);
		zTree.expandNode(treeNode);
	};

	function dataLoad(menuName) {
		var callFn = function(rs) {
			if (!rs.header.msg) {
				//$('#tree').empty(); ie报错，改用html
				$('#div1').html("");
				gridtreedata3 = rs['body']['zNodes'];
				//	console.info(gridtreedata3);

			} else {
				alert(rs.header.msg);
			}
		}
		var form = {
			'menuName' : '%' + menuName + '%'
		};
		sendAjax(form, 'assetClassify', 'doBiz', callFn);
	};

	function doEdit() {
		var t = treeGrid.getSelectedItem();
		$('#unit').attr("disabled",false);
		$('#bp').attr("disabled",false);
		$('#desc').attr("disabled",false);
		$('select#cwlx').attr("disabled",false);
		$('select#yslb').attr("disabled",false);
		$('#code').val(t.data.ac_code);
		$('#acname').val(t.data.ac_name);
		$('#unit').val(t.data.ac_unit);
		$('#bp').val(t.data.ac_bp);
		$('#desc').val(t.data.ac_description);
		$('select#cwlx').val(t.data.ffinancecategory);
		$('select#yslb').val(t.data.fyslb);
		$('#myModal').dialog('编辑');
		if("nkLeaf"!=t.data.ac_node_type){
			$('#unit').attr("disabled",true);
			$('#bp').attr("disabled",true);
			$('#desc').attr("disabled",true);
			$('select#cwlx').attr("disabled",true);
			$('select#yslb').attr("disabled",true);
		}
		param={	'node_type':t.data.ac_node_type,
				'acname':t.data.ac_name,
				'code':t.data.ac_code,
				'unit':t.data.ac_unit,
				'fid':t.data.id,
				'fyslb':t.data.fyslb,
				'fyslbname':t.data.fyslbname,
				'cwlx':t.data.ffinancecategory,
				'bp':t.data.ac_bp,
				'desc':t.data.ac_description 
			  };
	};
	
	function doSave(){
		param['acname']=$('#acname').val();
		param['code']=$('#code').val();
		param['unit']=$('#unit').val();
		param['fyslb']=$('select#yslb').val();
		param['cwlx']=$('select#cwlx').val();
		param['bp']=$('#bp').val();
		param['desc']=$('#desc').val();
		var extParam={'option':'save','txcode':'assetClassify','actionId':'doBiz'};	
		if($('input#acname').val()==''){
			alert("名称不能为空");
			return ;
		}
		if($('input#code').val()==''){
			alert("编码不能为空");
			return ;
		}
		$.IWAP.applyIf(param,extParam);
		$.IWAP.iwapRequest("iwap.ctrl",param,function(rs){
			 $('#myModal').find('.close').click();
			 if (rs['header']['msg']) {
			 	return alert("保存失败:"+rs['header']['msg']);
			 }else{
			 	alert("保存成功");
			 	dataLoad('');trans();
			 }
		 },function(){
			 alert("保存失败!");
		 });
	};
	
	function doReset(){
		$('#code').val(param['code']);
		$('#acname').val(param['acname']);
		$('#unit').val(param['unit']);
		$('#bp').val(param['bp']);
		$('#desc').val(param['desc']);
		$('select#cwlx').val(param['cwlx']);
		$('select#yslb').val(param['fyslb']);
	};

	function doRemove(module_id) {
		if (!confirm("确定要删除吗?请确定!"))
			return;
		var callFn = function(rs) {
			if (!rs.header.msg) {
				doQuery();
				alert("删除成功");
			} else {
				alert(rs.header.msg);
			}
		}
		var form = {
			'module_id' : "" + module_id,
			'option' : 'remove'
		};

		sendAjax(form, 'assetClassify', 'doBiz', callFn);
	};
	
	//导出excel
	function printexcel() {
		$('#div1').tableExport({
			type : 'excel',
			escape : 'false'
		});
	}
</script>

</html>
