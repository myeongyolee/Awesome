package com.kh.awesome.club.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.awesome.club.model.service.ClubService;
import com.kh.awesome.club.model.vo.Club;

@Controller
@RequestMapping("/club")
public class ClubController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private ClubService clubService;
	
	@RequestMapping("/clubList")
	public ModelAndView clubList(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage){
		ModelAndView mav = new ModelAndView();
		int numPerPage =10;
		
		List<Club> clublist = clubService.selectClubList(cPage,numPerPage);
		int totalCOntesnts = clubService.totalclubCount();
		
		mav.addObject("cPage",cPage);
		mav.addObject("numPerPage", numPerPage);
		mav.addObject("totalContents",totalCOntesnts);
		mav.addObject("clubList",clublist);
		
		return null;
	}
}
