<%@page import="com.kh.awesome.member.model.vo.Member"%>
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
		.flex{
					display : flex; 
            		flex-direction : row;
            		justify-content : flex-end;
				}
    </style>
    <!-- bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
</head>
<body>
    <header>

        <div class="video">
            <video autoplay loop muted >
                <source src="${pageContext.request.contextPath}/resources/video/Circle - 17445.mp4" type="video/mp4" />
            </video>
            
            <h1 id="logo">Awesome</h1>
        </div>
        
        <div id="content-container">
            
            <div id="index-image" class="section" >
            
                <div id="top-bar" >
				    <!-- 20190708 로그인 분기처리 :김용빈-->
				    	<c:if test="${sessionScope.memberLoggedIn==null }">
				        	<button type="button" class="btn btn-primary" id="login" data-toggle="modal" data-target="#loginmodal" href="#">Login</button>
				        </c:if>
				   <!-- 20190711 09:32 로그아웃,내정보 :김용빈-->
				        <c:if test="${sessionScope.memberLoggedIn!=null }">
				        	<div id="loginAfter">
				        		<a href="${pageContext.request.contextPath}/member/memberInfo.do"><button type="button" class="btn btn-primary" id="myInfo">My Info</button></a>
					        	<button type="button" class="btn btn-primary" id="logOut">LogOut</button>
				        	</div>	
				        </c:if>
                    <span>Awesome</span>
                    
                </div>
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
            <form action="${pageContext.request.contextPath}/member/memberLogin.do" method="post" onsubmit="return validate();">
            
            <div class="modal-body">
                <span>아이디</span>
                <input type="text" class="form-control" name="memberId" id="memberId" placeholder="이메일 형태의 아이디 입력" required>  <br>
                <span>비밀번호</span>
                <input type="password" class="form-control" name="password" id="password" required>  <br>
                <div class="flex">
	            	<div class="custom-control custom-checkbox">
					  <input type="checkbox" class="custom-control-input" name="saveMemberId" id="saveMemberId">
					  <label class="custom-control-label" for="saveMemberId">Save Id</label>
					</div> &nbsp;&nbsp;&nbsp;
					<div class="custom-control custom-checkbox">
					  <input type="checkbox" class="custom-control-input" name="autoLogin" id="autoLogin">
					  <label class="custom-control-label" for="autoLogin">Auto Login</label>
					</div>
            	</div>
            	<br />
                <!-- <a href="http://localhost/awesome/member/findMember.do">아이디/비밀번호를 잃어버렸습니까?.</a> <br> <br> -->
                <a href="#" id="findMember" onclick="findMember()">아이디/비밀번호를 잃어버렸습니까?.</a>
            </div>
            
            
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary">로그인</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
        </form>
        
                <!-- 20190706 23:48  -->
                <!-- google login 김용빈 -->
<%--  				<a href="${google_url}" id="btnJoinGoogle" class="g-signin2" data-theme="dark" style="width: 223px; height:48px">
                                <i class="fa fa-google" aria-hidden="true"></i>Google Login

                </a> --%>
               
               	    <div id="btnJoinGoogle" style="text-align:center"><a href="${google_url}">
					<img width="223" src="${pageContext.request.contextPath}/resources/images/btn_google.png"/></a></div>
					<br>  
                <!-- 20190709 09:36  -->
                <!-- naver login 김용빈 -->             
	                <div id="naver_id_login" style="text-align:center"><a href="${naver_url}">
					<img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/></a></div>
					<br>   
                           
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

    function findMember(){
    	window.open("/awesome/member/findMember.do","pop","width=570,height=420, scrollbars=yes, resizable=yes");
    }
    
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
		
	
	<!--20190718 18:07 김용빈-->
	<!--아이디 저장-->
		$(function(){
			$("#memberId").val(localStorage.getItem("awesomeSaveMemberId"));
			
			if($("#memberId").val().length>0){
				$("#saveMemberId").prop("checked",true);
			}
		});
		
	<!--20190715 12:35 김용빈-->
	<!--아이디 저장-->
		function validate(){
			if($("#saveMemberId").prop("checked")){
		        var value = $("#memberId").val();
		        localStorage.setItem("awesomeSaveMemberId", value);
			}else{
				localStorage.setItem("awesomeSaveMemberId", "");
			}
			
			return true;
		}
	    
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
</body>
</html>