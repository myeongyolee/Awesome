<%@page import="com.kh.awesome.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% Member member = (Member)session.getAttribute("memberLoggedIn"); %>

<!-- 부트스트랩관련 라이브러리 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.0.js"></script>

<p>글 내용 : ${detailContent.CONTENT }</p>

<hr />

<div class="club-comment">
 
        <div>
            <div>
                <span><strong>Comments</strong></span> <span id="cCnt"></span>
            </div>
            <div>
                <table class="table">                    
                    <tr>
                        <td>
                            <textarea style="width: 900px" rows="3" cols="30" id="commentContent" name="commentContent" placeholder="댓글을 입력하세요"></textarea>
                            <br>
                            <div>
                                <button onclick="fn_comment(${detailContent.CLUB_CONTENT_CODE})" class="btn pull-right btn-success fol float-right">등록</button>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <input type="hidden" name="meetingcontentCode" value="${detailContent.CLUB_CONTENT_CODE}"/>
		<input type="hidden" name="commentWriter" value="<%=member.getMemberCode()%>"/>
		<input type="hidden" name="commentWriterNickName" value="<%=member.getNickName()%>"/>
  
</div>
<div class="container">
    <form id="commentListForm" name="commentListForm" method="post">
        <div id="commentList">
   
        </div>
    </form>
</div>

<script>
function fn_comment(code){
	var commentContent= $("textarea#commentContent").val();
	var meetingcontentCode = $("[name=meetingcontentCode]").val();
	var commentWriter = $("[name=commentWriter]").val();
	
	$.ajax({
		url:"${pageContext.request.contextPath}/school/insertSchoolComent",
		data:{commentContent:commentContent, meetingcontentCode:meetingcontentCode, commentWriter:commentWriter},
		success:function(data){
			
			if(data == 1){
        		$("#commentContent").val('');
         		getCommentList(); 
			}
		}
	});
}
</script>

<script>
$(function(){
    getCommentList();
});

function getCommentList(){
	var meetingcontentCode = $("[name=meetingcontentCode]").val();
	
	$.ajax({
		url:"${pageContext.request.contextPath}/school/schoolCommentList",
		data:{meetingcontentCode:meetingcontentCode},
		async: false,
		success:function(data){ 
			console.log(data);
			
            var html = "";
            var cCnt = data.length;
            
            if(data.length > 0){
      
                for(i=0; i<data.length; i++){
                    html += "<div>";
                    html += "<div><table class='table'><h6><strong>"+data[i].nickname+"</strong></h6>";
                    html += data[i].comment_content + "<tr><td></td></tr>";
                    html += "</table></div>";
                    html += "</div>";
                }
                
            } else {
                
                html += "<div>";
                html += "<div><table class='table'><h6><strong>등록된 댓글이 없습니다.</strong></h6>";
                html += "</table></div>";
                html += "</div>";
                
            }
            
            $("#cCnt").html(cCnt);
            $("#commentList").html(html);
		}
	});
}
</script>