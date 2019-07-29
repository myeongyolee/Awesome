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
<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.0.js"></script>
</head>
<body>

<input type="hidden" name="clubCode" value="${Content.CLUB_CODE }" /> 

  <div class="form-group row">
    <label for="club_content_code" class="col-sm-2 col-form-label">글 번호</label>
    <div class="col-sm-10">
      <input type="text" readonly class="form-control-plaintext" id="club_content_code" value="${Content.CLUB_CONTENT_CODE }">
    </div>
  </div>
  
  <div class="form-group row">
    <label for="content_title" class="col-sm-2 col-form-label">글제목</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="content_title" value="${Content.CONTENT_TITLE }">
    </div>
  </div>
   
   <div class="form-group row">
    <label for="content" class="col-sm-2 col-form-label">글내용</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="content" value="${Content.CONTENT }">
    </div>
  </div>
  
  <button onclick="cancel();">취소</button>
  <button onclick="updateContentEnd();">수정</button>


<script>
function updateContentEnd(){
	var clubCode = $("input[name=clubCode]").val();
	
 	var clubContentCode = $("input#club_content_code").val();
	var contentTitle = $("input#content_title").val();
	var content = $("input#content").val();
	
	$.ajax({
		url:"${pageContext.request.contextPath}/school/updateContentEnd",
		data:{clubContentCode:clubContentCode, contentTitle:contentTitle, content:content},
		success:function(data){
			
			if(data > 0){
				window.opener.location.reload();
				self.close();
			}
		}
	});
}
</script>

<script>
function cancel(){
	self.close();
} 
</script>

</body>
</html>