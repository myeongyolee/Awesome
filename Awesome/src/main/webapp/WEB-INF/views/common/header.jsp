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
	            <input type="button" class="btn btn-light mdl-navigation__link" id="menu2" value="번개팅" />
	            <input type="button" class="btn btn-light mdl-navigation__link" id="menu2" value="동네 친구" />
	            <input type="button" class="btn btn-light mdl-navigation__link" id="menu2" value="소모임" />
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
		console.log("mCode = "+mCode)
		
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
	<%}%>
	
</script>

