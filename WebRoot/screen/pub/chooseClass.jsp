<%@ page language="java" import="com.nantian.iwap.web.WebEnv"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>资产分类</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<link href="${ctx}/css/TreeGrid.css" rel="stylesheet" type="text/css">
<!-- 公共 -->
<script src="${ctx}/js/jquery-1.3.2.min.js"></script>
<script src="${ctx}/js/UtilTool.js"></script>
<script src="${ctx}/js/bootstrap.min.js"></script>
<!-- 以下为组件JS -->
<script src="${ctx}/js/TextField.js"></script>
<script src="${ctx}/js/ButtonField.js"></script>
<script src="${ctx}/js/public.js"></script>
<!-- tree -->
<script type="text/javascript" src="${ctx}/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript"
	src="${ctx}/js/jquery.ztree.exhide-3.5.js"></script>
<script src="${ctx}/js/Tree.js"></script>
<!-- gridtree -->
<script type="text/javascript" src="${ctx}/js/TreeGrid.js"></script>

<script type="text/javascript">
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
	});
	function trans(){
		//要显示的字段  
		var fileds = "ac_node_type,ac_name,ac_code,ac_unit,ffinancecategory,fyslbname";
		//获取已转为符合treegrid的json的对象  
		var nodes = ConvertToTreeGridJson(
			(eval(gridtreedata3)), "id", "PID", fileds);
			//console.info(nodes);
			//json即为treegrid需要的json格式数据  
			var gridtreedata11 = JSON.stringify(nodes);
			var gridtreedata = eval(gridtreedata11);
			var config = {
				id : "tg1",
				width : "100%",
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
		//jQuery("#currentRow").val(id + ", " + index + ", " + TreeGrid.json2str(data));
	};
	/*
	 通过指定的方法来自定义栏数据
	 */
	function customCheckBox(row, col) {
		return "<input type='radio' id='radio1 'name='radio1'>";
	};

	function customOrgName(row, col) {
		var name = row[col.dataField] || "";
		return name;
	};

	function customLook(row, col) {
		return "<a href='' style='color:blue;'>查看</a>";
	};
	/*
	 展开、关闭所有节点。
	 isOpen=Y表示展开，isOpen=N表示关闭
	 */
	function expandAll(isOpen) {
		treeGrid.expandAll(isOpen);
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
				//$('#div1').empty(); ie报错，改用html
				$('#div1').html("");
				gridtreedata3 = rs['body']['zNodes'];
				//console.info(gridtreedata3);
			} else {
				alert(rs.header.msg);
			}
		}
		var form = {
			'menuName' : menuName
		};
		sendAjax(form, 'chooseClass', 'doBiz', callFn);
	};
	
	function doSaveClass(){
		var treeGridItem = treeGrid.getSelectedItem();
		if (treeGridItem == null) {
			alert("请选择分类节点！");
			return;
		}else{
			if("nkLeaf"!=treeGridItem.data.ac_node_type){
				alert("请选择分类节点！");
				return;
			}else{
				parent.document.getElementById("kind").value = treeGridItem.data.ac_name;
				parent.document.getElementById("budget").value = treeGridItem.data.fyslbname;
				parent.document.getElementById("kindno").value = treeGridItem.data.ac_code;
				$('#classModal',window.parent.document).find('.close').click();
			}
		}
	};
</script>
</head>
<body>
	<!-- 查询内容区域　开始 -->
	<div class="table_box">
		<div class="table_nav2">
			<div class="col-md-12">
				<a href="javaScript:void(0)" id="query" onclick="dataLoad('');trans();">
					<img alt="" src="../iwapabc/images/icon/refresh.png" /> 刷新
				</a> <a href="javaScript:void(0)" data-iwap-dialog="myModal" id="add"
					onclick="expandAll('Y')"> <img alt=""
					src="../iwapabc/images/icon/add.png" /> 展开所有
				</a> <a href="javaScript:void(0)" data-iwap-dialog="myModal" id="add"
					onclick="expandAll('N')"> <img alt=""
					src="../iwapabc/images/icon/add.png" /> 收缩所有
				</a>
				<div class="inputbox">
					<input name="menuName" type="text" data-iwap-xtype="TextField"
						id="menuName" class="input_text_1"
						onkeypress="if(event.keyCode==13) {doQuery();return false;}">
				</div>
				<a href="javaScript:void(0)" id="search" onclick="doQuery()">
					<img alt="" src="../iwapabc/images/icon/search.png" /> 搜索
				</a>
			</div>
		</div>
	</div>
	<div class="col-md-12" style="height: 265px; overflow-y: auto;">
		<div id="div1" style="margin-top: 7px;"></div>
	</div>
	<div class="col-md-12">
		<h5>说明：请选择分类节点。</h5>
		<div class="table_nav2" style="border: 1px solid white;margin-left:350px;">
			<a href="javaScript:void(0)" id="save" onclick="doSaveClass()">确定</a>
		</div>
	</div>
	
</body>
</html>
