package com.kh.awesome.club.controller;

<<<<<<< HEAD
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
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
import com.kh.awesome.club.model.vo.Clubcontent;
import com.kh.awesome.lightning.model.service.LightningService;


@Controller
@RequestMapping("/club")
public class ClubController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	//세션에서 memberCode가져오기
//	session.getAttribute("memberLoggedIn");
	
	@Autowired
	private ClubService clubService;
	@Autowired
	private LightningService lightningService;
	
	@RequestMapping("/clubList.do")
	public ModelAndView clubList(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage){
		ModelAndView mav = new ModelAndView();
		
		int numPerPage =7;
		
		List<Club> clubList = clubService.selectClubList(cPage,numPerPage);
		
		int totalContents = clubService.totalclubCount();
		
		System.out.println("clubList="+clubList);
		System.out.println("club@totalContents="+totalContents);
		
		
		//도시목록 가져오기
		List<String> cityList = lightningService.selectCityList();
		//분류목록 가져오기
		List<String> interestingList = lightningService.selectInterestingList();
		
		logger.info("cityList={}",cityList);
		logger.info("interestingList={}",interestingList);
		
		mav.addObject("cityList", cityList);
		mav.addObject("interestingList", interestingList);
	
		mav.addObject("cPage",cPage);
		mav.addObject("numPerPage", numPerPage);
		mav.addObject("totalContents",totalContents);
		mav.addObject("clubList",clubList);
		
		return mav;
	}
	
	@RequestMapping("/clubMake")
	public void clubMake(HttpServletRequest request) {
		//도시목록 가져오기
		List<String> cityList = lightningService.selectCityList();
		//분류목록 가져오기
		List<String> interestingList = lightningService.selectInterestingList();
		
		logger.info("cityList={}",cityList);
		logger.info("interestingList={}",interestingList);
		
		request.setAttribute("cityList", cityList);
		request.setAttribute("interestingList", interestingList);
	}
	
	@RequestMapping("/clubMakeEnd.do")
	@Transactional
	public String clubMakeEnd(Club club,HttpServletRequest request,HttpSession session, @RequestParam("uploadProfile") MultipartFile uploadProfile) {
	
		//세션에서 memberCode가져온거써야함
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
	public ModelAndView selectOneClub(@RequestParam("no") int clubCode,@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,HttpSession session) {
		logger.debug("클럽 상세보기 요청!");
		System.out.println("클럽상세보기페이지");
		ModelAndView mav = new ModelAndView();
		
		
		//club테이블+club_member테이블
		Club club = clubService.selectOneClub(clubCode);
		int clubmembercount = club.getClubMember().size();
		String clubadmin= clubService.searchClubAdmin(club.getMemberCode());
		
		mav.addObject("club",club);
		mav.addObject("clubadmin",clubadmin);
		mav.addObject("clubmembercount",clubmembercount);
		
		//club_content테이블
		int numPerPage =7;
		
		List<Clubcontent> contentList = clubService.selectcontentList(clubCode,cPage,numPerPage);
		
		int totalContents = clubService.totalclubCount();
		
		System.out.println("contentList="+contentList);
		System.out.println("club@totalContents="+totalContents);
		
		mav.addObject("cPage",cPage);
		mav.addObject("numPerPage", numPerPage);
		mav.addObject("totalContents",totalContents);
		mav.addObject("contentList",contentList);
		
		
		
		//meeting_photo테이블
		
		
		
		return mav;
		
	} 
	
	
	@RequestMapping("/clubcontentMake.do")
	public void clubcontentEnroll(@RequestParam("clubCode") int clubCode,Model model,HttpSession session) {
		Club club = clubService.selectOneClub(clubCode);
		model.addAttribute("club",club);
		
	} 
	
	@RequestMapping("/clubcontentMakeend.do")
	public String clubcontentMakeend(@RequestParam("clubCode") int clubCode,HttpServletRequest request,HttpSession session,Model model) {
		Clubcontent clubcontent = new Clubcontent();
		clubcontent.setClubCode(Integer.parseInt(request.getParameter("clubCode")));
		clubcontent.setMemberCode(Integer.parseInt(request.getParameter("memberCode")));
		clubcontent.setContentTitle(request.getParameter("contentTitle"));
		clubcontent.setContent(request.getParameter("content"));
		clubcontent.setWriteLevel(Integer.parseInt(request.getParameter("writeLevel")));
		
		int result = clubService.insertclubContent1(clubcontent);
		System.out.println("$$$$$"+result);
		
		String msg = result>0?"게시물 등록 성공":"게시물 등록 오류";
		String loc = "/club/clubView.do?no="+request.getParameter("clubCode");
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		return "/common/msg";
	} 
	
	@RequestMapping("/clubcontentView")
	public ModelAndView clubcontentView(@RequestParam("no") int contentCode,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		Clubcontent clubcontent = new Clubcontent();
		clubcontent=clubService.selectClubcontentOne(contentCode);
		
		mav.addObject("clubcontent",clubcontent);
		
		
		return mav;
	}
	
=======
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
>>>>>>> refs/remotes/origin/jinwoo
}
