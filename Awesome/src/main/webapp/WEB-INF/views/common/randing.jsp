<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    
    <!-- 20190706 23:48  -->
    <!-- google login 김용빈 -->
	<meta name="google-signin-scope" content="profile email">
    <meta name="google-signin-client_id" content="620340826519-n25olunhj7rerh7f6fde1umslcfvgquf.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>

    
    <title>AweSome</title>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bxslider-4-4.2.12/src/js/jquery.bxslider.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/fullpage.js"></script>
    
    <!-- 구글 폰트 -->
    <link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
    <%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/randing.css"> --%>
    <style>
    	body{margin: 0 0;}
		html{overflow: hidden; }
		header div.video{position: relative; }
		header div.video h1{position: absolute; top: 0px; display: none;}
		#top-bar{display:none; height: 60px; margin-right: 173px;}
		#top-bar img{display: inline-block; margin:0 14px; left: -50px;}
		#top-bar span{font-family: 'Nanum Pen Script', cursive; font-size:35px; margin-left:10px;}
		#login{margin: 9px 0; padding: 7px 15px; font-size: 16px; position: fixed; right: 50px; width:90px;  z-index: 999; display: none;}
		#loginAfter{margin: 9px 0; padding: 7px 15px; font-size: 16px; position: fixed; right: 100px; width:90px;  z-index: 999; display: none;
					display : flex; 
               		flex-direction : row;
            		justify-content : space-between; 
					}
		header #content-container{min-height: 500px;  display: none; }
		header #content-container #index-image{position: relative; text-align: center; background-color: rgb(250, 232, 234); }
		header #content-container #index-image img{opacity: 0.8; width:1024px; height: 660px;}
		header #content-container #index-image #pTag{position: absolute;top: 0px; left:0px; text-align: center; padding-top: 200px; z-index: 1; }
		header #content-container #index-image #pTag p{ color:white; text-align: center; font-size:80px; margin: 0 0; margin-bottom: 50px; text-shadow: 0 1px 6px rgba(0,0,0,.27)}
		header #content-container #index-image #pTag .mybutton-css{width: 250px;  height: 50px; background: linear-gradient(262deg, #ff7854, #fd267d); 
		        box-shadow: 0 1px 6px 0 rgba(0,0,0,.27); border:0px; font-size:20px; }
		.target{height: 500px;}
		#content-container #page-introduce .container .row .col img#flx{ margin-right:79px; height: 358px; width:310px; margin-top: 100px; border-radius: 60px;}
		header #content-container #page-introduce{background: #edc9c9;}
		.icon{width: 36px; margin-right: 10px; margin-top:10px;}
		.icon:last-of-type{margin-right:90px;}
		#content-container #meeting-introduce{background: #60f48e;}
		#content-container #meeting-introduce .container .row .col{margin-top: 106px; text-align: center;}
		#content-container #meeting-introduce .container .row .col h3{text-align: center;}
    </style>
    <!-- bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
</head>
<body>
    <header>
    
    <!-- 20190708 로그인 분기처리 :김용빈-->
    	<c:if test="${sessionScope.memberLoggedIn==null }">
        	<button type="button" class="btn btn-primary" id="login" data-toggle="modal" data-target="#loginmodal" href="#">Login</button>
        </c:if>
   <!-- 20190711 09:32 로그아웃,내정보 :김용빈-->
        <c:if test="${sessionScope.memberLoggedIn!=null }">
        	<div id="loginAfter">
	        	<button type="button" class="btn btn-primary" id="myInfo">My Info</button>
	        	<button type="button" class="btn btn-primary" id="logOut">LogOut</button>
        	</div>	
        </c:if>
        
        <div class="video">
            <video autoplay loop muted >
                <source src="${pageContext.request.contextPath}/resources/video/Circle - 17445.mp4" type="video/mp4" />
            </video>
            
            <h1 id="logo">Awesome</h1>
        </div>
        
        <div id="content-container">
            
            <div id="index-image" class="section" >
                <div id="top-bar" >
                    <img src="${pageContext.request.contextPath}/resources/images/paper-plane.png" width="50px" height="50px" id="icon-logo" alt="">
                    
                    <span>Awesome</span>
                </div>
                <div class="bxslider">
                    <img src="${pageContext.request.contextPath}/resources/images/blue-2564660_1280.jpg" alt="">
                    <img src="${pageContext.request.contextPath}/resources/images/portrait-3204843_640.jpg" alt="">
                    <img src="${pageContext.request.contextPath}/resources/images/workplace-1245776_1280.jpg" >
                </div>
                <div id="pTag">
                    <p> &nbsp;&nbsp;&nbsp;Awesome ${OAuth}</p>
                    
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

            <div id="page-introduce" class="section" >
                <div class="container">
                    <div class="row">
                        <div class="col" style="text-align: center">
                            <img id="flx" src="${pageContext.request.contextPath}/resources/images/portrait-3204843_640.jpg" alt="" ><br>
                            <img src="${pageContext.request.contextPath}/resources/images/like.png" alt="" class="icon">
                            <img src="${pageContext.request.contextPath}/resources/images/cancel.png" alt="" class="icon">
                        </div>
                        <div class="col" style="padding-top:123px;">
                            <h2>Awesome을 만나보세요</h2> <br>
                            <h4>여자가 선택한 남자,남자가 선택한 여자를 위한 서비스,</h4>
                            <h4>나의 모임을 한눈에 확인해 보세요.</h4>
                        </div>
                    </div>
                </div>
            </div>

            <div id="meeting-introduce" class="section">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <h3>º번개</h3>
                            <img src="${pageContext.request.contextPath}/resources/images/paper-plane.png" alt="" width="200px" height="300px"> <br>
                            
                        </div>
                        <div class="col">
                            <h3>º동네친구</h3>
                            <img src="${pageContext.request.contextPath}/resources/images/paper-plane.png" alt="" width="200px" height="300px"> <br>

                        </div>
                        <div class="col">
                            <h3>º소모임</h3>
                            <img src="${pageContext.request.contextPath}/resources/images/paper-plane.png" alt="" width="200px" height="300px"> <br>

                        </div>
                    </div>
                </div>
                
            </div>

        </div>
        <!-- Modal -->
        <div class="modal fade" id="loginmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel">로그인</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <form action="${pageContext.request.contextPath}/member/memberLogin.do" method="post">
            <div class="modal-body">
                <span>아이디</span>
                <input type="text" class="form-control" name="memberId" id="memberId" required>  <br>
                <span>비밀번호</span>
                <input type="password" class="form-control" name="password" id="password" required>  <br>
                <a href="#">아이디/비밀번호를 잃어버렸습니까?.</a> <br> <br>
                <button type="button">nav</button> 
                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                <button type="submit" class="btn btn-primary">로그인</button>
            </div>
        </form>
                <!-- 20190706 23:48  -->
                <!-- google login 김용빈 -->
  				<a href="${google_url}"><button id="btnJoinGoogle" class="btn btn-primary btn-round"
                                style="width: 100%">
                                <i class="fa fa-google" aria-hidden="true"></i>Google Login
                            </button></a>
                <!-- 20190709 09:36  -->
                <!-- naver login 김용빈 -->             
	                <div id="naver_id_login" style="text-align:center"><a href="${naver_url}">
					<img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/></a></div>
					<br>   
                            
<!--                 <div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark">Sign in</div>
                <div class="g-signin2" data-onsuccess="signOut" data-theme="dark">Sign Out</div>
                
                <a href="#" onclick="signOut();">Sign out</a> -->
          </div>
        </div>
      </div>
            
        <!-- 20190705 12:54 김용빈  -->
		<!-- 회원가입 모달 추가 -->
		    <style>
				#modalBody{ 
					display : flex; 
					flex-direction : row;
					justify-content : space-between; 
					align-items : center;      
					align-content : center;       
					max-width : 100%;     
				}
				
					#modalBody #modalList{
						flex : 1 1 0; 
						margin : auto; 
						
						display : flex; 
						flex-direction : column;
						justify-content : space-between; 
					}
						#modalBody #modalList .btn{
							flex : 1 1 0; 
							margin : auto;
							margin-top : 1%; 
							width:100%;
						}
					
					
					
					#modalBody .modal-body{
						flex : 1 1 0; 
						margin : auto; 
					}
			</style> 
			
	    <div class="modal fade" id="memberEnrollModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	      <div class="modal-dialog" role="document">
	        <div class="modal-content">
	        
	          
	        </div>
	      </div>
	    </div>
	 <!-- 회원가입 모달 끝 -->
            
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
    
    <!-- 20190705 12:54 김용빈  -->
	<!-- 회원가입 모달 추가 -->
		$("#signUp").on("click",function(){
			$.ajax({ 
				 url:"${pageContext.request.contextPath}/member/memberEnroll.do", 
				 data:"memberId=${param.memberId}",
				success : function(data){
					$("#memberEnrollModal .modal-content").empty();
					$("#memberEnrollModal .modal-content").append(data);
				},
				error: function(jqxhr, textStatus, errorThrown){
					console.log("ajax처리실패! : "+jqxhr.status);
					console.log(jqxhr);
					console.log(textStatus);
					console.log(errorThrown);
				}
			});
	    });
	    
	<!--20190711 09:34 김용빈-->
		$("#logOut").on("click",function(){
			
			var logout=confirm("정말로 로그아웃?");
			
			if(logout){
				location.href='${pageContext.request.contextPath}/member/memberLogout.do';
			}
	    });
	    
	    
	    
	    
	    
            $(function(){
                $('.bxslider').bxSlider({
                    auto: true,
                    autoControls: true,
                    stopAutoOnClick: true,
                    pager: true
            });
            $(".bx-controls.bx-has-controls-direction.bx-has-controls-auto.bx-has-pager").css("display","none")
                var myFullpage = new fullpage('#content-container', {
            /*  sectionsColor: ['#1bbc9b', '#4BBFC3', '#7BAABE', 'whitesmoke', '#ccddff'],*/
                anchors: ['firstPage', 'secondPage', '3rdPage', '4thpage', 'lastPage'],
                menu: '#menu',
                lazyLoad: true
            });

                //video 사이즈 조절
                $("video").width($(window).innerWidth())
                
                $("#logo").css("top",$("video").innerHeight()/2)
                    .css("left",$("video").innerWidth()/2 -95)
                    .fadeIn(3000,function(){
                        $("div.video").remove();
                        $("#top-bar").css("display","inline-block");
                        $("#content-container").fadeIn(1500);
                        $("#login").css("top","0px").css("display","block");
                        $("#loginAfter").css("top","0px").css("display");
                        $("html").css("overflow-y","auto");
                    })
                
                    
                $(".bx-viewport").height($(window).height())
                $("#index-image img").width($(window).width())
                        .height($(window).innerHeight()-60)
                $("#index-image #main-image").css("height","500px")
                
                
                $("#pTag").width($("#index-image").children("img").width())

                $(".fp-tableCell").height($(this).parent("img").height())

                $("#icon-logo").css("width","50px").css("height","50px")
                $("#myModal").prop("z-index","100").children().prop("z-index","100")

                $("#index-image").siblings().width($(window).width()).height($(window).height())

                
                
            })
            
    
        </script>
</body>
</html>