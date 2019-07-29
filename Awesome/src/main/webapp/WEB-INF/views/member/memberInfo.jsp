<%@page import="com.kh.awesome.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Awesome" name="title"/>
</jsp:include>

	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" 
    	integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous"/>
	  <!-- bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
	
	
	<style>
		#container{
			display : flex; 
            flex-direction : row;
            
           	height:100%;
           	width :100%;
		}
			#item-head{
           		flex : 1; 
           		margin : 5%;
           		
           		height:100%;
           		
           		display : flex; 
            	flex-direction : column;
            	justify-content :flex-start;
            	
			}
				#item-head-main{
	           		flex : 1; 
	           		margin : auto;
	           		
	           		
	           		width:100%;
	           		height:100%;
	           		
	           		display : flex; 
               		flex-direction : column;
	           		align-items : center;   
				}
					#item-list{
						list-style-type: none;
					}
					
					#profile{
						flex : 4; 
	           			margin : auto;
						
						margin : 2%;
						
						overflow:hidden;
        				border-radius: 70%;
        				width:50%;
					} 
					
				
				#item-head-items{
	           		flex : 3; 
	           		margin : 10%;
	           	
	           		height:100%;
	           		width:100%;
				}
           		
        		#item-body{
        		flex : 4;
        		 height:100vh;
        		 overflow:scroll;
			}
			#item-body::-webkit-scrollbar { 
			    display: none !important; // 윈도우 크롬 등
			}
	</style>
		
	<script>
		$(function(){
			$("#memberInfoUpdate").on("click",function(){
				
	      		  $.ajax({
	      			url:"${pageContext.request.contextPath}/member/memberInfoUpdate.do", 
	      			success : function(data){
	      				$("#item-body").html(data);
	      			},
	      			error: function(jqxhr, textStatus, errorThrown){
	      				console.log("ajax처리실패! : "+jqxhr.status);
	      				console.log(jqxhr);
	      				console.log(textStatus);
	      				console.log(errorThrown);
	      			}
	      		});
			})
			
			$("#memberSecession").on("click",function(){
	      		  $.ajax({
	      			url:"${pageContext.request.contextPath}/member/memberSecession.do", 
	      			success : function(data){
	      				console.log(data);
	      				$("#item-body").html(data);
	      			},
	      			error: function(jqxhr, textStatus, errorThrown){
	      				console.log("ajax처리실패! : "+jqxhr.status);
	      				console.log(jqxhr);
	      				console.log(textStatus);
	      				console.log(errorThrown);
	      			}
	      		});
			})
			
			$("#friendList").on("click",function(){
			var memberCode = $("input[name=memberLoggedIn]").val();
			console.log(memberCode+"zzz");
	      		  $.ajax({
	      			url:"${pageContext.request.contextPath}/map/friendList?memberCode="+memberCode,
	      			success : function(data){
	      				$("#item-body").html(data);  
	      			},
	      			error: function(jqxhr, textStatus, errorThrown){
	      				console.log("ajax처리실패! : "+jqxhr.status);
	      				console.log(jqxhr);
	      				console.log(textStatus);
	      				console.log(errorThrown);
	      			}
	      		});
			})
			
			$("#schoolClubList").on("click",function(){
			var memberCode = $("input[name=memberLoggedIn]").val();
			console.log(memberCode+"zzz");
	      		  $.ajax({
	      			url:"${pageContext.request.contextPath}/school/searchMySchoolClub?memberCode="+memberCode,
	      			success : function(data){
	      				$("#item-body").html(data);  
	      			},
	      			error: function(jqxhr, textStatus, errorThrown){
	      				console.log("ajax처리실패! : "+jqxhr.status);
	      				console.log(jqxhr);
	      				console.log(textStatus);
	      				console.log(errorThrown);
	      			}
	      		});
			})
			
		  $("#info-head li").on("click",function(){
    		 //$("#"+$(this)[0].className).slideToggle(1000, 'easeInBack');
    		  $("#"+$(this)[0].className).show(1000);
    	  });
			
			$("#memberInfoUpdate").trigger("click");
			
		  $("#myLightningInfo").on("click",function(){
      		  $.ajax({
      			url:"${pageContext.request.contextPath}/lightning/lightningInfo.do", 
      			success : function(data){
      				$("#item-body").html(data);
      			},
      			error: function(jqxhr, textStatus, errorThrown){
      				console.log("ajax처리실패! : "+jqxhr.status);
      				console.log(jqxhr);
      				console.log(textStatus);
      				console.log(errorThrown);
      			}
      		  });
		  })
		})
		function questionBoard(){
			location.href='${pageContext.request.contextPath}/questionBoard/questionBoard.do';
		}
</script>
<body>

	<div id="container">
		
		<div id="item-head">
		
			<div id="item-head-main">
				<div id="profile">
					<img id="profileImg" width=100% src="${pageContext.request.contextPath}/resources/upload/member/${member.renamedProfile }"/>
				</div>
				<div id="memberNickName">${member.nickName }</div>
			</div>
			
			<hr />
			
			<div id="item-head-items">
				<ul id="item-list">
					<li><input type="button" class="btn btn-light" id="memberInfoUpdate" value="내정보수정" /></li> 
					<li><input type="button" class="btn btn-light" id="myLightningInfo" value="나의 번개모임" /></li>
					<li><input type="button" class="btn btn-light" id="friendList" value="친구목록" /></li>
					<li><input type="button" class="btn btn-light" id="schoolClubList" value="내가 가입한 동창모임" /></li>
					<br /><br /><br /><br /><br /><br /><br /><br /><br /><hr />
					<li><input type="button" class="btn btn-light" onclick="questionBoard();" value="문의하기" /></li>
					<li><input type="button" class="btn btn-light" id="memberSecession" value="회원탈퇴" />
					</li>

				</ul>
			</div>
			
		</div>
		<div id="item-body">
			
		</div>

		
	</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>