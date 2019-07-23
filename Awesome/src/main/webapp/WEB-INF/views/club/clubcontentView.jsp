<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="" name="pageTitle"/>
</jsp:include>
<style>
div#clubcontentview-container{width:600px; margin:0 auto; text-align:center;}
div#clubcontentview-container input{margin-bottom:15px;}

</style>		
	
	
	${clubcontent }<Br>
	${club }<Br>
	
	<div style="text-align: center;">
			<c:if test="${empty club.mainrenamedFilename}">
				<img src="${pageContext.request.contextPath }/resources/images/log.jpg"  alt="awesome로고"  style="width: 95%; height: 250px; "  />
			</c:if>
			<c:if test="${not empty club.mainrenamedFilename}">
				<img src="${pageContext.request.contextPath }/resources/upload/club/${club.mainrenamedFilename}"  alt="awesome로고"  style="width: 95%; height: 250px; " />
			</c:if>
	</div>
	
	<div id="clubcontentview-container">
	제목 ,작성자, 작성자,일반게시글or공지사항,내용
	
	<input type="hidden" name="clubCode" value="${club.clubCode}" readonly> 
    <input type="hidden" name="writeLevel" value="${clubcontent.writeLevel }" readonly>
	
	<label for="contentTitle">제목</label>
	<input type="text" class="form-control" name="contentTitle" id="contentTitle" value="${clubcontent.contentTitle }" readonly required>
	<%-- 게시물타입:<c:if test="${clubcontent.clubcontent.writeLevel==1}"><input type="text" value="일반게시물" readonly="readonly"/></c:if>
	<c:if test="${clubcontent.clubcontent.writeLevel==0}"><input type="text" value="공지사항" readonly="readonly"/></c:if> --%>
	<label for="contentWriter">작성자</label>
	<input type="text" class="form-control" name="contentWriter" id="contentWriter" value="${clubcontent.memberNickname}" readonly required>	
    <label for="content">내용</label>
    <textarea class="form-control" name="content" id="content" placeholder="내용" required readonly>${clubcontent.content }</textarea>

</div>



<div class="club-comment">
    <form id="commentForm" name="commentForm" method="post">
    <br><br>
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
                                <a href='#' onClick="fn_comment('${clubcontent.clubcontentCode}')" class="btn pull-right btn-success fol float-right">등록</a>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <input type="hidden" name="meetingcontentCode" value="${clubcontent.clubcontentCode}"/>
		<input type="hidden" name="commentWriter" value="1"/>       
    </form>
</div>
<div class="container">
    <form id="commentListForm" name="commentListForm" method="post">
        <div id="commentList">
        </div>
    </form>
</div>






<script>
<%-- $(function(){
	//댓글textarea focus시에 로그인여부확인
	$("[name=clubCommentContent]").focus(function(){
		if(<%=memberLoggedIn==null%>){
			loginAlert();
		}
	}); --%>

	/*
	 * 댓글 등록하기(Ajax)
	 */
	function fn_comment(code){
	    
	    $.ajax({
	        type:'POST',
	        url : "<c:url value='/club/clubComment.do'/>",
	        data:$("#commentForm").serialize(),
	        success : function(data){
	            if(data=="success")
	            {
	               
	            	$("#commentContent").val('');
	            	getCommentList();
	            	
	            }
	        },
	        error:function(request,status,error){
	            //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	       }
	        
	    });
	}	
	
	/**
	 * 초기 페이지 로딩시 댓글 불러오기
	 */
	$(function(){
	    
	    getCommentList();
	    
	});
	
	/**
	 * 댓글 불러오기(Ajax)
	 */
	function getCommentList(){
		
	    $.ajax({
	        type:'GET',
	        url : "<c:url value='/club/commentList.do'/>",
	        dataType : "json",
	        data:$("#commentForm").serialize(),
	        contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
	        success : function(data){
	            
	            var html = "";
	            var cCnt = data.length;
	            
	            if(data.length > 0){
	      
	                for(i=0; i<data.length; i++){
	                    html += "<div>";
	                    html += "<div><table class='table'><h6><strong>"+data[i].writerNickname+"</strong></h6>";
	                    html += data[i].meetingcomment + "<tr><td></td></tr>";
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
	            
	        },
	        error:function(request,status,error){
	            
	       }
	    });
	}
	
	
	
	
</script>			
	
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>