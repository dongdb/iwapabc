<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>实物资产管理系统</title>
<meta name="description" content="">
<meta name="keywords" content="">


<link href="css/Common.css" rel="stylesheet" >
<link href="css/Login.css" rel="stylesheet" >

<link href="js/bootstrap2/css/bootstrap.css" rel="stylesheet" type="text/css">
<script src="js/jquery-1.9.0.js"></script>
<script src="js/bootstrap2/js/bootstrap.min.js"></script>


<script type="text/javascript">

function CTRLReSize() {
    $(document).height($(window).height());
    var a = $(window).height() - $('#header').height() - $('#footer').height();
    $('#content,#divLogin').height(a)
}

$(document).ready(function () {
    $('#txtUserName').focus();

    CTRLReSize();
    $(window).resize(function () {
        CTRLReSize();
    })
    $('#submitLogin').on('click',function(){
    	var userId = $('#txtUserName').val();
    	var password = $('#txtpwd').val();
    	var msg = $('#msg').html();
    	if(!userId){
    		$('#msg').html(msg.replace(/-&gt;.*/,'->用户名不能为空！'));    		
    		return false;
    	}else if(!password){
    		$('#msg').html(msg.replace(/-&gt;.*/,'->密码不能为空！'));    		
    		return false;
    	}
    	$("#formLogin").submit();    	
    });
})

</script>
</head>
<body>
<div class="header" id="header">
<img src="images/logo.png" class="logo" alt="nantian infomation" >
</div>

<div class="content" id="content">
    <div class="login" id="divLogin">
        <form class="formLogin" id="formLogin" action="iwap.ctrl" method="post">
            <input type="hidden" id="txcode" name="txcode" size="15" value="login">
           <input type="hidden" id="actionId" name="actionId" size="15" value="login">
            <div class="input-prepend" style="margin-bottom: 27px">
                <span class="add-on" style=" width:50px"><img src="images/institutions.png"></span>
                <input class="span2 error" id="txtUserName" type="text" placeholder="工号/身份证号" style="width:215px" name="userId"/>

            </div>

            <div class="input-prepend" style="margin-bottom: 20px">
                <span class="add-on" style=" width:50px"><img src="images/psw.png"></span>
                <input class="span2" id="txtpwd" type="password" placeholder="请输入密码" style="width:215px" name="password">
            </div>

            <div class="input-prepend" style="margin-bottom: 20px;text-align: left;width:275px">
               <input type="checkbox" name="jizhumima" id="jizhumima">
                <label style="display: inline" for="jizhumima">记住密码</label>

              <!-- <a style="padding-left: 130px">忘记密码</a> -->
            </div>

            <div class="input-prepend">
                <input id="submitLogin" type="submit" value="登&nbsp;&nbsp;录" style=" background-color: #4eb2d4; color: white; font-family: 微软雅黑; font-size: 14px;
                  height:32px; width:275px; border:0" />
            </div>

            <%-- <span class="label label-important" id="msg">提示信息->${errorMsg}</span>  --%>           
        </form>
    </div>
</div>
<div class="footer" id="footer">
    ©2016-云南南天电子信息股份有限责任公司-版权所有
</div>


</body>
</html>