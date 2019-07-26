<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>회원 찾기 페이지</title>
		<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
	    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css"/>
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" ></script>
		<!-- easing 플러그인 추가 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
    
    <!-- 20190723 김용빈 -->
    <!-- Tiny Nice Confirmation Popup Plugin With jQuery - H-confirm-alert -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/H-confirm-alert.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/H-confirm-alert.css">
    
	<script src='https://code.jquery.com/ui/1.10.4/jquery-ui.js'></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-animate-css-rotate-scale.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-css-transform.js"></script>
    	
	<style>
 		#container { 
			display : flex; 
			flex-direction : column;
			justify-content : center;
			align-items : center;
		}
			#container .container-items{ 
	           flex : 1 1 0; 
	           margin : auto; 
	           max-width: 300px; 
			}
			
			#container #findBtn { 
				display : flex; 
				flex-direction : row;
				
				justify-content : center;
				align-items : center;
				margin-top:5%;
			}
				#findBtn .items i{font-size:150px;}
				
				
	  		#findPwd{
	  			opacity:0.4;
	  			scale: 0.8;
	  			}
	  			
  			#findId{
	  			opacity:0.4;
	  			scale: 0.8;
  				}
				
		 .flex{
					display : flex; 
            		flex-direction : row;
				}
		 .nameHead{font-size:20px; font-weight: bold;}
		.nodisplay{display:none;}
	</style>
	
	<script>
	    $(function(){
	  	  $("#phoneAuthBtn").on("click",function(){
	    		var phone = $("#phone").val();
	    		var memberName = $("#memberName").val();
	    		
	    		  if(memberName.length ==0 || phone.length ==0){
	    			  alert("정보을 입력하세요");
	    			  return;
	    		  }
	    			
	    		$.ajax({
	    			url:"${pageContext.request.contextPath}/member/chkNamePhone.do",
	    			type : "POST",
	    			data:"phone="+phone+"&memberName="+memberName,
	    			dataType : 'text',
	    			success:function(data){
	    				if(data=="success"){
	    					$.confirm.show({
	    						  "message": "문자로 인증번호을 발송하였습니다.",
	    						  "yes": function (){
	    						  },
	    						  "hideNo":true,
	    						  "type":"success" // default or success, danger, warning
	    						})
	    					$("#smsAuthDiv").slideToggle(600, 'easeInBack');
	    				}else{
	    					$.confirm.show({
	    						  "message": "이름과 전화번호가 일치 하지 않습니다.",
	    						  "yes": function (){
	    						  },
	    						  "hideNo":true,
	    						  "type":"warning" // default or success, danger, warning
	    						})
	    				}
	    			},
	    			error:function(jqxhr, textStatus, errorThrown){
						console.log("ajax처리실패! : "+jqxhr.status);
						console.log(jqxhr);
						console.log(textStatus);
						console.log(errorThrown);
					}
	    		});
	  	  })
	  	  
	  	$("#smsAuthBtn").on("click",function(){
  		  
  		  var authNum = $("#smsAuth").val();
  		  var memberName = $("#memberName").val();
  		  var phone = $("#phone").val();
  		  
  		 
			 $.ajax({ 
				 url:"${pageContext.request.contextPath}/member/chkSmsAuth", 
				type: "POST",
				data: "authNum="+authNum+"&phone="+phone+"&memberName="+memberName,
				dataType : 'text',
				success : function(data){

					console.log(data);
					if(data =="fail"){
    					$.confirm.show({
  						  "message": "인증을 실패하였습니다. 인증번호을 확인하세요",
  						  "yes": function (){
  						  },
  						  "hideNo":true,
  						  "type":"warning" // default or success, danger, warning
  						})
  						
						$("#smsAuth").val("").focus();
					}
					
					if( data !="fail"){
    					$.confirm.show({
    						  "message": "문자인증을 완료하였습니다.",
    						  "yes": function (){
    						  },
    						  "hideNo":true,
    						  "type":"success" // default or success, danger, warning
    						})
						
						$.ajax({
			    			url:"${pageContext.request.contextPath}/member/getMemberId.do",
			    			type : "POST",
			    			data:"phone="+phone+"&memberName="+memberName,
			    			dataType : 'text',
			    			success:function(data){
			    				$("#idFindResult").val(data);
			    				$("#smsAuthDiv").slideToggle(1000, 'easeInBack');
			    				$("#idFindResultDiv").slideToggle(1000, 'easeInBack');
			    			},
			    			error:function(jqxhr, textStatus, errorThrown){
								console.log("ajax처리실패! : "+jqxhr.status);
								console.log(jqxhr);
								console.log(textStatus);
								console.log(errorThrown);
							}
			    		});
						
						
					}
				},
				error: function(jqxhr, textStatus, errorThrown){
					console.log("ajax처리실패! : "+jqxhr.status);
					console.log(jqxhr);
					console.log(textStatus);
					console.log(errorThrown);
				}
			}); 
	  	});  
			 
			 $("#pwd-phoneAuthBtn").on("click",function(){
		    		var phone = $("#pwd-phone").val();
		    		var memberName = $("#pwd-memberName").val();
		    		var memberId = $("#pwd-memberId").val();
		    		
		    		if(memberName.length ==0 || phone.length ==0 || memberId.length ==0){
		    			  alert("정보을 입력하세요");
		    			  return;
		    		  }
		    		
		    		$.ajax({
		    			url:"${pageContext.request.contextPath}/member/chkNamePhone.do",
		    			type : "POST",
		    			data:"phone="+phone+"&memberName="+memberName,
		    			dataType : 'text',
		    			success:function(data){
		    				if(data=="success"){
		    					$.confirm.show({
		    						  "message": "문자로 인증번호을 발송하였습니다.",
		    						  "yes": function (){
		    						  },
		    						  "hideNo":true,
		    						  "type":"success" // default or success, danger, warning
		    						})
		    						
		    					$("#pwd-smsAuthDiv").slideToggle(600, 'easeInBack');
		    				}else{
		    					$.confirm.show({
		    						  "message": "이름과 전화번호가 일치 하지 않습니다.",
		    						  "yes": function (){
		    						  },
		    						  "hideNo":true,
		    						  "type":"success" // default or success, danger, warning
		    						})
		    				}
		    			},
		    			error:function(jqxhr, textStatus, errorThrown){
							console.log("ajax처리실패! : "+jqxhr.status);
							console.log(jqxhr);
							console.log(textStatus);
							console.log(errorThrown);
						}
		    		});
		  	  })
			 
			 $("#pwd-smsAuthBtn").on("click",function(){
		  		  
		  		  var authNum = $("#pwd-smsAuth").val();
		  		  var memberName = $("#pwd-memberName").val();
		  		  var phone = $("#pwd-phone").val();
		    	  var memberId = $("#pwd-memberId").val();
		  			
		    	console.log(authNum,memberName,phone,memberId);
					 $.ajax({ 
						 url:"${pageContext.request.contextPath}/member/chkSmsAuth", 
						type: "POST",
						data: "authNum="+authNum+"&phone="+phone+"&memberName="+memberName+"&enrollMemberId="+memberId,
						dataType : 'text',
						success : function(data){

							console.log(data);
							if(data =="fail"){
		    					$.confirm.show({
		    						  "message": "인증을 실패하였습니다. 인증번호을 확인하세요",
		    						  "yes": function (){
		    						  },
		    						  "hideNo":true,
		    						  "type":"warning" // default or success, danger, warning
		    						})
		    						
								$("#smsAuth").val("").focus();
							}
							
							if( data !="fail"){
		    					$.confirm.show({
		    						  "message": "임시비밀번호을 이메일로 전달하였습니다.",
		    						  "yes": function (){
		    						  },
		    						  "hideNo":true,
		    						  "type":"success" // default or success, danger, warning
		    						})
								
							}
						},
						error: function(jqxhr, textStatus, errorThrown){
							console.log("ajax처리실패! : "+jqxhr.status);
							console.log(jqxhr);
							console.log(textStatus);
							console.log(errorThrown);
						}
					});  
			 
			 
		  	});
	  	  
	  	  
	  	  $("#findId").on("click",function(){
		  		$("#findId").animate({opacity:'1',scale: '1'}, 1000);
		  		$("#findPwd").animate({opacity:'0.4',scale: '0.8'}, 1000);
	  		
	  		  $("#findId-container").show(800, 'easeInBack');
		  	  $("#findPWD-container").hide(800, 'easeInBack');
	  		$("#pwd-memberId").val("");
	  		$("#pwd-memberName").val("");
	  		$("#pwd-phone").val("");
	  		$("#pwd-smsAuth").val("");
	  	  });
	  	  
	  	  $("#findPwd").on("click",function(){
	  		$("#findPwd").animate({opacity:'1',scale: '1'}, 1000);
	  		$("#findId").animate({opacity:'0.4',scale: '0.8'}, 1000);
	  		
	  		$("#findId-container").hide(800, 'easeInBack');
	  		$("#findPWD-container").show(800, 'easeInBack');
	  		$("#memberId").val("");
	  		$("#memberName").val("");
	  		$("#phone").val("");
	  		$("#smsAuth").val("");
		  	});
	  	  
	    });
	 </script>
	  	
</head>
<body>

		<div id="container">
		
			<div id="findBtn" class="container-items">
			
			<button type="button" class="btn btn-outline-success">
				<div id="findId" class="items">
					<i class="far fa-id-badge"></i>
					<p>아이디 찾기</p>
				</div> 
			</button>
				
			<button type="button" class="btn btn-outline-success">				
				<div id="findPwd" class="items">
					<i class="fas fa-unlock-alt"></i>
					<p>비밀번호 찾기</p>
				</div>
			</button>
			
			</div>
		
			<div id="findArea" class="container-items">
				<div id="findId-container" class="nodisplay" >
							<input type="text" class="form-control" name="memberName" id="memberName" placeholder="이름 입력" required>
						<div class="flex">
							<input type="tel" class="form-control" name="phone" id="phone" placeholder="연락처, '-'을 제외하고 입력하세요" required>
							<button type="button" class="btn btn-outline-success" id="phoneAuthBtn">인증문자 발송</button>
						</div>
						
						<div id="smsAuthDiv" class="nodisplay" >
							<div class="flex">
								<input type="number" class="form-control smsAuth" name="smsAuth" id="smsAuth" placeholder="인증문자 입력" required>
								<button type="button" class="btn btn-outline-success smsAuth" id="smsAuthBtn">확인</button>
							</div>
						</div>
						<br />
					<div id="idFindResultDiv" class="nodisplay">
						<input type="text" class="form-control" id="idFindResult" readonly/>
					</div>
				</div>
				
				<div id="findPWD-container" class="nodisplay" >
							<input type="email" class="form-control" name="memberId" id="pwd-memberId" placeholder="id 입력 (이메일 형태)" required>
							<input type="text" class="form-control" name="memberName" id="pwd-memberName" placeholder="이름 입력" required>
						<div class="flex">
							<input type="tel" class="form-control" name="phone" id="pwd-phone" placeholder="연락처, '-'을 제외하고 입력하세요" required>
							<button type="button" class="btn btn-outline-success" id="pwd-phoneAuthBtn">인증문자 발송</button>
						</div>
						
						<div id="pwd-smsAuthDiv" class="nodisplay" >
							<div class="flex">
								<input type="number" class="form-control smsAuth" name="smsAuth" id="pwd-smsAuth" placeholder="인증문자 입력" required>
								<button type="button" class="btn btn-outline-success smsAuth" id="pwd-smsAuthBtn">인증문자 확인</button>
							</div>
						</div>
						<br />
				</div>
			</div>
	</div>
	
</body>
</html>