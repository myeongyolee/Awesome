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
    <title>AweSome</title>
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.0.js"></script>
    <script src="${pageContext.request.contextPath }/resources/js/bxslider-4-4.2.12/src/js/jquery.bxslider.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/fullpage.js"></script>
    
    <!-- bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
    <!-- 구글 폰트 -->
    <link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap" rel="stylesheet">
    <style>
        body{margin: 0 0; height: 100%}
        html{ height: 100%;}
        #rational-friend{height: 100%;}
        #parent-div{height: 100%;}
        #my-info{ display: inline; padding:0 0;}
        #member-img{border-radius: 197px; margin: 10px 30px;}
        #top-bar{width:325px; height: 80px  ; margin:0 0; display: inline-block; background: deeppink ; text-align: center; padding: 20px 0; 
                border:1px solid lightblue; border-top-color: white; border-left-color: white; box-shadow: 0px 3px 5px lightgray;}
        #top-bar #profile-img{border: 3px solid lightgray; border-radius: 200px; margin: -7px 10px 0 0;}
        #top-bar span{font-size: 17px; margin-top:10px; margin-right: 110px;}
        #top-bar #next-img{ border:1px solid white; border-radius: 200px;}
        #my-info #matching-tool{height: 100%; width:325px; }
        .d-flex.bd-highlight{height: 100%;}
        #math-div{padding: 10px; }
        #math-div span{margin-right:10px; border-bottom: 3px solid white;}
        #LikeMe{padding:10px;}
        #LikeMe div{text-align: center; border:3px solid rgb(235, 120, 120); border-radius: 15px; margin:20px 14px; max-height: 600px; overflow-y: auto;}
        #LikeMe div img{border-radius: 3px;margin-left: 3px; }
        #chat{padding:10px; display:none;}
        #char div{border-bottom: 1px solid gray;}
        #chat img{margin-left:10px; margin-right: 30px;}
        #rational-switch{width: 70%; display: inline-block; background: lightblue; text-align: center; padding-top:30px;}
        #rational-switch img{border-radius: 30px; margin-top:20px;}
        #rational-switch div{position: relative; display: inline-block;}
        #rational-switch div img{border-radius: 25px;}
        #rational-switch div p#userId{position: absolute; top:378px; left:30px;}
        #address{position:absolute; top:430px; left: 30px;}
        #tablet{width:800px; height: 600px; background: black; margin:0 auto; border-radius: 40px; padding:10px 37px;}
        #vicinage-friend{background:cyan; padding-top:50px ;}
        #naver-map{width: 700px; height: 575px; background: white;}
        
    </style>
</head>
<body>  
    <header>
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
                                    <span onclick="switchbtn(this);">채팅</span>
                                    <hr>
                                </div>

                                <!-- 서버에서 데이터(사진 아이디) 받아와서 넣어줄것 LikeMe-->
                                <div id="LikeMe" class="d-flex align-content-start flex-wrap">
                                    <!--
                                        <div>
                                            <img src="./images/couple-1030744_1280.jpg" alt="" width="60px" height="90px"> <br>
                                            <span onclick="ss">ID</span>
                                        </div>
                                    -->
                                </div>
                                <!-- 서버에서 채팅창 가져오기 -->
                                <div id="chat">
                                    <!--
                                        <div>
                                            <img src="./images/like.png" alt="" width="50px" height="80px">
                                            <span>ID님과의 채팅</span>
                                        </div>
                                    -->
                                </div>
                            </div>
                        </section>
                    </div>


                    <div id="rational-switch" class="flex-shrink-1 bd-highlight">
                        <div>
                            <img src="${pageContext.request.contextPath }/resources/images/blue-2564660_1280.jpg" alt="" width="375px" height="500px">
                            <p id="userId">ID</p>
                            <p id="address">address</p>
                        </div>
                        <!--

                        -->
                        <br>
                        <img src="${pageContext.request.contextPath }/resources/images/like.png" alt="" width="80px" > &nbsp;&nbsp;&nbsp;&nbsp;
                        <img src="${pageContext.request.contextPath }/resources/images/cancel.png" alt="" width="80px" >
                    </div>
                  </div>
                </div>
            

            <div id="vicinage-friend" stlye="background:blue;" class="section">
                <div id="tablet">
                    <div id="naver-map">
                        
                    </div>
                </div>
            </div>
            <div id="3rd" class="section">
                
            </div>
           


        </div>
        
            
            
            
            
            
    </header>



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
    
        </script>
</body>
</html>