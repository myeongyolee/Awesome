<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>AweSome</title>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bxslider-4-4.2.12/src/js/jquery.bxslider.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/fullpage.js"></script>
    
    <!-- bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
    
    <!-- 구글 폰트 -->
    <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
    <%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/randing.css"> --%>
    <style>
    	body{margin: 0 0;}
		html{overflow: hidden; }
		header div.video{position: relative; }
		header div.video h1{position: absolute; top: 0px; display: none;}
		#top-bar{display:none; height: 60px; margin-right: 173px;}
		#top-bar img{display: inline-block; margin:0 14px; left: -50px;}
		#top-bar span{font-family: 'Nanum Pen Script', cursive; font-size:35px; margin-left:10px;}
		#login{margin: 9px 0; padding: 7px 15px; font-size: 16px; position: fixed; right: 50px; width:90px;  z-index: 999; display: none;}
		header #content-container{min-height: 500px;  display: none; }
		header #content-container #index-image{position: relative; text-align: center; background-color: rgb(250, 232, 234); }
		header #content-container #index-image img{opacity: 0.8; width:1024px; height: 660px;}
		header #content-container #index-image #pTag{position: absolute;top: 0px; left:0px; text-align: center; padding-top: 200px; z-index: 1; }
		header #content-container #index-image #pTag p{ color:white; text-align: center; font-size:80px; margin: 0 0; margin-bottom: 50px; text-shadow: 0 1px 6px rgba(0,0,0,.27)}
		header #content-container #index-image #pTag .mybutton-css{width: 250px;  height: 50px; background: linear-gradient(262deg, #ff7854, #fd267d); 
		        box-shadow: 0 1px 6px 0 rgba(0,0,0,.27); border:0px; font-size:20px; }
		.target{height: 500px;}
		#content-container #page-introduce .container .row .col img#flx{ margin-right:79px; height: 358px; width:310px; margin-top: 100px; border-radius: 60px;}
		header #content-container #page-introduce{background: white;}
		.icon{width: 36px; margin-right: 10px; margin-top:10px;}
		.icon:last-of-type{margin-right:90px;}
		#content-container #meeting-introduce{background: #60f48e;}
		#content-container #meeting-introduce .container .row .col{margin-top: 106px; text-align: center;}
		#content-container #meeting-introduce .container .row .col h3{text-align: center;}
    
 
/* 랜딩페이지 4가지 경로 보여주는곳 CSS*/
div.one{
/* 	border: 2px solid black; */
	width: 900px;
	height: 450px;
	
	display: inline-block;
	
	position: relative;
	top: 10px;
	left: 10px;
}

div.two{
/* 	border: 2px solid black; */
	width: 900px;
	height: 450px;
	
	display: inline-block;
	
	position: relative;
	top: 10px;
	left: 10px;
}

div.three{
/* 	border: 2px solid black; */
	width: 900px;
	height: 450px;
	
	display: inline-block;
	
	position: relative;
	top: 20px;
	left: 10px;
}

div.four{
/* 	border: 2px solid black; */
	width: 900px;
	height: 450px;
	
	display: inline-block;
	
	position: relative;
	top: 20px;
	left: 10px;
}

div.container-one, div.container-two, div.container-three, div.container-four{
	position: absolute;
}

div.container-one-text, div.container-two-text, div.container-three-text, div.container-four-text{
	position: relative;
	left: 485px;
	bottom: 400px;
	
	font-family: 'Nanum Gothic', sans-serif;
	
}
    
button.one-button, button.two-button, button.three-button, button.four-button{
	border: 5px solid black;
	padding: 60px 50px;
	
	font-size: 30px;
	text-align: center;
	cursor: pointer; 
}

/* 동네친구찾기 MODAL관련CSS */
textarea{
	border: 5px solid red;
	border-radius: 10px;
}
input#agree{
	position: relative;
	left: 400px;
}
label[for="agree"]{
	position: relative;
	left: 400px;
}

/* 동창찾기 CSS */
input[name=schoolModal]{
	display: none;
}
      
    </style>
    
</head>
<body>
    <header>
    
    <!-- 동네친구찾기버튼 눌렀을 때, 나타나는 MODAL -->
    <div class="modal fade" id="searchfriend" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="position:absolute;">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
        
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">동네친구찾기 추가정보 확인</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
           
          <form action="${pageContext.request.contextPath}/map/enrollFriend" name="friend-frm">
          <input type="text" name="memberLoggedIn" value="124"/> <!-- 로그인된 회원의 멤버코드라고 가정 -->
          <div class="modal-body"> 
			
			<div class="">
				<textarea name="" id="" cols="59" rows="3" readonly>해당 서비스를 이용하기 위해서는 사용자정보 공개를 허용해야 합니다. 사용 하시겠습니까?</textarea>
				<br />
				<input type="checkbox" name="infocheck" id="agree" value="Y" style="display:inline-block" />
				<label for="agree">수락</label>
			</div>
			
			<div class="">
				<p>회원님의 관심분야를 선택하여 주세요!</p>
				<input type="checkbox" name="interesting" id="1" value="음식"/>
				<label for="1">음식</label>
				<input type="checkbox" name="interesting" id="2" value="여행"/>
				<label for="2">여행</label>
				<input type="checkbox" name="interesting" id="3" value="술"/>
				<label for="3">술</label>
				<input type="checkbox" name="interesting" id="4" value="영화"/>
				<label for="4">영화</label>
				<input type="checkbox" name="interesting" id="5" value="기타"/>
				<label for="5">기타</label>
			</div>
			 
          </div>
          
          <div class="modal-footer">
            <button type="button" class="btn btn-outline-success" onclick="summitFrm2();">확인</button>
            <button type="button" class="btn btn-outline-success" data-dismiss="modal">취소</button>
          </div>
          </form>
         
        </div>
      </div>
    </div>
    <!-- 동네친구찾기 MODAL End -->
    
    <!-- 동창모임버튼 눌렀을 때, 나타나는 MODAL -->
    <div class="modal fade" id="searchModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
        
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">나의 출신 학교</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          
          <form action="${pageContext.request.contextPath}/school/enrollSchool" name="school-frm">
          <input type="text" name="memberLoggedIn" value="124"/> <!-- 로그인된 회원의 멤버코드라고 가정 -->
          <div class="modal-body"> <!-- 내가 회원가입할 때 등록한 학교정보 가지고 와서 보여주기 -->
                <input type="text" class="form-control" name="primary" placeholder="출신 초등학교" >
                <input type="hidden" name="primary_id" />
                <input type="hidden" name="primary_address" />
                <button type="button" onclick="test();">확인</button>
               
                <div class="primary-div">
                </div>
                
                <br /> 
                <input type="text" class="form-control" name="middle" placeholder="출신 중학교" >
                <input type="hidden" name="middle_id" />
                <input type="hidden" name="middle_address" />
                <button type="button" onclick="test2();">확인</button>
                
                <div class="middle-div">
                </div>
                
                <br />
                <input type="text" class="form-control" name="high" placeholder="출신 고등학교" >
                <input type="hidden" name="high_id" />
                <input type="hidden" name="high_address" />
                <button type="button" onclick="test3();">확인</button>
                
                <div class="high-div">
                </div>
               
          </div>
          
          <div class="modal-footer">
            <button type="button" class="btn btn-outline-success" onclick="summitFrm();">확인</button>
            <button type="button" class="btn btn-outline-success" data-dismiss="modal">취소</button>
          </div>
          </form>
         
        </div>
      </div>
    </div>
    <!-- 동창찾기MODAL End -->
    
        <button type="button" class="btn btn-primary" id="login" data-toggle="modal" data-target="#loginmodal" href="#">Login</button>
        <div class="video">
            <video autoplay loop muted >
                <source src="${pageContext.request.contextPath}/resources/video/Circle - 17445.mp4" type="video/mp4" />
            </video>
            
            <h1 id="logo">Awesome</h1>
        </div>
        
        <div id="content-container">
            
            <div id="index-image" class="section" >
                <div id="top-bar" >
                    <img src="${pageContext.request.contextPath}/resources/images/paper-plane.png" width="50px" height="50px" id="icon-logo" alt="">
                    
                    <span>Awesome</span>
                </div>
                <div class="bxslider">
                    <img src="${pageContext.request.contextPath}/resources/images/blue-2564660_1280.jpg" alt="">
                    <img src="${pageContext.request.contextPath}/resources/images/portrait-3204843_640.jpg" alt="">
                    <img src="${pageContext.request.contextPath}/resources/images/workplace-1245776_1280.jpg" >
                </div>
                <div id="pTag">
                    <p> &nbsp;&nbsp;&nbsp;Awesome</p>
                    <button type="button" class="btn btn-primary mybutton-css" id="signUp" >Sign up</button>
                </div>
            </div>

            <div id="page-introduce" class="section" >
                <div class="one">
                	<div class="container-one">
                		<img src="${pageContext.request.contextPath}/resources/images/소개팅.jpg" width="50%" height="445px" />
                		<div class="container-one-text">
                			<h2><strong>화끈한 만남을 원하십니까?</strong></h2>
                			<br /> 
                			<h3>더이상 망설이지마세요!</h3>
                			<br />
                			<h3>오직Awesome에서만!</h3>
                			<br />
                			<button class="one-button">짝궁 찾아보기!</button>
                		</div>
                	</div>
                </div>
                
                <div class="two">
                	<div class="container-two">
                		<img src="${pageContext.request.contextPath}/resources/images/동네친구.jpg" width="50%" height="445px" />
                		<div class="container-two-text">
                			<h2><strong>가까운 동네친구를 원하세요?</strong></h2>
                			<br />
                			<h3>더이상 망설이지마세요!</h3>
                			<br />
                			<h3>오직Awesome에서만!</h3>
                			<br />
                			<button class="two-button" onclick="modaltest();">동네친구 찾아보기!</button>
							<input type="button" value="동네친구찾기MODAL" class="modal" name="modal" data-toggle="modal" data-target="#searchfriend" /> 
                		</div>
                	</div>
                </div>
                
                <div class="three">
                	<div class="container-three">
                		<img src="${pageContext.request.contextPath}/resources/images/번개팅.jpg" width="50%" height="445px" />
                		<div class="container-three-text">
                			<h2><strong>번개같은 모임을 원하세요?</strong></h2>
                			<br />
                			<h3>더이상 망설이지마세요!</h3>
                			<br />
                			<h3>오직Awesome에서만!</h3>
                			<br />
                			<button class="three-button">번개팅 찾아보기!</button>
                		</div>
                	</div>
                </div>
                
                <div class="four">
                	<div class="container-four">
                		<img src="${pageContext.request.contextPath}/resources/images/모임.jpg" width="50%" height="445px" />
                		<div class="container-four-text">
                			<h2><strong>같은취미를 가진 모임을 원하세요?</strong></h2>
                			<br />
                			<h3>더이상 망설이지마세요!</h3>
                			<br />
                			<h3>오직Awesome에서만!</h3>
                			<br />
                			<button class="four-button">모임 찾아보기!</button>
                		</div>
                	</div>
                </div>
            </div>
        
          	<div id="page-introduce" class="section" >
         		<div class="one">
                	<div class="container-one">
                		<img src="${pageContext.request.contextPath}/resources/images/졸업식.jpg" width="50%" height="445px" />
                		<div class="container-one-text">
                			<h2><strong>추억을 찾으세요??</strong></h2>
                			<br /> 
                			<h3>더이상 망설이지마세요!</h3>
                			<br />
                			<h3>오직Awesome에서만!</h3>
                			<br />
                			<button class="one-button" onclick="searchSchool();">학교동창 찾아보기!</button>
                			<input type="button" value="동창찾기MODAL" name="schoolModal" data-toggle="modal" data-target="#searchModal"/>
                		</div>
                	</div>
                </div>
         	</div>
        
        </div>
        
        
        <!-- Modal -->
        <div class="modal fade" id="loginmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel">로그인</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <form action="" method="post">
            <div class="modal-body">
                <span>아이디</span>
                <input type="text" class="form-control" name="memberId" id="memberId" required>  <br>
                <span>비밀번호</span>
                <input type="password" class="form-control" name="password" id="password" required>  <br>
                <a href="#">아이디/비밀번호를 잃어버렸습니까?.</a> <br> <br>
                <button type="button">nav</button> 
                <button type="button">gog+</button>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary">로그인</button>
            </div>
        </form>
          </div>
        </div>
      </div>
            
            
            
            
            
            
    </header>

<script>
$(function(){
	$("div.primary-div").hide();
	$("div.middle-div").hide();
	$("div.high-div").hide();
});
</script>


<!-- 동네친구 관련 script -->
<script>
function modaltest(){
	var memberCode = $("input[name=memberLoggedIn]").val();
	console.log(memberCode);
	
	$.ajax({
		url:"${pageContext.request.contextPath}/map/checkInfo",
		data:{memberCode:memberCode},
		success:function(data){
			console.log(data);
			
			if(data == 'Y'){
				console.log("공개");
				location.href = "${pageContext.request.contextPath}/map/searchMap";	
			}
			else{
				console.log("비공개");
				$("input[name=modal]").trigger("click");
				
			}

		},error:function(jqxhr, textStatus, errorThrown){
			console.log("ajax처리실패"+jqxhr.status);
			console.log("ajax처리실패"+textStatus.status);
			console.log("ajax처리실패"+errorThrown.status);
		}
	});
}

function summitFrm2(){
	console.log("summitFrm2들어옴");
	
	if($("input[name=infocheck]").is(":checked")){
		$("form[name=friend-frm]").submit();
	}
	else{
		alert("수락버튼은 확인해주세요.");
	}
}
</script>
<!-- 동네친구 관련 script END-->

<!-- 동창찾기 관련 script -->
<script>
function searchSchool(){
	console.log("동창찾기 버튼누름");
	var memberCode = $("input[name=memberLoggedIn]").val();
	console.log(memberCode);
	
	//해당회원이 학교등록을 했는지 안했는지 여부 확인
	$.ajax({
		url:"${pageContext.request.contextPath}/school/checkSchool?memberCode="+memberCode,
		success:function(data){
			console.log(data);
			
			if(data == 0){
				console.log("등록된 학교 없음. 학교등록 필수");
				$("input[name=schoolModal]").trigger("click");
				
			}
			else{
				console.log("등록된 학교 있음. 동창리스트페이지로 이동");
				location.href="${pageContext.request.contextPath}/school/schoolList?memberCode="+memberCode;
			}
			
		},error:function(jqxhr, textStatus, errorThrown){
			console.log("ajax처리실패"+jqxhr.status);
			console.log("ajax처리실패"+textStatus.status);
			console.log("ajax처리실패"+errorThrown.status);
		}
	});
	
}

function test(){
	
	console.log("test함수 들어옴");
	
	var ch1 = $("input[name=primary]").val();
	
	console.log(ch1);
	
	$.ajax({
		url:"${pageContext.request.contextPath}/school/test",
		data:{schoolName1:ch1},
		success:function(data){
			console.log(data);
			
			if(data.response.header.resultCode == '00'){
				
				console.log(data.response.body.items.length);
				var HTML = "";
				
				if(data.response.body.items.length > 1) {
					for(var i=0; i<data.response.body.items.length; i++){
						console.log("반복문 들어옴 확인");
						
						$("div.primary-div").show();
						
						var result = data.response.body.items[i].schoolNm;
						var result2 = data.response.body.items[i].schoolId;
						var result3 = data.response.body.items[i].lnmadr;
				
						HTML += "<a href='#' onclick='selectPrimary("+i+");' class='p"+i+"'>"+result+"</a>";
						HTML += "<input type='hidden' name='pid"+i+"' value='"+result2+"'>";
						HTML += "<input type='hidden' name='padd"+i+"' value='"+result3+"' >";
						HTML += "&nbsp;&nbsp;&nbsp;";
						HTML += "<p>"+result3+"</p>";
						HTML += "<br/>";
					}
					$("div.primary-div").append(HTML);
				}
				else if(data.response.body.items.length == 1){
					
					var result = data.response.body.items[0].schoolNm;
					var result2 = data.response.body.items[0].schoolId;
					var result3 = data.response.body.items[0].lnmadr;
					
					console.log(result);
					console.log(result2);
					console.log(result3);
					
					$("input[name=primary]").val(result);
					$("input[name=primary_id]").val(result2);
					$("input[name=primary_address]").val(result3);
					
				}
				
			}
			else{
				console.log("해당데이터가 없습니다");
				$("input[name=primary]").val("해당 학교가 존재하지 않습니다.");
			}
		}
	});
}

function test2(){
	
	console.log("test2함수 들어옴");
	
	var ch1 = $("input[name=middle]").val();
	
	console.log(ch1);
	
	$.ajax({
		url:"${pageContext.request.contextPath}/school/test",
		data:{schoolName1:ch1},
		success:function(data){
			console.log(data);
			
			if(data.response.header.resultCode == '00'){
				var HTML = "";
				
				if(data.response.body.items.length > 1) {
					for(var i=0; i<data.response.body.items.length; i++){
						console.log("반복문 들어옴 확인");
						
						$("div.middle-div").show();
						
						var result = data.response.body.items[i].schoolNm;
						var result2 = data.response.body.items[i].schoolId;
						var result3 = data.response.body.items[i].lnmadr;
				
						HTML += "<a href='#' onclick='selectMiddle("+i+");' class='m"+i+"'>"+result+"</a>";
						HTML += "<input type='hidden' name='mid"+i+"' value='"+result2+"'>";
						HTML += "<input type='hidden' name='madd"+i+"' value='"+result3+"' >";
						HTML += "&nbsp;&nbsp;&nbsp;";
						HTML += "<p>"+result3+"</p>";
						HTML += "<br/>";
					}
					$("div.middle-div").append(HTML);
				}
				else if(data.response.body.items.length == 1){
					var result = data.response.body.items[0].schoolNm;
					var result2 = data.response.body.items[0].schoolId;
					var result3 = data.response.body.items[0].lnmadr;
					
					console.log(result);
					console.log(result2);
					console.log(result3);
					
					$("input[name=middle]").val(result);
					$("input[name=middle_id]").val(result2);
					$("input[name=middle_address]").val(result3);
				}
				
			}
			else{
				console.log("해당데이터가 없습니다");
				$("input[name=middle]").val("해당 학교가 존재하지 않습니다.");
			}
		}
	});
}

function test3(){
	
	console.log("test3함수 들어옴");
	
	var ch1 = $("input[name=high]").val();
	
	console.log(ch1);
	
	$.ajax({
		url:"${pageContext.request.contextPath}/school/test",
		data:{schoolName1:ch1},
		success:function(data){
			console.log(data);
			
			if(data.response.header.resultCode == '00'){
				var HTML = "";
				
				if(data.response.body.items.length > 1) {
					for(var i=0; i<data.response.body.items.length; i++){
						console.log("반복문 들어옴 확인");
						
						$("div.high-div").show();
						
						var result = data.response.body.items[i].schoolNm;
						var result2 = data.response.body.items[i].schoolId;
						var result3 = data.response.body.items[i].lnmadr;
				
						HTML += "<a href='#' onclick='selectHigh("+i+");' class='h"+i+"'>"+result+"</a>";
						HTML += "<input type='hidden' name='hid"+i+"' value='"+result2+"'>";
						HTML += "<input type='hidden' name='hadd"+i+"' value='"+result3+"' >";
						HTML += "&nbsp;&nbsp;&nbsp;";
						HTML += "<p>"+result3+"</p>";
						HTML += "<br/>";
					}
					$("div.high-div").append(HTML);
				}
				else if(data.response.body.items.length == 1){
					var result = data.response.body.items[0].schoolNm;
					var result2 = data.response.body.items[0].schoolId;
					var result3 = data.response.body.items[0].lnmadr;
					
					console.log(result);
					console.log(result2);
					console.log(result3);
					
					$("input[name=high]").val(result);
					$("input[name=high_id]").val(result2);
					$("input[name=high_address]").val(result3);
				}
				
			}
			else{
				console.log("해당데이터가 없습니다");
				$("input[name=high]").val("해당 학교가 존재하지 않습니다.");
			}
		}
	});
}

function selectPrimary(num){
	console.log("selectPrimary 들어옴");
	console.log(num);
	
	var result = $("a.p"+num)[0].innerHTML;
	var result2 = $("input[name=pid"+num+"]").val();
	var result3 = $("input[name=padd"+num+"]").val();
	
	console.log(result);
	console.log(result2);
	console.log(result3);
	
	$("input[name=primary]").val(result);
	$("input[name=primary_id]").val(result2);
	$("input[name=primary_address]").val(result3);
	
	$("div.primary-div").hide();
	
}

function selectMiddle(num){
	console.log("selectMiddle 들어옴");
	console.log(num);
	
	var result = $("a.m"+num)[0].innerHTML;
	var result2 = $("input[name=mid"+num+"]").val();
	var result3 = $("input[name=madd"+num+"]").val();
	
	console.log(result);
	console.log(result2);
	console.log(result3);
	
	$("input[name=middle]").val(result);
	$("input[name=middle_id]").val(result2);
	$("input[name=middle_address]").val(result3);
	
	$("div.middle-div").hide();
	
}

function selectHigh(num){
	console.log("selectHigh 들어옴");
	console.log(num);
	
	var result = $("a.h"+num)[0].innerHTML;
	var result2 = $("input[name=hid"+num+"]").val();
	var result3 = $("input[name=hadd"+num+"]").val();
	
	console.log(result);
	console.log(result2);
	console.log(result3);
	
	$("input[name=high]").val(result);
	$("input[name=high_id]").val(result2);
	$("input[name=high_address]").val(result3);
	
	$("div.high-div").hide();
	
}

function summitFrm(){
	console.log("summitFrm들어옴");
	$("form[name=school-frm]").submit();
}
</script>
<!-- 동창찾기 관련 script END-->

    <script>
            $(function(){
                $('.bxslider').bxSlider({
                    auto: true,
                    autoControls: true,
                    stopAutoOnClick: true,
                    pager: true
            });
            $(".bx-controls.bx-has-controls-direction.bx-has-controls-auto.bx-has-pager").css("display","none")
                var myFullpage = new fullpage('#content-container', {
            /*  sectionsColor: ['#1bbc9b', '#4BBFC3', '#7BAABE', 'whitesmoke', '#ccddff'],*/
                anchors: ['firstPage', 'secondPage', '3rdPage', '4thpage', 'lastPage'],
                menu: '#menu',
                lazyLoad: true
            });
			
            $(window).resize(function(){
            	$("#page-introduce div").width($(window).innerWidth()/2 -10)
    			$("#page-introduce .fp-tableCell").width("100%");
            	$("#page-introduce").width("100%");
            })
            
                //video 사이즈 조절
                $("video").width($(window).innerWidth())
                
                $("#logo").css("top",$("video").innerHeight()/2)
                    .css("left",$("video").innerWidth()/2 -95)
                    .fadeIn(3000,function(){
                        $("div.video").remove();
                        $("#top-bar").css("display","inline-block")
                        $("#content-container").fadeIn(1500)
                        $("#login").css("top","0px").css("display","block")
                        $("html").css("overflow-y","auto")
                    })
                
                    
                $(".bx-viewport").height($(window).height())
                $("#index-image img").width($(window).width())
                        .height($(window).innerHeight()-60)
                $("#index-image #main-image").css("height","500px")
                
                
                $("#pTag").width($("#index-image").children("img").width())

                $(".fp-tableCell").height($(this).parent("img").height())

                $("#icon-logo").css("width","50px").css("height","50px")
                $("#myModal").prop("z-index","100").children().prop("z-index","100")

                $("#index-image").siblings().width($(window).width()).height($(window).height())
                
            })
            
    
        </script>
</body>
</html>