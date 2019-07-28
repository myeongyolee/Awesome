<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>회원가입</title>
	<script src="https://www.google.com/recaptcha/api.js" async defer></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" 
			integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"/>
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=gf3hncw6qx&submodules=geocoder"/>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" 
		integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" 
		crossorigin="anonymous">
		
	<!-- 20190721 김용빈 -->
    <!-- Tiny Nice Confirmation Popup Plugin With jQuery - H-confirm-alert -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/H-confirm-alert.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/H-confirm-alert.css">
    
    <style>
		#modalBody{ 
			display : flex; 
			flex-direction : row;
			justify-content : space-between; 
			align-items : center;      
			align-content : center;       
			max-width : 100%;     
		}
		
		#modalBody span.guide {display:none;font-size: 12px; top:12px; right:10px;}
		#modalBody span.ok{color:green;}
		#modalBody span.error{color:red;}
		
		#modalBody span.pwd {display:none;font-size: 12px; top:12px; right:10px;}
		#modalBody span.error{color:red;}
		.smsAuth {display:none;}
		
			#modalBody #modalList{
				flex : 1 1 0; 
				margin : auto; 
				
				display : flex; 
				flex-direction : column;
				justify-content : space-between; 
			}
				#modalBody #modalList .btn{
					flex : 1 1 0; 
					margin : auto;
					margin-top : 1%; 
					width:100%;
				}
			
			
			
			#modalBody .modal-body{
				flex : 1 1 0; 
				margin : auto; 
			}
			
			 #introduce{display:none;} 
			 #introduceDiv{border:1px solid gray; border-radius:10px; padding:2%;}
		
		.flex{
					display : flex; 
            		flex-direction : row;
				}
				
		#introduceBtnDiv{text-align: right;}
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
	
	
		//스마트 에디터 연결(자기소개 작성)
		function introducePopup(){
			var pop = window.open("/awesome/member/smartEditor","pop","width=610,height=450, scrollbars=yes, resizable=yes");
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
		    	$.confirm.show({
					  "message": str,
					  "yes": function (){
						  $("#enrollMemberId").focus();
	    				  $("#idDuplicateCheck").val(0);
					  },
					  "hideNo":true,
					  "type":"warning" // default or success, danger, warning
					})
		        return false;
		    }else{
		        return true;
		    }
		}
		
		 function nullChk(v,y,str){
		    var id = $("#"+y).val();

		    if(v.test(id)){
		    	$.confirm.show({
					  "message": str,
					  "yes": function (){
						  $("#enrollMemberId").focus();
	    				  $("#idDuplicateCheck").val(0);
					  },
					  "hideNo":true,
					  "type":"warning" // default or success, danger, warning
					})
		        return false;
		    }else{
		        return true;
		    }
		 }
	
	  	function enrollValidate(){
	  		console.log("!!start!!!");
	  		result=false;
            $.ajax({
                url: '${pageContext.request.contextPath}/member/VerifyRecaptcha',
                type: 'post',
                async: false,
                data: {
                    recaptcha: $("#g-recaptcha-response").val()
                },
                success: function(data) {
                    switch (data) {
                        case 0:
                        	result=true;
                            break;

                        case 1:
                        	result=false;
                            $.confirm.show({
         						  "message": "자동 가입 방지 봇을 확인 한뒤 진행 해 주세요.",
         						  "yes": function (){
         						  },
         						  "hideNo":true,
         						  "type":"warning" // default or success, danger, warning
         						})
                            break;

                        default:
                        	result=false;
                            $.confirm.show({
       						  "message": "자동 가입 방지 봇을 실행 하던 중 오류가 발생 했습니다. [Error bot Code : " + Number(data) + "]",
       						  "yes": function (){
       						  },
       						  "hideNo":true,
       						  "type":"warning" // default or success, danger, warning
       						})
                        	break;
                    }
                }
            });
            console.log("!!!!!"+result);
	  		if(!result){
	  			return false;
	  		}
            
			if($("#idDuplicateCheck").val()!=1 ){
				
				$.confirm.show({
						  "message": "아이디 중복 여부 확인하세요.",
						  "yes": function (){
						  },
						  "hideNo":true,
						  "type":"warning" // default or success, danger, warning
						})
				
				$("#memberId").focus();
				return false;
			}
			
			if($("#nickDuplicateCheck").val()!=1 ){
				$.confirm.show({
					  "message": "닉네임 중복 여부 확인하세요.",
					  "yes": function (){
					  },
					  "hideNo":true,
					  "type":"warning" // default or success, danger, warning
					})
				$("#nickDuplicateCheck").focus();
				return false;
			}
			
			if($("#smsAuthChk").val()!=1 ){
				
				$.confirm.show({
					  "message": "핸드폰 인증이 필요합니다.",
					  "yes": function (){
					  },
					  "hideNo":true,
					  "type":"warning" // default or success, danger, warning
					})
					
				$("#phoneAuth").focus();
				
				return false; //운영시에 주석해제
			}
			return true;
		}
		
      $(function(){
    	  $("#phoneAuthBtn").on("click",function(){
      		var userPhoneNumber = $("#phoneAuth").val();
			if($("#phoneAuth").val().length<10 ){
				
				$.confirm.show({
						  "message": "연락처을 -을 제외하고 입력하세요",
						  "yes": function (){
						  },
						  "hideNo":true,
						  "type":"warning" // default or success, danger, warning
						})
				
				$("#phoneAuth").focus();
				return false;
			}
      		
			$.ajax({        //운영시에 주석해제
  			 	url:"${pageContext.request.contextPath}/member/checkPhoneDuplicate.do", 
      			type: "POST",
      			data: "userPhoneNumber="+userPhoneNumber,
				dataType : 'json',
      			success : function(data){
      				console.log(data);
      				if(data.isUsable){
      					 $.ajax({        //운영시에 주석해제
    	      			 	url:"${pageContext.request.contextPath}/member/sendSMS", 
    		      			type: "POST",
    		      			data: "userPhoneNumber="+userPhoneNumber,
    						dataType : 'text',
    		      			success : function(data){
    		      				
    		      				if(data !="전송 실패"){
    			      				$(".smsAuth").show(400);
    			      				$("#smsAuthBtn").show(400);
    			
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
	      			}else{
	      				$.confirm.show({
							  "message": "이미 사용중인 번호입니다.",
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
							  "type":"warning" // default or success, danger, warning
							})
							
						$("#smsAuth").val("").hide(400);
						$("#smsAuthBtn").hide(400);
						//$(".smsAuth").hide();
						$("#smsAuthChk").val(1);
						//$("#phoneAuthBtn").hide();
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
    	  
    	  
    	$("#idDuplicateCheckBtn").on("click",function(){
    		var memberId = $("#enrollMemberId").val().trim();
    		
    		
    	    var regExp1 = /^[a-z][a-z\d]{3,11}/;
    	    var regExp2 = /[0-9]/;
    	    var regExpId = /\s/;
    	    var regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

    	    var bool = regExpTest(regEmail,"enrollMemberId","사용자 아이디는 이메일형식으로 입력하세요");
    	    if(!bool){
    	    	$("#enrollMemberId").focus();
    	    	return;
    	    }
    	    
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
    					$.confirm.show({
							  "message": "사용가능한 아이디입니다.",
							  "yes": function (){
								  $("#nickName").focus();
			    				  $("#idDuplicateCheck").val(1);
							  },
							  "hideNo":true,
							  "type":"warning" // default or success, danger, warning
							})
    					
    				}else{
    					$.confirm.show({
    						  "message": "사용불가한 아이디입니다 ",
    						  "yes": function (){
    							  $("#enrollMemberId").focus();
    		    				  $("#idDuplicateCheck").val(0);
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
    					$.confirm.show({
  						  "message": "사용 가능 한 닉네임입니다.",
  						  "yes": function (){
  							$("#password_").focus();
  	    					$("#nickDuplicateCheck").val(1);
  						  },
  						  "hideNo":true,
  						  "type":"warning" // default or success, danger, warning
  						})
    				}else{
    					$.confirm.show({
   						  "message": "사용 불가 한 닉네임입니다.",
   						  "yes": function (){
   		    					$("#nickName").focus();
   		    					$("#nickDuplicateCheck").val(0);
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
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">회원 가입</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
	          
       <div id="modalBody">
        <!-- : https://getbootstrap.com/docs/4.1/components/forms/#overview -->
        <form name="memberEnrollFrm" action="${pageContext.request.contextPath}/member/memberEnrollEnd.do" 
        		enctype="multipart/form-data" method="post" onsubmit="return enrollValidate();">
        <div class="modal-body">
        	<div id="img-viewer-container">
				<img id="profileImg" width=200/>
			</div>
			<br />
			<div class="flex">
            		<input type="email" class="form-control" name="memberId" id="enrollMemberId" placeholder="이메일 형식 아이디" value="${param.memberId}" required>
             		<button type="button" class="btn btn-outline-success" id="idDuplicateCheckBtn">중복체크</button>
		  		<input type="hidden" id="idDuplicateCheck" value="0"/>
		  	</div>
              <br />
             <div class="flex">
              <input type="text" class="form-control" name="nickName" id="nickName" placeholder="별명(4~11자 사이로 입력)" required>
              <button type="button" class="btn btn-outline-success" id="nickDuplicateCheckBtn">중복체크</button>
              <input type="hidden" id="nickDuplicateCheck" value="0"/>
             </div>
              <br />
              <input type="password" class="form-control" name="password" id="password_" placeholder="비밀번호" required>
              <span class="pwd error ori">패스워드는 6글자이상 입력하세요</span>
              <br />
              <input type="password" class="form-control" name="passwordChk" id="passwordChk" placeholder="비밀번호 확인" required>
              <span class="pwd error chk">패스워드가 일치하지 않습니다.</span>
              <br />
	            <div id="profileUp" class="input-group mb-3" style="padding:0px;">
				  <div class="custom-file">
				    <input type="file" class="form-control custom-file-input" name="upfile" id="upfile" onchange="loadImg(this);">
				    <label class="custom-file-label" for="upfile"><i class="far fa-user"> 프로필 사진 등록</i></label>
				  </div>
				</div>
              <br />
              
              <input type="text" class="form-control" name="memberName" placeholder="이름" required>
              <br />
              <input type="date" class="form-control" name="birthday" placeholder="생년월일" required>
              <br />
              
              <div class="flex">
	            <div class="custom-control custom-radio">
				  <input type="radio" id="gender_m" name="gender" class="custom-control-input" value="M" checked required>
				  <label class="custom-control-label" for="gender_m">male</label>
				</div> &nbsp;&nbsp;&nbsp;
				<div class="custom-control custom-radio">
				  <input type="radio" id="gender_f" name="gender" class="custom-control-input" value="F" required>
				  <label class="custom-control-label" for="gender_f">female</label>
				</div>
			</div>

			<br />
              
              <div class="flex">
	              <input type="tel" class="form-control" name="phone" id="phoneAuth" placeholder="연락처, '-'을 제외하고 입력하세요" required>
	              <button type="button" class="btn btn-outline-success" id="phoneAuthBtn">인증문자 발송</button>
              </div>
              <div class="flex">
	              <input type="number" class="form-control smsAuth" name="smsAuthInput" id="smsAuth" placeholder="인증문자 입력">
	              <button type="button" class="btn btn-outline-success smsAuth" id="smsAuthBtn">확인</button>
	              <input type="hidden" id="smsAuthChk" value="0"/>
              </div>
              <br />
              <div class="flex">
	              <input type="number" class="form-control" name="postNo" id="postNo" placeholder="우편번호" required readonly>
	              <button type="button" class="btn btn-outline-success" onclick="goPopup()">검색</button>
              </div>
              <input type="text" class="form-control" name="roadAddress" id="roadAddress" placeholder="주소" required readonly>
              <input type="hidden" class="form-control" name="address" id="address" placeholder="지번주소" required readonly>
              <input type="hidden" class="form-control" name="placeLat" id="placeLat" placeholder="위도" required readonly>
              <input type="hidden" class="form-control" name="placeLng" id="placeLng" placeholder="경도" required readonly>
              <input type="text" class="form-control" name="detailAddress" id="detailAddress" placeholder="상세주소" required readonly>
              <br />
<!--               <input type="checkbox" name="blindDateOpen" id="blindDateOpen" value="Y"/>
              <label for="blindDateOpen">소개팅공개여부</label>
              <br />
              <input type="checkbox" name="friendOpen" id="friendOpen" value="Y"/>
              <label for="friendOpen">친구공개여부</label>
              <br />
              <input type="checkbox" name="searchOpen" id="searchOpen" value="Y"/>
				<label for="searchOpen">검색공개여부</label>
              <br /> -->
 			 <textarea name="introduce" id="introduce" cols="30" rows="5" style="resize: none" placeholder="자기소개" required>
			</textarea>
			<div id="introduceDiv" name="introduceDiv">
				<p>안녕하세요!~AWESOME입니다.<br>아래버튼을 눌러 자기소개을 작성하세요!</p>
			</div>
			<div id="introduceBtnDiv">
				<button type="button" class="btn btn-outline-success" id="introduceBtn" onclick="introducePopup()">자기소개 작성</button>
			</div>
				<br />
			<div class="g-recaptcha" data-sitekey="6LfzMK0UAAAAAKN5D-f_R8j35H8xSDPgbxDBBReO"></div>
			<input type="hidden" class="form-control" name="recaptcha" id="recaptcha" readonly>
        </div>
	       <div class="modal-footer">
	         <button type="submit" class="btn btn-outline-success" >확인</button>
	         <button type="button" class="btn btn-outline-success" data-dismiss="modal">취소</button>
	       </div>
       </form>
       </div>
		 <!-- 회원가입 모달 끝 -->
		 
</body>
</html>