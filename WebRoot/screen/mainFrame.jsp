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
<link href="<%=request.getContextPath() %>/css/easyui.css" rel="stylesheet" type="text/css">
<script src="<%=request.getContextPath() %>/js/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/js/jquery-1.9.0.js"></script>
<script src="<%=request.getContextPath() %>/js/jquery-3.2.0.min.js"></script>
<script src="<%=request.getContextPath() %>/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath() %>/js/UtilTool.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.ztree.exhide-3.5.js"></script>
<script src="<%=request.getContextPath() %>/js/Menu.js"></script>
<script src="<%=request.getContextPath() %>/js/MenuField3.js"></script>
<script src="<%=request.getContextPath() %>/js/jquery.easyui.min.js"></script>
<script src="<%=request.getContextPath() %>/js/jquery.tabs.js"></script>

<style type="text/css">
/*样式写在此处是因为此页面需要BODY高度单独设为高度百分百*/
 body,html{height: 100%; overflow-y: hidden;}
.changeBg{  background-image: url("../images/select-bg.png");  }
</style>
</head>
<body class="iwapui" style="background-image:url(../iwapabc/images/bg1.jpg);">
	<div id="head" class="head clearfix" style="background-color:transparent;">
    	<div class="Hleft_box">
       		<div class="clearfix">
       			<div><h3 style="color:#fff; margin-left:20px;">实 物 资 产 管 理 系 统</h3></div>
       		</div>       	
    	</div>
    </div> 
    <div class="center">
		<!--左侧菜单-->
		<div  class="left_box" id="left_box" style="margin-left:30px;width:190px;
			height:85%;float:left;background-color:rgba(255,255,255,0.4);">
		</div>
   		<!--用户信息（右上）-->
   		<div style="margin-right:20px;width:160px;height:180px;float:right;
   			background-color:rgba(0,0,1,0.2);color:#fff;text-align:center;font-size:14px;">
   			<img alt="" src="../iwapabc/images/admin.jpg;"
   				style="background-color:#fff;width:70px;height:70px;
   				border:1px solid #fff;border-radius:50px;margin:22px; ">
   			<div> <i>欢迎	${userInfo.ACCT_NM}</i> </div>
   			<div> <i>机构号：${userInfo.ORG_ID}</i></div>
   			<div> <i><%=DateUtil.getCurrentDate("yyyy-MM-dd") %></i></div>
		</div>
		<!--快捷方式（右下）-->
		<div style="margin-top:190px;margin-right:-160px;width:160px;height:55%;
			float:right;background-color:rgba(0,0,0,0.2);">
			<div style="margin-top:25px;margin-left:35px;">
				<img alt="" src="../iwapabc/images/kjfs.png;">			
			</div>
			<div style="margin-top:20px;margin-left:25px">
				<a href="javascript:void(0)" class="home" onclick="getTask()" title="待办事项"><img alt="" src="../iwapabc/images/icon/dbsx.png;" style="width:100px;height:25px;margin-top:30px;"></a>
				<a href="javascript:void(0)" class="mdfPwd" onclick="mdfPwd()" title="修改密码"><img alt="" src="../iwapabc/images/icon/xgmm.png;" style="width:100px;height:25px;margin-top:30px;"></a>
				<a href="javascript:void(0)" class="home" onclick="getHome()" title="首页"><img alt="" src="../iwapabc/images/icon/sy.png;" style="width:100px;height:25px;margin-top:30px;"></a>
				<a href="<%=request.getContextPath() %>/screen/loginOut.jsp" class="exit_on" title="退出"><img alt="" src="../iwapabc/images/icon/tc.png;" style="width:100px;height:25px;margin-top:30px;"></a>
			</div>
		</div> 
		<!--窗口导航-->
			<div id="title"></div>
		<!--主窗口-->
		<div style="margin-left:230px;margin-top:10px;width:69%;min-width:940px;height:85%;
			float:top;background-color:transparent; ">
			<div id="tt" class="easyui-tabs" style="width:100%;height:100%;">
				<div title="待办事项" class="tabs-inner">
					<iframe src="./screen/system/homePage.jsp" style="min-width:940px;overflow-x:auto;font-size:13px;width:100%;height:96%;"></iframe>';  
    			</div>
			</div>
			<!-- <iframe name="main"  id="main" width="100%" height="100%"  
				src="./screen/system/homePage.jsp" style="font-size:13px;min-width:940px;overflow-x:auto;"></iframe>
		 	-->
		</div>
	</div>
</body>
<SCRIPT type="text/javascript">
var flag=0;
function getHome(){
	//$("#main").attr('src','./screen/system/homePage.jsp');
	var href = "./screen/system/homePage.jsp";
	var title1 = "首页";
	addTab(title1,href);
}
function getTask(){
	//$("#main").attr('src','./screen/system/homePage.jsp');
	var href = "./screen/system/homePage.jsp";
	var title1 = "待办事项";
	addTab(title1,href);
}
function mdfPwd(){
	var href = "<%=request.getContextPath()%>/iwap.ctrl?txcode=modifyPwd";
	var title1 = "修改密码";
	addTab(title1,href);
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
/**     
 * 新建tab 
 * @zsj  
 *example: {tabTitle:'tabTitle',url:'refreshUrl'} 
 *如果tabTitle为空，则默认刷新当前选中的tab 
 *如果url为空，则默认以原来的url进行reload 
 */
function addTab(title, href){  
	if ($('#tt').tabs('exists', title)){//如果tab已经存在,则选中并刷新该tab   
		$('#tt').tabs('select', title);  
        //refreshTab({tabTitle:title,url:href});  
    } else {  
        if (href){  
            var content = '<iframe  frameborder="0"  src="'+href+'" style="min-width:940px;overflow-x:auto;width:100%;height:100%;"></iframe>';  
        } else {  
            var content = '未实现';  
        }  
        $('#tt').tabs('add',{  
            title:title,  
            content:content,  
            closable:true
		      
        }); 
    }
}  
/**     
 * 刷新tab 
 * @zsj  
 */  
function refreshTab(cfg){  
    var refresh_tab = cfg.tabTitle?$('#tabs').tabs('getTab',cfg.tabTitle):$('#tabs').tabs('getSelected');  
    if(refresh_tab && refresh_tab.find('iframe').length > 0){  
    var _refresh_ifram = refresh_tab.find('iframe')[0];  
    var refresh_url = cfg.url?cfg.url:_refresh_ifram.src;  
    //_refresh_ifram.src = refresh_url;  
    _refresh_ifram.contentWindow.location.href=refresh_url;  
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
			            				  var href = "iwap.ctrl?txcode="+data['moduleOpCode'];
			            				  //$("#main").attr("src",href);
			            				  var title1 = data['moduleNm'];
			            				  addTab(title1,href);
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