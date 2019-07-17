<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="keywords" content="">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="icon" href="img/logo.png" type="image/png">
  <title>广东科技学院</title>

    <!--Begin  Page Level  CSS -->
    <link href="assets/plugins/morris-chart/morris.css" rel="stylesheet">
    <link href="assets/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet"/>
     <!--End  Page Level  CSS -->
    <link href="assets/css/icons.css" rel="stylesheet">
    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">
    <link href="assets/css/responsive.css" rel="stylesheet">
    
</head>
<style>
body{margin:0px;padding:0px;}
td,th{text-align:center;}
</style>
<body class="sticky-header">


    <!--Start left side Menu-->
    <div class="left-side sticky-left-side">

        <!--logo-->
        <div class="logo">
            <a ><img src="img/logo_2.png" alt=""></a>
        </div>

        <div class="logo-icon text-center">
            <a ><img src="img/logo_1.png" alt=""></a>
        </div>
        <!--logo-->

        <div class="left-side-inner">
            <!--Sidebar nav-->
            <ul class="nav nav-pills nav-stacked custom-nav">
                <li><a href="index" ><i class="icon-loop"></i> <span>上传下载</span></a></li>
				
				<li  style="background-color: #353F4F"><a href="#"><i class="icon-layers"></i> <span>查课</span></a></li>

                
            </ul>
            <!--End sidebar nav-->

        </div>
    </div>
    <!--End left side menu-->
    
    
    <!-- main content start-->
    <div class="main-content" id="top">

        <!-- header section start-->
        <div class="header-section">

            <a class="toggle-btn"><i class="fa fa-bars"></i></a>
			
			<!-- 搜索框 -->
            <form class="searchform">
                <input type="text" class="form-control" name="keyword" placeholder="Search here..." />
            </form>
        </div>
        <!-- header section end-->


        <!--body wrapper start-->
        
        <div class="wrapper"  style='height: 800px;'>        
			<!--Start row-->
                 <div class="row">
                     <div class="container">
                         <div class="analytics-box">
                             
                         </div>
                     </div>
                 </div>
            <!--End row-->        
			<div style="width: 100%;height: 120px;" >
				 <input type="button" style="border-radius:0px;float: left;margin-left:30%;
												width:120px;height:70px;font-size: 19px;line-height: 2px;color: white;
												background-color: #03A9F3;border:none" 
												onclick="ClassroomSelect()" value="教室查询"/>
				<input type="button" style="border-radius:0px;float: left;margin-left:50px ;color: white;
												width:110px;height:70px;font-size: 19px;line-height: 2px;
												background-color:#81c868;border:none" 
												 onclick="TeacherSelect()" value="教师查询"/>
				<input type="button" style="border-radius:0px;float: left;margin-left:50px ;color: white;
												width:120px;height:70px;font-size: 19px;line-height: 2px;
												background-color: #deaa4e;border:none" 
												 onclick="ClassSelect()" value="班级查询" />
                <input type="text" id="name" style="margin-left: 20%;width: 100%;background-color: #ececed;border: none;font-size: 20px;margin-top: 10px;" readonly="readonly">

			</div>
            <div id="tips">

            </div>
        </div>
        
        <!-- End Wrapper-->
      <!--End main content -->
    


    <!--Begin core plugin -->
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/plugins/moment/moment.js"></script>
    <script  src="assets/js/jquery.slimscroll.js "></script>
    <script src="assets/js/jquery.nicescroll.js"></script>
    <script src="assets/js/functions.js"></script>
    <!-- End core plugin -->
    
    <!--Begin Page Level Plugin-->
    <script src="assets/pages/dashboard.js"></script>
    <script src="assets/plugins/sweetalert/sweetalert2.all.js"></script>
    <script src="assets/pages/jquery.sweet-alert.custom.js"></script>
    <!--End Page Level Plugin-->

</body>
<script>
	function ClassroomSelect(){
		Swal({   
				title: '教室查询',
	  		html:
	    		'<input id="swal-input1" class="swal2-input" placeholder="教室"  autofocus="autofocus">' +
	    		'<input id="swal-input2" class="swal2-input" placeholder="周次">',
	  		showCancelButton: true,
		    cancelButtonText: "取消",
		    confirmButtonText: "查询 ",
	  		
		}).then((result) => {

            var input1 = document.getElementById('swal-input1').value;
	    	var input2 = document.getElementById('swal-input2').value;
				if(input1=='' || input2==''){
					alert("内容不能为空！");
				}else{
                    var weekNum = Array(" ","one", "two", "three","four","five" ,"six" ,"seven" ,"eight" ,"nine", "ten",
                        "eleven" ,"twelve" ,"thirteen" ,"fourteen" ,"fifteen" ,"sixteen" ,"seventeen", "eighteen");
                    var k = parseInt(input2);
                    $.ajax({
                        url : "select" ,
                        type : "post",
                        data : JSON.stringify({"choose":"classroom","text":input1}),
                        contentType:"application/json;charset=UTF-8",
                        dataType:"json",
                        success : function(data){
                            var str = data.text;
                            if(str!=null){
                            var jsonstr = eval('('+str+')');
                            var my = document.getElementById("tip");
                            if (my != null)
                                my.parentNode.removeChild(my);
                            var namstr = input1+"     第"+input2+"周";
                            document.getElementById("name").value = namstr;
                            $('#tips').append("    <div style=\"margin-left: 20%;font-size:17px;\" id='tip'> \n" +
                                "    \t<table border=\"1\" cellspacing=\"0\" width=\"70%\" height=\"420px\">\t\t\n" +
                                "\t\t    <tr style=\"background-color: #03a9f3;color: white;\">\t\t\n" +
                                "\t\t        <th>#</th>\t\t\n" +
                                "\t\t        <th>周一</th>\t\n" +
                                "\t\t        <th>周二</th>\t\t\n" +
                                "\t\t        <th>周三</th>\t\t\n" +
                                "\t\t        <th>周四</th>\n" +
                                "\t\t        <th>周五</th>\n" +
                                "\t\t        <th>周六</th>\n" +
                                "\t\t        <th>周日</th>\n" +
                                "\t\t    </tr>\t\t\n" +
                                "\t\t    <tr>\t\t\n" +
                                "\t\t        <td >1</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期一.一二[weekNum[k]]+"</td>\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期二.一二[weekNum[k]]+"</td>\t\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期三.一二[weekNum[k]]+"</td>\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期四.一二[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期五.一二[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期六.一二[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期日.一二[weekNum[k]]+"</td>\n" +
                                "\t\t    </tr>\t\n" +
                                "\t\t    <tr>\t\n" +
                                "\t\t        <td>2</td>\t\t\t\n" +
                                "\t\t    </tr>\t\t\n" +
                                "\t\t    <tr>\t\t\n" +
                                "\t\t        <td >3</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期一.三四[weekNum[k]]+"</td>\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期二.三四[weekNum[k]]+"</td>\t\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期三.三四[weekNum[k]]+"</td>\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期四.三四[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期五.三四[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期六.三四[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期日.三四[weekNum[k]]+"</td>\n" +
                                "\t\t    </tr>\t\n" +
                                "\t\t    <tr>\t\n" +
                                "\t\t        <td>4</td>\t\t\t\n" +
                                "\t\t    </tr>\t\n" +
                                "\t\t    <tr>\t\t\n" +
                                "\t\t        <td >5</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期一.五六[weekNum[k]]+"</td>\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期二.五六[weekNum[k]]+"</td>\t\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期三.五六[weekNum[k]]+"</td>\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期四.五六[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期五.五六[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期六.五六[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期日.五六[weekNum[k]]+"</td>\n" +
                                "\t\t    </tr>\t\n" +
                                "\t\t    <tr>\t\n" +
                                "\t\t        <td>6</td>\t\t\t\n" +
                                "\t\t    </tr>\t\n" +
                                "\t\t    <tr>\t\t\n" +
                                "\t\t        <td >7</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期一.七八[weekNum[k]]+"</td>\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期二.七八[weekNum[k]]+"</td>\t\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期三.七八[weekNum[k]]+"</td>\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期四.七八[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期五.七八[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期六.七八[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期日.七八[weekNum[k]]+"</td>\n" +
                                "\t\t    </tr>\t\n" +
                                "\t\t    <tr>\t\n" +
                                "\t\t        <td>8</td>\t\t\t\n" +
                                "\t\t    </tr>\t\n" +
                                "\t\t    <tr>\t\t\n" +
                                "\t\t        <td >9</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期一.九十[weekNum[k]]+"</td>\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期二.九十[weekNum[k]]+"</td>\t\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期三.九十[weekNum[k]]+"</td>\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期四.九十[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期五.九十[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期六.九十[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期日.九十[weekNum[k]]+"</td>\n" +
                                "\t\t    </tr>\t\n" +
                                "\t\t    <tr>\t\n" +
                                "\t\t        <td>10</td>\t\t\t\n" +
                                "\t\t    </tr>\t\n" +
                                "\t\t</table>\n" +
                                "    </div>")
                        }
                            else{
                                alert("未查询到对应信息，请确定是否输入正常！")
                            }}
                    });
                }
		})
	}
	function TeacherSelect() {
        Swal({
            title: '教师查询',
            html:
            '<input id="swal-input3" class="swal2-input" placeholder="教师名" autofocus="autofocus">' +
            '<input id="swal-input4" class="swal2-input" placeholder="周次">',
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonText: "查询 ",

        }).then((result) = > {
            var input3 = document.getElementById('swal-input3').value;
        var input4 = document.getElementById('swal-input4').value;
        if (input3 == '' || input4 == '') {
            alert("内容不能为空！");
        } else {
            var weekNum = Array(" ", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten",
                "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen");
            var k = parseInt(input4);
            $.ajax({
                url: "select",
                type: "post",
                data: JSON.stringify({"choose": "teacher", "text": input3}),
                contentType: "application/json;charset=UTF-8",
                dataType: "json",
                success: function (data) {
                    var str = data.text;
                    if (str != null) {
                        var jsonstr = eval('(' + str + ')');
                        var my = document.getElementById("tip");
                        if (my != null)
                            my.parentNode.removeChild(my);
                        var namstr = input3 + "     第" + input4 + "周";
                        document.getElementById("name").value = namstr;
                        $('#tips').append("    <div style=\"margin-left: 20%;font-size: 17px;\" id='tip'> \n" +
                            "    \t<table border=\"1\" cellspacing=\"0\" width=\"70%\" height=\"420px\">\t\t\n" +
                            "\t\t    <tr style=\"background-color: #03a9f3;color: white;\">\t\t\n" +
                            "\t\t        <th>#</th>\t\t\n" +
                            "\t\t        <th>周一</th>\t\n" +
                            "\t\t        <th>周二</th>\t\t\n" +
                            "\t\t        <th>周三</th>\t\t\n" +
                            "\t\t        <th>周四</th>\n" +
                            "\t\t        <th>周五</th>\n" +
                            "\t\t        <th>周六</th>\n" +
                            "\t\t        <th>周日</th>\n" +
                            "\t\t    </tr>\t\t\n" +
                            "\t\t    <tr>\t\t\n" +
                            "\t\t        <td >1</td>\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期一.一二[weekNum[k]] + "</td>\t\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期二.一二[weekNum[k]] + "</td>\t\t\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期三.一二[weekNum[k]] + "</td>\t\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期四.一二[weekNum[k]] + "</td>\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期五.一二[weekNum[k]] + "</td>\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期六.一二[weekNum[k]] + "</td>\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期日.一二[weekNum[k]] + "</td>\n" +
                            "\t\t    </tr>\t\n" +
                            "\t\t    <tr>\t\n" +
                            "\t\t        <td>2</td>\t\t\t\n" +
                            "\t\t    </tr>\t\t\n" +
                            "\t\t    <tr>\t\t\n" +
                            "\t\t        <td >3</td>\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期一.三四[weekNum[k]] + "</td>\t\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期二.三四[weekNum[k]] + "</td>\t\t\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期三.三四[weekNum[k]] + "</td>\t\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期四.三四[weekNum[k]] + "</td>\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期五.三四[weekNum[k]] + "</td>\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期六.三四[weekNum[k]] + "</td>\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期日.三四[weekNum[k]] + "</td>\n" +
                            "\t\t    </tr>\t\n" +
                            "\t\t    <tr>\t\n" +
                            "\t\t        <td>4</td>\t\t\t\n" +
                            "\t\t    </tr>\t\n" +
                            "\t\t    <tr>\t\t\n" +
                            "\t\t        <td >5</td>\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期一.五六[weekNum[k]] + "</td>\t\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期二.五六[weekNum[k]] + "</td>\t\t\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期三.五六[weekNum[k]] + "</td>\t\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期四.五六[weekNum[k]] + "</td>\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期五.五六[weekNum[k]] + "</td>\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期六.五六[weekNum[k]] + "</td>\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期日.五六[weekNum[k]] + "</td>\n" +
                            "\t\t    </tr>\t\n" +
                            "\t\t    <tr>\t\n" +
                            "\t\t        <td>6</td>\t\t\t\n" +
                            "\t\t    </tr>\t\n" +
                            "\t\t    <tr>\t\t\n" +
                            "\t\t        <td >7</td>\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期一.七八[weekNum[k]] + "</td>\t\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期二.七八[weekNum[k]] + "</td>\t\t\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期三.七八[weekNum[k]] + "</td>\t\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期四.七八[weekNum[k]] + "</td>\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期五.七八[weekNum[k]] + "</td>\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期六.七八[weekNum[k]] + "</td>\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期日.七八[weekNum[k]] + "</td>\n" +
                            "\t\t    </tr>\t\n" +
                            "\t\t    <tr>\t\n" +
                            "\t\t        <td>8</td>\t\t\t\n" +
                            "\t\t    </tr>\t\n" +
                            "\t\t    <tr>\t\t\n" +
                            "\t\t        <td >9</td>\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期一.九十[weekNum[k]] + "</td>\t\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期二.九十[weekNum[k]] + "</td>\t\t\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期三.九十[weekNum[k]] + "</td>\t\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期四.九十[weekNum[k]] + "</td>\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期五.九十[weekNum[k]] + "</td>\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期六.九十[weekNum[k]] + "</td>\n" +
                            "\t\t        <td rowspan=\"2\">" + jsonstr.星期日.九十[weekNum[k]] + "</td>\n" +
                            "\t\t    </tr>\t\n" +
                            "\t\t    <tr>\t\n" +
                            "\t\t        <td>10</td>\t\t\t\n" +
                            "\t\t    </tr>\t\n" +
                            "\t\t</table>\n" +
                            "    </div>")
                    }
                    else {
                        alert("未查询到对应信息，请确定是否输入正常！")
                    }
                }
            });
        }
    });
	function ClassSelect(){
		Swal({   
				title: '班级查询',
	  		html:
	    		'<input id="swal-input5" class="swal2-input" placeholder="班级" autofocus="autofocus">' +
	    		'<input id="swal-input6" class="swal2-input" placeholder="周次">',
	  		showCancelButton: true,
		    cancelButtonText: "取消",
		    confirmButtonText: "查询 ",
	  		
		}).then((result) => {
				var input5 = document.getElementById('swal-input5').value;
	    	var input6 = document.getElementById('swal-input6').value;
				if(input5=='' || input6==''){
					alert("内容不能为空！");
				}else{
                    var weekNum = Array(" ","one", "two", "three","four","five" ,"six" ,"seven" ,"eight" ,"nine", "ten",
                        "eleven" ,"twelve" ,"thirteen" ,"fourteen" ,"fifteen" ,"sixteen" ,"seventeen", "eighteen");
                    var k = parseInt(input6);
                    $.ajax({
                        url : "select" ,
                        type : "post",
                        data : JSON.stringify({"choose":"class","text":input5}),
                        contentType:"application/json;charset=UTF-8",
                        dataType:"json",
                        success : function(data){
                            var str = data.text;
                            if(str!=null){
                            var jsonstr = eval('('+str+')');
                            var my = document.getElementById("tip");
                            if (my != null)
                                my.parentNode.removeChild(my);
                            var namstr = input5+"     第"+input6+"周";
                            document.getElementById("name").value = namstr;
                            $('#tips').append("    <div style=\"margin-left: 20%;font-size: 17px;\" id='tip'> \n" +
                                "    \t<table border=\"1\" cellspacing=\"0\" width=\"70%\" height=\"420px\">\t\t\n" +
                                "\t\t    <tr style=\"background-color: #03a9f3;color: white;\">\t\t\n" +
                                "\t\t        <th>#</th>\t\t\n" +
                                "\t\t        <th>周一</th>\t\n" +
                                "\t\t        <th>周二</th>\t\t\n" +
                                "\t\t        <th>周三</th>\t\t\n" +
                                "\t\t        <th>周四</th>\n" +
                                "\t\t        <th>周五</th>\n" +
                                "\t\t        <th>周六</th>\n" +
                                "\t\t        <th>周日</th>\n" +
                                "\t\t    </tr>\t\t\n" +
                                "\t\t    <tr>\t\t\n" +
                                "\t\t        <td >1</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期一.一二[weekNum[k]]+"</td>\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期二.一二[weekNum[k]]+"</td>\t\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期三.一二[weekNum[k]]+"</td>\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期四.一二[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期五.一二[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期六.一二[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期日.一二[weekNum[k]]+"</td>\n" +
                                "\t\t    </tr>\t\n" +
                                "\t\t    <tr>\t\n" +
                                "\t\t        <td>2</td>\t\t\t\n" +
                                "\t\t    </tr>\t\t\n" +
                                "\t\t    <tr>\t\t\n" +
                                "\t\t        <td >3</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期一.三四[weekNum[k]]+"</td>\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期二.三四[weekNum[k]]+"</td>\t\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期三.三四[weekNum[k]]+"</td>\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期四.三四[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期五.三四[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期六.三四[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期日.三四[weekNum[k]]+"</td>\n" +
                                "\t\t    </tr>\t\n" +
                                "\t\t    <tr>\t\n" +
                                "\t\t        <td>4</td>\t\t\t\n" +
                                "\t\t    </tr>\t\n" +
                                "\t\t    <tr>\t\t\n" +
                                "\t\t        <td >5</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期一.五六[weekNum[k]]+"</td>\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期二.五六[weekNum[k]]+"</td>\t\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期三.五六[weekNum[k]]+"</td>\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期四.五六[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期五.五六[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期六.五六[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期日.五六[weekNum[k]]+"</td>\n" +
                                "\t\t    </tr>\t\n" +
                                "\t\t    <tr>\t\n" +
                                "\t\t        <td>6</td>\t\t\t\n" +
                                "\t\t    </tr>\t\n" +
                                "\t\t    <tr>\t\t\n" +
                                "\t\t        <td >7</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期一.七八[weekNum[k]]+"</td>\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期二.七八[weekNum[k]]+"</td>\t\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期三.七八[weekNum[k]]+"</td>\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期四.七八[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期五.七八[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期六.七八[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期日.七八[weekNum[k]]+"</td>\n" +
                                "\t\t    </tr>\t\n" +
                                "\t\t    <tr>\t\n" +
                                "\t\t        <td>8</td>\t\t\t\n" +
                                "\t\t    </tr>\t\n" +
                                "\t\t    <tr>\t\t\n" +
                                "\t\t        <td >9</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期一.九十[weekNum[k]]+"</td>\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期二.九十[weekNum[k]]+"</td>\t\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期三.九十[weekNum[k]]+"</td>\t\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期四.九十[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期五.九十[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期六.九十[weekNum[k]]+"</td>\n" +
                                "\t\t        <td rowspan=\"2\">"+jsonstr.星期日.九十[weekNum[k]]+"</td>\n" +
                                "\t\t    </tr>\t\n" +
                                "\t\t    <tr>\t\n" +
                                "\t\t        <td>10</td>\t\t\t\n" +
                                "\t\t    </tr>\t\n" +
                                "\t\t</table>\n" +
                                "    </div>")
                        }else{
                                alert("未查询到对应信息，请确定是否输入正常！")
                            }}
                    });
				}
		})
	}
</script>
</html>

