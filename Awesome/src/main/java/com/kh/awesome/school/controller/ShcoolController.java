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
		
		List<Map<String,String>> schoolList = schoolService.schoolList(cPage, numPerPage, list);
		
		int totalContent = schoolService.totalContent(list);
	
		mav.addObject("MyList", MyList);
		mav.addObject("schoolList", schoolList);
		mav.addObject("totalContent", totalContent);
		mav.addObject("cPage", cPage);
		mav.addObject("numPerPage", numPerPage);
		mav.addObject("memberCode", memberCode);
		
		mav.setViewName("/school/schoolList");
		
		return mav;
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
		if(!primary.equals("해당 학교가 존재하지 않습니다.")) {
			if(!primary.equals("")) {
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
		
		mav.setViewName("/school/findPeople");
		
		return mav;
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
