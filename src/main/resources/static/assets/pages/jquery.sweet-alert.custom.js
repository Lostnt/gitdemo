
!function($) {
    "use strict";

    var SweetAlert = function() {};

    //examples 
    SweetAlert.prototype.init = function() {
        
    //Basic
    $('#sa-basic').click(function(){
        swal("Here's a message!");
    });

    //A title with a text under
    $('#sa-title').click(function(){
        swal("Here's a message!", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed lorem erat eleifend ex semper, lobortis purus sed.")
    });

    //Success Message
    $('#sa-success').click(function(){
        swal("Good job!", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed lorem erat eleifend ex semper, lobortis purus sed.", "success")
    });

    //Custom Image
    $('#sa-image').click(function(){
        swal({   
            title: "Title",   
            text: "Lorem ipsum dolor sit amet, consectetur",   
            imageUrl: "assets/images/users/avatar-1.jpg" 
        });
    });

    //Auto Close Timer
    $('#sa-close').click(function(){
         swal({   
            title: "Auto close alert!",   
            text: "I will close in 2 seconds.",   
            timer: 2000,   
            showConfirmButton: false 
        });
    });


    },
    //init
    $.SweetAlert = new SweetAlert, $.SweetAlert.Constructor = SweetAlert
}(window.jQuery),

//initializing 
function($) {
    "use strict";
    $.SweetAlert.init()
}(window.jQuery);


function deleteTopic(topicId,topicStatus) {
	if(topicStatus == "已选"){
		Swal({
			  type: 'error',
			  title: '已选题目无法执行删除操作!',
			  showConfirmButton: true,						  
			})		
	}else{
	swal({   
        title: "是否确定删除此题目??",   
        text: "你将彻底删除此题目!",   
        type: "warning",   
        showCancelButton: true, 
        cancelButtonText: "取消",
        confirmButtonText: "确定 ",         
        closeOnConfirm: false ,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
    }).then((result) => {   
    	if (result.value) {
    	$.ajax({
			url : "deleteTopic" ,
			type : "post",
			data : JSON.stringify({"topicId":topicId}),
			contentType:"application/json;charset=UTF-8",
			dataType:"json",
			success : function(data){
				  if(data > 0){
					  Swal({
						  type: 'success',
						  title: '已删除',
						  showConfirmButton: false,						  
						})					
					setTimeout(function () {  window.location.href="teacherSetTopic"; }, 1000);				
					}else{
						 Swal({
							  type: 'error',
							  title: '删除失败',
							  showConfirmButton: false,						  
							})					
						setTimeout(function () {  window.location.href="teacherSetTopic"; }, 1000);							
					}  
			}
		}); 
    	}
    })
	}
}
function newTopic(teaId) {
	swal({   
		title: '创建题目',
		input: 'textarea',
		inputPlaceholder: 'Writing here...',
		showCancelButton: true,
        cancelButtonText: "取消",
        confirmButtonText: "确定 ",         
    }).then((result) => {  
    	if (result.value) {
    	$.ajax({
			url : "newTopic" ,
			type : "post",
			data : JSON.stringify({"topicName":result.value,"teaId":teaId}),
			contentType:"application/json;charset=UTF-8",
			dataType:"json",
			success : function(data){
				  if(data > 0){
					  Swal({
						  type: 'success',
						  title: '创建成功',
						  showConfirmButton: false,						  
						})					
					setTimeout(function () {  window.location.href="teacherSetTopic"; }, 1000);				
					}else{
						 Swal({
							  type: 'error',
							  title: '创建失败',
							  showConfirmButton: false,						  
							})					
						setTimeout(function () {  window.location.href="teacherSetTopic"; }, 1000);							
					}  
			}
		}); 
    } 
   })
}