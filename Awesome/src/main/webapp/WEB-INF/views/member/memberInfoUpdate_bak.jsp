﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
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
	
	<style>
		div#update-container{width:400px; margin:0 auto; text-align:center;}
		div#update-container input, div#update-container select {margin-bottom:10px;}
		
		span.guide {display:none;font-size: 12px; top:12px; right:10px;}
		span.ok{color:green;}
		span.error{color:red;}
		
		span.pwd {display:none;font-size: 12px; top:12px; right:10px;}
		span.error{color:red;}
		.smsAuth {display:none;}
	</style>
	
		<script>
	
	/*사진 미리보기
	* FileReader객체을 이용해서 동적으로 파일을 읽어옴
	* FileReader.result
	* FileReader.readAsDataURL(file)
	* FileReader.onload
	*/
		function loadImg(f){  //f= input:file 태그
			console.log(f.files); //FileList
			console.log(f.files[0]); // File 실제 업로드한 파일
			
			if(f.files && f.files[0]){ //undefined시에 false로 인식함 (js에서만 이런식으로 동작)
				var reader = new FileReader();
				//파일 읽기메소드 호출. 읽기완료하면 onload에 등록된 함수을 호출
				 reader.readAsDataURL(f.files[0]);
				
				reader.onload = function(){
					//result속성에는 파일컨텐츠가 담겨있음.
					 $("#profileImg").attr("src",reader.result);
					 //$("#profileUp").hide();
				}
			}
		}

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
	    	
	  /*회원가입 유효성검사*/

		function regExpTest(v,y,str){
		    var id = $("#"+y).val();

		    if(!v.test(id)){
		    	alert(str);
		        return false;
		    }else{
		        return true;
		    }
		}
		
		 function nullChk(v,y,str){
		    var id = $("#"+y).val();

		    if(v.test(id)){
		    	alert(str);
		        return false;
		    }else{
		        return true;
		    }
		 }
	
	  	function validate(){
			
			if($("#smsAuthChk").val()!=1 ){
				alert("핸드폰 인증이 필요합니다.");
				$("#phoneAuth").focus();
				
				//return false; //운영시에 주석해제
			}
			
			return true;
		}
		
      $(function(){
    	  $("#phoneAuthBtn").on("click",function(){
      		var userPhoneNumber = $("#phoneAuth").val();
      		$(".smsAuth").show(); //운영시에 삭제
      		
      		/*  $.ajax({         //운영시에 주석해제
      			 url:"${pageContext.request.contextPath}/member/sendSMS", 
      			type: "POST",
      			data: "userPhoneNumber="+userPhoneNumber,
				dataType : 'text',
      			success : function(data){
      				$(".smsAuth").show();
      				alert(data);
      			},
      			error: function(jqxhr, textStatus, errorThrown){
      				console.log("ajax처리실패! : "+jqxhr.status);
      				console.log(jqxhr);
      				console.log(textStatus);
      				console.log(errorThrown);
      			}
      		});  */
    	  });
      	$("#phoneAuthBtn").on("click",function(){
    		$("#smsAuthChk").val(0);	
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
						//$("#smsAuthBtn").hide();
						$("#smsAuthChk").val(1);
						//$("#phoneAuthBtn").hide();
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
    	  
    	  
    	$("#idDuplicateCheckBtn").on("click",function(){
    		var memberId = $("#enrollMemberId").val().trim();
    		
    		
    	    var regExp1 = /^[a-z][a-z\d]{3,11}/;
    	    var regExp2 = /[0-9]/;
    	    var regExpId = /\s/;

    	    var bool = nullChk(regExpId,"enrollMemberId","아이디에는 공백이포함되면 안됩니다.");
    	    if(!bool){
    	    	$("#enrollMemberId").focus();
    	    	return;
    	    }
    		
    		$.ajax({ 
    			 url:"${pageContext.request.contextPath}/member/checkIdDuplicate.do", 
    			data:{memberId: memberId},
    			success : function(data){
    				
    				if(data.isUsable == true){
    					alert("사용 가능 한 아이디입니다.");
    					$("#nickName").focus();
    					$("#idDuplicateCheck").val(1);
    				}else{
    					alert("사용 불가 한 아이디입니다.");
    					$("#enrollMemberId").focus();
    					$("#idDuplicateCheck").val(0);
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
    	
    	$("#nickDuplicateCheckBtn").on("click",function(){
    		var nickName = $("#nickName").val().trim();
    		
    		
    	    var regExp1 = /^.{4,11}/;
    	    var regExp2 = /[0-9]/;
    	    var regExpId = /\s/;

    	    var bool = regExpTest(regExp1,"nickName","사용자 닉네임은 4~11자로 입력하세요");
    	    if(!bool){
    	    	$("#nickName").focus();
    	    	return;
    	    }

    	    var bool = nullChk(regExpId,"nickName","닉네임에는 공백이포함되면 안됩니다.");
    	    if(!bool){
    	    	$("#nickName").focus();
    	    	return;
    	    }
    		
    		$.ajax({ 
    			 url:"${pageContext.request.contextPath}/member/checkNickNameDuplicate.do", 
    			data:{nickName: nickName},
    			success : function(data){
    				
    				if(data.isUsable == true){
    					alert("사용 가능 한 닉네임입니다.");
    					$("#password_").focus();
    					$("#nickDuplicateCheck").val(1);
    				}else{
    					alert("사용 불가 한 닉네임입니다.");
    					$("#nickName").focus();
    					$("#nickDuplicateCheck").val(0);
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
    	
    	
    	$("#password_").blur(function(){
    		$(".pwd.error.ori").hide();
    		if($("#password_").val().length<6){
    			$(".pwd.error.ori").show();
    			$("#password_").focus();
    			return;
    		}
    	});
    	
    	$("#passwordChk").blur(function(){
    		var p1=$("#password_").val(), p2=$("#passwordChk").val();
    		if(p1!=p2){
				$(".pwd.error.chk").show();
    			$("#password_").focus();
    			return;
    		}
    		$(".pwd.error.chk").hide();
    	});
    	
    	$("#phoneAuth").blur(function(){
    		
    		var phoneNo = $("#phoneAuth").val();
    		var findStr = "-";

    		if (phoneNo.indexOf(findStr) != -1) {
    		  $(".pwd.error.phone").show();
    		  $("#phoneAuth").focus();
    		}else{
    			$(".pwd.error.phone").hide();
    		}
    	});
    	
    	
    	$("[name=upfile]").on("change",function(){
    		//사용자가 파일입력을 취소한경우
    		if($(this).prop('files')[0]===undefined){
    			$(this).next(".custom-file-label").html("사진을 선택하세요");
    			return;
    		}
    		// var fileName = $(this).val();   //C:\\fakepath\\'파일명'
    		var fileName = $(this).prop('files')[0].name;
    		console.log(fileName);
    		
    		$(this).next(".custom-file-label").html(fileName);
    	})


    });
	</script>
	    	
</head>
<body>

	<div id="update-container">
		<form name="memberUpdateFrm" action="${pageContext.request.contextPath}/member/memberUpdate.do" 
        		enctype="multipart/form-data" method="post" onsubmit="return validate();">
		    <div id="img-viewer-container">
				<img id="profileImg" width=200 src="${pageContext.request.contextPath}/resources/upload/member/${member.renamedProfile }"/>
			</div>
			<input type="hidden" name="memberCode" value="${member.memberCode }"/>
			<input type="email" class="form-control" placeholder="아이디 (4글자이상)" name="memberId" id="memberId_" value="${member.memberId }" readonly>
			<br />
			<input type="text" class="form-control" placeholder="이름" name="memberName" id="memberName" value="${member.memberName }" >
			<br />
	            <div id="profileUp" class="input-group mb-3" style="padding:0px;">
				  <div class="custom-file">
				    <label class="custom-file-label" for="upfile"><i class="far fa-user"> 프로필 사진 등록</i>
				    	<input type="file" class="form-control custom-file-input" name="upfile" id="upfile" onchange="loadImg(this);">
				    </label>
				  </div>
				</div>
			<br />
			<input type="text" class="form-control" placeholder="별명" name="nickName" id="nickName" value="${member.nickName }" >
			<button type="button" class="btn btn-outline-success" id="nickDuplicateCheckBtn">중복체크</button>
			<br />
  			<select class="form-control" name="gender" required>
			  <option value="" disabled selected>성별</option>
			  <option value="M" ${member.gender == 'M'.charAt(0)?"selected":"" }>남</option>
			  <option value="F" ${member.gender == 'F'.charAt(0)?"selected":"" }>여</option>
			</select>
			<br />
			<input type="date" class="form-control" name="birthday" placeholder="생년월일" value="${member.birthday }">
			<br />
			<input type="tel" class="form-control" placeholder="전화번호 (예:01012345678)" name="phone" id="phoneAuth" maxlength="11"  value="${member.phone }" placeholder="연락처, '-'을 제외하고 입력하세요">
              <span class="pwd error phone">'-'을 제외하고 입력하세요</span>
              <button type="button" class="btn btn-outline-success" id="phoneAuthBtn">인증문자 발송</button>
              <input type="number" class="form-control smsAuth" name="phoneAuthIn" id="smsAuth" placeholder="인증문자 입력">
              <button type="button" class="btn btn-outline-success smsAuth" id="smsAuthBtn">확인</button>
              <input type="hidden" id="smsAuthChk" value="1"/>
			<br />
			  <input type="number" class="form-control" name="postNo" id="postNo" placeholder="우편번호"  value="${address.postNo }" readonly>
              <button type="button" class="btn btn-outline-success" onclick="goPopup()">주소검색</button>
              <br />
              <input type="text" class="form-control" name="roadAddress" id="roadAddress" placeholder="주소"  value="${address.roadAddress }" readonly>
              <br />
              <input type="hidden" class="form-control" name="address" id="address" placeholder="지번주소"  value="${address.address }" readonly>
              <input type="hidden" class="form-control" name="placeLat" id="placeLat" placeholder="위도"  value="${address.placeLat }" readonly>
              <input type="hidden" class="form-control" name="placeLng" id="placeLng" placeholder="경도"  value="${address.placeLng }" readonly>
              <input type="text" class="form-control" name="detailAddress" id="detailAddress" placeholder="상세주소" value="${address.detailAddress }"  readonly>
              <br />
              
			<br />
			<textarea name="introduce" id="introduce" cols="30" rows="5" style="resize: none" placeholder="자기소개" required>${member.introduce }</textarea>
			<br />
			<input type="submit" class="btn btn-outline-success" value="수정" >&nbsp;
			<input type="reset" class="btn btn-outline-success" value="취소">
		</form>
	</div>

</body>
</html>