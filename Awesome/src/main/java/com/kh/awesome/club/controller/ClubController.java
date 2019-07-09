package com.kh.awesome.club.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.awesome.club.model.service.ClubService;
import com.kh.awesome.club.model.vo.Club;
import com.kh.awesome.club.model.vo.Clubmember;


@Controller
@RequestMapping("/club")
public class ClubController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private ClubService clubService;
	
	@RequestMapping("/clubList.do")
	public ModelAndView clubList(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage){
		ModelAndView mav = new ModelAndView();
		
		int numPerPage =7;
		
		List<Club> clubList = clubService.selectClubList(cPage,numPerPage);
		
		int totalContents = clubService.totalclubCount();
		
		System.out.println("clubList="+clubList);
		System.out.println("club@totalContents="+totalContents);
		
		mav.addObject("cPage",cPage);
		mav.addObject("numPerPage", numPerPage);
		mav.addObject("totalContents",totalContents);
		mav.addObject("clubList",clubList);
		
		return mav;
	}
	
	@RequestMapping("/clubMake")
	public void clubMake() {
		
	}
	
	@RequestMapping("/clubMakeEnd.do")
	@Transactional
	public String clubMakeEnd(Club club,HttpServletRequest request,HttpSession session, @RequestParam("uploadProfile") MultipartFile uploadProfile) {
		//세션에서 memberCode가져오기
//		session.getAttribute("memberLoggedIn");
		
		
		club.setInterestingCode(Integer.parseInt(request.getParameter("interestingCode")));
		club.setMemberCode(1);
		club.setClubName(request.getParameter("clubName"));
	    club.setClubsimpleInfo(request.getParameter("clubsimpleInfo"));
	    club.setClubInfo(request.getParameter("clubInfo"));
		
	    
		logger.info("uploadProfile@club="+uploadProfile);
		
		if(!uploadProfile.isEmpty()) {
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/club");
			String originalFileName = uploadProfile.getOriginalFilename();
			String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
			SimpleDateFormat fileSdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSSS");
			int rndNum = (int)(Math.random()*1000);
			String renamedFileName = fileSdf.format(new java.util.Date())+"_"+rndNum+"."+ext;
			//서버 지정위치에 파일 보관
			
			try {
				uploadProfile.transferTo(new File(saveDirectory+"/"+renamedFileName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			club.setMainoriginalFilename(originalFileName);
			club.setMainrenamedFilename(renamedFileName);
			
		}
		
		int result = clubService.insertClub(club);
		
		
		if(result==1) {
			result = clubService.insertClubAdmin(club);
		}
		
		
		
		
		String msg = result>0?"게시물 등록 성공":"게시물 등록 오류";
		String loc = "/club/clubList.do";
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		return "/common/msg";
	}
	
	
	@RequestMapping("/clubView.do")
	public void selectOneBoard(@RequestParam("no") int clubCode, Model model) {
		logger.debug("클럽 상세보기 요청!");
		System.out.println("클럽상세보기페이지");
		
		Club club = clubService.selectOneClub(clubCode);
		
		model.addAttribute("club",club);
		
		//model.addAttribute("board",b);
	} 
}
