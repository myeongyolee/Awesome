<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
<style>
     body{margin: 0 0; height: 100%}
    html{ height: 100%;}
    #rational-friend{height: 100%;}
    #parent-div{height: 100%;}
    #my-info{ display: inline; padding:0 0;}
    #member-img{border-radius: 197px; margin: 10px 30px;}
    #top-bar{width:310px; height: 80px  ; margin:0 0; display: inline-block; background: rgb(248, 105, 181) ; text-align: center; padding: 20px 0; 
            border:1px solid lightblue; border-top-color: white; border-left-color: white; box-shadow: 0px 3px 5px lightgray;}
    #top-bar #profile-img{border: 3px solid lightgray; border-radius: 200px; margin: -7px 10px 0 0;}
    #top-bar span{font-size: 17px; margin-top:10px; margin-right: 110px;}
    #top-bar #next-img{ border:1px solid white; border-radius: 200px;}
    #my-info #matching-tool{height: 100%; width:310px; }
    .d-flex.bd-highlight{height: 100%;}
    #math-div{padding: 10px; }
    #math-div span{margin-right:10px; border-bottom: 3px solid white;}
    #LikeMe{padding:10px;}
    #LikeMe div{text-align: center; border:3px solid rgb(235, 120, 120); border-radius: 15px; margin:20px 14px; max-height: 600px; overflow-y: auto;}
    #LikeMe div img{border-radius: 3px;margin-left: 3px; }
    #chat{padding:10px; display:none;}
    #char div{border-bottom: 1px solid gray;}
    #chat img{margin-left:10px; margin-right: 30px;}
    #rational-switch{width: 70%; display: inline-block; text-align: center; padding-top:30px; position: relative;}
    #rational-switch>img{border-radius: 30px; margin-bottom:10px; position: absolute;}
    #rational-switch div{position: relative; display: inline-block; width: 300px; height: 504px;}
    #rational-switch div.user-id-addr{border-radius: 40px; }
    #rational-switch div.user_profile img{border-radius: 40px; left: 0px;}
    #rational-switch div p#userId{position: absolute; top:378px; left:30px;}
    #rational-switch div#like-can-box{width: 300px; height: 150px;}
    #rational-switch div.maching-info img{border-radius:40px}
    #rational-switch #selectBox{position: realtivce;     bottom: 478px;}
    #address{position:absolute; top:430px; left: 30px;}
    #cancel-icon{left: 210px;}
 #search-container div h4 {text-align: center}
 #search-container div{margin-top:20px;}
 #meeting-page{width: 100%; height: 100%;}
 #meeting-container{width: 70%; height: 100%;}
 #meeting-search{width: 30%; height: 100%;}
 .fp-tableCell{width: 100%;}
 #flex-container{width: 100%; height: 100%;}
 #meeting-container{padding-left: 50px;}
 #meeting-info{margin-left:130px; margin-top:30px;}
 #meeting-img{display:inline-block; position: relative; width: 252px; height: 150px;}
 #meeting-img img{position: absolute; top:15px; border-radius: 7px;} 
 #meeting-text{display: inline-block; margin-left:30px;}
 .meeting-title{font-size: 30px;}
 .meeting-div{margin-bottom: 30px;   }
 .user-id-addr{position: absolute; width: 0px; height: 0px; top:-504px; background: linear-gradient(to top, rgba(0,0,0,0.5), transparent); border-radius: 30px}
</style>
	<div id="content-container">
	   
	   <div id="rational-friend" class="section" >
	       <div class="d-flex bd-highlight">
	           <div id="my-info" class="bd-highlight">
	               <div id="top-bar" >
	                   <img id="profile-img" src="${pageContext.request.contextPath }/resources/images/paper-plane.png" alt="" width="35px" height="35px">
	                   <span>나의 프로필</span>
	                   <img id="next-img" src="${pageContext.request.contextPath }/resources/images/next.png" alt="" width="40px" height="40px">
	               </div>
	
	               <section id="matching-tool">
	                   <div id="math">
	                       <div id="math-div">
	                           <span onclick="switchbtn(this);">Like Me</span>
	                           <hr>
	                       </div>
	
	                       <!-- 서버에서 데이터(사진 아이디) 받아와서 넣어줄것 LikeMe-->
	                       <div id="LikeMe" class="d-flex align-content-start flex-wrap">
	                           <c:forEach items="likeMe" var="e" >
	                               <div>
	                               	<input type="hidden" name="" />
	                                   <img src="${pageContext.request.contextPath }/resources/images/" alt="" width="60px" height="90px"> <br>
	                                   <span onclick="ss"> <%-- ${e.MEMBER_ID } --%></span>
	                               </div>
	                           </c:forEach>
	                           
	                       </div>

	                   </div>
	               </section>
	           </div>
	
	
	           <div id="rational-switch" class="flex-shrink-1 bd-highlight"> 
	               <div class="maching-info">
	                   <img src="${pageContext.request.contextPath }/resources/images/blue-2564660_1280.jpg" alt="" width="300px" height="504px">
	                   <div class="user-id-addr">
	                   		<input type="hidden" id="memberCode" name="memberCode" value="1" />
	                   		<input type="hidden" name="receiveMemberCode" id="receiveMemberCode" value="2"/>
	                        <p id="userId">ID</p>
	                        <p id="address">address</p>
	                   </div>
	               </div>
	               <!-- 아이콘 상자 -->
	               <br>
	               <div id="selectBox">
	                <img id="like" src="${pageContext.request.contextPath }/resources/images/like.png" alt="" width="80px" > &nbsp;&nbsp;&nbsp;&nbsp;
	                <img id="non-like" src="${pageContext.request.contextPath }/resources/images/cancel.png" alt="" width="80px" >
	               </div>
	           </div>
	         </div>
	       </div>
       </div>
       
   <script>
        $(function(){
            $(".bx-controls.bx-has-controls-direction.bx-has-controls-auto.bx-has-pager").css("display","none");

            var myFullpage = new fullpage('#content-container', {
            /*  sectionsColor: ['#1bbc9b', '#4BBFC3', '#7BAABE', 'whitesmoke', '#ccddff'],*/
                anchors: ['firstPage', 'secondPage', '3rdPage', '4thpage', 'lastPage'],
                menu: '#menu',
                lazyLoad: true
            });
            $("#matching-tool").height($("#matching-tool").height()-80)
            
            $(".card-img-top").width(100)
        })

        $("#math-div").children().eq(0).css("border-bottom-color","#ec3554")

        function switchbtn(spans){
            $("#math-div").children().css("border-bottom-color","white");
            $("#LikeMe").css("display","none")
            $("#chat").css("display","none")
            $(spans).css("border-bottom-color","#ec3554")

            if($(spans).html() =='Like Me'){
                $("#LikeMe div").css("display","block")
                $("#chat").css("display","none")
            }else if($(spans).html() =="채팅"){
                $("#chat").css("display","block");
                $("#LikeMe div").css("display","none");
            }
        }
        
        //소개팅 페이지 ajax
        function changeUser(selectLike){
        	if($("p#userId").html() == "더이상회원이없습니다") return false;
        	
        	
        	var memberCode = $("#memberCode").val();
        	var receiveMemberCode = $("#receiveMemberCode").val();
        	var like = selectLike;
        	$.ajax({
        		url: "${pageContext.request.contextPath}/meeting/changeUser?memberCode="+memberCode+"&receiveMemberCode="+receiveMemberCode+"&like="+like,
        		type: "get",
        		success:function(data){
        			console.log(data.html);
        			$(".maching-info").children().remove();
        			
                	/* $("#selectBox").siblings("br").before(data.html); */
        			$(".maching-info").append(data.html)
                	
                	
        		},error: function(jqxhr, textStatus, errorThrown){
        			console.log("ajax 처리 실패:"+jqxhr.status);
					console.log(errorThrown);
				}
       		})
        		
        	 
        }
        
        
        $("#like").on("click",function(){
        	changeUser("Y");
        });
        
        $("#non-like").on("click",function(){
        	changeUser("N");
        });
        
        /* 나를 좋아한 사람 */
        function likeMeUser(){
        	var memberCode = ${sessioScope.memberCode}
        	$.ajax({
        		url:"${pageContext.request.contextPath}/meeting/likeMeMember",
        		type:"get",
        		success: function(data){

        		}, error(jqxhr, textStatus, errorThrown){
        			
        		}
        	})
        }
        

    </script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>		