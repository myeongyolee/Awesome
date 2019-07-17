<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.0.js"></script>
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>

<script>
var sock = new SockJS("<c:url value="/echo"/>");

sock.onmessage = onMessage;

sock.onclose = onClose;

$(function(){
	$("#sendBtn").click(function(){
		console.log("send Message");
		sendMessage();
	});
});

function sendMessage(){
	sock.send($("#message").val());
}

function onMessage(evt){
	var data = evt.data;
	console.log(data);
	var sessionid = null;
	var message = null;
	
	var strArray = data.split('|');
	
	for(var i=0; i<strArray.length; i++){
		console.log('str['+i+']:' + strArray[i]);
	}
	
	var currentuser_session = $("#sessionuserid").val();
	consile.log("current session id:" + currentuser_session);
	
	sessionid = strArray[0];
	message = strArray[1];
	
	if(sessionid == currentuser_session){
		var printHTML = "<div class='well'>";
		printHTML += "<div class='alert alert-info'>";
		printHTML += "<strong>["+sessionid+"] -> "+message+"</strong>";
		printHTML += "</div>";
		printHTML += "</div>";
		
		$("#chatdata").append(printHTML);
	}
	else{
		var printHTML = "<div class='well'>";
		printHTML += "<div class='alert alert-warning'>";
		printHTML += "<strong>["+sessionid+"] -> "+message+"</strong>";
		printHTML += "</div>";
		printHTML += "</div>";
		
		$("#chatdata").append(printHTML);
	}
	
	console.log("chatting data:" + data);
}

function onClose(evt){
	$("#data").append("연결 끊김");	
}
</script>

</head>
<body>
채팅view
	<h1>Chatting Page (id: ${userId })</h1>

	<br>

	<div>
		<div>
			<input type="text" id="message"/>
    		<input type="button" id="sendBtn" value="전송"/>
    	</div>
    	<br>
    	<div class="well" id="chatdata" style="height:300px;">
    		<!-- User Session Info Hidden -->
    		<input type="hidden" value="${userId }" id="sessionuserid">
    	</div>
	</div>

</body>
</html>