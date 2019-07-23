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

</head>
<body>
<input type="text" name="clubCode" value="${clubCode }" /> <!-- 안보임 처리할 것 -->
<input type="text" name="length" value="${fn:length(waitingList) }" /> <!-- 안보임 처리할 것 -->
	
	<div class="enroll-container">
	<c:forEach items="${waitingList }" var="list" varStatus="vs">
		<p id="${vs.index }">멤버코드:${list.MEMBER_CODE }</p>
		<p>이름: ${list.MEMBER_NAME }</p>
		<p>성별: ${list.GENDER }</p>
		<input type="checkbox" name="test${vs.index }" id="check" />
		<label for="check">확인</label>
		<hr />
	</c:forEach>
	<button onclick="accept();">가입처리</button>
	</div>
	
<script>
function accept(){
	var clubCode = $("input[name=clubCode]").val();
	var length = $("input[name=length]").val();
	var memberCode = "";
	
	for(var i=0; i<length; i++){
		if($("input[name=test"+i+"]").is(":checked") == true ){
			memberCode += $("p#"+i+"")[0].innerHTML.split(":")[1]+",";
		}
	}
	
	console.log(memberCode);
	
	location.href = "${pageContext.request.contextPath}/school/acceptMember?clubCode="+clubCode+"&memberCode="+memberCode;
}
</script>

</body>
</html>