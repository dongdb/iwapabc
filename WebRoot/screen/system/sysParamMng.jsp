<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/screen/comm/header.jsp" %>
<style type="text/css">
.t_string{
	text-align: left
}
.t_number{
	text-align: right
}
.t_date{
	text-align: center
}
</style>
<%
Object auth=request.getAttribute("auth");
List auths=new ArrayList();
if(auth!=null){
	String[] strAuth=auth.toString().split(",");
	for(int i=0;i<strAuth.length;i++){
		auths.add(strAuth[i]);
	}
}
System.out.println(auths);
%>
<script src=""></script>
<script src=""></script>
<script src=""></script>
<title>系统参数维护</title>
</head>
<body>
<div id="conFrm">

</div>
<div id="list"></div>
<div id="mngFrm" style="display:none">

</div>
<div id="div1" style="display:none">

</div>
<script type="text/javascript">
var grid=null;
var form=null;
var editForm=null;
var dialog=null;
var actionType="";
var qyzt_select=[{id:'0',text:'0-禁用'},
                 {id:'1',text:'1-启用'}];
$(document).ready(function(){
	form=$.IWAP.Form({
		renderTo:"conFrm",
		column:"6",
		items:[{
            label:'参数中文名称',
            name:"paramZhNm",
            xtype:"TextField"
        },{
            name:"actionId",
            type:'hidden',
            value:'doBiz',
            hidden:true,
            xtype:"TextField"
        },
        {label:'启用状态',
            name:"enableFlag",
            mode:"local",
            useValue:'id',
            displayValue:'text',
            value:'',
            data:qyzt_select,
            xtype:"ListField"
        }
		],
		buttons:[{xtype:'ButtonField',label:'查询',click:function(){
			grid.doQuery(form.getData());
        }},
        {xtype:'ButtonField',label:'重置',click:function(){
            form.reset();
        }},
        {xtype:'ButtonField',label:'新增',click:function(){
        	 dialog.show();
        	 actionType="insert";
        	 form.reset();
        	//$("#mngFrm").show();
        }}
        ]
	});
	$("<option value='' selected>全部</option>").insertBefore("#enableFlag option:first");
	grid=$.IWAP.Grid({"txcode":"sysParam",
		"renderTo":"list",
		'param':{'body':{'start':0,limit:3},'header':{'txcode':'sysParam'}},
		sUrl:'iwap.ctrl',
		bRetrieve:true,
		iDrawError:3,
		"aoColumns": [ 
                      { "mData": "PARAM_EN_NM",title:"参数名称",defaultContent:"",class:"t_string"}, 
                      { "mData": "PARAM_ZH_NM",title:"参数中文名称",defaultContent:""}, 
                      { "mData": "PARAM_VAL",title:"参数值",defaultContent:""}, 
                      { "mData": "ENABLE_FLAG",title:"是否启用",defaultContent:"",
                    	  mRender:function(data,type,full){
                    		  if(data){
									for(var p in qyzt_select){
										if(qyzt_select[p].id==data){
											return qyzt_select[p].text;
													}
												}
								}else{
									return "";
								} 
                    	 /*  if(data=="0"){
                    		  return "禁用";
                    	  }else{
                    		  return "启用";
                    	  } */
                      }}, 
                      { "mData": "CRT_DATE",title:"创建日期",defaultContent:"",
                    	  class:"t_date",
                    	  width:80,
                    	  mRender:function(data,type,full){
                    	  if(data){
                    		  var d=new Date(data);
                    		  return d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
                    	  }else{
                    		  return "";
                    	  }
                      }}, 
                      { "mData": "CRT_USR",title:"参数人",defaultContent:""},
                      { "mData": "oper",title:"操作",defaultContent:"",mRender:function(data,type,full,info){
                    	  
                    	  return "<%if(auths.contains("delete")){%><a href='javaScript:void(0)' onclick='delRec(\""+full["PARAM_EN_NM"]+"\")'>删除</a>&nbsp;|<%}%><a  href='javaScript:void(0)' onclick='editRec("+info['row']+")'>修改</a>";
                    	  
                      }}
                  ],
		});
	editForm=$.IWAP.Form({
		renderTo:"mngFrm",
		//column:"6",
		items:[{
            label:'参数名称',
            name:"PARAM_EN_NM",
            xtype:"TextField"
        },
        {
            label:'中文名称',
            name:"PARAM_ZH_NM",
            xtype:"TextField"
        },
        {
            label:'参数值',
            name:"PARAM_VAL",
            xtype:"TextField"
        },
        {
            label:'启用状态',
            name:"ENABLE_FLAG",
            mode:"local",
            useValue:'id',
            displayValue:'text',
          //  value:'1',
            data:qyzt_select,
            xtype:"ListField"
        }
		],
		buttons:[{xtype:'ButtonField',label:'保存',click:function(){
			doSave();
			dialog.hidden();
        }},
        {xtype:'ButtonField',label:'重置',click:function(){
        	editForm.reset();
        }}
        ]
	});
	
	 dialog=$.IWAP.Dialog({
         title:'新增参数',//对话框标题
         html:"",//对话框内容
        // buttons:['取消','修改','保存','添加'],//对话框底部按钮
         renderTo:'div1',//渲染对象
         //close:'close',//hidden 隐藏对话框  close销毁对话框
         //disabled:true,//是否禁用对话框 默认false
         hidden:true,//是否隐藏对话框 默认false
         height:700,//对话框高度
         width:800
         /*listeners:{//配置监听事件
             beforeClose:function(){alert('准备关闭test对话框');},//对话框关闭前的监听事件
             afterClose:function(){alert('成功关闭了test对话框');}//对话框关闭后的监听事件
         }*/
     });
	 $("#mngFrm").appendTo($("#div1 .modal .modal-dialog .modal-content .modal-body"));
	 $("#mngFrm").height(300);
	 $("#mngFrm").show();
	 $("#div1").show();
	 grid.doQuery(form.getData());
});
/**
 * 编辑记录
 */
function editRec(idx){
	var data=grid.getGrid().fnSettings().aoData[idx]._aData;
	dialog.setTitle("修改参数");
	//dialog.setWidth(600);
	//dialog.setHeight(800);
	dialog.show();
	editForm.setData(data);
	actionType="update";
}
/**
 * 删除记录
 */
function  delRec(paramNm){
	actionType="delete";
	var param={};
	param['actionType']=actionType;
	param['txcode']="sysParam";
	param['PARAM_EN_NM']=paramNm;
	param['actionId']="doBiz";
	 $.IWAP.iwapRequest("iwap.ctrl",param,function(data){
		 if(data['header']['msg']){
			 alert("删除失败!"+data['header']['msg']);
		 }else{
			 alert("删除成功");
			 grid.doQuery(form.getData()); 
		 }
		 
	 },function(){
		 alert("删除失败!");
	 });
}

function doSave(){
	var param=editForm.getData();
	param['actionType']=actionType;
	param['txcode']="sysParam";
	param['actionId']="doBiz";
	 $.IWAP.iwapRequest("iwap.ctrl",param,function(){
		 if(arguments[0]["header"]["msg"]){
			 alert("保存失败:"+arguments[0]["header"]["msg"]);
		 }else{
			 alert("保存成功");
			 grid.doQuery(form.getData());
		 }
	 },function(){
		 alert("保存失败!");
	 });
}
</script>
</body>
</html>