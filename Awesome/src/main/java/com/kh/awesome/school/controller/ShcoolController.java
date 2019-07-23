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
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.awesome.club.model.vo.Clubcontent;
import com.kh.awesome.club.model.vo.Clubphoto;
import com.kh.awesome.school.model.service.SchoolService;

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
	
	@RequestMapping("/makeSchoolEnd")
	public ModelAndView makeSchoolEnd(@RequestParam("memberCode") String memberCode, @RequestParam("schoolClubTitle") String schoolClubTitle,
			                  @RequestParam("schoolName") String schoolName, @RequestParam("schoolId") String schoolId,
			                  @RequestParam("schoolAddress") String schoolAddress, @RequestParam("club_info") String club_info,
			                  @RequestParam("club_info_long") String club_info_long, @RequestParam("upFile") MultipartFile upFile, HttpServletRequest request) {
		
		logger.info("makeSchoolEnd들어옴");
		ModelAndView mav = new ModelAndView();
		
		Map<String,String> param = new HashMap<String,String>();
		param.put("memberCode", memberCode);
		param.put("schoolClubTitle", schoolClubTitle);
		param.put("schoolName", schoolName);
		param.put("schoolId", schoolId);
		param.put("schoolAddress", schoolAddress);
		param.put("club_info", club_info);
		param.put("club_info_long", club_info_long);
		
		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/school");
		
			if(!upFile.isEmpty()) {
				String originalFileName = upFile.getOriginalFilename();
				
				String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
				int rndNum = (int)(Math.random()*1000);
				
				String renamedFileName = sdf.format(new Date())+"_"+rndNum+"."+ext;
				
				//서버지정위치에 파일보관
				try {
					File file = new File(saveDirectory+"/"+renamedFileName);
					upFile.transferTo(file);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				param.put("originalFileName", originalFileName);
				param.put("renamedFileName", renamedFileName);
			}
		
		logger.info("파라미터 확인="+param);
		int result = schoolService.makeSchoolEnd(param);
		
		String msg = result>0?"동창모임 만들기 성공":"동창모임 만들기 실패";
		String loc = "/school/schoolList";
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		
		mav.setViewName("common/msg");
		
		return mav;
	}
	
	
	@RequestMapping("/findPeople")
	public ModelAndView findPeople(@RequestParam("schoolCode") String schoolCode, @RequestParam("memberCode") String memberCode,
								   @RequestParam(value="cPage", required=false, defaultValue="1") int cPage) {
		logger.info("findPeople들어옴");
		
		ModelAndView mav = new ModelAndView();
		
		Map<String,String> param = new HashMap<String,String>();
		param.put("memberCode", memberCode);
		param.put("schoolCode", schoolCode);
		param.put("open", "Y");
		
		int numPerPage = 5;
		
		List<Map<String,String>> friendList = schoolService.findPeople(cPage, numPerPage, param); // 해당학교ID에 해당하는 회원정보 가져오기
		logger.info("가입되어있는 내 친구="+friendList);
		int totalContent = schoolService.totalCountfindPeople(param);
		logger.info("총검색된 수:"+totalContent);
		
		mav.addObject("totalContent", totalContent);
		mav.addObject("friendList", friendList);
		mav.addObject("cPage", cPage);
		mav.addObject("numPerPage", numPerPage);
		mav.addObject("memberCode", memberCode);
		mav.addObject("schoolCode", schoolCode);
		
		mav.setViewName("school/findPeople");
		
		return mav;
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

		
		List list = new ArrayList<>();
		for(int i=0; i<SchoolContentlist.size(); i++) {
			list.add(SchoolContentlist.get(i).get("CLUB_CONTENT_CODE"));
		}		
		List<Map<String,String>> SchoolPhoto = schoolService.schoolPhoto(list);//해당 게시글코드에 해당하는 사진을 가져오기
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
	public ModelAndView schoolContentMakeEnd(@RequestParam("clubCode") int clubCode, @RequestParam("memberCode") String memberCode, 
			                         @RequestParam("contentTitle") String contentTitle, @RequestParam("content") String content,
			                         @RequestParam("writeLevel") int writeLevel){
		logger.info("schoolContentMakeEnd 들어옴");
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
