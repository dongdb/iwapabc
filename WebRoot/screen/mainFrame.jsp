<%@page import="com.nantian.iwap.common.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IWAP5.0</title>
<meta name="description" content="">
<meta name="keywords" content="">
<link href="<%=request.getContextPath() %>/css/font-awesomecss/font-awesome.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath() %>/css/font-awesomecss/font-awesome-ie7.min.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath() %>/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath() %>/css/iwapui-style.css" rel="stylesheet" type="text/css">
<script src="<%=request.getContextPath() %>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath() %>/js/UtilTool.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.ztree.exhide-3.5.js"></script>
<script src="<%=request.getContextPath() %>/js/Menu.js"></script>
<script src="<%=request.getContextPath() %>/js/MenuField3.js"></script>

<style type="text/css">
/*样式写在此处是因为此页面需要BODY高度单独设为高度百分百*/
 body,html{height: 100%; overflow-y: hidden;}
.changeBg{  background-image: url("../images/select-bg.png");  }
</style>
</head>
<body class="iwapui">
<div id="head" class="head clearfix">
    <div class="Hleft_box">
       	<div class="clearfix">
       		<div class="logo"></div>
       		<div class="logotext">实物资产管理系统</div>
       	</div>       	
    </div>
    <div class="Hright_box clearfix">
    	<div class="h_top">
    		<a class="date" id="date" title="<%=DateUtil.getCurrentDate("yyyy-MM-dd") %>"><i></i>
    			<img alt="" src="../iwapabc/images/icon/calendar.png"/></a>
    		<a href="javascript:void(0)" class="mdfPwd" onclick="mdfPwd()" title="修改密码"><i></i><img alt="" src="../iwapabc/images/icon/key.png"/></a>
    		<a href="#" class="changemenu" title="换菜单"><i></i><img alt="" src="../iwapabc/images/icon/menu.png"/></a>
    		<a href="javascript:void(0)" class="home" onclick="getHome()" title="首页"><i></i><img alt="" src="../iwapabc/images/icon/home.png"/></a>
    		<a href="<%=request.getContextPath() %>/screen/loginOut.jsp" class="exit_on" title="退出"><i></i><img alt="" src="../iwapabc/images/icon/exit.png"/></a>
    	</div>
    	<div class="h_bottom">
    	  <i><%=DateUtil.getCurrentDate("yyyy-MM-dd") %></i>
          <i>机构号：${userInfo.ORG_ID}</i>
          <i>用户名：${userInfo.ACCT_NM}</i>
      	</div>
    </div> 
    <div class="head_bottom">
    	<input id="title" disabled="disabled" value="首页" type="text">
    </div>    
</div>
<div class="menubar menuflag" id="menubar">
</div>
<div class="center">
	<div class="left_box" id="left_box">
		<div class="left_bottom" id="left_bottom">
			<button title="隐藏" id="hide" onclick="hide()"></button>
		</div>
	</div>
	<div class="right_box">
		<iframe name="main"  id="main" width="100%" height="100%"  scrolling="auto" frameborder="0" src="./screen/system/homePage.jsp"></iframe>
	</div>
</div>
<div class="bottom Hright_box">
	  
</div>
</body>
<SCRIPT type="text/javascript">
var flag=0;
function getHome(){
	$("#main").attr('src','./screen/system/homePage.jsp');
}
function mdfPwd(){
	$("#main").attr('src','<%=request.getContextPath()%>/iwap.ctrl?txcode=modifyPwd');
}
function hide(){
	if (flag==0){
		var temp=document.getElementById("hide");
		//temp.style.width="20px";
		temp.style.left="5px";
		$("#hide").attr("title","展开");
		temp.style.backgroundImage="url(<%=request.getContextPath()%>/images/icon/hide_right.png)";
		document.getElementById("left_box").style.width="20px";
		flag=1;
	}else{
		var temp=document.getElementById("hide");
		//temp.style.width="180px";
		temp.style.left="165px";
		$("#hide").attr("title","隐藏");
		temp.style.backgroundImage="url(<%=request.getContextPath()%>/images/icon/hide_left.png)";
		document.getElementById("left_box").style.width="180px";
		flag=0;
	}
}
  $(document).ready(function(){	  
	  $.IWAP.iwapRequest("iwap.ctrl",{txcode:"getUserMenu"},
			  function(rst){
		  		if(rst["header"]["retcode"]<1){//存在业务错误
		  			alert(rst["header"]["msg"]);
		  		}else{
		  			var data=rst["body"]["rows"];
		  			var  menu=$.IWAP.Menu({
			              disabled:false,//禁用菜单 默认为false
			              hidden:false,//隐藏菜单 默认为false
			              items:data,
			              data: {
			            	  key:{
				            	  children:'child',
				            	  name:'moduleNm'
				              },
			                  simpleData: {
			                      enable: true,
			                      idKey:'moduleId',
			                      pIdKey:'pModuleId',
			                      rootPId:0
			                  }
			              },//初始化菜单数据 
			              
			              callback:{
			            	  onClick:function(event,id,data,level){
			            		  if(data['moduleType']=="1"){
			            			  if(data["moduleUrl"]){
			            				  $("#main").attr("src",data["moduleUrl"]);
			            			  }else{
			            				  $("#main").attr("src","iwap.ctrl?txcode="+data['moduleOpCode']);
			            			  }
			            		  }
			            	  }
			              },
			              renderTo:'left_box'
			            });
					var flag=1;
				    $('.changemenu').click(function() {
				        if (flag==0) {
				            //树向菜单
				            $('.menubar').html('');
				            $('.left_box').show();
				            var  menu=$.IWAP.Menu({
				              disabled:false,                            //禁用菜单 默认为false
				              hidden:false,                               //隐藏菜单 默认为false
				              items:data,
				              data: {
				            	  key:{
					            	  children:'child',
					            	  name:'moduleNm'
					              },
				                  simpleData: {
				                      enable: true,
				                      idKey:'moduleId',
				                      pIdKey:'pModuleId',
				                      rootPId:0
				                  }
				              },//初始化菜单数据 
				              callback:{
				            	  onClick:function(event,id,data,level){
				            		  if(data['moduleType']=="1"){
				            			  if(data["moduleUrl"]){
				            				  $("#main").attr("src",data["moduleUrl"]);
				            			  }else{
				            				  $("#main").attr("src","iwap.ctrl?txcode="+data['moduleOpCode']);
				            			  }
				            			  
				            		  }
				            	  }
				              },
				              renderTo:'left_box'
				            });
				            flag=1;
				        }else{
				            //横向菜单
				            $('.left_box').html('');
				            $('.left_box').hide();
				            $('.menubar').html('');
				            var menu2=null;
				            menu2=$.IWAP.menuField2({
				                    zindex:99,
				                    disabled:false, //禁用菜单 默认为false
				                    hidden:false, //隐藏菜单 默认为false
				                    data: data,
				                    name:'moduleNm',
				                    children:'child',
				                    mode:'local',
				                    idKey:'moduleId',
							        click:function(e){
							        	var node=$(e.target)[0].data;
							        	if(node['moduleType']=="1"){
					            			  if(node["moduleUrl"]){
					            				  $("#main").attr("src",node["moduleUrl"]);
					            			  }else{
					            				  $("#main").attr("src","iwap.ctrl?txcode="+node['moduleOpCode']);
					            			  }
					            			  
					            		  }
							        },
				              renderTo:'menubar'
				            });
				            flag=0;
				        }
				    });
		  		}
	  		}
	  );
  });
</SCRIPT>
</html>