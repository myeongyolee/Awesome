<%@page import="com.kh.awesome.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% Member member = (Member)session.getAttribute("memberLoggedIn"); %>

<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.0.js"></script>
<style>
.img-thumbnail{
	width: 284px;
	height: 194px;
}

</style>

<script>
$(function(){
	$("#img-viewer1").click(function(){
		$("#uploadProfile1").click();
	});	
});
function loadProfile1(f){
	console.log(f.files);
	
	if(f.files && f.files[0]){
		var reader = new FileReader();
		reader.readAsDataURL(f.files[0]);
		reader.onload = function(){
			$("#img-viewer1").attr("src", reader.result);
		}
	}
};

function loadProfile2(f){
	console.log(f.files);
	
	if(f.files && f.files[0]){
		var reader = new FileReader();
		reader.readAsDataURL(f.files[0]);
		reader.onload = function(){
			$("#img-viewer2").attr("src", reader.result);
		}
	}
};

function loadProfile3(f){
	console.log(f.files);
	
	if(f.files && f.files[0]){
		var reader = new FileReader();
		reader.readAsDataURL(f.files[0]);
		reader.onload = function(){
			$("#img-viewer3").attr("src", reader.result);
		}
	}
};
</script>

<table id="clubcontentImg">
	<div>
		<c:if test="${empty schoolInfo[0].MAIN_RENAMED_FILENAME }">
			<img src="${pageContext.request.contextPath }/resources/images/log.jpg"  alt=""  style="width: 95%; height: 250px; "  />
		</c:if>
		<c:if test="${not empty schoolInfo[0].MAIN_RENAMED_FILENAME}">
			<img src="${pageContext.request.contextPath }/resources/upload/school/${schoolInfo[0].MAIN_RENAMED_FILENAME}"  alt=""  style="width: 95%; height: 250px; " />
		</c:if>
	</div>
</table>

	<button class="btn btn-outline-secondary" onclick="imgcountAdd();" style="position:relative; left:20px;">사진더올리기</button>
	
	<form action="${pageContext.request.contextPath}/school/schoolContentImgEnd" method="post" enctype="multipart/form-data">
		<div class="main-container" style="display:flex;">
		
		<div class="1" id="1" style="display: inline; margin-left: 20px; ">
			<img src="${pageContext.request.contextPath}/resources/images/sampleimage.png" id="img-viewer1">
			<input type="file" name="upFile" id="uploadProfile1" style="display:none;" onchange="loadProfile1(this);"/>	
			<input type="hidden" name="content1" id="content1"/>			
		</div>
		
		</div>
		
		<br>

		<input type="hidden" name="clubCode" value="${schoolInfo[0].CLUB_CODE }"/>
		<input type="hidden" name="memberCode" value="<%=member.getMemberCode() %>"/>
		<input type="hidden" name="writeLevel" value="2" readonly>
		
		<button  type="submit" class="btn btn-primary" style="position: absolute; left: 38%;">등록하기</button>
		<button  type="button" class="btn btn-primary" value="BACK" onclick="history.go(-1)" style="position: absolute; left: 53%;">취소</button>
	</form> 


<script>
function imgcountAdd(){
	
	var num2 = $("div.2").attr("id");
	var num3 = $("div.3").attr("id");
	
	if(num2 == undefined && num3 == undefined){
		var HTML = "";
		HTML += "<div class='2' id='2' style='display:inline;'>";
		HTML += "<img src='${pageContext.request.contextPath}/resources/images/sampleimage.png' id='img-viewer2' onclick='imgupload(this);'>";
		HTML += "<input type='file' name='upFile' id='uploadProfile2' style='display:none;' onchange='loadProfile2(this);'/>";
		HTML += "<input type='hidden' name='content2' id='content2' />";
		HTML += "</div>";
		HTML += "<br>";
		$("div.main-container").append(HTML);
	}
	
	else if(num2 != undefined && num3 == undefined){
		var HTML = "";
		HTML += "<div class='3' id='3' style='display:inline;'>";
		HTML += "<img src='${pageContext.request.contextPath}/resources/images/sampleimage.png' id='img-viewer3' onclick='imgupload(this);'>";
		HTML += "<input type='file' name='upFile' id='uploadProfile3' style='display:none;' onchange='loadProfile3(this);'/>";
		HTML += "<input type='hidden' name='content3' id='content3' />";
		HTML += "</div>";
		HTML += "<br>";
		$("div.main-container").append(HTML);
	}
	else {
		alert("더이상 추가할 수 없습니다.");
	}
}

function imgupload(result){
	
	if(result.id == "img-viewer2"){
		$("#uploadProfile2").click();
	}
	
	if(result.id == "img-viewer3"){
		$("#uploadProfile3").click();
	}
}
</script>