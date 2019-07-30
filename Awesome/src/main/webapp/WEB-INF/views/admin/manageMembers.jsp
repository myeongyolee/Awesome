<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Awesome" name="title"/>
</jsp:include>
<!-- 부트스트랩관련 라이브러리 -->
<script  src="${pageContext.request.contextPath}/resources/js/jquery-3.4.0.js"></script>
<script src="https://use.fontawesome.com/5a964364f0.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/admin_main.css" />
 <!--Plugin CSS file with desired skin-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ion-rangeslider/2.3.0/css/ion.rangeSlider.min.css"/> 
    <script src="https://cdnjs.cloudflare.com/ajax/libs/ion-rangeslider/2.3.0/js/ion.rangeSlider.min.js"></script>
 <!-- Tiny Nice Confirmation Popup Plugin With jQuery - H-confirm-alert -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/H-confirm-alert.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/H-confirm-alert.css">
   
<style>
#t_title{ position: relative;display:block;margin-top:0;left:0px;height: 65x;
	padding:1em;}
#pplList{
  position: relative; padding: 2px;
  left:100px; border: solid 3px yellow; border-radius: 3%;
  width: 620px;display:flex; flex-wrap: wrap;height: auto;top:0;}
#btn-more-container{position: relative;
    left: 100px;
    bottom: 3px;
    z-index: 999;
    width: auto;
    border: none;
    height: 50px;
	text-align: center;} 
#m-contentInner{width:285px; flex-flow:row-reverse wrap;height:auto;position:absolute;}
#m-head{width:200px; margin-bottom: 10px;}
#search-container{
	width: 250px;
    position: absolute; 
    display:inline-block;
    left: -265px;
    top: 0px;
}
img.card-img-top{border-radius:50%;
width:180px;height:180px;padding:5px;}
img.card-img-top:hover{
opacity: 0.5;
}
.text-sm-left{padding: 0.5em;}
/*더보기 화살표   */
 div#btn-more-container i#left,
div#btn-more-container i#right{
 	margin: 50px; 
 	display: inline-block;
    position:relative;
    color: pink;
    top: -100%; 
    cursor: pointer;
} 
i#right,i#left:hover{
 cursor:pointer;
}


   </style>
 
<div id="admin_board">
  <div id="main_board">
 <!--메뉴 탭  -->
	  <div class="tab">
	  <button class="tablinks" onclick="location.href='${pageContext.request.contextPath}/admin/adminMain.do'">
 	  <img src="${pageContext.request.contextPath}/resources/images/icons/home.png"/> 
	  	<span class="text_">&nbsp;
	  	 전체보기
	  	</span>
	  </button>
	  <button class="tablinks" onclick="location.href='${pageContext.request.contextPath}/admin/manageMembers'">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/group.png"/>
	  	<span class="text_">&nbsp;
	  	 회원찾기 
	  	</span>
	  </button>
	  <button class="tablinks" onclick="location.href='${pageContext.request.contextPath}/admin/FindMembers'">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/network.png"/>
	  	<span class="text_">&nbsp;
	  	 회원관리
	  	</span>
	  </button>
	  <%-- <button class="tablinks" onclick="location.href='${pageContext.request.contextPath}/admin/reportBoard'">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/search.png"/>
	  	<span class="text_">&nbsp;
	  	신고관리
	  	</span>
	  </button>
	  <button class="tablinks" onclick="location.href='${pageContext.request.contextPath}/admin/answersToQuestions'">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/october.png"/>
	  	<span class="text_">&nbsp;
	  	문의 게시판
	  	</span>
	  </button>
	  <button class="tablinks" onclick="location.href='${pageContext.request.contextPath}/admin/answersToQuestions'">
	  <img src="${pageContext.request.contextPath}/resources/images/icons/search.png"/>
	  	<span class="text_">&nbsp;
	  	문의 게시판
	  	</span>
	  </button> --%>
	</div>
	
	<div id="Home" class="tabcontent">
		
<!-- <input type="hidden" id="cPage" value="1"/> -->
	
 <!--회원 리스트 보여주기   -->
	<div id="t_title"><h3>모든 회원</h3></div>
	
	<div id="pplList" class="mx-auto">


<!--검색 박스  -->
	<div id="search-container" class="card p-4 mb-4 bg-white">
	회원 검색창
		<ul class="list-group list-group-flush">
			<li class="list-group-item">
				<label for="byName">회원 이름으로 검색</label>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<div class="input-group-text">
							<input type="checkbox" name="byName">
						</div>
					</div>
					<input type="text" class="form-control" id="byName">
				</div>
				<label for="byMid">회원 아이디로 검색 (이메일 형식)</label>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<div class="input-group-text">
							<input type="checkbox" name="byMid">
						</div>
					</div>
					<input type="text" class="form-control" id="byMid">
				</div>
				<label for="nickname">회원 별명으로 검색</label>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<div class="input-group-text">
							<input type="checkbox" name="nickname">
						</div>
					</div>
					<input type="text" class="form-control" id="nickname">
				</div>
			</li>
			<li class="list-group-item">
				<label for="gender">성별 </label>
				<select class="form-control" id="gender">
					<option id="defaultGender" value="0" disabled selected>성별을 선택해 주세요.</option>
					<option value="M">남자</option>						
					<option value="F">여자</option>						
				</select>
			</li>
			<li class="list-group-item">
	 			<label for="age">나이 </label>
				  <input type="text" class="js-range-slider" name="age" value="" />
			</li>
			<li class="list-group-item">
				<button class="btn btn-outline-secondary" type="button" onclick="getPplList(1);">검색하기</button>
			</li>
		</ul>
	</div>
	<!--검색 박스 끝.   -->
	<!-- paging 처리하는 화살표  -->

<br /><br /><br />
	</div>
	<!--pplList 끝  -->
	<div id="btn-more-container">
 <input type="hidden" id="cPage" value="1"/>
<!-- 		<i class="fa fa-angle-double-left fa-3x" id="left"></i>	 -->
		<i class="fa fa-angle-double-down fa-3x" id="right"></i>
</div>
	</div>
	
  </div>
 </div>
 <script>
 /*page 가 열리자 마자 전체 회원 보여주기  */
  $(function(){
	  getMore($("#cPage").val());
  });
	  //오른쪽 화살표 클릭시 더 보여준다. 
	  $("i#right").click(function(){
		  console.log("this: "+$(this).val());
			console.log("rightcclick의 value=="+ (Number($(this).val())+1));
			getMore(Number($(this).val())+1);
		});
	  
	 function getMore(cPage){	
		 console.log("cPage==" + cPage);
	  /* var param = {cPage: cPage_ };
	  console.log("cPage@getMore==" + param); */
	  $.ajax({
			 url: '${pageContext.request.contextPath}/admin/showAll.do?cPage='+cPage,
			 success: function(data){	
				 console.log(data);
				 for(var i=0; i<data.list.length; i++){
						$("#t_title>h3").html("Awesome 모든 회원입니다."); 
						
				var html = "";
				html += '<div id="m_contentInner" style = "z-index:50;">';
				html += '<div id="m-head">';
				html += '<img class="card-img-top" src="${pageContext.request.contextPath}/resources/upload/member/'+data.list[i].renamedProfile+'" onclick="seeOneM('+data.list[i].memberCode+');">';
				html += '<input type="hidden" value="'+data.list[i].memberCode+'"/>';
				html +=	'<h5 class="card-title">'+data.list[i].memberName+' </h5></div></div>';
					
				$("#pplList").append(html);	
				}
				 console.log("ajax 안에서 cPage:  "+data.cPage);
				 $("i#right").val(data.cPage);
				 $("i#left").val(data.cPage);
				 
				 //// 현재 요청 페이지가 마지막 페이지라면, 더보기 버튼을 비 활성화  
				 if(data.cPage == data.totalPage){
						$("i#right").css("display","none");
// 						$("i#right").css("pointer-events","none").append("더이상 조회된 회원이 없습니다. ");
					}
					else{
						$("i#right").css("display","inline-block");				
					}
					if(data.cPage == 1){
 						$("i#left").css("opacity","0.8");				
						$("i#left").css("pointer-events","none")
						.append("멤버 더보기");
					} 

			 }//end of success	
			 
		});//end of ajax	
		
	  };
	  //the end of function

function seeOneM(memberCode_){
		  var param = {memberCode: memberCode_};
		 $.ajax({
			 url:'${pageContext.request.contextPath}/admin/seeOneMember',  
			 data: param, 
			 dataType: "json", 
			 type: "get", 
			 contentType: "application/json; charset=UTF-8", 
			 success: function(data){
				 console.log(data);
				 console.log("data.OneM.memberCode== "+data.oneM.memberCode);
					 
					 var html = "";
					 html += '<div id ="one_m">';
					 html += '<div id ="onem-head">';
					 html += '<img class="oneM_img" style="width: 580px; height: 500px; text-align:center;" src="${pageContext.request.contextPath}/resources/upload/member/'+data.oneM.renamedProfile+'">';
					 html += '<p class="text-sm-left">';
					 html += '회원 코드: '+data.oneM.memberCode+'<br>'+'<br>';
					 html += '회원아이디: '+data.oneM.memberId+'<br>'+'<br>';
					 html += '회원 이름: '+data.oneM.memberName+'<br>'+'<br>';
					 html += '생년월일: '+data.oneM.birthday+'<br>'+'<br>';
					 html += '전화번호: '+data.oneM.phone+'<br>'+'<br>';
					 html += '소개팅 공개 여부: '+data.oneM.blindDateOpen+'<br>'+'<br>';
					 html += '친구 공개 여부: '+data.oneM.friendOpen+'<br>'+'<br>';
					 html += '검색 공개 여부: '+data.oneM.searchOpen+'<br>'+'<br>';
					 html += '가입일: '+data.oneM.enrollDate+'<br>'+'<br>';
					 html += '별명: '+data.oneM.nickName+'<br>'+'<br>';
					 html += '자기소개 : '+data.oneM.introduce+'<br>'+'<br>';
					 html += '</p>';
					 
					 if(data.cm==null)
					 {html += '현재 가입된 클럽이 없습니다. ';}
					 else 
					 {html += ' 가입된 클럽 이름: ' + data.cm;}
				 $("#t_title>h3").html(data.oneM.memberName+" 님의 정보입니다. "); 
				 $("#pplList").html(html);	
				 $("i#left").css("display", "none");
				 $("i#right").css("display", "none");
				 }
		 })
 };
  /*나이 검색 슬라이더  */
  $(".js-range-slider").ionRangeSlider({
      type: "double",
      grid: true,
      min: 0,
      max: 100,
      from: 18,
      to: 45,
      step: 1
     /*  onChange: function(data){
    	  var from = data.from;
    	  var to = data.to;
    	  console.dir("data.from=="+ from);
    	  console.dir("data.to=="+ to);
    }
    */
  });
  
 /*
$(function(){
 function searchPpl(){
	 $("#pplList").html("");
	 $("#cPage").val(); 
	 getPplList(1);
 };
	 */
 /*회원 검색   */

 function getPplList(cPage_){
	 var param = {cPage: cPage_ };
	 console.log("cPage== " + param.cPage);
/* =======
 function getPplList(){
	 var param = {cPage: $("#cPage").val() };
	 console.log($("#byName"));
>>>>>>> refs/remotes/origin/master
	 */
	 if($("[name=byName]:checked")){
		 var byName = $("input#byName").val();
	 };
	 console.log("param.cPage==" + param.cPage);
	 console.log('$("#byName").val()== '+ $("input#byName").val());
	 
	  var check = $(":checkbox:checked");
	 console.log("check="+check); 
	  if(check!=null){ 
		 for(var i=0; i<check.length;i++){
			 var id = $(check[i]).attr("name");
			 console.log('$("#"+id).val()'+$("#"+id).val());
			 switch(id){
			 case "byName" :
				 param.byName = $(":text#" + id).val();
				 console.log("param.byName" +param.byName);
				 break;
			 case "byMid" : 
				 param.byMid = $(":text#" + id).val();
				 break;
			 case "nickname" : 
				 param.nickname = $(":text#" + id).val();
				 break;
			 }
		 }
		 }
	 	
	 if($("#gender>option:selected").not("#defaultGender")) 
		 param.gender = $("#gender>option:selected").val();
	 console.log("parma의 gender는 : " + param.gender);
	 	 
 	 param.age = $("[name=age]").val();
 	 console.log("ageRange==",param.age);
 	 
	 var str = JSON.stringify(param);
	 console.log(param);
	 
	  
	 $.ajax({
		 url: '${pageContext.request.contextPath}/admin/searchPpl.do',
		 dataType: "json", 
		 type: "POST", 
		 data: str, 	
		 contentType: "application/json; charset=UTF-8", 
		 success: function(data){
			 console.log(data);
				 if(data == "") {
					 alert("검색하신 회원이 없습니다.검색 조건을 다시 입력해주세요.");
					
					 $("#byName" && "#byMid" && "#nickname").val("");
				 }
				 if(data !== ""){
					 $("#pplList").html("");
					 console.log(data);
					 for(var i=0; i<data.searchPplList.length; i++){
							$("#t_title>h3").html("검색된 회원입니다."); 
							
					var html = "";
					html += '<div id="m_contentInner" style = "z-index:50;">';
					html += '<div id="m-head">';
					html += '<img class="card-img-top" src="${pageContext.request.contextPath}/resources/upload/member/'+data.searchPplList[i].renamedProfile+'" onclick="seeOneM('+data.searchPplList[i].memberCode+');">';
					html += '<input type="hidden" value="'+data.searchPplList[i].memberCode+'"/>';
					html +=	'<h5 class="card-title">'+data.searchPplList[i].memberName+' </h5></div></div>';
						
					$("#pplList").append(html);	
					}//end of for
					
					$("#byName" && "#byMid" && "#nickname").val("");
			 }
				 console.log("ajax 안에서 cPage:  "+data.cPage);
				 $("i#right").val(data.cPage);
				 $("i#left").val(data.cPage);
				 
				 //// 현재 요청 페이지가 마지막 페이지라면, 더보기 버튼을 비 활성화  
				 if(data.cPage == data.totalPage){
						$("i#right").css("display", "none");
					}
					else{
						$("i#right").css("display","inline-block");				
					}
		 }, 
			 error: function(jqxhr, textStatus, errorThrown){
				 console.log("ajax 처리 실패: " , jqxhr.statu, textStatus, errorThrown);
			 }
	 });
	 };
 </script>
   