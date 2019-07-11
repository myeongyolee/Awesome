<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>Document</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
</head>
<body>
<!-- 검색 기능을 표시할 <div>를 생성한다 -->
<div id="postcodify"></div>

<!-- 주소와 우편번호를 입력할 <input>들을 생성하고 적당한 name과 id를 부여한다 -->
<label for="postcode">우편번호</label>
<input type="text" name="postcode" id="postcode" value="" />
<br />
<label for="address">주소</label>
<input type="text" name="address" id="address" value="" />
<input type="text" name="extra_info" id="extra_info" value="" />
<br />
<label for="details">상세주소</label>
<input type="text" name="details" id="details" value="" />
<br />

<button type="button" class="btn btn-outline-success" onclick="confirm()">확인</button>
<!-- jQuery와 Postcodify를 로딩한다 -->

<!-- 위에서 생성한 <div>에 검색 기능을 표시하고, 결과를 입력할 <input>들과 연동한다 -->
<script>

	function confirm(){
		window.opener.document.memberEnrollFrm.postNo.value=$("#postcode").val();
		window.opener.document.memberEnrollFrm.roadAddress.value=$("#address").val()+$("#extra_info").val();
		window.opener.document.memberEnrollFrm.detailAddress.value=$("#details").val();
		
		self.close();
	}
	
    $(function() { $("#postcodify").postcodify({
        insertPostcode5 : "#postcode",
        insertAddress : "#address",
        insertDetails : "#details",
        insertExtraInfo : "#extra_info",
        hideOldAddresses : false
    }); });
</script>
								
</body>
</html>