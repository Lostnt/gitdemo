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
   <link href="assets/plugins/sweetalert/sweetalert2.css" rel="stylesheet"/>
   <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,600" rel="stylesheet">
	<link rel="stylesheet" href="css/reset.min.css">	
	<link rel="stylesheet" href="css/style.css">
</head>
<style>
body{margin:0px;padding:0px;}
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
                <li style="background-color: #353F4F"><a href="#" ><i class="icon-loop"></i> <span>上传下载</span></a></li>
				
				<li><a href="selectHome"><i class="icon-layers"></i> <span>查课</span></a></li>

                
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
        
        <div class="wrapper"  style='min-height: 800px;height: auto'>
			<!--Start row-->
                 <div class="row">
                     <div class="container">
                         <div class="analytics-box">
                             
                         </div>
                     </div>
                 </div>
            <!--End row-->        
				<div style="border-bottom: 1px solid #eee;border-radius:0 0 10px 10px;min-height: 545px;">
					<div style="width:100% ;height: 60px;margin-top:20px">
					<div style="float:left;margin-left :30px;margin-top:30px;width:auto">
						<font style="color:#2B2B38 ;font-size: 20px;font-weight: 400;line-height: 30px;">
                         	请选择上传的资源: 
                    	</font>  					
					</div>					
					<form class="inpform" id="uploadForm2" enctype="multipart/form-data">
					<div class="uploader white" style="margin-left:30px;margin-top:25px;float:left">
						<input id="choicefile" type="text" class="filename" readonly="readonly"/>
						<input type="button" name="file" class="button" value="Browse..."/>
						<input  name="file1" multiple="multiple" type="file" size="30"/>
					</div>					
					</form>
					<div style=" width:200px;height:50px;margin-left: 25px;float:left;margin-top: 22px">
					<button type="button" class="btn btn-primary" onclick="uploadSource()"
							style="border-radius:0px;width:80px;height:40px;margin-top: 3px;background-color: #03A9F3;border:1px solid #4EC1F0">
						上传
					</button>
                        <button type="button" class="btn btn-primary" onclick="deleteSource()"
                                style="border-radius:0px;width:80px;height:40px;margin-top: 3px;background-color: #03A9F3;border:1px solid #4EC1F0;margin-left: 30px">
                            一键删除
                        </button>
					</div>
					</div>
					<div style="width:auto;height:40px;margin-left: 25px;margin-top: 20px">
					<font style="color:#2B2B38 ;font-size: 20px;font-weight:  550;line-height: 40px;">
                         	下载 
                    </font>  					
					</div>	 
				  	<div class="container" style="margin-top:10px;width:90%;margin-left: 33px;visibility: hidden;"  id="tip">
					  <table class="table table-bordered table-striped" id="tables" style="border:1px solid  #ddd;">
					    <thead>
							<tr>
								<th style="width:5% ;text-align: center;"><input type="checkbox" onclick='checkedAll()' style="width:20px;height:20px"></th>
								<th style="width:35%;text-align: center;">文件名</th>
								<th style="width:30%; text-align: center;">类型</th>
								<th style="width:30% ;text-align: center;">上传日期</th>
							</tr>
						</thead>
					    <tbody id="tips">					    
					     
					    </tbody>	    
					  </table>
					  <input type="button" style="border-radius:0px;margin-left:45%;
												width:80px;height:34px;font-size: 18px;line-height: 2px;
												background-color: #03A9F3;border:none" 
												class="btn btn-primary" onclick="downfile()" value="下载"/>
					</div> 
					
				</div>
        </div>
        
        <!-- End Wrapper-->
       </div>
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
        <script src="assets/plugins/jquery-toast/jquery.toast.min.js"></script>		
    <script src="assets/pages/notifications.js"></script>
    
    
    <script src="js/jquery-1.11.3.min.js"></script> 
	<script src="js/jquery.tableCheckbox.js"></script> 
	<script src="js/modernizr.min.js"></script>
    <script src="js/jquery-1.11.3.min.js"></script>
	<script src="js/vendor/tabcomplete.min.js"></script>
	<script src="js/vendor/livefilter.min.js"></script>
	<script src="js/vendor/src/bootstrap-select.js"></script>
	<script src="js/vendor/src/filterlist.js"></script>
	<script src="js/plugins.js"></script>	
	<script src="assets/plugins/sweetalert/sweetalert2.all.js"></script>
    <script src="assets/pages/jquery.sweet-alert.custom.js"></script>
    <script src="js/prefixfree.min.js"></script>
	<script type="text/javascript" src="js/jquery-tab.js"></script>
	<script  src="js/index.js"></script>
	<script src="js/mousescroll.js"></script>
	<script src="assets/plugins/sweetalert/sweetalert2.all.js"></script>
	<script src="js/jquery.tableCheckbox.js"></script> 
	<script>
		$('table').tableCheckbox({ /* options */ });
	</script> 
    <!--End Page Level Plugin-->
<script>
     function deleteSource() {
         $.ajax({
             url : "${pageContext.request.contextPath}/deleteSource" ,
             type : "post",
             success : function(data){
                 if(data >0){
                     Swal({
                         type: 'success',
                         title: '删除成功',
                         showConfirmButton: false,
                         timer: 1200
                     });
                     document.getElementById("tip").style.visibility="hidden";
                 }else{
                     Swal({
                         type: 'error',
                         title: '删除失败',
                         showConfirmButton: false,
                         timer: 1200
                     })
                 }
             }
         });
     }
	 function uploadSource(){
	 var fileName = $('#choicefile').val() ;
	 if(fileName == "" || fileName == "No file selected..."){
		 alert("请选择文件");
		 return false;
	 }else{
	 var rows = document.getElementById("tables").rows.length;
	 var formData = new FormData($("#uploadForm2")[0]);
 	$.ajax({
		url : "${pageContext.request.contextPath}/uploadSource" ,
		type : "post",
		data : formData,  
        processData : false,  //必须false才会避开jQuery对 formdata 的默认处理   
        contentType : false,
		success : function(data){
			  if(data != null){
				  Swal({
					  type: 'success',
					  title: '上传成功',
					  showConfirmButton: false,		
					  timer: 1200
					});
				  document.getElementById("choicefile").value = "No file selected..."
				  document.getElementById("tip").style.visibility="visible";
				  var fileSources = data.fileSources;
				  for(var i=0;i<fileSources.length;i++){
				  		$('#tips').append("<tr><td style='text-align: center'><input type='checkbox' value='"+fileSources[i].fileName+"' style='width:20px;height:20px'></td><td style='height: 40px;text-align: center'>"+fileSources[i].fileName+"</td><td style='text-align: center'>Excel</td><td style='text-align: center'>"+fileSources[i].fileTime+"</td></tr>");
				  }
			  }else{
					 Swal({
						  type: 'error',
						  title: '上传失败',
						  showConfirmButton: false,	
						  timer: 1200
						})												
				}  
		}
	});
	}
 }
function downfile() {
	var choice = new Array();
	var i=0;
	var flag = false;
		$("input[type='checkbox']").each(function() {             
        	if(this.checked){
        		this.checked = false;
        		choice[i] = $(this).val();            	
        		i++;
        		flag = true;
        	}	
    	}); 
		if(flag != true){
			alert("请选择要下载的稿件 !");
			return false;
		}else{
 			  Swal({
				  type: 'success',
				  title: '已添加到下载队列',
				  showConfirmButton: false,		
				  timer: 1200
				});																
			window.location.href="${pageContext.request.contextPath}/downFile?choice="+choice;
 		}
}
</script>
 <script>
    var isCheckAll = false; 
    function checkedAll() { 
    	var rows = document.getElementById("tables").rows;
        if (isCheckAll) { 
            $("input[type='checkbox']").each(function() { 
                this.checked = false;      
            }); 
            isCheckAll = false; 
        } else { 
            $("input[type='checkbox']").each(function() { 
                this.checked = true;  
            }); 
            isCheckAll = true; 
        } 
    } 
</script>
<script>
$(function(){
	$("input[type=file]").change(function(){$(this).parents(".uploader").find(".filename").val($(this).val());});
	$("input[type=file]").each(function(){
	if($(this).val()==""){$(this).parents(".uploader").find(".filename").val("No file selected...");}
	});
});
</script>
</body>
</html>
