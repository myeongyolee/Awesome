<%@page import="com.kh.awesome.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% Member member = (Member)session.getAttribute("memberLoggedIn"); %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Awesome" name="title"/>
</jsp:include>
    <style>
    	body{margin: 0 0; overflow-y: hidden;}
		html{overflow: hidden; overflow-y:hidden;}
		header div.video{position: relative; }
		header div.video h1{position: absolute; top: 0px; display: none;}
		#loginAfter{margin: 9px 0; padding: 7px 15px; font-size: 16px; position: fixed; right: 100px; width:90px;  z-index: 999; display: none;display : flex; flex-direction : row;justify-content : space-between; }
		header #content-container{min-height: 500px;  display: none; }
		header #content-container #index-image{position: relative; text-align: center; background-color: #fff; }
		header #content-container #index-image img{opacity: 0.8; width:1024px; height: 660px;}
		header #content-container #index-image #pTag{position: absolute;top: 0px; left:0px; text-align: center; padding-top: 200px; z-index: 1; }
		header #content-container #index-image #pTag p{ color:white; text-align: center; font-size:80px; margin: 0 0; margin-bottom: 50px; text-shadow: 0 1px 6px rgba(0,0,0,.27)}
		header #content-container #index-image #pTag .mybutton-css{width: 250px;  height: 50px; background: linear-gradient(262deg, #ff7854, #fd267d); 
		        box-shadow: 0 1px 6px 0 rgba(0,0,0,.27); border:0px; font-size:20px; }
		.target{height: 500px;}
		#content-container #page-introduce .container .row .col img#flx{ margin-right:79px; height: 358px; width:310px; margin-top: 100px; border-radius: 60px;}
		header #content-container #page-introduce{background: #fff;}
		.icon{width: 36px; margin-right: 10px; margin-top:10px;}
		.icon:last-of-type{margin-right:90px;}
		.fp-tableCell{width:100%;}
		#page-introduce{width:100%; height:100%; display:block;}
		#page-introduce div.inline-div{display:inline-block;}
		#page-introduce div#select-info{width:25%; height:100%; background:#4e6168;}
		#page-introduce div#select-page-introduce{width:74%; height:100%; }
		div.bx-viewport{width:100%; height:100%;}
		.img-select{width:150px; height:100px; border:1px solid;}
		#select-info{text-align:center;}
		#select-info img{width:200px; height:150px;}
		#select-page-introduce{position:absolute; padding:150px 150px;}
		#select-page-introduce div img{width:672px; height:400px;}
		
    </style>
    <header>

        <div class="video">
            <video autoplay loop muted >
                <source src="${pageContext.request.contextPath}/resources/video/Circle - 17445.mp4" type="video/mp4" />
            </video>
            
            <h1 id="logo">Awesome</h1>
        </div>
        
        <div id="content-container">
            
            <div id="index-image" class="section" >
            
                <div class="bxslider">
                    <img src="${pageContext.request.contextPath}/resources/images/blue-2564660_1280.jpg" alt="">
                    <img src="${pageContext.request.contextPath}/resources/images/portrait-3204843_640.jpg" alt="">
                    <img src="${pageContext.request.contextPath}/resources/images/workplace-1245776_1280.jpg" >
                </div>
                <div id="pTag">
                    <p> &nbsp;&nbsp;&nbsp;Awesome</p>
                    
                   <!-- 20190705 12:53 김용빈  -->
                   <!-- 회원가입 모달 추가 -->
                       <!-- 20190708 로그인 분기처리 :김용빈-->
                    <c:if test="${param.OAuth eq 'NoMember'}">
            			<script>$(function(){
            							alert("${param.msg}");
            							$("#signUp").trigger("click");
            							});</script>
            		</c:if>
    				<c:if test="${sessionScope.memberLoggedIn==null }">
                    <button type="button" class="btn btn-primary mybutton-css" id="signUp" 
                    			data-toggle="modal"
	    						data-target="#memberEnrollModal">Sign up</button>
	    			</c:if>
                </div>
            </div>

			<%-- #######################  홈페이지 소개  ############################ --%>
            <div id="page-introduce" class="section" >
            	<div id="select-info" class="inline-div">
            	<br />
            		<img id="sel-1st" src="${pageContext.request.contextPath }/resources/images/sampleimage.png" alt="" /> <br /><br />
            		<img id="sel-2nd" src="${pageContext.request.contextPath }/resources/images/sampleimage.png" alt="" /> <br /><br />
            		<img id="sel-3rd" src="${pageContext.request.contextPath }/resources/images/sampleimage.png" alt="" /> <br /><br />
            		<img id="sel-4th" src="${pageContext.request.contextPath }/resources/images/sampleimage.png" alt="" /> <br /><br />
            		<img id="sel-5th" src="${pageContext.request.contextPath }/resources/images/sampleimage.png" alt="" /> <br /><br />
            	</div>
            	<div id="select-page-introduce" class="inline-div">
            		<div class="intro-img" id="intro-1st">
            			<h2>소개팅</h2><br />
            			<h4>설렘을 찾아보세요!</h4> <br />
            			<img src="${pageContext.request.contextPath }/resources/images/sampleimage.png" alt="" />
            		</div>
            		<div class="intro-img" id="intro-2nd">
            			<h2>동네친구</h2> <br />
            			<h4>내 근처 친구를 만나보세요!</h4> <br />
            			<img src="${pageContext.request.contextPath }/resources/images/sampleimage.png" alt="" />
            			
            		</div>
            		<div class="intro-img" id="intro-3rd">
						<h2>번개팅</h2> <br />
						<h4>약속과 약속사이 비는 시간에 새로운 만남!</h4> <br />    			
            			<img src="${pageContext.request.contextPath }/resources/images/sampleimage.png" alt="" />
            		</div>
            		<div class="intro-img" id="intro-4th">
            			<h2>모임</h2> <br />
            			<h4>나의 취미를 공유 하는 모임</h4> <br />
            			<img src="${pageContext.request.contextPath }/resources/images/sampleimage.png" alt="" />
            			
            		</div>
            		<div class="intro-img" id="intro-5th">
            			<h2>동창</h2> <br />
            			<h4>학교 친구들을 찾을 수있게 도와드립니다.</h4> <br />
            			<img src="${pageContext.request.contextPath }/resources/images/sampleimage.png" alt="" />
            		</div>
            	</div>
		  </div>

        </div>
        
            
    </header>

    <script>
    //20190708 12:48
    //구글 인증 인,아웃
/*     function onSignIn(googleUser) {
        // Useful data for your client-side scripts:
        var profile = googleUser.getBasicProfile();
        console.log("ID: " + profile.getId()); // Don't send this directly to your server!
        console.log('Full Name: ' + profile.getName());
        console.log('Given Name: ' + profile.getGivenName());
        console.log('Family Name: ' + profile.getFamilyName());
        console.log("Image URL: " + profile.getImageUrl());
        console.log("Email: " + profile.getEmail());

        // The ID token you need to pass to your backend:
        var id_token = googleUser.getAuthResponse().id_token;
        console.log("ID Token: " + id_token);
    };
    
    function signOut() {
        var auth2 = gapi.auth2.getAuthInstance();
        auth2.signOut().then(function () {
          console.log('User signed out.');
        });
        auth2.disconnect();
      } */
    
    		//first 페이지 이미지슬라이드
            $(function(){
                $('.bxslider').bxSlider({
                    auto: true,
                    autoControls: true,
                    stopAutoOnClick: true,
                    pager: true
            });
            // fullpage .js
            $(".bx-controls.bx-has-controls-direction.bx-has-controls-auto.bx-has-pager").css("display","none")
                var myFullpage = new fullpage('#content-container', {
            /*  sectionsColor: ['#1bbc9b', '#4BBFC3', '#7BAABE', 'whitesmoke', '#ccddff'],*/
                anchors: ['firstPage', 'secondPage', '3rdPage', '4thpage', 'lastPage'],
                menu: '#menu',
                lazyLoad: true
            });
            
            //웹크기 변경시 홈출되는 함수
            $(window).resize(function(){
            	$("#page-introduce div").width($(window).innerWidth()/2 -10)
    			$("#page-introduce .fp-tableCell").width("100%");
            	$("#page-introduce").width("100%");
            	$("#select-info").width("25%");
            	$("#select-page-introduce").width("74%");
            	$(".bxslider img").height($(window).innerHeight()-60)
            })
                //video 사이즈 조절
                $("video").width($(window).innerWidth())
                
                if(<%=member%> == null){
                	
	                $("#logo").css("top",$("video").innerHeight()/2)
	                    .css("left",$("video").innerWidth()/2 -95)
	                    .fadeIn(3000,function(){
	                        $("div.video").remove();
	                        $("#content-container").fadeIn(1500);
	                        $("#login").css("top","0px").css("display","block");
	                        $("#loginAfter").css("top","0px").css("display");
	                        $("html").css("overflow-y","auto");
                    })
                }else{
                	$("#content-container").fadeIn(1500);
                	$("#login").css("top","0px").css("display","block");
                    $("#loginAfter").css("top","0px").css("display");
                    $("html").css("overflow-y","auto");
                }
                
                    
				$(".page-introduce .fp-tableCell").width("100%");	
                $(".bx-viewport").height("100%").width("100%");
                $("#index-image img").width($(window).width())
                        .height($(window).innerHeight()-60)
                $("#index-image #main-image").css("height","500px")
                
                
                $("#pTag").width($("#index-image").children("img").width())

                $(".tp-tableCell").width("100%")

                $("#icon-logo").css("width","120px").css("height","50px")
                $("#myModal").prop("z-index","100").children().prop("z-index","100")

                $("#index-image").siblings().width($(window).width()).height($(window).height())
	
                
                $("#select-page-introduce div").css("display","none").eq(0).css("display","inline-block");
                
                $("#select-info img").on("click",function(){
                	if($(this).attr("id") == "sel-1st") changeImg("intro-1st")
                	else if($(this).attr("id") == "sel-2nd") changeImg("intro-2nd")
                	else if($(this).attr("id") == "sel-3rd") changeImg("intro-3rd")
                	else if($(this).attr("id") == "sel-4th") changeImg("intro-4th")
                	else if($(this).attr("id") == "sel-5th") changeImg("intro-5th")
                	
                	
                })
            })
            function changeImg(idd){
            	$("#select-page-introduce div").css("display","none")
            	$("#"+idd+"").css("display","inline-block")
            }
            
            
            
    	
        </script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>