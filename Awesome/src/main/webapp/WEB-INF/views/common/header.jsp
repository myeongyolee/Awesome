<%@page import="com.kh.awesome.member.model.vo.Member,
			java.util.List.*,
			com.kh.awesome.util.model.vo.Chat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% Member member = (Member)session.getAttribute("memberLoggedIn"); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Awesome</title>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bxslider-4-4.2.12/src/js/jquery.bxslider.js"></script>
    <script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
     <link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
     <%-- jquery ui --%>
     <link rel="stylesheet" href="//apps.bdimg.com/libs/jqueryui/1.10.4/css/jquery-ui.min.css">
     
	<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/fullpage.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bxslider-4-4.2.12/src/js/jquery.bxslider.js"></script>
      <script src="//apps.bdimg.com/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
      
      <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=gf3hncw6qx"></script>
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=gf3hncw6qx&submodules=geocoder"></script>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
     

     <%-- WebSocket:sock.js CDN --%>
	<%-- <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.js"></script>
	WebSocket: stomp.js CDN
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script> --%>
    
    <!-- 20190721 김용빈 -->
    <!-- Tiny Nice Confirmation Popup Plugin With jQuery - H-confirm-alert -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/H-confirm-alert.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/H-confirm-alert.css">
    
    <%-- bootstrap --%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>

    <%-- 구글 폰트 --%>
    <!-- <link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap" rel="stylesheet"> -->
    <link href="https://fonts.googleapis.com/css?family=Jua|Luckiest+Guy&display=swap" rel="stylesheet">
	<style>
		.mdl-layout__header-row{background: white;}
		.mdl-layout__header-row .mdl-navigation__link{color:black;}
		.mdl-layout-title{color:black;}
		#awe-logo-img{height:30px;}
		#modalBody{ flex-direction : row; justify-content : space-between; align-items : center;align-content : center;max-width : 100%;     }
		#modalBody #modalList{flex : 1 1 0; margin : auto; display : flex; flex-direction : column;justify-content : space-between; }
		#modalBody #modalList .btn{flex : 1 1 0; margin : auto;margin-top : 1%; width:100%;}
		#modalBody .modal-body{flex : 1 1 0; margin : auto; }
		#login{font-size: 16px;  right: 50px; width:90px;  }
		.mdl-badge{ border: 1px solid white; background: white;}
		*{font-family: 'Jua', sans-serif;}
		#titleLogo:hover{cursor:pointer;}
		<%-- socket chat --%>
		.dragcomponent{position: fixed;z-index: 10; left:50px; top: 100px;width: 280px; height:450px;border-radius:21px;}
		#chat_head{height:43px; padding-top:10px; padding-left:10px; border-bottom: 1px solid #e1e1e1; width:100%}
		#chat_log{width:279px;  height: 358px; overflow-y: auto; padding: 10px 9px; border-bottom:1px solid #e1e1e1;background:#1aaec5a6;}
		#chat_com{text-align:center; padding-top: 11px;}
		ul>li{list-style: none;}
		ul{padding-left: 10px;}
		ul>li.other span{background: #ffffff; padding:0 10px; border-radius:20px;}
		ul>li.My{text-align:right;}
		ul>li.My span{background: yellow; padding: 0 10px; border-radius: 20px;}
		#chat_com input{border-radius: 10px; border: 2px solid lightblue;}
		#chat_com button{border-radius: 20px;border: 1px solid #f0d5d5;background: #dedede;}
		div#chat_head img{ width: 10px;float: right;margin-right: 20px;}
	</style>
	<script>
	$(function(){
		$(window).scroll(function(){
			var page = $(location).attr('pathname');
			console.log($(document).scrollTop());
			if(page == '/awesome/lightning/lightningList.do'){
				if($(window).scrollTop() >= $(document).height() - $(window).height()){
					getLightningList();
				}			
			}
			else if(page == '/awesome/member/memberInfo.do'){
				
				var name = $("#lightningList-body").attr('name');
				
				if(name == 'lightningListAjax'){
					
					if($(window).scrollTop() >= $(document).height() - $(window).height()){
						lightningListAjax();
					}
					
				}else if(name == 'joinLightningListAjax'){
					
					if($(window).scrollTop() >= $(document).height() - $(window).height()){
						joinLightningListAjax();
					}
					
				}
			}
		});
	});
	</script>
</head>
<body>

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
            <form action="${pageContext.request.contextPath}/member/memberLogin.do" method="post" onsubmit="return validate();">
            
            <div class="modal-body">
                <span>아이디</span>
                <input type="text" class="form-control" name="memberId" id="memberId" placeholder="이메일 형태의 아이디 입력" required>  <br>
                <span>비밀번호</span>
                <input type="password" class="form-control" name="password" id="password" required>  <br>
                <div class="flex">
	            	<div class="custom-control custom-checkbox">
					  <input type="checkbox" class="custom-control-input" name="saveMemberId" id="saveMemberId">
					  <label class="custom-control-label" for="saveMemberId">Save Id</label>
					</div> &nbsp;&nbsp;&nbsp;
					<div class="custom-control custom-checkbox">
					  <input type="checkbox" class="custom-control-input" name="autoLogin" id="autoLogin">
					  <label class="custom-control-label" for="autoLogin">Auto Login</label>
					</div>
            	</div>
            	<br />
                <!-- <a href="http://localhost/awesome/member/findMember.do">아이디/비밀번호를 잃어버렸습니까?.</a> <br> <br> -->
                <a href="#" id="findMember" onclick="findMember()">아이디/비밀번호를 잃어버렸습니까?.</a>
            </div>
            
            
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary">로그인</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
        </form>
                <!-- 20190706 23:48  -->
                <!-- google login 김용빈 -->
               	    <div id="btnJoinGoogle" style="text-align:center"><a href="${google_url}">
					<img width="223" src="${pageContext.request.contextPath}/resources/images/btn_google.png"/></a></div>
					<br>  
                <!-- 20190709 09:36  -->
                <!-- naver login 김용빈 -->             
	                <div id="naver_id_login" style="text-align:center"><a href="${naver_url}">
					<img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/></a></div>
					<br>  
                       
     </div>
   </div>
 </div>
<!-- 20190705 12:54 김용빈 
회원가입 모달 추가 -->
<div class="modal fade" id="memberEnrollModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
    
      
    </div>
  </div>
</div>
<!-- 회원가입 모달 끝 -->

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
          <input type="hidden" name="memberLoggedIn" value="<%=member!=null?member.getMemberCode():""%>"/> <!-- 로그인된 회원의 멤버코드라고 가정 -->
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
          <input type="hidden" name="memberLoggedIn" value="<%=member!=null?member.getMemberCode():""%>"/> <!-- 로그인된 회원의 멤버코드라고 가정 -->
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


    <!-- Always shows a header, even in smaller screens. -->
    <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
      <header class="mdl-layout__hea.der">
        <div class="mdl-layout__header-row">
          <!-- Title -->
          <span id="titleLogo" class="mdl-layout-title"><img id="awe-logo-img" src="${pageContext.request.contextPath }/resources/images/awesome-nontext.png" alt="" /> &nbsp;&nbsp;Awesome</span>
          <!-- Add spacer, to align navigation to the right -->
          <div class="mdl-layout-spacer"></div>
          <!-- Navigation. We hide it in small screens. -->
          <nav class="mdl-navigation">
            <!-- Icon badge -->
            <c:if test="${ memberLoggedIn != null}">
                <button id="demo-menu-lower-left" data-badge="♥" class="mdl-button mdl-js-button mdl-badge">Mesaage</button>
                    
                    <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu mdl-js-ripple-effect" for="demo-menu-lower-left" id="chatBox">
                    </ul>
            </c:if>
	        
            <c:if test="${memberLoggedIn == null }">
            	<input type="button" class="btn btn-light mdl-navigation__link" onclick="signUp()" value="Sign Up"></input>
            </c:if>
            
            <script>
            	function signUp(){
    				$("#signUp").trigger("click");
    			}
            </script>
            
            <c:if test="${memberLoggedIn != null }">
	            <input type="button" class="btn btn-light mdl-navigation__link" id="menu2" value="소개팅" />
	            <input type="button" class="btn btn-light mdl-navigation__link" id="menu2" value="번개모임" onclick="location.href='${pageContext.request.contextPath}/lightning/lightningList.do'"/>
	            <input type="button" class="btn btn-light mdl-navigation__link" id="menu2" value="동네 친구" onclick="modaltest();" />
	            <input type="button" value="동네친구찾기MODAL" class="modal" name="modal" data-toggle="modal" data-target="#searchfriend" style="display:none;" />
	            <input type="button" class="btn btn-light mdl-navigation__link" id="menu2" value="소모임" />
	            <input type="button" class="btn btn-light mdl-navigation__link" id="menu2" value="동창모임" onclick="searchSchool();"/>
	            <input type="button" value="동창찾기MODAL" name="schoolModal" data-toggle="modal" data-target="#searchModal" style="display:none;"/>
            </c:if>
            
            <c:if test="${memberLoggedIn == null }">
                <input type="button" class="btn btn-light mdl-navigation__link" id="login" data-toggle="modal" data-target="#loginmodal" value="Login"></input>
            </c:if>
            <c:if test="${memberLoggedIn != null }">
            	<input type="button" class="btn btn-light mdl-navigation__link" onclick="myInfo()" value="My Info"></input>
            	<input type="button" class="btn btn-light mdl-navigation__link" id="logOut" value="LogOut"></input>
            </c:if>
          </nav>
        </div>
	  </header>
	  <main class="mdl-layout__content">
	    <div class="page-content">
<script>

$(function(){
	$("#titleLogo").on("click",function(){
		location.href="${pageContext.request.contextPath}/index";
   });
	
})

function myInfo(){
	location.href="${pageContext.request.contextPath}/member/memberInfo.do";
}

function findMember(){
	window.open("/awesome/member/findMember.do","pop","width=570,height=420, scrollbars=yes, resizable=yes");
}


/* <!-- 20190705 12:54 김용빈  --> */
/* <!-- 회원가입 모달 추가 - --> */
    $(function(){
        $("#signUp").on("click",function(){
        	
            $.ajax({ 
                 url:"${pageContext.request.contextPath}/member/memberEnroll.do", 
                 data:"memberId=${param.memberId}",
                success : function(data){
                    $("#memberEnrollModal .modal-content").empty();
                    $("#memberEnrollModal .modal-content").append(data);
                    
                },
                error: function(jqxhr, textStatus, errorThrown){
                    console.log("ajax처리실패! : "+jqxhr.status);
                    console.log(jqxhr);
                    console.log(textStatus);
                    console.log(errorThrown);
                }
            });
        });
    })
/* <!--20190711 09:34 김용빈--> */
    $("#logOut").on("click",function(){
        
        var logout=confirm("정말로 로그아웃?");
        
        if(logout){
            location.href='${pageContext.request.contextPath}/member/memberLogout.do';
        }
    });
    
/* <!-- 20190715 12:35 김용빈  -->
<!-- 아이디 저장 --> */
    $(function(){
        $("#memberId").val(localStorage.getItem("awesomeSaveMemberId"));
    });
    
    function validate(){
        if($("#saveMemberId").prop("checked")){
            var value = $("#memberId").val();
            localStorage.setItem("awesomeSaveMemberId", value);
        }else{
            localStorage.setItem("awesomeSaveMemberId", "");
        }
        
        return true;
    }
    
    
	/* 20190721 김용빈 */
	//자동로그인 경고창
	$("#autoLogin").on("click",function(){
		
		if($("#autoLogin").prop("checked")){
			$.confirm.show({
				  "message": "개인정보보호를 위해 주의해주세요 <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;자동로그인 쿠키는 일주일간 보관됩니다. ",
				  "yes": function (){
				  },
				  "no": function (){
					  $("#autoLogin").prop("checked",false);
				  },
				})
		}
	});
	
	$(function(){
	
	<%-- socket 관련 ajax --%>
	$("#demo-menu-lower-left").on("click",function(){
		var mCode = ${memberLoggedIn.memberCode}
		console.log("hello chatBox")
		$.ajax({ 
			 	url:"${pageContext.request.contextPath}/sock/selectChat", 
			 	data: mCode,
			success : function(data){
				$("ul#chatBox").html(data.html)
			},
			error: function(jqxhr, textStatus, errorThrown){
				console.log("ajax처리실패! : "+jqxhr.status);
			}
		})
		
	})
	
	$("li.mdl-menu__item").on("click",function(){
		var mCode = $(this).attr("id");
		console.log("mCode = "+mCode);
		
		$.ajax({
			url : "${pageContext.request.contextPath}/sock/selectMyChat",
			data: mCode,
			success: function(data){
				var html ='<div id="draggable" class="ui-widget-content dragcomponent">'
					html +=  '<div id="chat_head">'
			  	 	html += '&nbsp;&nbsp;&nbsp;'+data.receiveMember+'님과의 채팅'
			  		html += '</div>'
			  		html += '<div id="chat_body">'
				  	html += '<div id="chat_log">'
			  		html += '<ul id="'+mCode+'">'
			  		for(var i=0; i<data.size();i++){
			  			if(data.get(i).getMemberCode() == mCode){
			  				html += '<li class="other"><span>'+data.list.get(i).getChatContent()+'</span></li>';
			  			}else{
			  				html += '<li class="My"><span>'+data.list.get(i).getChatContent()+'</span></li>';
			  				
			  			}
			  		}
			  			
			  		html += '</ul>'
			  		html += '</div>'
			  		html += '<div id="chat_com">'
			  		html += '<input type="text" name="message" id="msg" /> <button value="'+mCode+'" class="sendMsg">전송</button>'
			  	 	html += '</div>'
			  		html += '</div>'
					html += '</div>';
				$("body").append(html)
				
				
			},error: function(jqxhr, textStatus, errorThrown){
				console.log("ajax처리 실패! : "+jqxhr.status)
			}
			
		})
	})
	
	<%-- 채팅방 관련 script--%>
	
		$("#removeChat").on("click",function(){
			$(this).parents("#chat_head").parents("#draggable").remove();
		})
		
		$(".sendMsg").on("click",function(){
			//입력한 메시지 가져오기
			var msg = $(this).siblings("input").val();
			
			//input 태그 비워주기
			$(this).siblings("input").val('');
			//memberCodem, receiceMemberCode 가져오기
			var memberCode = ${memberLoggedIn.memberCode}+"";
			var receiveMemberCode = $(this).val();
			
			var sendMsg = "message|"+receiveMemberCode+"|"+msg;
			sendMessage(sendMsg);
			
		})
		
		
	})
</script>
<script type="text/javascript">
 <%if( member != null){%>
		
	function onClose(evt){
		console.log("연결 끊김")
	}
	
	var sock = new SockJS("<c:url value='/echo'/>");
	
	//web socket 메세지보내면 자동 실행
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	
	function sendMessage(msg){
		sock.send(msg);
	}
	
	function onMessage(evt){
		console.log("onMessage 호출됨")
		var data = evt.data;
		var memberCode = null;
		var message = null;
		
		//문자열을 split
		var strArray = data.split("|");
		
		for(var i=0; i<strArray.length; i++){
			console.log("str["+i+"]" + strArray[i])
		}
		 
		messageType = strArray[0];
		sender = strArray[1];
		memberCode = strArray[2];
		message = strArray[3];
		
		console.log("멤버 코드 :" +memberCode)
		console.log("메시지 : "+message)
		
		if(msessageType == "message"){
			if($("ul#"+sender).length() > 0){
				var html = "";
				if(sender == <%=member.getMemberCode()%>){
	  				html = '<li class="My"><span>'+message+'</span></li>';
	  			}else{
	  				html = '<li class="other"><span>'+message+'</span></li>';
	  				
	  			}
				$("ul#"+sender).append(html)
			}
		}else if(messageTpye =="alarm"){
			
		}
	}

	<%}%>

<!-- 동네친구 관련 script -->
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
/* <!-- 동네친구 관련 script END--> */

/* <!-- 동창찾기 관련 script --> */
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
	var ch1 = $("input[name=primary]").val();
	$.ajax({
		url:"${pageContext.request.contextPath}/school/test",
		data:{schoolName1:ch1},
		success:function(data){	
			if(data.response.header.resultCode == '00'){
				$("div.primary-div").html("");
				$("input[name=primary]").removeClass("text-success");
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
					$("input[name=primary]").addClass("text-success");
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
			/* console.log(data); */
			$("div.middle-div").html("");
			$("input[name=middle]").removeClass("text-success");
			
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
					$("input[name=middle]").addClass("text-success");
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
			/* console.log(data); */
			$("div.high-div").html("");
			$("input[name=high]").removeClass("text-success");
			
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
					$("input[name=high]").addClass("text-success");
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
<!-- 동창찾기 관련 script END-->
</script>