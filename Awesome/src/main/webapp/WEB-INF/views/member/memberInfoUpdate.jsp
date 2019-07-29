<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>내정보 수정 페이지</title>
	
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" 
    	integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous"/>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=gf3hncw6qx&submodules=geocoder"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
	<!-- easing 플러그인 추가 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
    <!-- 스마트에디터 -->
    <script src="${pageContext.request.contextPath}/resources/smartEditor/js/service/HuskyEZCreator.js"></script>
    
    <!-- 20190723 김용빈 -->
    <!-- Tiny Nice Confirmation Popup Plugin With jQuery - H-confirm-alert -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/H-confirm-alert.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/H-confirm-alert.css">
    
    
	<style>
			
			
		#info-container{
			display : flex; 
            flex-direction : row;
            height:100%;
           	width :100%;
		}
			#info-body{
           		flex : 3; 
           		margin : 1%;
           		
           		height:97%;
           		
           		display : flex; 
            	flex-direction : column;
			}
				
				 #basic-info-head{
					text-align: right;
				}  
				
				#info-body input{
					width:50%;
				}
				
				.info-body-item{
					flex : 1; 
           			margin : 5%;
				}
				
					.info-body-item #accessMemberUpdate{
	           			display : flex; 
	            		flex-direction : column;
	            		justify-content: center;
	            		align-items : center;
	            		margin-top: 20%;
					}
					
					.info-body-item #accessMemberUpdate #accessMemberUpdateInput{
	           			display : flex; 
            			flex-direction : row;
	           			width:50%;
					}
					
					.info-body-item #accessMemberUpdate input{
						width:100%;
					}
					
					
				.flex{
					display : flex; 
            		flex-direction : row;
            		justify-content: flex-start;
				}

	.nameHead{font-size:20px; font-weight: bold;}
	.nodisplay{display:none;}
			
	</style>
	
	<script>
	
	/*
	 * 주소검색
	*/
    	function goPopup(){
    		// 주소검색을 수행할 팝업 페이지를 호출합니다.
    		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
    		var pop = window.open("/awesome/member/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes");
    	}
    	
    	function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
    		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
    		$("#postNo").val(zipNo);
    		$("#roadAddress").val(roadAddrPart1);
    		$("#address").val(jibunAddr);
    		$("#detailAddress").val(addrDetail);
    		$("#addressUpdate").show(300);
    		
	    	/* 회원가입시 주소받을 때 사용자 지번주소의 x좌표 , y좌표 구하기 시작 */
	    	naver.maps.Service.geocode({
	    	    address: jibunAddr
	    	}, function(status, response) {
	    	    if (status !== naver.maps.Service.Status.OK) {
	    	        return alert('Something wrong!');
	    	    }

	    	    var result = response.result, // 검색 결과의 컨테이너
	    	        items = result.items; // 검색 결과의 배열
	    		
	    	        $("#placeLat").val(items[0].point.x);
	    	        $("#placeLng").val(items[0].point.y);
	    	        	console.log(items);
	    	    		console.log(items[0].point.x);
	    	    		console.log(items[0].point.y);
	    	     
	    	});
	    	/* 회원가입시 주소받을 때 사용자 지번주소의 x좌표 , y좌표 구하기 끝  */
    	}
    	
    	
	    $(".btn").click(function(){
	        var target = $(this);
	        $("."+target[0].id).each(function(){
	                $(this).slideToggle(1000, 'easeInBack');
	        })
	        console.log(target);
	        
	        if(target[0].id=="introduceModi"){
				oEditors.getById["introduceArea"].exec("CHANGE_EDITING_MODE", ["WYSIWYG"]);
				oEditors.getById["introduceArea"].exec("RESET_TOOLBAR");
	        }

	    })

	    
	    $(function(){
	    	
	    	
	    	  //최초암호확인
	    	  $("#accessMemberUpdatePwdBtn").on("click",function(){
	    		  
	    		  var password = $("#accessMemberUpdatePwd").val();
	    		  var memberCode = $("#memberCode").val();
	    		  var memberId = $("#memberId_").val();
				  
	 			 $.ajax({ 
					 url:"${pageContext.request.contextPath}/member/checkPwd.do", 
					type: "POST",
					data: "password="+password+"&memberId="+memberId+"&memberCode="+memberCode,
					dataType : 'text',
					success : function(data){
						if(data !="fail"){
							$("#accessMemberUpdate").slideToggle(700, 'easeInBack');
							$("#basic-info").slideToggle(700, 'easeInBack');
						}
						if(data =="fail"){
							$.confirm.show({
								  "message": "패스워드가 틀렸습니다.",
								  "yes": function (){
								  },
								  "hideNo":true,
								  "type":"warning" // default or success, danger, warning
								})
								
							$("#accessMemberUpdatePwd").val("");
							$("#accessMemberUpdatePwd").focus();
						}
					},
					error: function(jqxhr, textStatus, errorThrown){
						console.log("ajax처리실패! : "+jqxhr.status);
						console.log(jqxhr);
						console.log(textStatus);
						console.log(errorThrown);
					}
				});  
			  });  //최초암호확인
			  
    	  $("#phoneAuthBtn").on("click",function(){
      		var userPhoneNumber = $("#phoneAuth").val();

      		
      		  $.ajax({        //운영시에 주석해제
      			 url:"${pageContext.request.contextPath}/member/sendSMS", 
      			type: "POST",
      			data: "userPhoneNumber="+userPhoneNumber,
				dataType : 'text',
      			success : function(data){
      				if(data !="전송 실패"){
      					$(".smsAuth").slideToggle(1000, 'easeInBack');
          	      		$("#smsAuth").val("");
          	      		$("#phoneUpdate").hide(300);
	
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
						alert("문자인증을 완료하였습니다.");
						$(".smsAuth").hide();
						$("#phoneUpdate").slideToggle(1000, 'easeInBack');
					}
					if(data =="fail"){
						alert("인증을 실패하였습니다. 인증번호을 확인하세요");
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
						alert("새로운 비밀번호을 입력하세요");
						$(".newPassword").slideToggle(700, 'easeInBack');
					}
					if(data =="fail"){
						alert("패스워드가 틀렸습니다.");
						$("#password_").val("");
						$("#password_").focus();
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
		  
		  //새암호 입력
    	  $("#passwordUpdate").on("click",function(){
		  
		  if($("#newPassword").val()!=$("#passwordChk").val()){
			alert("새로운 비밀번호가 맞지 않습니다");
			$("#passwordChk").val("").focus();
			return;
		  }
    		  
    		  var password = $("#newPassword").val();
    		  var memberCode = $("#memberCode").val();
    		  var memberId = $("#memberId_").val();
    		  console.log(password,memberCode,memberId);
			  
 			 $.ajax({ 
				 url:"${pageContext.request.contextPath}/member/memberUpdate.do", 
				type: "POST",
				data: "password="+password+"&memberId="+memberId+"&memberCode="+memberCode,
				dataType : 'text',
				success : function(data){
					if(data !="fail"){
						alert("암호 변경 성공");
						
						$("#password_").val("");
						$("#newPassword").val("");
						$("#passwordChk").val("");
						$(".newPassword").slideToggle(700, 'easeInBack');
						$(".passwordModi").slideToggle(700, 'easeInBack');
					}
					if(data =="fail"){
						alert("패스워드가 틀렸습니다.");
					}
				},
				error: function(jqxhr, textStatus, errorThrown){
					console.log("ajax처리실패! : "+jqxhr.status);
					console.log(jqxhr);
					console.log(textStatus);
					console.log(errorThrown);
				}
			});  
		  });  //새암호 입력
		  
    	  
    	//닉네임 중복체크 시작
    	  $("#nickDuplicateCheckBtn").on("click",function(){
    		  
    		  var nickName = $("#nick").val();
    		  console.log(nickName);
 			 $.ajax({ 
				 url:"${pageContext.request.contextPath}/member/checkNickNameDuplicate.do", 
				type: "POST",
				data: "nickName="+nickName,
				dataType : 'json',
				success : function(data){
					console.log(data.isUsable);
					if(data.isUsable == true){
						alert("닉네임 사용 가능");
						$("#nickNameUpdate").slideToggle(700, 'easeInBack');
					}else{
						alert("닉네임 사용 불가");
					}
				},
				error: function(jqxhr, textStatus, errorThrown){
					console.log("ajax처리실패! : "+jqxhr.status);
					console.log(jqxhr);
					console.log(textStatus);
					console.log(errorThrown);
				}
			});  
		  });  //닉네임 중복체크 끝
		  
	    //닉네임 수정 시작
    	  $("#nickNameUpdate").on("click",function(){
    		  
    		  var nickName = $("#nick").val();
    		  var memberCode = $("#memberCode").val();
    		  var memberId = $("#memberId_").val();
    		  
 			 $.ajax({ 
				 url:"${pageContext.request.contextPath}/member/memberUpdate.do", 
				type: "POST",
				data: "nickName="+nickName+"&memberCode="+memberCode+"&memberId="+memberId,
				dataType : 'text',
				success : function(data){
					if(data !="fail"){
						alert("닉네임 수정 완료.");
						$("#nickName").html(nickName);
						$("#memberNickName").html(nickName);
						$(".nickNameModi").slideToggle(700, 'easeInBack');
					}
					if(data =="fail"){
						alert("닉네임 수정 실패");
					}
				},
				error: function(jqxhr, textStatus, errorThrown){
					console.log("ajax처리실패! : "+jqxhr.status);
					console.log(jqxhr);
					console.log(textStatus);
					console.log(errorThrown);
				}
			});  
		  });  //닉네임 수정 끝
		  
		//이름 수정 시작
    	  $("#memberNameUpdate").on("click",function(){
    		  
    		  var memberName = $("#memberNameVal").val();
    		  var memberCode = $("#memberCode").val();
    		  var memberId = $("#memberId_").val();
    		  
 			 $.ajax({ 
				 url:"${pageContext.request.contextPath}/member/memberUpdate.do", 
				type: "POST",
				data: "memberName="+memberName+"&memberCode="+memberCode+"&memberId="+memberId,
				dataType : 'text',
				success : function(data){
					if(data !="fail"){
						alert("이름 수정 완료.");
						$("#memberName").html(memberName);
						$(".memberNameModi").slideToggle(700, 'easeInBack');
					}
					if(data =="fail"){
						alert("닉네임 수정 실패");
					}
				},
				error: function(jqxhr, textStatus, errorThrown){
					console.log("ajax처리실패! : "+jqxhr.status);
					console.log(jqxhr);
					console.log(textStatus);
					console.log(errorThrown);
				}
			});  
		  });  //이름 수정 끝
		  
		//생년월일 수정 시작
    	  $("#birthdayUpdate").on("click",function(){
    		  
    		  var birthday = $("#birthdayVal").val();
    		  var memberCode = $("#memberCode").val();
    		  var memberId = $("#memberId_").val();
    		  
 			 $.ajax({ 
				 url:"${pageContext.request.contextPath}/member/memberUpdate.do", 
				type: "POST",
				data: "birthday="+birthday+"&memberCode="+memberCode+"&memberId="+memberId,
				dataType : 'text',
				success : function(data){
					if(data !="fail"){
						alert("생년월일 수정 완료.");
						$("#birthday").html(birthday);
						$(".birthdayModi").slideToggle(700, 'easeInBack');
					}
					if(data =="fail"){
						alert("닉네임 수정 실패");
					}
				},
				error: function(jqxhr, textStatus, errorThrown){
					console.log("ajax처리실패! : "+jqxhr.status);
					console.log(jqxhr);
					console.log(textStatus);
					console.log(errorThrown);
				}
			});  
		  });  //생년월일 수정 끝
		  
		//성별 수정 시작
    	  $("#genderUpdate").on("click",function(){
    		  
    		  var gender = "";
    		  if($("#gender_m").prop("checked")){
	    		  gender = "M";    			  
    		  }else{
    			  gender = "F";
    		  }
    		  var memberCode = $("#memberCode").val();
    		  var memberId = $("#memberId_").val();
    		  
    		  
 			  $.ajax({ 
				 url:"${pageContext.request.contextPath}/member/memberUpdate.do", 
				type: "POST",
				data: "gender="+gender+"&memberCode="+memberCode+"&memberId="+memberId,
				dataType : 'text',
				success : function(data){
					if(data !="fail"){
						alert("성별 수정 완료.");
						
					}
					if(data =="fail"){
						alert("성별 수정 실패");
					}
				},
				error: function(jqxhr, textStatus, errorThrown){
					console.log("ajax처리실패! : "+jqxhr.status);
					console.log(jqxhr);
					console.log(textStatus);
					console.log(errorThrown);
				}
				});  
		  });  //성별 수정 끝
		  
    	  //전화번호 수정
    	  $("#phoneUpdate").on("click",function(){
    		  
    		  var phone = $("#phoneAuth").val();
    		  var memberCode = $("#memberCode").val();
    		  var memberId = $("#memberId_").val();
    		  console.log(phone,memberCode,memberId);
 			 $.ajax({ 
				 url:"${pageContext.request.contextPath}/member/memberUpdate.do", 
				type: "POST",
				data: "phone="+phone+"&memberId="+memberId+"&memberCode="+memberCode,
				dataType : 'text',
				success : function(data){
					if(data !="fail"){
						alert("전화번호 수정완료.");
						$("#memberPhone").html(phone);
						$(".phoneModi").slideToggle(700, 'easeInBack');
					}
					if(data =="fail"){
						alert("전화번호 수정 실패");
					}
				},
				error: function(jqxhr, textStatus, errorThrown){
					console.log("ajax처리실패! : "+jqxhr.status);
					console.log(jqxhr);
					console.log(textStatus);
					console.log(errorThrown);
				}
			});  
		  });  //전화번호 수정 끝
    	  
    	  //주소 수정
    	  $("#addressUpdate").on("click",function(){
    		  
    		  var memberCode = $("#memberCode").val();
    		  var memberId = $("#memberId_").val();
    		  
    		  var postNo = $("#postNo").val();
    		  var roadAddress = $("#roadAddress").val();
    		  var address = $("#address").val();
    		  var placeLat = $("#placeLat").val();
    		  var placeLng = $("#placeLng").val();
    		  var detailAddress = $("#detailAddress").val();
    		  
    		  console.log(memberId);
    		  /* console.log(memberCode,memberId,postNo,roadAddress,address,detailAddress);
    		  console.log(placeLat,placeLng); */
    		  
 			 $.ajax({ 
				 url:"${pageContext.request.contextPath}/member/memberUpdate.do", 
				type: "POST",
				data: "memberCode="+memberCode
						+"&memberId="+memberId
						+"&postNo="+postNo
						+"&roadAddress="+roadAddress
						+"&address="+address
						+"&placeLat="+placeLat
						+"&placeLng="+placeLng 
						+"&detailAddress="+detailAddress,
				dataType : 'text',
				success : function(data){
					if(data !="fail"){
						alert("주소 수정완료.");
						
						$("#memberRoadAddress").html(roadAddress);
						$("#memberDetailAddress").html(detailAddress);
						$("#memberAddress").html(address);
						$("#memberPostNo").html(postNo);
						
						$(".addressModi").slideToggle(700, 'easeInBack');
						
						$("#postNo").val("");
						$("#roadAddress").val("");
						$("#detailAddress").val("");
						
					}
					if(data =="fail"){
						alert("주소 수정 실패");
					}
				},
				error: function(jqxhr, textStatus, errorThrown){
					console.log("ajax처리실패! : "+jqxhr.status);
					console.log(jqxhr);
					console.log(textStatus);
					console.log(errorThrown);
				}
			});  
		  });//주소 수정 끝
    	  
    	  //자기소개 수정
    	  $("#introduceUpdate").on("click",function(){
    		  
    		  var memberCode = $("#memberCode").val();
    		  var memberId = $("#memberId_").val();
    		  
    		  oEditors.getById["introduceArea"].exec("UPDATE_CONTENTS_FIELD", []);
    		  var introduce = $("#introduceArea").val()
		       console.log($("#introduceArea").val());
    		  
    		  
 			 $.ajax({ 
				 url:"${pageContext.request.contextPath}/member/memberUpdate.do", 
				type: "POST",
				data: "memberCode="+memberCode
						+"&memberId="+memberId
						+"&introduce="+introduce,
				dataType : 'text',
				success : function(data){
					if(data !="fail"){
						alert("자기소개 수정완료.");
						$("#introduce").html(introduce);
						$(".introduceModi").slideToggle(700, 'easeInBack');
					}
					if(data =="fail"){
						alert("자기소개 수정 실패");
					}
				},
				error: function(jqxhr, textStatus, errorThrown){
					console.log("ajax처리실패! : "+jqxhr.status);
					console.log(jqxhr);
					console.log(textStatus);
					console.log(errorThrown);
				}
			});  
		  });//자기소개 수정 끝
		  
		  $("#profileModiBtn").on("click",function(){
			  $("#upfile").trigger("click");
		  })
		  
	    $('#profileUpdate').on('click', function(){
	        uploadFile();
	    });
	 
	}); //onload end


		function uploadFile(){
		    
		    var form = $('#uploadForm')[0];
		    var formData = new FormData(form);
		 
		    $.ajax({
		    	url:"${pageContext.request.contextPath}/member/memberUpdate.do", 
				type: "POST",
				//enctype: 'multipart/form-data',
				data : formData,
				dataType : 'text',
				contentType : false, //false 로 선언 시 content-type 헤더가 multipart/form-data로 전송되게 함
		        processData : false, // false로 선언 시 formData를 string으로 변환하지 않음     
		    }).done(function(data){
		        //callback(data);
		        
				if(data !="fail"){
					alert("프로파일 수정완료.");
					$("#profileUpdate").slideToggle(500, 'easeInBack');
					$("#profileImg").attr("src",$("#profileImgModi").attr("src"));
				}
				if(data =="fail"){
					alert("프로파일 수정 실패");
				}
		    });
		}
	
		function loadImg(f){  //f= input:file 태그
			console.log(f.files); //FileList
			console.log(f.files[0]); // File 실제 업로드한 파일
			
			if(f.files && f.files[0]){ //undefined시에 false로 인식함 (js에서만 이런식으로 동작)
				var reader = new FileReader();
				//파일 읽기메소드 호출. 읽기완료하면 onload에 등록된 함수을 호출
				 reader.readAsDataURL(f.files[0]);
				
				reader.onload = function(){
					//result속성에는 파일컨텐츠가 담겨있음.
					 $("#profileImgModi").attr("src",reader.result);
					 //$("#profileUp").hide();
					 $("#profileUpdate").slideToggle(500, 'easeInBack');
				}
			}
		}
	
	
	</script>
	    	
</head>
<body>
			<input type="hidden" name="memberCode" id="memberCode" value="${member.memberCode }"/>
			<input type="hidden" name="memberId" id="memberId_" value="${member.memberId }"/>
	


	<div id="info-container">
		
		<div id="info-body">
		
			<div id="infomation" class="info-body-item">
			
				<div id="accessMemberUpdate">
					<div>본인확인을 위해 패스워드을 입력해주세요!</div>
					<br />
					<div id="accessMemberUpdateInput">
						<input type="password" id="accessMemberUpdatePwd" />
						<button type="button" class="btn btn-outline-success " id="accessMemberUpdatePwdBtn"> 확인</button>
					</div>
				</div>
				<div id="basic-info" class="nodisplay">
					<div id="basic-info-head"><span class="nameHead">기본정보</span></div>
						<hr />
						<div><span class="nameHead">내 이미지</span> <button type="button" class="btn btn-outline-success" id="profileModiBtn">수정</button>
						<button type="button" class="btn btn-outline-success nodisplay" id="profileUpdate">저장</button>
						</div>
						<div id="profileModi">
							<img class="img-fluid rounded img-thumbnail"
							id="profileImgModi" 
							alt="Responsive image" width=30% 
							src="${pageContext.request.contextPath}/resources/upload/member/${member.renamedProfile }"/>
						</div>
						
						<form id="uploadForm" class="nodisplay">
							<input type="hidden" name="memberCode" id="memberCode" value="${member.memberCode }"/>
							<input type="hidden" name="memberId" value="${member.memberId }" readonly>
							 <div id="profileUp" class="input-group mb-3 nodisplay" style="padding:0px;">
							  <div class="custom-file">
							    <input type="file" class="form-control custom-file-input" name="upfile" id="upfile" onchange="loadImg(this);">
							    <!-- <label class="custom-file-label" for="upfile"><i class="far fa-user"> 프로필 사진 등록</i></label> -->
							  </div>
							 </div>
						</form>
						
						<hr />
						<div id="id"><span class="nameHead">아이디</span> <br />
						<div>${member.memberId}</div><br />
						
						<hr />
						
						<div><span class="nameHead">패스워드</span> <button type="button" class="btn btn-outline-success" id="passwordModi">수정</button> <br />
						</div>
							<div class="passwordModi nodisplay">
								<div class="flex">
									<input type="password" class="form-control" placeholder="기존패스워드입력" name="password" id="password_">
									<button type="button" class="btn btn-outline-success " id="passwordAuth">암호 확인</button>
								</div>
								<br />
								<div class="flex newPassword nodisplay">
									    <input type="password" class="form-control" name="password" id="newPassword" placeholder="비밀번호" required>
              							<input type="password" class="form-control" name="passwordChk" id="passwordChk" placeholder="비밀번호 확인" required>
									<button type="button" class="btn btn-outline-success" id="passwordUpdate">비밀번호 수정 </button>
								</div>
							</div>
						<hr />
						
						<div><span class="nameHead">닉네임</span> <button type="button" class="btn btn-outline-success" id="nickNameModi">수정</button> <br />
						<div id="nickName">${member.nickName}</div>
						</div>
							<div class="nickNameModi nodisplay">
								<div class="flex">
									<input type="text" class="form-control" name="nick" id="nick" placeholder="별명(4~11자 사이로 입력)" required>
              						<button type="button" class="btn btn-outline-success" id="nickDuplicateCheckBtn">중복체크</button>
              						<button type="button" class="btn btn-outline-success nodisplay" id="nickNameUpdate">닉네임 수정 </button>
								</div>
							</div>
						<hr />
						
						<div><span class="nameHead">이름</span> <button type="button" class="btn btn-outline-success" id="memberNameModi">수정</button> <br />
						<div id="memberName">${member.memberName}</div>
						</div>
							<div class="memberNameModi nodisplay">
								<div class="flex">
									<input type="text" class="form-control" name="memberName" id="memberNameVal" placeholder="이름 입력" required>
              						<button type="button" class="btn btn-outline-success" id="memberNameUpdate">이름 수정 </button>
								</div>
							</div>
						<hr />
						
						<div><span class="nameHead">생년월일</span> <button type="button" class="btn btn-outline-success" id="birthdayModi">수정</button> <br />
						<div id="birthday">${member.birthday}</div>
						</div>
							<div class="birthdayModi nodisplay">
								<div class="flex">
									<input type="date" class="form-control" name="birthday" id="birthdayVal" placeholder="생년월일" required>
              						<button type="button" class="btn btn-outline-success" id="birthdayUpdate">생일 수정 </button>
								</div>
							</div>
						<hr />
						
						<div><span class="nameHead">성별</span> <button type="button" class="btn btn-outline-success" id="genderUpdate">성별 수정</button> <br />
				       <div class="flex">
				            <div class="custom-control custom-radio">
							  <input type="radio" id="gender_m" name="gender" class="custom-control-input" value="M" ${member.gender eq 'M'.charAt(0)?"checked":"" }>
							  <label class="custom-control-label" for="gender_m">male</label>
							</div> &nbsp;&nbsp;&nbsp;
							<div class="custom-control custom-radio">
							  <input type="radio" id="gender_f" name="gender" class="custom-control-input" value="F" ${member.gender eq 'F'.charAt(0)?"checked":"" }>
							  <label class="custom-control-label" for="gender_f">female</label>
							</div>
						</div>
						<hr />
						
						<div id="phone"><span class="nameHead">휴대폰번호</span> <button type="button" class="btn btn-outline-success" id="phoneModi">수정</button> <br />
						<div id="memberPhone">${member.phone}</div><br />
						</div>
							<div class="phoneModi nodisplay">
								<div class="flex">
									<input type="tel" class="form-control " placeholder="전화번호 (예:01012345678)" name="phone" id="phoneAuth" maxlength="11"  value="${member.phone }" placeholder="연락처, '-'을 제외하고 입력하세요">
									<button type="button" class="btn btn-outline-success " id="phoneAuthBtn">인증문자 발송</button>
								</div>
								<br />
								<div class="flex">
									<input type="number" class="form-control smsAuth nodisplay" name="phoneAuthIn" id="smsAuth" placeholder="인증문자 입력">
									<button type="button" class="btn btn-outline-success smsAuth nodisplay" id="smsAuthBtn">인증문자 확인</button>
									<button type="button" class="btn btn-outline-success nodisplay" id="phoneUpdate">연락처 수정 </button>
								</div>
							</div>
						<hr />
						<div id="address"><span class="nameHead">사는곳</span> <button type="button" class="btn btn-outline-success" id="addressModi">수정</button><br />
							<div class="flex">
								도로명주소 :<div id="memberRoadAddress">${address.roadAddress}</div><br />
							</div>
							<div class="flex">
								우편번호 : <div id="memberPostNo">${address.postNo}</div> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								상세주소 : <div id="memberDetailAddress">${address.detailAddress}</div><br />
							</div>
							<div class="flex">
								지번주소 : <div id="memberAddress">${address.address}</div><br />
							</div>
						</div>
				           		<br />
							<div class="addressModi nodisplay">
								<div class="flex">
								  <input type="number" class="form-control" name="postNo" id="postNo" placeholder="우편번호" required readonly>
					              <button type="button" class="btn btn-outline-success" onclick="goPopup()">검색</button>
				           		</div>
					              <input type="text" class="form-control" name="roadAddress" id="roadAddress" placeholder="주소" required readonly>
					              <input type="hidden" class="form-control" name="address" id="address" placeholder="지번주소" required readonly>
					              <input type="hidden" class="form-control" name="placeLat" id="placeLat" placeholder="위도" required readonly>
					              <input type="hidden" class="form-control" name="placeLng" id="placeLng" placeholder="경도" required readonly>
					              <div class="flex">
					              <input type="text" class="form-control" name="detailAddress" id="detailAddress" placeholder="상세주소" required readonly>
					              <button type="button" class="btn btn-outline-success nodisplay" id="addressUpdate">주소 수정 </button>
					              </div>
							</div>
						<hr />
						
						<div><span class="nameHead">자기소개</span> <button type="button" class="btn btn-outline-success" id="introduceModi">수정</button> <br />
							<div id="introduce">${member.introduce}</div>
						</div>
						<br /><br />
							 <div class="introduceModi nodisplay">
								<div class="flex">
              						<textarea rows="13" cols="40" id="introduceArea" name="introduceArea"></textarea>
              						<button type="button" class="btn btn-outline-success" id="introduceUpdate" onclick="submitContents()">자기소개 수정 </button>
									
									<!-- 스마트에디터 -->
									<script type="text/javascript"> 
									
										var oEditors = [];
										nhn.husky.EZCreator.createInIFrame({
										    oAppRef: oEditors,
										    elPlaceHolder: "introduceArea",
										    sSkinURI: "/awesome/resources/smartEditor/SmartEditor2Skin.html",
										    fCreator: "createSEditor2",
										    fOnAppLoad: function () {    
										        $("iframe").css("width", "100%").css("height", "296px").css("background","white");
										      },
										      
										    htParams : { // 툴바 사용 여부 (true/false)
									            bUseToolbar : true, // 입력창 크기 조절바 사용 여부 (true/false)
									            bUseVerticalResizer : true, // 모드 탭(Editor|HTML|TEXT) 사용 여부 (true/false)
									            bUseModeChanger : true // 전송버튼 클릭이벤트
									        }
										});
										
										function submitContents() {
									        // 에디터의 내용이 textarea에 적용
											oEditors.getById["introduceArea"].exec("UPDATE_CONTENTS_FIELD", []);
									        
									        console.log($("#introduceArea").val());
											//$("#introduceArea").val($("#text").val());
										}
									</script>
								</div>
							</div> 
							<br /><br /><br /><br /><br /><br />
							
						<hr />
				</div>
			</div>
			
		</div>


</body>
</html>