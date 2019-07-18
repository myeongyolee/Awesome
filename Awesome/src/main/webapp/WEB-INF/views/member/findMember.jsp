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
	    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" 
	    	integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous"/>
	    
			
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
			}
				#findBtn .items i{font-size:100px;}
				
			#container #findArea {display:none;}
				#container #findArea .smsAuth {display:none;}
		 
	</style>
	
	<script>
	    $(function(){
	  	  $("#phoneAuthBtn").on("click",function(){
	  		    var enrollMemberId = $("#enrollMemberId").val();
	    		var phone = $("#phoneAuth").val();
	    		var memberName = $("#memberName").val();
	    		console.log(enrollMemberId.length);
	    		console.log(enrollMemberId,phone,memberName);
	    		
	    		$.ajax({
	    			url:"${pageContext.request.contextPath}/member/chkNamePhone.do",
	    			type : "POST",
	    			data:"phone="+phone+"&memberName="+memberName,
	    			dataType : 'text',
	    			success:function(data){
	    				if(data=="success"){
	    					if(enrollMemberId.length==0){
					    		$("#smsAuth").show();
					    		$("#smsAuthBtn").show();
					    		$("#smsAuthBtn2").hide();
		    				}
	    					if(enrollMemberId.length!=0){
					    		$("#smsAuth").show();
					    		$("#smsAuthBtn").hide();
					    		$("#smsAuthBtn2").show();
		    				}
	    				}else{
							alert("이름과 전화번호가 일치 하지 않습니다.");
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
  		  var phone = $("#phoneAuth").val();
  			
			 $.ajax({ 
				 url:"${pageContext.request.contextPath}/member/chkSmsAuth", 
				type: "POST",
				data: "authNum="+authNum+"&phone="+phone+"&memberName="+memberName,
				dataType : 'text',
				success : function(data){

					console.log(data);
					if(data =="fail"){
						alert("인증을 실패하였습니다. 인증번호을 확인하세요");
						$("#smsAuth").val("").focus();
					}
					
					if( data !="fail"){
						alert("문자인증을 완료하였습니다.");
						console.log(data);
						$("#idFindResult").val(data);
						$(".smsAuth").hide();
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
	  	  
		  	$("#smsAuthBtn2").on("click",function(){
		  		
		  		  var enrollMemberId = $("#enrollMemberId").val();
		  		  var authNum = $("#smsAuth").val();
		  		  var memberName = $("#memberName").val();
		  		  var phone = $("#phoneAuth").val();
		  			
					 $.ajax({ 
						 url:"${pageContext.request.contextPath}/member/chkSmsAuth", 
						type: "POST",
						data: "authNum="+authNum+"&phone="+phone+"&memberName="+memberName+"&enrollMemberId="+enrollMemberId,
						dataType : 'text',
						success : function(data){

							if(data =="fail"){
								alert("인증을 실패하였습니다. 인증번호을 확인하세요");
								$("#smsAuth").val("").focus();
							}
							
							if( data =="success"){
								alert("문자인증을 완료하였습니다. 당신의 비밀번호을 이메일로 전달하였습니다.");
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
	  		  $("#findArea").show();
	  		  $("#enrollMemberId").hide();
	  		  $("#smsAuthBtn2").hide();
	  		  $("#smsAuthBtn").hide();
	  		  $("#idFindResult").show();
	  	  });
	  	  
	  	  $("#findPwd").on("click",function(){
		  		 $("#findArea").show();
		  		 $("#smsAuthBtn2").hide();
		  		 $("#smsAuthBtn").hide();
		  		 $("#enrollMemberId").show();
		  		 $("#idFindResult").hide();
		  	});
	  	  
	    });
	 </script>
	  	
</head>
<body>

		<div id="container">
		
			<div id="findBtn" class="container-items">
				<div id="findId" class="items">
					<i class="far fa-id-badge"></i>
					<p>아이디 찾기</p>
				</div>
				
				<div id="findPwd" class="items">
					<i class="fas fa-unlock-alt"></i>
					<p>비밀번호 찾기</p>
				</div>
			</div>
		
			<div id="findArea" class="container-items">
				<div id="findId-container">
					<%-- <form name="findId" action="${pageContext.request.contextPath}/member/findMemberId.do" 
	        				method="post" onsubmit="return validate();"> --%>
	        			<input type="email" class="form-control" name="memberId" id="enrollMemberId" placeholder="아이디" required>
						<input type="text" class="form-control" name="memberName" id="memberName" placeholder="이름" required>
						<br />
						<input type="tel" class="form-control" name="phone" id="phoneAuth" placeholder="연락처, '-'을 제외하고 입력하세요" required>
						<span class="pwd error phone">'-'을 제외하고 입력하세요</span>
						<button type="button" class="btn btn-outline-success" id="phoneAuthBtn">인증문자 발송</button>
						<input type="number" class="form-control smsAuth" name="phoneAuth" id="smsAuth" placeholder="인증문자 입력" required>
						<button type="button" class="btn btn-outline-success smsAuth" id="smsAuthBtn">확인</button>
						<button type="button" class="btn btn-outline-success smsAuth" id="smsAuthBtn2">확인</button>
						<br />
						
					<!-- </form> -->
					<div id="test">
						<input type="text" id="idFindResult" readonly/>
					</div>
				</div>
			
			</div>
	</div>
	
</body>
</html>