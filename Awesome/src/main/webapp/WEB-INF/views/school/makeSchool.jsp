<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.0.js"></script>

<style>
div.one{
	width: 1000px;
	height: 500px;
	
	border: 1px solid black;
}

div.two{
	width: 400px;
	height: 400px;
	
	border: 1px solid red;
	position: absolute;
	display: inline-block;
}

div.three{
	width: 400px;
	height: 400px;
	
	border: 1px solid blue;
	display: inline-block;
	position: absolute;
	left: 450px;
}

input[name=upFile], input[name=submit]{
	position:relative;
	top: 430px;
	
}
button[name=searchSchool]{
	position:relative;
	left: 800px;
	top: 55px;
}
</style>

</head>
<body>

<div class="one">

<form action="${pageContext.request.contextPath }/school/makeSchoolEnd" enctype="multipart/form-data" method="post">
<div class="two">
<img id="img-viewer" width=350 />
</div>

<div class="three">
<input type="text" name="memberCode" value="작성자코드" />
<hr />

<input type="text" name="schoolClubTitle" placeholder="모임제목 입력" />
<hr />

<input type="text" name="schoolName" placeholder="학교등록하기"/>
<div class="school-select">
</div>
<input type="text" name="schoolId" placeholder="학교id" />
<input type="text" name="schoolAddress" placeholder="학교주소" />
<hr />

<input type="text" name="club_info" placeholder="클럽간단소개"/>
<hr />

<input type="text" name="club_info_long" placeholder="클럽상세소개"/>
<hr />
</div>

<input type="file" name="upFile" id="upFile" onchange="loadImg(this);">
<input type="submit" name="submit" value="전송" />
</form>

<button name="searchSchool" onclick="enrollSchool();">학교검색</button>

</div>
	


<script>
$(function(){
	$("div.school-select").hide();
});
</script>

<script>
function enrollSchool(){
  	console.log("enrollSchool들어옴");
	var ch1 = $("input[name=schoolName]").val();
	console.log(ch1);
	
	$.ajax({
		url:"${pageContext.request.contextPath}/school/test",
		data:{schoolName1:ch1},
		success:function(data){
			console.log(data);
			
			if(data.response.header.resultCode == '00'){
				var HTML = "";
				
				if(data.response.body.items.length > 1){
					for(var i=0; i<data.response.body.items.length; i++){
						console.log("반복문 들어옴 확인");
						
						$("div.school-select").show();
						
						var result = data.response.body.items[i].schoolNm;
						var result2 = data.response.body.items[i].schoolId;
						var result3 = data.response.body.items[i].lnmadr;
				
						HTML += "<a href='#' onclick='selectSchool("+i+");' class='p"+i+"'>"+result+"</a>";
						HTML += "<input type='hidden' name='pid"+i+"' value='"+result2+"'>";
						HTML += "<input type='hidden' name='padd"+i+"' value='"+result3+"' >";
						HTML += "&nbsp;&nbsp;&nbsp;";
						HTML += "<p>"+result3+"</p>";
						HTML += "<br/>";
					}
					$("div.school-select").append(HTML);
					
				}
				else if(data.response.body.items.length == 1){
					var result = data.response.body.items[0].schoolNm;
					var result2 = data.response.body.items[0].schoolId;
					var result3 = data.response.body.items[0].lnmadr;
					
					console.log(result);
					console.log(result2);
					console.log(result3);
					
					$("input[name=schoolName]").val(result);
					$("input[name=schoolId]").val(result2);
					$("input[name=schoolAddress]").val(result3);
				}
			}
			else{
				console.log("해당데이터가 없습니다");
				$("input[name=schoolName]").val("해당 학교가 존재하지 않습니다.");
			}			
		}
	}); 
}

function selectSchool(num){
	console.log("selectSchool 들어옴");
	console.log(num);
	
	var result = $("a.p"+num)[0].innerHTML;
	var result2 = $("input[name=pid"+num+"]").val();
	var result3 = $("input[name=padd"+num+"]").val();
	
	console.log(result);
	console.log(result2);
	console.log(result3);
	
	$("input[name=schoolName]").val(result);
	$("input[name=schoolId]").val(result2);
	$("input[name=schoolAddress]").val(result3);
	
	$("div.school-select").hide();
	
}
</script>

<script>
function loadImg(f){
	console.log(f.files); //파일리스트
	console.log(f.files[0]); // 실제업로드한파일(리스트내에 존재)
	
	if(f.files && f.files[0]){ //JavaScript에서는 값이 있으면 true, 없으면 false로 볼 수 있음
		var reader = new FileReader();
		//파일읽기메소드 호출. 읽기완료하면 onload에 등록된 함수를 호출
		reader.readAsDataURL(f.files[0]);
		reader.onload = function(){
			//result속성에는 파일컨텐츠가 담겨있음
			$("#img-viewer").attr("src", reader.result);
		}
	}
}
</script>
	
</body>
</html>