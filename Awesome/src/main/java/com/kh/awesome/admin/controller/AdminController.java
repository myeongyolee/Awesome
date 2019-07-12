package com.kh.awesome.admin.controller;


import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

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
