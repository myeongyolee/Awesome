package com.kh.awesome.club.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.awesome.club.model.service.ClubService;
import com.kh.awesome.club.model.vo.Club;
import com.kh.awesome.club.model.vo.Clubcomment;
import com.kh.awesome.club.model.vo.Clubcontent;
import com.kh.awesome.club.model.vo.Clubphoto;
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
		
		int cityCode = Integer.parseInt(request.getParameter("cityName"));
		int localCode = Integer.parseInt(request.getParameter("localCode"));
		System.out.println("!!^"+cityCode+","+localCode);
		club.setLocalCode(localCode);
		
		
		
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
	
	
	
	//클럽선택시 클럽뷰페이지로전송
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
		
		mav.addObject("cPage",cPage);
		mav.addObject("numPerPage", numPerPage);
		mav.addObject("totalContents",totalContents);
		mav.addObject("contentList",contentList);
		
		
		
		//club_photo테이블
		List<Clubcontent> photocontentList = clubService.selectphotocontentList(clubCode);
		System.out.println("club@photoList="+photocontentList);
		mav.addObject("photoList",photocontentList);
		
		return mav;
		
	} 
	
	
	@RequestMapping("/clubcontentMake.do")
	public void clubcontentEnroll(@RequestParam("clubCode") int clubCode,Model model,HttpSession session) {
		Club club = clubService.selectOneClub(clubCode);
		model.addAttribute("club",club);
	} 
	
	//클럽게시글 작성
	@RequestMapping("/clubcontentMakeend.do")
	public String clubcontentMakeend(@RequestParam("clubCode") int clubCode,HttpServletRequest request,HttpSession session,Model model) {
		Clubcontent clubcontent = new Clubcontent();
		clubcontent.setClubCode(Integer.parseInt(request.getParameter("clubCode")));
		clubcontent.setMemberCode(Integer.parseInt(request.getParameter("memberCode")));
		clubcontent.setContentTitle(request.getParameter("contentTitle"));
		clubcontent.setContent(request.getParameter("content"));
		clubcontent.setWriteLevel(Integer.parseInt(request.getParameter("writeLevel")));
		
		int result = clubService.insertclubContent1(clubcontent);
		
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
		Club club = clubService.selectOneClub(clubcontent.getClubCode());
		
		
		mav.addObject("clubcontent",clubcontent);
		mav.addObject("club",club);
		
		return mav;
	}
	
	
	
	@RequestMapping("/clubcontentNotice.do")
	public void clubcontentNotice(@RequestParam("clubCode") int clubCode,Model model,HttpSession session) {
		Club club = clubService.selectOneClub(clubCode);
		model.addAttribute("club",club);
	} 
	
	
	
	//공지사항등록
	@RequestMapping("/clubcontentNoticeend.do")
	public String clubcontentNoticeinsert(@RequestParam("clubCode") int clubCode,HttpServletRequest request,HttpSession session) {
		Clubcontent clubcontent = new Clubcontent();
		clubcontent.setClubCode(Integer.parseInt(request.getParameter("clubCode")));
		clubcontent.setMemberCode(Integer.parseInt(request.getParameter("memberCode")));
		clubcontent.setContentTitle(request.getParameter("contentTitle"));
		clubcontent.setContent(request.getParameter("content"));
		clubcontent.setWriteLevel(Integer.parseInt(request.getParameter("writeLevel")));
		
		int result = clubService.insertclubContent0(clubcontent);
		
		String msg = result>0?"게시물 등록 성공":"게시물 등록 오류";
		String loc = "/club/clubView.do?no="+request.getParameter("clubCode");
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		return "/common/msg";
	}
	
	//클럽이미지등록
	@RequestMapping("/clubcontentImg.do")
	public void clubcontentImg(@RequestParam("clubCode") int clubCode,Model model,HttpSession session) {
		Club club = clubService.selectOneClub(clubCode);
		model.addAttribute("club",club);
	
	}
	
	@RequestMapping("/clubcontentImgend.do")
	public String clubcontentImginsert(@RequestParam("clubCode") int clubCode,HttpServletRequest request,HttpSession session,MultipartFile[] upFile) {
		Clubcontent clubcontent = new Clubcontent();
		clubcontent.setClubCode(Integer.parseInt(request.getParameter("clubCode")));
		clubcontent.setMemberCode(Integer.parseInt(request.getParameter("memberCode")));
		clubcontent.setContentTitle("사진");
		clubcontent.setContent("사진게시판");
		clubcontent.setWriteLevel(Integer.parseInt(request.getParameter("writeLevel")));
		
		int result = clubService.insertclubContent2(clubcontent);
		System.out.println("sijoon:"+clubcontent.getClubcontentCode());
		
		
		String picinfo1 = request.getParameter("content1");
		String picinfo2 = request.getParameter("content2");
		String picinfo3 = request.getParameter("content3");
		int cnt =1;
		
		try {
		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/club");
		List<Clubphoto> clubphotoList = new ArrayList<>();
				
		
		for(MultipartFile f: upFile) {
			if(!f.isEmpty()) {
				String originalFileName = f.getOriginalFilename();
				String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
				int rndNum = (int)(Math.random()*1000);
				
				String renamedFileName = sdf.format(new Date())+"_"+rndNum+"."+ext;
				try {
					f.transferTo(new File(saveDirectory+"/"+renamedFileName));
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				Clubphoto clubphoto = new Clubphoto();
				clubphoto.setClubcontentCode(clubcontent.getClubcontentCode());
				clubphoto.setClubCode(clubCode);
				clubphoto.setCluboriginalFilename(originalFileName);
				clubphoto.setClubrenamedFilename(renamedFileName);
				if(cnt==1) {
				clubphoto.setPicInfo(picinfo1);	
				}
				else if(cnt==2) {
				clubphoto.setPicInfo(picinfo2);	
				}	
				else if(cnt==3) {
				clubphoto.setPicInfo(picinfo3);
				}
				
				cnt++;
				clubphotoList.add(clubphoto);
			}			
		}
		
		logger.debug("clubphotoList={}",clubphotoList);
			
		result= clubService.insertClubphoto(clubphotoList);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		String msg = result>0?"사진 등록 성공":"사진 등록 오류";
		String loc = "/club/clubView.do?no="+request.getParameter("clubCode");
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		return "/common/msg";
		
	}
	
	@RequestMapping("/clubComment.do")
	@ResponseBody
	public String ajax_addComment(@ModelAttribute("clubComment") Clubcomment clubComment, HttpServletRequest request) throws Exception{
       int result =0;
		
	   int commentwriter = Integer.parseInt(request.getParameter("commentWriter"));
       String commentcontent = request.getParameter("commentContent");
       int meetingcontentcode = Integer.parseInt(request.getParameter("meetingcontentCode"));
        
       Clubcomment clubcomment = new Clubcomment();
       clubcomment.setCommentWriter(commentwriter);
       clubcomment.setCommentContent(commentcontent);
       clubComment.setMeetingcontentCode(meetingcontentcode);
       
        try{      
            result=clubService.addComment(clubComment);
            
        } catch (Exception e){
            e.printStackTrace();
        }
        
        return "success";
    }
	
	 @RequestMapping(value="commentList.do", produces="application/json; charset=utf8")
	    @ResponseBody
	    public List<HashMap> ajax_commentList(@ModelAttribute("clubComment") Clubcomment clubComment, HttpServletRequest request) throws Exception{
	        
	        HttpHeaders responseHeaders = new HttpHeaders();
	        ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
	        
	        // 해당 게시물 댓글
	        List<Clubcomment> commentVO = clubService.selectBoardCommentByCode(clubComment);
	        System.out.println("qqqqq"+clubComment);
	        
	        if(commentVO.size() > 0){
	            for(int i=0; i<commentVO.size(); i++){
	                HashMap hm = new HashMap();
	                hm.put("meetingcommentCode", commentVO.get(i).getMeetingcommentCode());//댓글번호
	                hm.put("commentWriter",commentVO.get(i).getCommentWriter());//작성자번호
	                hm.put("meetingcomment", commentVO.get(i).getCommentContent()); //글내용
	                hm.put("commentDate", commentVO.get(i).getCommentDate());//작성일
	                hm.put("meetingcontentCode", commentVO.get(i).getMeetingcontentCode());//게시글번호
	                hm.put("writerNickname",commentVO.get(i).getWriterNickname());
	                
	                hmlist.add(hm);
	            }
	            
	        }
	        
	            
	        return hmlist;
	        
	    }
	 
	 
	 @RequestMapping("/seePhoto.do")
		@ResponseBody
		public List<Clubcontent> selectlocalList(@RequestBody Map contentCode){
		 System.out.println("ajax안");
		 int seephotoCode = Integer.parseInt((String)contentCode.get("contentCode"));
		 System.out.println("ajax에서 받아온 contentCode값"+seephotoCode);
			
		 List<Clubcontent> seephotoList = clubService.selectseephotoList(seephotoCode);
		
		 logger.info("seephotoList={}",seephotoList);
			
			System.out.println("^^^^^**="+seephotoList);
			
			return seephotoList;
		}
	
}
