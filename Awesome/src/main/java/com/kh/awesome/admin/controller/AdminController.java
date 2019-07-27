package com.kh.awesome.admin.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.awesome.admin.model.service.AdminService;
import com.kh.awesome.admin.model.vo.Report;
import com.kh.awesome.board.model.vo.QuestionComment;


@Controller
@RequestMapping("/admin")
public class AdminController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private AdminService adminService;
	
	//MainPage 요청
	@RequestMapping("/adminMain.do")
	public void adminMain() {

		
	}
	
	//회원 정보 모두 보기 
	@RequestMapping("/manageMembers")
	public void manageMembers() {
		
	}
	@RequestMapping("/showAll.do")
	@ResponseBody
	public Map<String,Object> selectAllMembers(
			@RequestParam(value = "cPage", required=false, defaultValue = "1") int cPage) {
		Map<String,Object> map = new HashMap<String,Object>();
		//한페이지당 10명씩 데리고 오기
		int numPerPage = 12;
		logger.info("cPage@Controller== "+cPage);
		List<Map<String, String>> list =
				adminService.selectAllMembers(cPage, numPerPage); 
		
		//전체 컨텐츠수 구하기 
		int totalMemberNum = adminService.selectTotalMemberNum();
		int totalPage = (int)(Math.ceil(totalMemberNum*1.0/numPerPage));
		logger.info("총 멤버수@Controller == " + totalMemberNum);
		
		map.put("list", list);
		map.put("totalMemberNum", totalMemberNum);
		map.put("numPerPage", numPerPage);
		map.put("totalPage", totalPage);
		map.put("cPage", cPage);
		
		
		return map;
	}
	
	@RequestMapping("/chart.do")
	public void drawChart(Model model) {
		//회원성비 / 연령대별 / 도시별 개시물 수 / 분야별 개시물 수 / 전체 클럽 수 / 도시별 클럽 수 / 분야별 클럽 수
		List<Map<String, String>> chartList = adminService.drawChart();
		//도시리스트가져오기
		List<String> cityList = adminService.selectCityList();
		logger.info("chartList={}", chartList);
		model.addAttribute("chartList", chartList);
		model.addAttribute("cityList", cityList);
	}
	
	//인터셉터로변경예정
	@RequestMapping("/reportCheck.do")
	public void reportCheck(HttpServletRequest request) {
//		신고하는 회원코드
//		Member member = (Member)session.getAttribute("memberLoggedIn");
//		int memberCode = member.getMemberCode();
//		테스트용memberCode
		int memberCode = 60;
		
		List<Report> reportList = adminService.selectReportList(memberCode);
	}
	
	@RequestMapping("/seeOneMember")
	@ResponseBody
	public  Map<String,Object> seeOneMember(
			@RequestParam(value = "memberCode") int memberCode) {
		logger.info("memberCode"+memberCode);
		Map<String, Object> oneM = adminService.seeOneMember(memberCode);
		String cm = adminService.seeClubJoined(memberCode);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("oneM", oneM);
		map.put("cm", cm);
		return map;
	}
	
	@RequestMapping("/report.do")
	public void report(HttpServletRequest request, HttpSession session) {
//		신고한 회원코드
//		Member member = (Member)session.getAttribute("memberLoggedIn");
//		int memberCode = member.getMemberCode();
//		테스트용memberCode
		int memberCode = 60;
//		신고타입
		String reportType = request.getParameter("reportType");
//		신고대상코드
		int reportedCode = Integer.parseInt(request.getParameter("reportedCode"));
//		신고대상분류(회원인지, 개시글인지, 클럽인지)
		String reportedType = request.getParameter("reportedType");
//		신고내용
		String reportComment = request.getParameter("reportComment");
		
		Report report = new Report(memberCode, reportType, reportedCode, reportedType, reportComment);
		int result = adminService.insertReport(report);
		
		
	}
	
	@RequestMapping("/searchPpl.do")
	@ResponseBody
	public Map<String, Object> searchPpl(@RequestBody Map requestMap){
		logger.info("requestMap={}", requestMap);
		int cPage = Integer.parseInt((String)requestMap.get("cPage"));
		String byName = "";
		String byMid = "";
		String nickname = "";
		String gender="";
		
		if(requestMap.get("byName")!=null) byName = (String)requestMap.get("byName");
		if(requestMap.get("byMid")!=null) byMid = (String)requestMap.get("byMid");
		if(requestMap.get("nickname")!=null) nickname = (String)requestMap.get("nickname");
		if(requestMap.get("gender")!=null) gender = String.valueOf(requestMap.get("gender"));
		Map<String, String> search = new HashMap();
		
		search.put("byName", byName);
		search.put("byMid", byMid);
		search.put("nickname", nickname);
		search.put("gender", gender);
		
		int numPerPage = 12;
		logger.info("search==@controller"+ search);
		List<Map<String, Object>> searchPplList = adminService.searchPpl(search, cPage, numPerPage);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchPplList", searchPplList);
		map.put("numPerPage", numPerPage);
		map.put("cPage", cPage);
		
		logger.info("searchPplList={}", searchPplList);
		logger.info("searchPplList.size= " + searchPplList.size());		
		
		return map;
	}
	
}
