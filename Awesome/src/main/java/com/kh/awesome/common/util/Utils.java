package com.kh.awesome.common.util;

public class Utils {
	
	public static String getPageBar(int totalContent, int cPage, int numPerPage, String url) {
		
		String pageBar = "";
		
		//페이지바에 표시할 페이지 수
		int pageBarSize = 5;
		
		//총 페이지수
		int totalPage = (int)Math.ceil((double)totalContent/numPerPage);
		
		//pageBar순회용변수
		int pageNo = ((cPage-1)/pageBarSize) * pageBarSize + 1;
		//마지막페이지 변수
		int pageEnd = pageNo + pageBarSize - 1;
		
		pageBar += "<ul class='pagination justify-content-center pagination-sm'>";
		//[이전]
		if(pageNo == 1) {
			pageBar += "<li class='page-item disabled'>";
			pageBar += "<a class='page-link' href='#' tabindex='-1'>이전</a>";
			pageBar += "</li>";
		}
		else {
			pageBar += "<a class='page-link' href='javascript:paging("+(pageNo-1)+")'>이전</a>";
			pageBar += "</li>";
		}
		
		//[pageNo]
		while(!(pageNo>pageEnd || pageNo>totalPage)) {
			//현재페이지인 경우,
			if(pageNo == cPage) {
				pageBar += "<li class='page-item active'>";
				pageBar += "<a class='page-link'>"+pageNo+"</a>";
				pageBar += "</li>";
			}
			else {
				pageBar += "<a class='page-link' href='javascript:paging("+(pageNo)+")'>"+pageNo+"</a>";
				pageBar += "</li>";
			}
			pageNo++;
		}
		
		//[다음]section
		//다음페이지가 없는 경우
		if(pageNo > totalPage) {
			pageBar += "<li class='page-item disabled'>";
			pageBar += "<a class='page-link' href='#'>다음</a>";
			pageBar += "</li>";
		}
		else {
			pageBar += "<a class='page-link' href='javascript:paging("+(pageNo)+")'>다음</a>";
			pageBar += "</li>";
		}
		
		pageBar += "</ul>";
		
		
		//paging함수
		pageBar += "<script>";
		pageBar += "function paging(cPage){";
		pageBar += "location.href='"+url+"?cPage='+cPage;";
		pageBar += "}";
		pageBar += "</script>";
		
		return pageBar;
	}
	
	public static String getPageBar2 (int totalContent, int cPage, int numPerPage, String memberCode, String schoolId, String url) {
		
		String pageBar = "";
		
		//페이지바에 표시할 페이지 수
		int pageBarSize = 5;
		
		//총 페이지수
		int totalPage = (int)Math.ceil((double)totalContent/numPerPage);
		
		//pageBar순회용변수
		int pageNo = ((cPage-1)/pageBarSize) * pageBarSize + 1;
		//마지막페이지 변수
		int pageEnd = pageNo + pageBarSize - 1;
		
		pageBar += "<ul class='pagination justify-content-center pagination-sm'>";
		//[이전]
		if(pageNo == 1) {
			pageBar += "<li class='page-item disabled'>";
			pageBar += "<a class='page-link' href='#' tabindex='-1'>이전</a>";
			pageBar += "</li>";
		}
		else {
			pageBar += "<a class='page-link' href='javascript:paging("+(pageNo-1)+")'>이전</a>";
			pageBar += "</li>";
		}
		
		//[pageNo]
		while(!(pageNo>pageEnd || pageNo>totalPage)) {
			//현재페이지인 경우,
			if(pageNo == cPage) {
				pageBar += "<li class='page-item active'>";
				pageBar += "<a class='page-link'>"+pageNo+"</a>";
				pageBar += "</li>";
			}
			else {
				pageBar += "<a class='page-link' href='javascript:paging("+(pageNo)+")'>"+pageNo+"</a>";
				pageBar += "</li>";
			}
			pageNo++;
		}
		
		//[다음]
		//다음페이지가 없는경우,
		if(pageNo > totalPage) {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='#'>다음</a>";
			pageBar += "</li>";
		}
		else {
			pageBar += "<a class='page-link' href='javascript:paging("+(pageNo)+")'>다음</a>";
			pageBar += "</li>";
		}
		
		pageBar += "</ul>";
		
		
		//paging함수
		pageBar += "<script>";
		pageBar += "function paging(cPage){";
		pageBar += "location.href='"+url+"?schoolCode="+schoolId+"&memberCode="+memberCode+"&cPage='+cPage;";
		pageBar += "}";
		pageBar += "</script>";
		
		return pageBar;
	}
	
	public static String getPageBar3(int totalContent, int cPage, int numPerPage, String memberCode, String url) {
		
		String pageBar = "";
		
		//페이지바에 표시할 페이지 수
		int pageBarSize = 5;
		
		//총 페이지수
		int totalPage = (int)Math.ceil((double)totalContent/numPerPage);
		
		//pageBar순회용변수
		int pageNo = ((cPage-1)/pageBarSize) * pageBarSize + 1;
		//마지막페이지 변수
		int pageEnd = pageNo + pageBarSize - 1;
		
		pageBar += "<ul class='pagination justify-content-center pagination-sm'>";
		//[이전]
		if(pageNo == 1) {
			pageBar += "<li class='page-item disabled'>";
			pageBar += "<a class='page-link' href='#' tabindex='-1'>이전</a>";
			pageBar += "</li>";
		}
		else {
			pageBar += "<a class='page-link' href='javascript:paging("+(pageNo-1)+")'>이전</a>";
			pageBar += "</li>";
		}
		
		//[pageNo]
		while(!(pageNo>pageEnd || pageNo>totalPage)) {
			//현재페이지인 경우,
			if(pageNo == cPage) {
				pageBar += "<li class='page-item active'>";
				pageBar += "<a class='page-link'>"+pageNo+"</a>";
				pageBar += "</li>";
			}
			else {
				pageBar += "<a class='page-link' href='javascript:paging("+(pageNo)+")'>"+pageNo+"</a>";
				pageBar += "</li>";
			}
			pageNo++;
		}
		
		//[다음]
		//다음페이지가 없는경우,
		if(pageNo > totalPage) {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='#'>다음</a>";
			pageBar += "</li>";
		}
		else {
			pageBar += "<a class='page-link' href='javascript:paging("+(pageNo)+")'>다음</a>";
			pageBar += "</li>";
		}
		
		pageBar += "</ul>";
		
		
		//paging함수
		pageBar += "<script>";
		pageBar += "function paging(cPage){";
		pageBar += "location.href='"+url+"?memberCode="+memberCode+"&cPage='+cPage;";
		pageBar += "}";
		pageBar += "</script>";
		
		return pageBar;
	}
	public static String getPageBar4(int totalContent, int cPage, int numPerPage, int clubCode, String url) {
		
		String pageBar = "";
		
		//페이지바에 표시할 페이지 수
		int pageBarSize = 5;
		
		//총 페이지수
		int totalPage = (int)Math.ceil((double)totalContent/numPerPage);
		
		//pageBar순회용변수
		int pageNo = ((cPage-1)/pageBarSize) * pageBarSize + 1;
		//마지막페이지 변수
		int pageEnd = pageNo + pageBarSize - 1;
		
		pageBar += "<ul class='pagination justify-content-center pagination-sm'>";
		//[이전]
		if(pageNo == 1) {
			pageBar += "<li class='page-item disabled'>";
			pageBar += "<a class='page-link' href='#' tabindex='-1'>이전</a>";
			pageBar += "</li>";
		}
		else {
			pageBar += "<a class='page-link' href='javascript:paging("+(pageNo-1)+")'>이전</a>";
			pageBar += "</li>";
		}
		
		//[pageNo]
		while(!(pageNo>pageEnd || pageNo>totalPage)) {
			//현재페이지인 경우,
			if(pageNo == cPage) {
				pageBar += "<li class='page-item active'>";
				pageBar += "<a class='page-link'>"+pageNo+"</a>";
				pageBar += "</li>";
			}
			else {
				pageBar += "<a class='page-link' href='javascript:paging("+(pageNo)+")'>"+pageNo+"</a>";
				pageBar += "</li>";
			}
			pageNo++;
		}
		
		//[다음]
		//다음페이지가 없는경우,
		if(pageNo > totalPage) {
			pageBar += "<li class='page-item'>";
			pageBar += "<a class='page-link' href='#'>다음</a>";
			pageBar += "</li>";
		}
		else {
			pageBar += "<a class='page-link' href='javascript:paging("+(pageNo)+")'>다음</a>";
			pageBar += "</li>";
		}
		
		pageBar += "</ul>";
		
		
		//paging함수
		pageBar += "<script>";
		pageBar += "function paging(cPage){";
		pageBar += "location.href='"+url+"?clubCode="+clubCode+"&cPage='+cPage;";
		pageBar += "}";
		pageBar += "</script>";
		
		return pageBar;
	}

}