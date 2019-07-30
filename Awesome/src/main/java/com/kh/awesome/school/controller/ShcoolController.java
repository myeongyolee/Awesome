package com.kh.awesome.school.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kh.awesome.club.model.vo.Clubcontent;
import com.kh.awesome.club.model.vo.Clubphoto;
import com.kh.awesome.school.model.service.SchoolService;
import com.kh.awesome.school.model.vo.SchoolClub;

@Controller
@RequestMapping("/school")
public class ShcoolController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private SchoolService schoolService;
	
	@RequestMapping("/schoolList")
	public ModelAndView schoolList(@RequestParam(value="cPage", required=false, defaultValue="1") int cPage,
			                       @RequestParam("memberCode") String memberCode) {
		logger.info("schoolList들어옴");
		ModelAndView mav = new ModelAndView();
		//자기자신 학교이름 + 학교ID가져오기
		List<Map<String,String>> MyList = schoolService.MyList(memberCode);

		List list = new ArrayList<String>();
		//자기자신 학교 아이디 가지고 오기
		list = schoolService.MySchoolIdCheck(memberCode); // list:[B000003848, B000012508] 이런식으로 넘어옴
		
		int numPerPage = 5;
		List<Map<String,String>> schoolList = new ArrayList<>();
		
		if(list != null) {
			logger.info("리스트 널 아님");
			schoolList = schoolService.schoolList(cPage, numPerPage, list);
			int totalContent = schoolService.totalContent(list);
		
			mav.addObject("MyList", MyList);
			mav.addObject("schoolList", schoolList);
			mav.addObject("totalContent", totalContent);
			mav.addObject("cPage", cPage);
			mav.addObject("numPerPage", numPerPage);
			mav.addObject("memberCode", memberCode);
			mav.setViewName("school/schoolList");
			return mav;
		}
		else {
			logger.info("리스트 널");
			logger.info("schoolList:"+schoolList);
			mav.addObject("schoolList", schoolList);
			mav.setViewName("school/schoolList");
			return mav;
		}
	}
	
	@RequestMapping("/checkSchool")
	@ResponseBody
	public int checkSchool(@RequestParam("memberCode") String memberCode) {
		logger.info("checkSchool들어옴");
		
		int result = schoolService.checkSchool(memberCode);
		
		return result;
	}
	
	@RequestMapping("/enrollSchool")
	public ModelAndView enrollSchool(@RequestParam("primary") String primary, @RequestParam("primary_id") String primary_id, @RequestParam("primary_address") String primary_address,
			                 @RequestParam("middle") String middle, @RequestParam("middle_id") String middle_id, @RequestParam("middle_address") String middle_address,
			                 @RequestParam("high") String high, @RequestParam("high_id") String high_id, @RequestParam("high_address") String high_address,
			                 @RequestParam("memberLoggedIn") String memberCode) {
		logger.info("enrollSchool@Controller 확인");
		ModelAndView mav = new ModelAndView();
		
		//로그인된 사용자가 입력한 학교정보 DB에 저장하기
		if(!primary.equals("해당 학교가 존재하지 않습니다.")) {			if(!primary.equals("")) {
				Map<String,String> param = new HashMap<String, String>();
				param.put("memberCode", memberCode);
				param.put("school_name", primary);
				param.put("school_code", primary_id);
				param.put("school_address", primary_address);
				
				logger.info("초등param확인:"+param);
				
				int result = schoolService.insertSchool(param);
				logger.info("초등입력확인:"+result);
			}
		}
		
		if(!middle.equals("해당 학교가 존재하지 않습니다.")) {
			if(!middle.equals("")) {
				Map<String,String> param = new HashMap<String, String>();
				param.put("memberCode", memberCode);
				param.put("school_name", middle);
				param.put("school_code", middle_id);
				param.put("school_address", middle_address);
				
				logger.info("중등param확인:"+param);
				
				int result = schoolService.insertSchool(param);
				logger.info("중등입력확인:"+result);
			}
		}
		
		if(!high.equals("해당 학교가 존재하지 않습니다.")) {
			if(!high.equals("")) {
				Map<String,String> param = new HashMap<String, String>();
				param.put("memberCode", memberCode);
				param.put("school_name", high);
				param.put("school_code", high_id);
				param.put("school_address", high_address);

				logger.info("고등param확인:"+param);
				
				int result = schoolService.insertSchool(param);
				logger.info("고등입력확인:"+result);
			}
		}
		
		mav.addObject("msg", "확인");
		mav.addObject("loc", "/school/schoolList?memberCode="+memberCode);
		mav.setViewName("common/msg");
		
		return mav;
	}
	
	@RequestMapping("/makeSchool")
	public String makeSchool() {
		logger.info("makeSchool들어옴");
		
		return "school/makeSchool";
	}
	
	@RequestMapping("/schoolView")
	public ModelAndView schoolView(@RequestParam("clubCode") int clubCode, @RequestParam(value="cPage", required=false, defaultValue="1") int cPage) {
		logger.info("schoolView 들어옴");
		ModelAndView mav = new ModelAndView(); 
		
		List<Map<String,String>> schoolInfo = schoolService.selectSchoolOne(clubCode);//해당클럽에 대한 정보 전부 가져오기
		logger.info("해당클럽정보:"+schoolInfo);
		
		Map<String,Object> param = new HashMap<>();
		param.put("clubCode", clubCode);
		param.put("joinCheck", "Y");
		int totalMemberCount = schoolService.totalMemberCount(param);//클럽 회원수
		logger.info("해당클럽회원수정보:"+totalMemberCount);
		
		List<Map<String,String>> memberInfo = schoolService.selectClubMember(param);//해당클럽에 대한 회원정보 가져오기(해당 정보로 클럽장,매니저,일반회원을 view페이지에서 구별할 수 있음) 
		logger.info("해당클럽회원정보:"+memberInfo);

		//--------------------------------------------------------------------------------//
		int numPerPage = 5;
		List<Map<String,String>> SchoolContentlist = schoolService.schoolView(clubCode, cPage, numPerPage); //해당 클럽에 존재하는 게시글 가져오기
		int totalContent = schoolService.totalClubContent(clubCode); // 해당클럽에 존재하는 게시글의 총 수
		
		
		List AllContentCode = schoolService.AllContentCode(clubCode);//해당 클럽에 존재하는 게시글 번호 전부 가져오기
		logger.info("AllContentCode 확인 :" + AllContentCode);
		
		List<Map<String,String>> SchoolPhoto = new ArrayList<>();
		
		if(AllContentCode.size() != 0) {
			logger.info("if문 들어옴");
			SchoolPhoto = schoolService.schoolPhoto(AllContentCode); //해당 게시글코드에 해당하는 사진을 가져오기
		}
		else {
			logger.info("else문");
		}

		//--------------------------------------------------------------------------------//

		Map<String,String> Calender = schoolService.selectOneCalender(clubCode);//모임 일정 가져오는 일정 (매치매니저 테이블의 인터레스링코드(클럽코드)를 이용해서 해당 클럽의 모임을 가져온다)

		//--------------------------------------------------------------------------------//
		
		mav.addObject("schoolInfo", schoolInfo);
		mav.addObject("totalMemberCount", totalMemberCount);
		mav.addObject("memberInfo", memberInfo);
		
		mav.addObject("clubCode", clubCode);
		mav.addObject("SchoolContentlist", SchoolContentlist);
		mav.addObject("totalContent", totalContent);
		mav.addObject("cPage", cPage);
		mav.addObject("numPerPage", numPerPage);
		mav.addObject("SchoolPhoto", SchoolPhoto);
		mav.addObject("Calender", Calender);
	
		mav.setViewName("school/schoolView");

		return mav;
	}
	
	@RequestMapping("/schoolContentMake")
	public ModelAndView schoolContentMake(@RequestParam("clubCode") int clubCode) {
		ModelAndView mav = new ModelAndView();
		
		List<Map<String,String>> schoolInfo = schoolService.selectSchoolOne(clubCode);
		
		mav.addObject("schoolInfo", schoolInfo);
		mav.setViewName("school/schoolContentMake");
		return mav;
	}
	
	@RequestMapping("/schoolContentMakeEnd")
	@ResponseBody
	public int schoolContentMakeEnd(@RequestParam("clubCode") int clubCode, @RequestParam("memberCode") String memberCode, 
			                         @RequestParam("contentTitle") String contentTitle, @RequestParam("content") String content,
			                         @RequestParam("writeLevel") int writeLevel){
		logger.info("schoolContentMakeEnd 들어옴");

		Map<String,Object> param = new HashMap<String,Object>();
		param.put("clubCode", clubCode);
		param.put("memberCode", memberCode);
		param.put("contentTitle", contentTitle);
		param.put("content", content);
		param.put("writeLevel", writeLevel);
		
		int result = schoolService.insertSchoolContent(param);
		
		return result;
	}
	
	@RequestMapping("/schoolContentNotice")
	public ModelAndView schoolContentNotice(@RequestParam("clubCode") int clubCode) {
		ModelAndView mav = new ModelAndView();
		
		List<Map<String,String>> schoolInfo = schoolService.selectSchoolOne(clubCode);
		
		mav.addObject("schoolInfo", schoolInfo);
		mav.setViewName("school/schoolContentNotice");
		return mav;
	}
	
	@RequestMapping("/schoolNoticeEnd")
	public ModelAndView schoolNoticeEnd(@RequestParam("clubCode") int clubCode, @RequestParam("memberCode") String memberCode, 
            					@RequestParam("contentTitle") String contentTitle, @RequestParam("content") String content,
            					@RequestParam("writeLevel") int writeLevel) {
		logger.info("schoolNoticeEnd들어옴");
		ModelAndView mav = new ModelAndView();

		Map<String,Object> param = new HashMap<String,Object>();
		param.put("clubCode", clubCode);
		param.put("memberCode", memberCode);
		param.put("contentTitle", contentTitle);
		param.put("content", content);
		param.put("writeLevel", writeLevel);
		
		int result = schoolService.insertSchoolContent(param);
		
		String msg = result>0?"게시글등록성공":"게시글등록실패";
		String loc = "/school/schoolView?clubCode="+clubCode;
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		
		return mav;
	}
	
	@RequestMapping("/schoolContentImg")
	public ModelAndView schoolContentImg(@RequestParam("clubCode") int clubCode) {
		ModelAndView mav = new ModelAndView();
		
		List<Map<String,String>> schoolInfo = schoolService.selectSchoolOne(clubCode);
		
		mav.addObject("schoolInfo", schoolInfo);
		mav.setViewName("school/schoolContentImg");
		return mav;
	}
	//이미지업로드 관련 처리 할 공간
	@RequestMapping("/schoolContentImgEnd")
	public String schoolContentImgEnd(MultipartFile[] upFile, HttpServletRequest request, @RequestParam("clubCode") int clubCode,
			                        @RequestParam("memberCode") String memberCode, @RequestParam("writeLevel") int writeLevel) {
		logger.info("schoolContentImgEnd 들어옴");
		
		Clubcontent clubcontent = new Clubcontent();
		clubcontent.setClubCode(Integer.parseInt(request.getParameter("clubCode")));
		clubcontent.setMemberCode(Integer.parseInt(request.getParameter("memberCode")));
		clubcontent.setContentTitle("사진");
		clubcontent.setContent("사진게시판");
		clubcontent.setWriteLevel(Integer.parseInt(request.getParameter("writeLevel")));
		
		int result = schoolService.insertSchoolImg(clubcontent);
		logger.info("게시글코드는?"+clubcontent.getClubcontentCode());
		int num = clubcontent.getClubcontentCode();
		
		String picinfo1 = request.getParameter("content1");
		String picinfo2 = request.getParameter("content2");
		String picinfo3 = request.getParameter("content3");
		logger.info(picinfo1 + "," + picinfo2 + "," + picinfo3);
		
		int cnt = 1;
		try {
		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/school");
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
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				logger.info(originalFileName);
				Clubphoto clubphoto = new Clubphoto();
				clubphoto.setClubcontentCode(num);
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
		
		logger.info("clubphotoList={}",clubphotoList);
		result = schoolService.insertSchoolImg2(clubphotoList);
		
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		String msg = result>0?"사진 등록 성공":"사진 등록 오류";
		String loc = "/school/schoolView?clubCode="+clubCode;
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		return "/common/msg";
	}
	
	
	
	@RequestMapping("/checkClubSchool")
	@ResponseBody
	public String checkClubSchool(@RequestParam("clubCode") int clubCode, @RequestParam("memberCode") String memberCode) {
		logger.info("checkClubSchool 들어옴");
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("clubCode", clubCode);
		param.put("memberCode", memberCode);
		
		String result = schoolService.checkClubSchool(param);//club_member 테이블에서 해당회원의 가입여부 확인
		logger.info("모임가입여부 확인 결과:"+result); // 0 또는 N 또는 Y
		
		return result;
	}
	
	@RequestMapping("/enrollSchoolClub")
	public ModelAndView enrollSchoolClub(@RequestParam("clubCode") int clubCode, @RequestParam("memberCode") String memberCode) {
		logger.info("enrollSchoolClub 들어옴");
		ModelAndView mav = new ModelAndView();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("clubCode", clubCode);
		param.put("memberCode", memberCode);
		param.put("clubJoinCheck", "N");
		param.put("grade", 0);
		
		int result = schoolService.enrollSchoolClub(param);
		
		String msg = result>0?"가입신청성공":"가입신청실패";
		String loc = "/school/schoolList?memberCode="+memberCode;
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		
		return mav;
	}
	
	@RequestMapping("/waitingEnroll")
	public ModelAndView waitingEnroll(@RequestParam("clubCode") int clubCode) {
		logger.info("waitingEnroll 들어옴");
		ModelAndView mav = new ModelAndView();
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("clubCode", clubCode);
		param.put("clubJoinCheck", "N");
		
		List<Map<String,Object>> waitingList = schoolService.waitingList(param);
		logger.info("가입대기명단 확인:" + waitingList);
		
		mav.addObject("waitingList", waitingList);
		mav.addObject("clubCode", clubCode);
		mav.setViewName("school/clubwaitingList");
		
		return mav;
	}
	
	@RequestMapping("/acceptMember")
	public ModelAndView acceptMember(@RequestParam("clubCode") int clubCode, @RequestParam("memberCode") String memberCode) {
		logger.info("acceptMember 들어옴");
		ModelAndView mav = new ModelAndView();
		String[] str = memberCode.split(",");
		List list = new ArrayList<>();
		for(int i=0; i<str.length; i++) {
			list.add(str[i]);
		}
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("clubCode", clubCode);
		param.put("memberCode", list);
		param.put("accpet", "Y");
		
		int result = schoolService.acceptMember(param);
		
		mav.addObject("msg", result>0?"처리성공":"처리실패");
		mav.addObject("loc", "/school/waitingEnroll?clubCode="+clubCode);
		mav.setViewName("common/msg");
	
		return mav;
	}
	
	@RequestMapping("/checkClubMember")
	public ModelAndView checkClubMember(@RequestParam("clubCode") int clubCode) {
		logger.info("checkClubMember 들어옴");
		ModelAndView mav = new ModelAndView();
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("clubCode", clubCode);
		param.put("clubJoinCheck", "Y");
		
		List<Map<String,Object>> clubMemberList = schoolService.checkClubMember(param);
		
		mav.addObject("clubCode", clubCode);
		mav.addObject("clubMemberList", clubMemberList);
		mav.setViewName("school/checkClubMember");
		
		return mav;
	}
	
	@RequestMapping("/movePage")
	public ModelAndView movePage(@RequestParam("clubCode") int clubCode, @RequestParam("memberCode") String memberCode,
                                 @RequestParam("memberGrade") String memberGrade, @RequestParam("memberName") String memberName) {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("clubCode", clubCode);
		mav.addObject("memberCode", memberCode);
		mav.addObject("memberGrade", memberGrade);
		mav.addObject("memberName", memberName);
		mav.setViewName("/school/updateClubMember");
		return mav;
	}
	
	@RequestMapping("/updateGrade")
	@ResponseBody
	public List<Map<String,Object>> updateGrade(@RequestParam("clubCode") int clubCode, @RequestParam("memberCode") String memberCode,
			                @RequestParam("memberGrade") String memberGrade) {
		logger.info("updateGrade 들어옴");
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("clubCode", clubCode);
		param.put("memberCode", memberCode);
		param.put("memberGrade", memberGrade);

		int result = schoolService.updateGrade(param);
		
		List<Map<String,Object>> clubMemberList = new ArrayList<>();
		if(result>0) {
			logger.info("if문들어옴");
			Map<String,Object> param2 = new HashMap<String,Object>();
			param2.put("clubCode", clubCode);
			param2.put("clubJoinCheck", "Y");
			
			clubMemberList = schoolService.checkClubMember(param2);
		}
		logger.info("clubMemberList="+clubMemberList);
		return clubMemberList;
	}
	
	@RequestMapping("/searchMySchoolClub")
	public ModelAndView searchMySchoolClub(@RequestParam("memberCode") String memberCode) {
		logger.info("searchMySchool 들어옴");
		ModelAndView mav = new ModelAndView();
		
		Map<String,String> param = new HashMap<String,String>();
		param.put("memberCode", memberCode);
		param.put("clubJoinCheck", "Y");
		
		List<Map<String,String>> mySchoolClubList = schoolService.searchMySchoolClub(param);
		logger.info("mySchoolClubList 확인:"+mySchoolClubList);
		
		mav.addObject("mySchoolClubList", mySchoolClubList);
		mav.setViewName("school/searchMySchoolClub");
		return mav;
	}
	
	@RequestMapping("/schoolContentView")
	public ModelAndView schoolContentView(@RequestParam("clubCode") int clubCode, @RequestParam("clubContentCode") int clubContentCode) {
		logger.info("schoolContentView 들어옴");
		ModelAndView mav = new ModelAndView();
		
		Map<String, Integer> param = new HashMap<String,Integer>();
		param.put("clubCode", clubCode);
		param.put("clubContentCode", clubContentCode);
		
		Map<String,String> detailContent = schoolService.schoolContentView(param);
		logger.info("해당 게시글 정보 확인:"+detailContent);
		
		mav.addObject("detailContent", detailContent);
		mav.setViewName("school/schoolContentView");
		
		return mav;
	}
	
	@RequestMapping("/insertSchoolComent")
	@ResponseBody
	public int insertSchoolComent(@RequestParam("commentContent") String commentContent, @RequestParam("meetingcontentCode") String meetingcontentCode,
			                       @RequestParam("commentWriter") String commentWriter){
		logger.info("insertSchoolComent 들어옴");
		Map<String,String> param = new HashMap<String,String>();
		param.put("commentContent", commentContent);
		param.put("meetingcontentCode", meetingcontentCode);
		param.put("commentWriter", commentWriter);
		
		int result = schoolService.insertSchoolComment(param);
		
		return result; 
	}
	
	@RequestMapping("/schoolCommentList")
	@ResponseBody
	public List<HashMap> schoolCommentList(@RequestParam("meetingcontentCode") int meetingcontentCode) {
		logger.info("schoolCommentList 들어옴");
		logger.info("meetingcontentCode:"+meetingcontentCode);
		List<Map<String,String>> commentList = schoolService.schoolCommentList(meetingcontentCode);
		logger.info("댓글리스트 확인:"+commentList);
		
		List<HashMap> result = new ArrayList<HashMap>();
		for(int i=0; i<commentList.size(); i++) {
			 HashMap map = new HashMap();
			 map.put("comment_content", commentList.get(i).get("COMMENT_CONTENT"));
			 map.put("nickname", commentList.get(i).get("NICKNAME"));
			 map.put("comment_date", commentList.get(i).get("COMMENT_DATE"));
			 result.add(map);
		}
		
		return result;
	}
	
	@RequestMapping("/updateSchoolContent")
	public ModelAndView updateSchoolContent(@RequestParam("clubContentCode") int clubContentCode) {
		logger.info("updateSchoolContent 들어옴");
		ModelAndView mav = new ModelAndView();
		
		Map<String,String> Content = schoolService.updateSchoolContent(clubContentCode);//해당 게시글에 대한 정보 가져오기
		logger.info("수정할 게시글 정보 확인:"+Content);
		
		mav.addObject("Content", Content);
		mav.setViewName("school/updateSchoolContent");
		
		return mav;
	}
	
	@RequestMapping("/updateContentEnd")
	@ResponseBody
	public int updateContentEnd(@RequestParam("clubContentCode") int clubContentCode, @RequestParam("contentTitle") String contentTitle,
			                     @RequestParam("content") String content) {
		logger.info("updateContentEnd 들어옴");
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("clubContentCode", clubContentCode);
		param.put("contentTitle", contentTitle);
		param.put("content", content);
		
		int result = schoolService.updateContentEnd(param);
		
		return result;
	}
	
	@RequestMapping("/deleteSchoolContent")
	public ModelAndView deleteSchoolContent(@RequestParam("clubContentCode") int clubContentCode, @RequestParam("clubCode") int clubCode) {
		logger.info("deleteSchoolContent 들어옴");
		ModelAndView mav = new ModelAndView();
		
		logger.info("지울 게시글 번호 확인 :" + clubContentCode);
		
		int result = schoolService.deleteSchoolContent(clubContentCode); // on delete cascade 설정으로 연결된거 한번에 다 지우기
		
		if(result>0) {
			mav.addObject("msg", "삭제 성공");
			mav.addObject("loc", "/school/schoolView?clubCode="+clubCode);
		}
		else {
			mav.addObject("msg", "삭제 실패");
			mav.addObject("loc", "/school/schoolView?clubCode="+clubCode);
		}
		
		mav.setViewName("common/msg");
		return mav;
	}
	
	@RequestMapping("/clubCalendar")
	public ModelAndView clubCalendar(@RequestParam("clubCode") int clubCode) {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("clubCode", clubCode);
		mav.setViewName("school/clubCalendar");
		return mav;
	}
	
	@RequestMapping("/deleteCalender")
	public ModelAndView deleteCalender(@RequestParam("matchNo") int matchNo, @RequestParam("clubCode") int clubCode ) {
		logger.info("deleteCalender 들어옴");
		ModelAndView mav = new ModelAndView();
		
		int result = schoolService.deleteCalender(matchNo);
		
		String msg = result>0?"일정삭제성공":"일정삭제실패";
		String loc = "/school/schoolView?clubCode="+clubCode;
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		
		return mav;
	}
	
	@RequestMapping("/logoutClub")
	public ModelAndView logoutClub(@RequestParam("clubCode") int clubCode, @RequestParam("memberCode") int memberCode) {
		logger.info("logoutClub 들어옴");
		ModelAndView mav = new ModelAndView();
		
		Map<String, Integer> param = new HashMap<String,Integer>();
		param.put("clubCode", clubCode);
		param.put("memberCode", memberCode);
		
		int result = schoolService.logoutClub(param);// club_member 테이블에서 삭제
		
		String msg = result>0?"탈퇴성공":"탈퇴실패";
		String loc = "/school/schoolList?memberCode="+memberCode;
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		mav.setViewName("common/msg");
		
		return mav;
	}
	
	@RequestMapping(value = "/imgupload", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> imgupload(MultipartHttpServletRequest request) {
		
		Map<String,Object> param = new HashMap<String,Object>();
		
		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/school");
		Iterator<String> itr = request.getFileNames(); 
		if(itr.hasNext()) { 
			MultipartFile mpf = request.getFile(itr.next()); 
			try {
				String originalFileName = mpf.getOriginalFilename();
				
				String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
				int rndNum = (int)(Math.random()*1000);
				
				String renamedFileName = sdf.format(new Date())+"_"+rndNum+"."+ext;
				
				//서버지정위치에 파일보관
				File file = new File(saveDirectory+"/"+renamedFileName);
				mpf.transferTo(file);
				
				param.put("originalFileName", originalFileName);
				param.put("renamedFileName", renamedFileName);
				param.put("result", true);
				
				} catch (IOException e) { 
					System.out.println(e.getMessage()); e.printStackTrace(); 
				}  
			}
			return param;
		}
	
	@RequestMapping("/makeSchoolEnd")
	@ResponseBody
	public Object makeSchoolEnd(@RequestParam("memberCode") String memberCode, @RequestParam("schoolClubTitle") String schoolClubTitle,
			                  @RequestParam("schoolName") String schoolName, @RequestParam("schoolId") String schoolId,
			                  @RequestParam("schoolAddress") String schoolAddress, @RequestParam("club_info") String club_info,
			                  @RequestParam("club_info_long") String club_info_long, @RequestParam("originalFileName") String originalFileName,
			                  @RequestParam("renamedFileName") String renamedFileName){
		
		logger.info("makeSchoolEnd들어옴");
		SchoolClub sc = new SchoolClub();
		sc.setMemberCode(Integer.parseInt(memberCode));
		sc.setSchoolClubTitle(schoolClubTitle);
		sc.setSchoolName(schoolName);
		sc.setSchoolId(schoolId);
		sc.setSchoolAddress(schoolAddress);
		sc.setClub_info(club_info);
		sc.setClub_info_long(club_info_long);
		sc.setOriginalFileName(originalFileName);
		sc.setRenamedFileName(renamedFileName);
				
		int result = schoolService.makeSchoolEnd(sc);
		
		logger.info("result="+sc.getSchoolClubCode());
		Map<String,Object> param2 = new HashMap<String,Object>();
		param2.put("clubJoinCheck", "Y");
		param2.put("clubMemGrade", 2);
		param2.put("clubCode", sc.getSchoolClubCode());
		param2.put("memberCode", memberCode);
		logger.info("param2:"+param2);
		int result2 = schoolService.insertClubZzang(param2);
		
		return result2;
	}
	
	@RequestMapping("/findPeople")
	@ResponseBody
	public Map<String, Object> findPeople(@RequestParam("schoolCode") String schoolCode, @RequestParam("memberCode") String memberCode,
								   @RequestParam(value="cPage", required=false, defaultValue="1") int cPage) {
		logger.info("findPeople들어옴");
		Map<String, Object> result = new HashMap<String,Object>();
		
		Map<String,String> param = new HashMap<String,String>();
		param.put("memberCode", memberCode);
		param.put("schoolCode", schoolCode);
		param.put("open", "Y");
		logger.info("param확인:"+param);
		
		int numPerPage = 1;
		
		List<Map<String,String>> friendList = schoolService.findPeople(cPage, numPerPage, param); // 해당학교ID에 해당하는 회원정보 가져오기
		logger.info("가입되어있는 내 친구="+friendList);
		int totalContent = schoolService.totalCountfindPeople(param);
		logger.info("총검색된 수:"+totalContent);
		
		result.put("totalContent", totalContent);
		result.put("friendList", friendList);
		result.put("cPage", cPage);
		result.put("numPerPage", numPerPage);
		result.put("memberCode", memberCode);
		result.put("schoolCode", schoolCode);
		
		return result;
	}
	
	
	
	
	
	
	
	
	@RequestMapping(value="/test", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String test(@RequestParam("schoolName1") String ch1) throws Exception {
		logger.info("test@Controller확인");
		logger.info(ch1);
		
		String json;
		String address = "http://api.data.go.kr/openapi/elesch-mskul-lc-std"
				+ "?ServiceKey=ZowdfvbpqIpqLdA%2FyaP3E7DNHtK%2BiGwgRcP9VE1MzDn%2FdNp6NicpBSKajL2pQt2e3B4wXC5XNxVBsHvveGBLVw%3D%3D"
				+ "&pageNo=1"
				+ "&type=json"
				+ "&schoolNm="+ch1;
		BufferedReader br;
		URL url;
		HttpURLConnection conn;
		String protocol = "GET";
		
		url = new URL(address);
		conn = (HttpURLConnection)url.openConnection();
		conn.setRequestMethod(protocol);
		br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		
		json = br.readLine();

        return json;
	}
	
}
