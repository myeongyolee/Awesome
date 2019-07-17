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
    <script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
    
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
        
        /* ----------- 소개팅 페이지 끝 -------------------------------*/
        
        /* --------------- 동네친구 페이지 시작 ----------------------------*/
        #tablet{width:800px; height: 600px; background: black; margin:0 auto; border-radius: 40px; padding:10px 37px;}
        #vicinage-friend{background:aliceblue; padding-top:50px ;}
        #naver-map{width: 700px; height: 575px; background: white;}
        
        /* ----------- 번개팅  페이지 시작 -------------------------------*/
        #lighting-box{width: 100%; height: 100%; }
        #lighting{width: 70%; }
        #lighting-list{margin: 10px 20px;}
        #lighting-search{width: 30%; padding:10px 10px;}
        #lighting-Test-head{border-radius: 22px;}
        .card-header{border-radius: 22px;}
        .card-body{display: inline-block;}
        .card-title{font-size:20px;}
        #search-container{border-radius: 20px; background: white; height: 98%; padding: 30px 10px;}
        /* ----------- 번개팅 페이지 끝 -------------------------------*/
        
        /* button slide*/
        .switch {position: relative;display: block; width: 100px;height: 30px;padding: 3px;margin: 0 auto;background: linear-gradient(to bottom, #eeeeee, #FFFFFF 25px);background-image: -webkit-linear-gradient(top, #eeeeee, #FFFFFF 25px);
      border-radius: 18px;box-shadow: inset 0 -1px white, inset 0 1px 1px rgba(0, 0, 0, 0.05);cursor: pointer;}
    .switch-input {position: absolute; top: 0;left: 0; opacity: 0;}
    .switch-label {position: relative;display: block;height: inherit;font-size: 10px;text-transform: uppercase;background: #eceeef;border-radius: inherit;box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.12), inset 0 0 2px rgba(0, 0, 0, 0.15);}
    .switch-label:before, .switch-label:after { position: absolute;top: 50%;margin-top: -.5em;line-height: 1;-webkit-transition: inherit;-moz-transition: inherit;-o-transition: inherit;transition: inherit;}
    .switch-label:before {content: attr(data-off);right: 11px;color: #aaaaaa;text-shadow: 0 1px rgba(255, 255, 255, 0.5);}
    .switch-label:after {content: attr(data-on);left: 11px;color: #FFFFFF;text-shadow: 0 1px rgba(0, 0, 0, 0.2);opacity: 0;}
    .switch-input:checked ~ .switch-label {background: aquamarine;box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.15), inset 0 0 3px rgba(0, 0, 0, 0.2); }
    .switch-input:checked ~ .switch-label:before {opacity: 0;}
    .switch-input:checked ~ .switch-label:after {opacity: 1; }
    .switch-handle {position: absolute;top: 4px;left: 4px;width: 28px;height: 28px;background: linear-gradient(to bottom, #FFFFFF 40%, #f0f0f0);background-image: -webkit-linear-gradient(top, #FFFFFF 40%, #f0f0f0);border-radius: 100%;box-shadow: 1px 1px 5px rgba(0, 0, 0, 0.2);}
    .switch-handle:before {content: "";position: absolute;top: 50%;left: 50%;margin: -6px 0 0 -6px;width: 12px;height: 12px;background: linear-gradient(to bottom, #eeeeee, #FFFFFF);background-image: -webkit-linear-gradient(top, #eeeeee, #FFFFFF);border-radius: 6px;box-shadow: inset 0 1px rgba(0, 0, 0, 0.02);}
    .switch-input:checked ~ .switch-handle {left: 74px;box-shadow: -1px 1px 5px rgba(0, 0, 0, 0.2);}
    /* Transition ========================== */
    .switch-label, .switch-handle {transition: All 0.3s ease; -webkit-transition: All 0.3s ease;-moz-transition: All 0.3s ease;-o-transition: All 0.3s ease;}
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
            <%-- ########################################## 소개팅 페이징 끝 ################################################### --%>
	
            <div id="vicinage-friend" class="section">
                <div id="tablet">
                    <div id="naver-map">
            		     
                    </div>
                </div>
            </div>

		<%-- ########################################## 동네친구 페이징 끝 ################################################### --%>
            <div id="3rd-lighting" class="section">
                <div id="lighting-box" class="d-flex flex-row">
                    <div id="lighting" class="p-2 card" style="background:#e9ebee" >
                        
                        <div id="lightningTest-head" class="card-header">
                            <img class="card-img-top" src="${pageContext.request.contextPath }/resources/images/sampleimage.png" alt="Card image cap" width="100px" height="100px">
                            <div class="card-body" data-toggle="collapse" data-target="#lightningTest-body" aria-expanded="true" aria-controls="lightningTest-body">
                                <span class="card-title"> 매칭타이틀 </span>
                            </div>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item"> 분류 | 지역 | 장소이름 | 마감시간 </li>
                                <li class="list-group-item"> 작성회원 | 참여회원수 </li>
                            </ul>
                        </div>
                        <div id="lightningTest-body" class="collapse" aria-labelledby="lightningTest-head" data-parent="#lightning">
                            <div class="card-body">
                                <p class="card-text">매칭내용</p>
                            </div>        
                        </div>

                    </div>
                    <div id="lighting-search" class="p-2" style="background:#e9ebee">
                        <div id="search-container">
                            <div id="age">
                                 <h4>나이</h4>
                                <label class="switch">
                                    <input class="switch-input" type="checkbox" />
                                    <span class="switch-label" data-on="On" data-off="Off"></span> <span class="switch-handle"></span> 
                                </label>
                            </div>
                            <div id="addr">
                                <h4>주소</h4>
                                <label class="switch">
                                    <input class="switch-input" type="checkbox" />
                                    <span class="switch-label" data-on="On" data-off="Off"></span> <span class="switch-handle"></span> 
                                </label>
                            </div>

                        </div>
                    </div>
                  </div>
            </div>

			<%-- ########################################## 번개팅 페이징 끝 ################################################### --%>

            <div id="meeting-page" class="section">
                <div id="flex-container" class="d-flex flex-row">

                    <div id="meeting-container" class="p-2" >

                        <div id="meeting-info" class="p-2">
                            <div class="meeting-div">
                                <div id="meeting-img">
                                    <img src="${pageContext.request.contextPath }/resources/images/sampleimage.png" alt="" width="252px" height="150px">
                                </div>
                                <div id="meeting-text" >
                                    <span class="meeting-title">title</span> <br>
                                    <span>master : admin</span> <br>
                                    <span>personnel : 0</span> <br>
                                    <br>
                                    <span>next: date</span>
                                </div>
                            </div>

                            <div class="meeting-div">
                                <div id="meeting-img">
                                    <img src="${pageContext.request.contextPath }/resources/images/sampleimage.png" alt="" width="252px" height="150px">
                                </div>
                                <div id="meeting-text" >
                                    <span class="meeting-title">title</span> <br>
                                    <span>master : admin</span> <br>
                                    <span>personnel : 0</span> <br>
                                    <br>
                                    <span>next: date</span>
                                </div>
                            </div>

                            <div class="meeting-div">
                                    <div id="meeting-img">
                                        <img src="${pageContext.request.contextPath }/resources/images/sampleimage.png" alt="" width="252px" height="150px">
                                    </div>
                                    <div id="meeting-text" >
                                        <span class="meeting-title">title</span> <br>
                                        <span>master : admin</span> <br>
                                        <span>personnel : 0</span> <br>
                                        <br>
                                        <span>next: date</span>
                                    </div>
                            </div>


                        </div>

                        <div id="meeting-more">
                                <button type="button" class="btn btn-secondary btn-lg btn-block">more</button>
                        </div>
                    </div>
                    <div id="meeting-search" class="p-2" style="background:#eae5e5">
                        <div id="search-container">
                                <div id="age">
                                     <h4>나이</h4>
                                    <label class="switch">
                                        <input class="switch-input" type="checkbox" />
                                        <span class="switch-label" data-on="On" data-off="Off"></span> <span class="switch-handle"></span> 
                                    </label>
                                </div>
                                <div id="addr">
                                    <h4>주소</h4>
                                    <label class="switch">
                                        <input class="switch-input" type="checkbox" />
                                        <span class="switch-label" data-on="On" data-off="Off"></span> <span class="switch-handle"></span> 
                                    </label>
                                </div>
    
                            </div>  
                    </div>
                </div>
            </div>
           


        </div>
            
    </header>

<script>
function modaltest(){
	var memberCode = $("input[name=modalmember]").val();
	
	$.ajax({
		url:"${pageContext.request.contextPath}/map/checkInfo",
		data:{memberCode:memberCode},
		success:function(data){
			console.log(data);
			
			if(data == 'Y'){
				console.log("공개");
				location.href = "${pageContext.request.contextPath}/map/searchMap";	
			}
			else{
				console.log("비공개");
				$("input[name=modal]").trigger("click");
				
			}

		},error:function(jqxhr, textStatus, errorThrown){
			console.log("ajax처리실패"+jqxhr.status);
			console.log("ajax처리실패"+textStatus.status);
			console.log("ajax처리실패"+errorThrown.status);
		}
	});
}

function summitFrm2(){
	console.log("summitFrm2들어옴");
	
	if($("input[name=infocheck]").is(":checked")){
		$("form[name=friend-frm]").submit();
	}
	else{
		alert("수락버튼은 확인해주세요.");
	}
}
</script>


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
            	var memberCode = $("#memberCode").val();
            	var receiveMemberCode = $("#receiveMemberCode").val();
            	var like = selectLike;
            	$.ajax({
            		url: "${pageContext.request.contextPath}/meeting/changeUser?memberCode="+memberCode+"&receiveMemberCode="+receiveMemberCode+"&like="+like,
            		type: "get",
            		success:function(data){
            			console.log(data.html);
            			$(".maching-info").children().remove();
            			
                    	$(".maching-info").append(data.html);
                    	
                    	
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
</body>
</html>