<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>smart Editor</title>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
	<script src="${pageContext.request.contextPath}/resources/smartEditor/js/service/HuskyEZCreator.js"></script>
	
	<style>
		#rev{display:none;}
	</style>

</head>
<body>
    <textarea rows="13" cols="40" id="textTest" name="textTest"></textarea>
    <button type = "submit" onclick="submitContents()">전송</button>
	
	<script type="text/javascript"> 
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
		    oAppRef: oEditors,
		    elPlaceHolder: "textTest",
		    sSkinURI: "/awesome/resources/smartEditor/SmartEditor2Skin.html",
		    fCreator: "createSEditor2",
		    htParams : { // 툴바 사용 여부 (true/false)
	            bUseToolbar : true, // 입력창 크기 조절바 사용 여부 (true/false)
	            bUseVerticalResizer : true, // 모드 탭(Editor|HTML|TEXT) 사용 여부 (true/false)
	            bUseModeChanger : true // 전송버튼 클릭이벤트
	        }
		});
		
		function submitContents() {
	        // 에디터의 내용이 textarea에 적용
			oEditors.getById["textTest"].exec("UPDATE_CONTENTS_FIELD", []);
	       
	        //alert( $("#textTest").val());
	        //$(opener.document).find("#Form").attr("action","index.do").submit();
			//-opener.document.getElementById("id").value="value"; //dom 객체로 제어
			$("#introduce",opener.document).val($("#textTest").val());
			$("#introduceDiv",opener.document).html($("#textTest").val());
			//window.opener.document.memberEnrollFrm.introduce.value=$("#textTest").val();

			self.close();
		}
	</script>
	
</body>
</html>