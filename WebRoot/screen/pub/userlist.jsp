<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>用户-查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 一般查询页面所引入的样式/js文件 -->
<link href="${ctx}/css/font-awesomecss/font-awesome.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/font-awesomecss/font-awesome-ie7.min.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/jquery.dataTables.css" rel="stylesheet" type="text/css">
<link href="${ctx}/css/bootstrap.css" rel="stylesheet" type="text/css">
<script src="${ctx}/js/jquery.min.js"></script>
<!-- dataTables -->
<script src="${ctx}/js/jquery.dataTables.js"></script>
<script src="${ctx}/js/UtilTool.js"></script>
<script src="${ctx}/js/Grid.js"></script>
<link href="${ctx}/css/style.css" rel="stylesheet" type="text/css">
<!-- 文本框 -->
<link href="${ctx}/css/css.css" rel="stylesheet">
<link href="${ctx}/css/iwapui-style.css" rel="stylesheet">
<script src="${ctx}/js/TextField.js"></script>
<!-- 对话框 -->
<script src="${ctx}/js/bootstrap.min.js"></script>
<script src="${ctx}/js/ButtonField.js"></script>
<script src="${ctx}/js/public.js"></script>
<script src="${ctx}/js/jquery.cookie.js"></script>
<style type="text/css">
.deptlist_Table table{width: 100%;}
body{width: 100%;}
body.center_body{padding-top: 15px; margin-bottom: 130px;}
</style>
<script type="text/javascript">
	var grid = null;
	var acct_id = null;
	var acct_nm = null;
	var org_id = null;
	var org_nm = null;
    var _table = null;


    
 
	$(document).ready(function() {
		getUserValue=function(acct_id,acct_nm,org_id,org_nm){
				document.getElementById("acct_id_input").value=acct_id;
				document.getElementById("org_id_input").value=org_id;
				document.getElementById("org_nm_input").value=org_nm;
			
		}
		returnDept=function(){
			var acct_id_input = document.getElementById("acct_id_input").value;
			var org_id_input = document.getElementById("org_id_input").value;
			var org_nm_input = document.getElementById("org_nm_input").value;
			if(acct_id_input==""){
			alert("请选择用户");
			return;
			}
			window.parent.document.getElementsByName("acct_id")[0].value=acct_id_input;
			window.parent.document.getElementsByName("org_id")[0].value=org_id_input;
			window.parent.document.getElementsByName("org_nm")[0].value=org_nm_input;
			var win=$(window.parent.document);
			var myModa2=win.find("#myModa2");
			
			//确定所属用户后，清空查询条件后并查询《选择所属用户》对话框
			setTimeout(function(){
					$("input:not([type=hidden])").val("");
					doQuery();
			});
			myModa2.find(".close").click();
			
		}

		/* 普通文本框 */
		acct_id = $.IWAP.TextField({
		    width:'100px',
			label:'用户编号',
			renderTo:'acct_id'
		});
		
		acct_nm = $.IWAP.TextField({
		    width:'100px',
			label:'用户名称',
			renderTo:'acct_nm'
		});	
		org_id = $.IWAP.TextField({
		    width:'100px',
			label:'机构编号',
			renderTo:'org_id'
		});
		
		org_nm = $.IWAP.TextField({
		    width:'100px',
			label:'机构名称',
			renderTo:'org_nm'
		});
		/*查询表格初始化*/
		
		grid = $.IWAP.Grid({
			'txcode':'usertList',
			'param':{'acct_id':acct_id.getValue(),'acct_nm':$('#acct_nm').val(),
				'org_id':org_id.getValue(),'org_nm':$('#org_nm').val(),'_deptId':$('#_deptId').val(),
				'actionId':'doBiz'},
			'beforeRequest':function(){//请求前的回调函数
				
			},
			'beforeSuccess':function(){//请求成功前的回调函数
				
			},
			'sUrl':'iwap.ctrl',
			//'width':'100%',
			'bAutoWidth': false,
			'bStateSave':true,
			lazyLoad:false,
			ordering:false,
			renderTo:'userlist_Table',
			"aoColumns":[
			   {"mData":"ACCT_ID",title:'用户编号'},
			   {"mData":"ACCT_NM",title:'用户名称',defaultContent:""},
	  		   {"mData":"ORG_ID",title:'机构编号'},
			   {"mData":"ORG_NM",title:'机构名称',defaultContent:""},
	  		   {"mData":"OPER",title:'选择',
				"mRender":function(data,type,full){
					return ['<input type="radio"  name="radid" onClick="getUserValue(\''+full.ACCT_ID+'\',\''+full.ACCT_NM+'\',\''+full.ORG_ID+'\',\''+full.ORG_NM+'\')">'].join('');}   
			   }
			]
		});
		
		
		
		/** 清空数据 */
		$("#btn_clear").click(function(){
			$("input:not([type=hidden])").val("");
		});
		
		//获取table对象
		_table = grid.getGrid();
	});
	
	function setString(str, len) {  
	    var strlen = 0;  
	    var s = "";  
	    for (var i = 0; i < str.length; i++) {  
	        if (str.charCodeAt(i) > 128) {  
	            strlen += 2;  
	        } else {  
	            strlen++;  
	        }  
	        s += str.charAt(i);  
	        if (strlen >= len) {  
	            return s+"...";  
	        }  
	    }  
	    return s;  
	}
	
	/** 查询操作员 */
	function doQuery(){
		var api = new jQuery.fn.dataTable.Api(_table.fnSettings());
		 var params = {'acct_id':acct_id.getValue(),'acct_nm':$('#acct_nm').val(),
					   'org_id':org_id.getValue(),'org_nm':$('#org_nm').val(),'_deptId':$('#_deptId').val(),
				       'actionId':'doBiz'}
		 _table.fnSettings().ajax.data=params;
        api.ajax.reload();  
	}


</script>
</head>
<body class="iwapui center_body">
<input type="hidden" value="${userInfo.ACCT_ID}" id="_roleid">
<input type="hidden" value="${userInfo.ORG_ID}" id="_deptId">
<div class="">
	<ul class="linelist">
		<li class="clearfix">
	  			<div width="50px" class="inputbox pr" id="acct_id"></div>
	  			<div class="inputbox pr" id="acct_nm"></div>
	  			<div width="50px" class="inputbox pr" id="org_id"></div>
	  			<div class="inputbox pr" id="org_nm"></div>
		</li>
	</ul>
</div>
<div class="tc">
	<a href="javaScript:void(0)" class="btn btn-primary mr30" onclick="doQuery()">查询</a>
	<a href="javaScript:void(0)" class="btn btn-primary mr30" id="btn_clear">清空</a>
</div>
<div>
		<div class="fr mb5"><a id="s_ture" href="javaScript:void(0)" class="btn btn-success w80" onclick="returnDept()">确定</a></div>
		<input id="acct_id_input" type="hidden" style="display:none;">
		<input id="org_id_input" type="hidden" style="display:none;">
		<input id="org_nm_input" type="hidden" style="display:none;">
</div> 
<div class="table_box">
	<div id="userlist_Table"></div>
</div>
</body>
</html>
