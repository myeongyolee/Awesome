<%@page import="com.kh.awesome.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>회원 탈퇴 페이지</title>
	
	    
    <!-- 20190723 김용빈 -->
    <!-- Tiny Nice Confirmation Popup Plugin With jQuery - H-confirm-alert -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/H-confirm-alert.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/H-confirm-alert.css">
    
    
	<style>
	
	#infoHead{font-size:25px; font-weight: bold; color:red;}
	.nameHead2{font-size:23px; font-weight: bold; color:red;}
	.nameHead{font-size:20px; font-weight: bold;}
	.nodisplay{display:none;}
	
	#warningDiv{
		display : flex; 
        flex-direction : column;
        justify-content : center;
        align-items : center;
		margin-top: 15%;
	}
		.warningHead{
			font-size:30px; font-weight: bold; color:red;
		}
		
		.warningList{
			padding : 2%;
			margin-top : 3%;
			border : 1px solid;
			border-radius: 15px;
		}
			.warningList li{
				font-size:15px; font-weight: bold;
			}
			
			.warningMessage{
				margin-top : 5%;
				font-size:15px; font-weight: bold; color:red;
			}
		
			#basic-info{
           		display : flex; 
            	flex-direction : column;
            	justify-content: flex-start;
	            margin-top: 10%;
	            margin-bottom: 20%;
	            margin-left:25%;
	            width:50%;
	            display:none;
			}
				#basic-info input{
					width:50%;
				}
				
				#sucessionMemberBtn{
					width:100%;
				}
	</style>
	
	<script>
		$(function(){
			
			//이메일 인증
	    	  $("#emailAuth").on("click",function(){
	    		  
	    		  var memberId = $("#memberId_").val();
				  
	 			 $.ajax({ 
					 url:"${pageContext.request.contextPath}/member/authMailSending.do", 
					type: "POST",
					data: "memberId="+memberId,
					dataType : 'text',
					success : function(data){
						if(data !="fail"){
							$.confirm.show({
								  "message": "이메일 발송 완료",
								  "yes": function (){
								  },
								  "hideNo":true,
								  "type":"success" // default or success, danger, warning
								})
								$("#emailAuthVal").slideToggle(1000, 'easeInBack');
								$("#emailAuthBtn").slideToggle(1000, 'easeInBack');
								$("#emailAuth").slideToggle(1000, 'easeInBack');
						}
						if(data =="fail"){
							$.confirm.show({
								  "message": "이메일 발송을 실패하였습니다.",
								  "yes": function (){
								  },
								  "hideNo":true,
								  "type":"warning" // default or success, danger, warning
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
			
			$("#emailAuthBtn").on("click",function(){
	    		  
	    		  var authNum = $("#emailAuthVal").val();
	    		  
	 			 $.ajax({ 
					 url:"${pageContext.request.contextPath}/member/chkSmsAuth", 
					type: "POST",
					data: "authNum="+authNum,
					dataType : 'text',
					success : function(data){
						if(data =="success"){
							$.confirm.show({
								  "message": "이메일 인증을 완료하였습니다.",
								  "yes": function (){
								  },
								  "hideNo":true,
								  "type":"success" // default or success, danger, warning
								})
								$("#emailAuthVal").slideToggle(1000, 'easeInBack');
								$("#emailAuthBtn").slideToggle(1000, 'easeInBack');
								$("#emailAuth").slideToggle(1000, 'easeInBack');
							$("#emailChk").val(1);
							
							if($("#emailChk").val() ==1 && $("#pwdChk").val() ==1 && $("#smsAuthChk").val() ==1){
								$("#sucessionMemberDiv").slideToggle(1000, 'easeInBack');
							}
						}
						if(data =="fail"){
							$.confirm.show({
								  "message": "이메일 인증을 실패하였습니다. 인증번호을 확인하세요",
								  "yes": function (){
								  },
								  "hideNo":true,
								  "type":"warning" // default or success, danger, warning
								})
							$("#emailChk").val(0);
							$("#emailAuth").slideToggle(1000, 'easeInBack');
							$("#emailAuthVal").val("").focus();
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
			
			//이메일 인증
			
			//암호확인
	    	  $("#passwordAuth").on("click",function(){
	    		  
	    		  var password = $("#password_").val();
	    		  var memberCode = $("#memberCode").val();
	    		  var memberId = $("#memberId_").val();
				  
	 			 $.ajax({ 
					 url:"${pageContext.request.contextPath}/member/checkPwd.do", 
					type: "POST",
					data: "password="+password+"&memberId="+memberId+"&memberCode="+memberCode,
					dataType : 'text',
					success : function(data){
						if(data !="fail"){
							$.confirm.show({
								  "message": "확인완료",
								  "yes": function (){
								  },
								  "hideNo":true,
								  "type":"success" // default or success, danger, warning
								})
								$("#pwdChk").val(1);
							if($("#emailChk").val() ==1 && $("#pwdChk").val() ==1 && $("#smsAuthChk").val() ==1){
								$("#sucessionMemberDiv").slideToggle(1000, 'easeInBack');
							}
						}
						if(data =="fail"){
							$.confirm.show({
								  "message": "암호가 틀렸습니다.",
								  "yes": function (){
								  },
								  "hideNo":true,
								  "type":"success" // default or success, danger, warning
								})
							$("#password_").focus();
							$("#password_").val("");
							$("#pwdChk").val(0);
						}
					},
					error: function(jqxhr, textStatus, errorThrown){
						console.log("ajax처리실패! : "+jqxhr.status);
						console.log(jqxhr);
						console.log(textStatus);
						console.log(errorThrown);
					}
				});  
			  });  //암호 확인
			
			  //폰인증 확인
		   	  $("#phoneAuthBtn").on("click",function(){
		      		var userPhoneNumber = $("#memberPhoneVal").val();
		      		console.log(userPhoneNumber);
		      		  $.ajax({        //운영시에 주석해제
		      			 url:"${pageContext.request.contextPath}/member/sendSMS", 
		      			type: "POST",
		      			data: "userPhoneNumber="+userPhoneNumber,
						dataType : 'text',
		      			success : function(data){
		      				if(data !="전송 실패"){
		      					$(".smsAuth").slideToggle(1000, 'easeInBack');
		      					$("#phoneAuthBtn").slideToggle(1000, 'easeInBack');
		          	      		$("#smsAuth").val("");
			
								$.confirm.show({
								  "message": data,
								  "yes": function (){
								  },
								  "hideNo":true,
								  "type":"warning" // default or success, danger, warning
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
		   	$("#smsAuthBtn").on("click",function(){
	    		  
	    		  var authNum = $("#smsAuth").val();
	    		  
	 			 $.ajax({ 
					 url:"${pageContext.request.contextPath}/member/chkSmsAuth", 
					type: "POST",
					data: "authNum="+authNum,
					dataType : 'text',
					success : function(data){
						if(data =="success"){
							$.confirm.show({
								  "message": "문자인증을 완료하였습니다.",
								  "yes": function (){
								  },
								  "hideNo":true,
								  "type":"success" // default or success, danger, warning
								})
							$(".smsAuth").slideToggle(1000, 'easeInBack');
							$("#phoneAuthBtn").slideToggle(1000, 'easeInBack');
							$("#smsAuthChk").val(1);
							
							if($("#emailChk").val() ==1 && $("#pwdChk").val() ==1 && $("#smsAuthChk").val() ==1){
								$("#sucessionMemberDiv").slideToggle(1000, 'easeInBack');
							}
						}
						if(data =="fail"){
							$.confirm.show({
								  "message": "인증을 실패하였습니다. 인증번호을 확인하세요",
								  "yes": function (){
								  },
								  "hideNo":true,
								  "type":"warning" // default or success, danger, warning
								})
							$("#smsAuthChk").val(0);
							$("#smsAuth").val("").focus();
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
		  //폰인증 확인 끝
		  
		  $("#showBasic-info").on("click",function(){
			  $("#basic-info").slideToggle(1000, 'easeInBack');
			  $("#warningDiv").slideToggle(1000, 'easeInBack');
			  
		  });

		})
		
		function sucessionMemberValidate(){
			
			var result=false;
			
			if($("#emailChk").val() ==1 && $("#pwdChk").val() ==1 && $("#smsAuthChk").val() ==1){

				result=confirm("정말로 탈퇴 하시겠습니까? 탈퇴시에 복구는 불가합니다.");
			}
				
			return result;	
		  }
		
	</script>
</head>
<body>
			<input type="hidden" name="memberCode" id="memberCode" value="${member.memberCode }"/>
			<input type="hidden" name="memberId" id="memberId_" value="${member.memberId }"/>
	
	<div id="warningDiv">
		<div class="warningHead">회원탈퇴</div>
		<div class="warningHead2">유의사항 확인 후 탈퇴 신청을 해주세요.</div>
		<div class="warningList">
			<ul>
				<li>회원 탈퇴을 하시면 Awesome에 가입된 모든 서비스을 사용할 수 없습니다.</li>
				<br />
				<li>또한 Awesome의 서비스을 가입/사용 사면서 축척된 정보 및 기록은 모두 삭제되며, 복구가 불가능 합니다.</li>
			</ul>
		</div>
		<div class="warningMessage">위내용을 모두 확인 하였으며, 탈퇴 시 모든 정보가 복구 불가능함에 동의하십니까?</div>
		<br />
		<button type="button" class="btn btn-outline-success " id="showBasic-info">네.. 탈퇴할래요</button>
		<hr />
	</div>
			
	<div id="basic-info">
			<div id="infoHead">아래 3단계 인증을 거쳐주세요</div>
			<hr />
			<div id="id"><span class="nameHead2">1단계. </span><span class="nameHead">이메일 인증</span> <br /></div>
				<div>${member.memberId}</div>
			<div class="flex">
				<button type="button" class="btn btn-outline-success " id="emailAuth">인증 메일 발송</button>
				<input type="number" class="form-control nodisplay" placeholder="인증 번호 입력" name="emailAuthVal" id="emailAuthVal">
				<button type="button" class="btn btn-outline-success nodisplay" id="emailAuthBtn">암호 확인</button>
				<input type="hidden" id="emailChk" value="0"/>
			</div>
			<hr />
			
			<div>
				<span class="nameHead2">2단계. </span><span class="nameHead">패스워드 인증</span> 
				<br />
			</div>
				<div class="passwordModi">
					<div class="flex">
						<input type="password" class="form-control" placeholder="패스워드입력" name="password" id="password_">
						<button type="button" class="btn btn-outline-success  " id="passwordAuth">암호 확인</button>
						<input type="hidden" id="pwdChk" value="0"/>
					</div>
				</div>
			<hr />

			<div id="phone"><span class="nameHead2">3단계. </span><span class="nameHead">휴대폰 인증</span></div>
			<br />
				<div class="phoneModi">
						<div id="memberPhone">${member.phone}</div>
						<input type="hidden" name="memberPhone" id="memberPhoneVal" value="${member.phone}"/>
					<div class="flex">
						<button type="button" class="btn btn-outline-success " id="phoneAuthBtn">인증문자 발송</button>
					</div>
					<br />
					<div class="flex">
						<input type="number" class="form-control smsAuth nodisplay" name="phoneAuthIn" id="smsAuth" placeholder="인증문자 입력">
						<button type="button" class="btn btn-outline-success smsAuth nodisplay" id="smsAuthBtn">인증문자 확인</button>
						<input type="hidden" id="smsAuthChk" value="0"/>
					</div>
				</div>
			<hr />
			
			<div id="sucessionMemberDiv" class="">
				<form action="${pageContext.request.contextPath}/member/sucessionMemberEnd.do" onsubmit="return sucessionMemberValidate();">
				<div><span class="nameHead">탈퇴 사유</span></div>
				<p> - 보다 나은 서비스 개선을 위해 작성해 주세요.</p>
				<textarea name="reason" class="form-control" id="reason" cols="50" rows="5" style="resize: none" ></textarea> 
				<hr />
					<input type="hidden" name="memberCode" value="${member.memberCode }"/>
					<input type="hidden" name="memberId" value="${member.memberId }"/>
					<button type=submit class="btn btn-outline-success" id="sucessionMemberBtn">탈퇴 신청</button>
				</form>
			</div>
	</div>
		

</body>
</html>