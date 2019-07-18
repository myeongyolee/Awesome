package com.kh.awesome.admin.controller;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.awesome.admin.model.service.AdminService;

@Controller
@RequestMapping("admin")
public class AdminController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private AdminService adminService;
	
	//MainPage 요청
	@RequestMapping("/adminMain.do")
	public void adminMain() {
		if(logger.isDebugEnabled())
			logger.debug("메인 페이지 요청");
		//접속자 수
		
		//회원성비/ 연령대별 /관심분야 /공개여부
		Map<String, Integer> memberStatisticsMap = adminService.memberStatistics();
		//전체 개시물 수  /도시별 개시물 수 / 지역별 개시물 수 / 분야별 개시물 수
		Map<String, Integer> matchStatisticsMap = adminService.matchStatistics();		
		//전체 클럽 수 / 도시별 클럽 수 / 지역별 클럽 수 / 분야별 클럽 수
		Map<String, Integer> clubStatisticsMap = adminService.clubStatistics();
		
		
	}
	
	//회원 정보 모두 보기 
	@RequestMapping("/manageMembers")
	public void manageMembers() {
		if(logger.isDebugEnabled())
			logger.debug("멤버 페이지 요청");
	}
	/*public ModelAndView selectAllMembers(
			@RequestParam(value = "cPage", required=false
			, defaultValue = "1") int cPage) {
		if(logger.isDebugEnabled())
			logger.debug("멤버관리 페이지 요청");*/
		/*ModelAndView mav = new ModelAndView();
		//한페이지당 10명 데리고 오기
		int numPerPage = 10;
		
		List<Map<String, String>> list =
				adminService.selectAllMembers(cPage, numPerPage); 
		logger.info("list@Controller == "  + list);
		
		//전체 컨텐츠수 구하기 
		int totalMemberNum = adminService.selectTotalMemberNum();
		logger.info("총 멤버수@Controller == " + totalMemberNum);
		
		mav.addObject("list", list);
		mav.addObject("totalMemberNum", totalMemberNum);
		mav.addObject("numPerPage", numPerPage);
		mav.addObject("cPage", cPage);
		
		return mav;
	}*/
	
	
	
}
