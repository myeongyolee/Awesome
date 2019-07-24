package com.kh.awesome.admin.controller;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.awesome.admin.model.service.AdminService;
import com.kh.awesome.admin.model.vo.Report;


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
	public ModelAndView selectAllMembers(
			@RequestParam(value = "cPage", required=false
			, defaultValue = "1") int cPage) {
		
		ModelAndView mav = new ModelAndView();
		//한페이지당 10명씩 데리고 오기
		int numPerPage = 10;
		
		List<Map<String, String>> list =
				adminService.selectAllMembers(cPage, numPerPage); 
		
		//전체 컨텐츠수 구하기 
		int totalMemberNum = adminService.selectTotalMemberNum();
		logger.info("총 멤버수@Controller == " + totalMemberNum);
		
		mav.addObject("list", list);
		mav.addObject("totalMemberNum", totalMemberNum);
		mav.addObject("numPerPage", numPerPage);
		mav.addObject("cPage", cPage);
		
		return mav;
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
	
	/*@RequestMapping("/seeOneMember")
	public ModelAndView seeOneMember(
			@RequestParam("memberCode") int memberCode) {
		
		ModelAndView mav = new ModelAndView();
		Map<String, Object>
		Member m = adminService.seeOneMember(memberCode);
		Clubmember cm = adminService.seeClubJoined(memberCode);
		mav.addObject("member", m);
		mav.addObject("clubjoined", cm);
		mav.setViewName("admin/seeOneMember");
		return mav;
	}*/
	
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
}
