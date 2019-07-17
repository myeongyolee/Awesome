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
           		background : gray;
           		
           		height:97%;
           		
           		overflow: scroll;
           		
           		border : 1px solid black;
           		border-radius: 5%;
           		
           		display : flex; 
            	flex-direction : column;
			}
			#info-body::-webkit-scrollbar { 
			    display: none; 
			} 
				.info-body-item{
					flex : 1; 
           			margin : 5%;
				}
				
				.flex{
					display : flex; 
            		flex-direction : row;
				}

				
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
	    })

	    
	    $(function(){
    	  $("#phoneAuthBtn").on("click",function(){
      		var userPhoneNumber = $("#phoneAuth").val();
      		$(".smsAuth").slideToggle(1000, 'easeInBack');
      		$("#smsAuth").val("");
      		$("#phoneUpdate").hide(300);
      		
      		/*  $.ajax({        //운영시에 주석해제
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
    	  
    	  //전화번호 수정
    	  $("#phoneUpdate").on("click",function(){
    		  
    		  var phone = $("#phoneAuth").val();
    		  var memberCode = $("#memberCode").val();
    		  var memberId = $("#memberId").val();
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
    		  var memberId = $("#memberId").val();
    		  
    		  var postNo = $("#postNo").val();
    		  var roadAddress = $("#roadAddress").val();
    		  var address = $("#address").val();
    		  var placeLat = $("#placeLat").val();
    		  var placeLng = $("#placeLng").val();
    		  var detailAddress = $("#detailAddress").val();
    		  
    		  console.log(memberCode,memberId,postNo,roadAddress,address,detailAddress);
    		  console.log(placeLat,placeLng);
    		  
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
						$(".addressModi").slideToggle(700, 'easeInBack');
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
    	  
    	  $("#info-head li").on("click",function(){
    		 //$("#"+$(this)[0].className).slideToggle(1000, 'easeInBack');
    		  $("#"+$(this)[0].className).show(1000);
    	  });
    	  
	}); //onload end
		
	</script>
	    	
</head>
<body>
			<input type="hidden" name="memberCode" id="memberCode" value="${member.memberCode }"/>
			<input type="hidden" name="memberId" id="memberId" value="${member.memberId }" readonly>

	<div id="info-container">
		
		<div id="info-body">
		
			<div id="infomation" class="info-body-item">
				<div id="basic-info">
					<div id="basic-info-head">기본정보</div>
					<hr />
						<div id="phone">휴대폰번호 <button type="button" class="btn btn-outline-success" id="phoneModi">수정</button> <br />
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
						<div id="address">사는곳 <button type="button" class="btn btn-outline-success" id="addressModi">수정</button><br />
							<div class="flex">
								도로명주소 :<div id="memberRoadAddress">${address.roadAddress}</div><br />
							</div>
							<div class="flex">
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
				</div>
			</div>
			
		</div>


</body>
</html>