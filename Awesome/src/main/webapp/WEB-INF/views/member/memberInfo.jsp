<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>내정보 수정 페이지</title>
	
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" 
    	integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous"/>
	
	<style>
		#container{
			display : flex; 
            flex-direction : row;
            
           	height:500px;
           	width :1000px;
		}
			#item-head{
           		flex : 1; 
           		margin : auto;
           		background : black;
           		
           		height:100%;
           		
           		display : flex; 
            	flex-direction : column;
			}
				#item-head-main{
	           		flex : 1; 
	           		margin : auto;
	           		
	           		background : blue;
	           		
	           		width:100%;
	           		height:100%;
	           		
	           		display : flex; 
               		flex-direction : column;
	           		align-items : center;   
				}
					#profile{
						flex : 4; 
	           			margin : auto;
						
						background : pink;
						margin : 2%;
						
						overflow:hidden;
						border: 1px solid black;
        				border-radius: 70%;
        				width:50%;
					} 
					
					#memberName{
						flex : 1; 
	           			margin : auto;
					}
				
				#item-head-items{
	           		flex : 3; 
	           		margin : 10%;
	           		background : yellow;
	           	
	           		height:100%;
				}
			
			#item-body{
           		flex : 4; 
           		margin : auto;
           		background : red;
           		
           		/* overflow: scroll; */
           		height:100%;
			}
			
 			#item-body::-webkit-scrollbar { 
			    display: none; 
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
		})
	</script>
	    	
</head>
<body>

	<div id="container">
		
		<div id="item-head">
		
			<div id="item-head-main">
				<div id="profile">
					<img id="profileImg" width=100% src="${pageContext.request.contextPath}/resources/upload/member/${member.renamedProfile }"/>
				</div>
				<div id="memberName">${member.nickName }</div>
			</div>
			
			<div id="item-head-items">
				<ul>
					<li><input type="button" id="memberInfoUpdate" value="내정보수정" /></li> 
					<li></li>
					<li></li>
					<li></li>
					<li></li>
				</ul>
			</div>
			
		</div>
		<div id="item-body">
			
		</div>
	
	</div>

</body>
</html>