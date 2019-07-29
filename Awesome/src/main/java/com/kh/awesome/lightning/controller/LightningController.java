package com.kh.awesome.lightning.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.awesome.lightning.model.service.LightningService;
import com.kh.awesome.matchManager.model.vo.MatchManager;
import com.kh.awesome.member.model.vo.Member;

@Controller
@RequestMapping("/lightning")
public class LightningController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private LightningService lightningService;
	
	@RequestMapping("/lightningList.do")
	public void selectlightningList(HttpServletRequest request) {
		//도시목록 가져오기
		List<String> cityList = lightningService.selectCityList();
		//분류목록 가져오기
		List<String> interestingList = lightningService.selectInterestingList();
		
		logger.info("cityList={}",cityList);
		logger.info("interestingList={}",interestingList);
		
		request.setAttribute("cityList", cityList);
		request.setAttribute("interestingList", interestingList);
	}
	
	@RequestMapping("localList.do")
	@ResponseBody
	public List<Map<String, Object>> selectlocalList(@RequestBody Map cityMap){
		int city = Integer.parseInt((String)cityMap.get("city"));
		List<Map<String, Object>> localList = lightningService.selectLocalList(city);
		logger.info("localList={}",localList);
		
		return localList;
	}
	
	@RequestMapping("/lightningListPage.do")
	@ResponseBody
	public List<Map<String, Object>> lightningListPage(@RequestBody Map requestMap){
		//RequestBody 파라미터 핸들링
		logger.info("requestMap={}", requestMap);
		int cPage = Integer.parseInt((String)requestMap.get("cPage"));
		String title = "";
		String city = "";
		String local = "";
		String nickName = "";
		String interesting = "";
		
		if(requestMap.get("title")!=null) title = (String)requestMap.get("title");
		
		if(requestMap.get("city")!=null || !((String)requestMap.get("city")).equals("0")) 
			city = (String)requestMap.get("city");
		
		if(requestMap.get("local")!=null || !((String)requestMap.get("local")).equals("0")) 
			local = (String)requestMap.get("local");
		
		if(requestMap.get("memberId")!=null) nickName = (String)requestMap.get("nickName");
		
		if(requestMap.get("interesting")!=null || !((String)requestMap.get("interesting")).equals("0")) 
			interesting = (String)requestMap.get("interesting");
		
		String matchingType = "L";
		Map<String, String> search = new HashMap();
		search.put("title", title);
		search.put("city", city);
		search.put("local", local);
		search.put("nickName", nickName);
		search.put("interesting", interesting);
		search.put("matchingType", matchingType);
		//파라미터 핸들링 종료
		
		int numPerPage = 5;
		List<Map<String, Object>> lightningList = lightningService.selectLightningList(search, cPage, numPerPage);
		logger.info("lightningList={}", lightningList);
		logger.info("lightningList.size="+lightningList.size());
		
		Map<String,List<String>> param = new HashMap();
		List<String> matchNo = new ArrayList();
		for(Map<String, Object> map : lightningList) {
			String no = String.valueOf(map.get("matchNo"));
			matchNo.add(no);
		}
		param.put("matchNo", matchNo);
		
		List<Map<String, Object>> joinMemberList = lightningService.selectJoinMemberList(param);
		logger.info("joinMemberList={}",joinMemberList);
		
		Map<String, String> joinMemberMap = new HashMap();
		List<String> key = new ArrayList();
		
		for(Map<String, Object> map : joinMemberList) {
			String k = String.valueOf(map.get("matchNo"));
			if(joinMemberMap.isEmpty() || !joinMemberMap.containsKey(k)) {
				joinMemberMap.put(k, String.valueOf(map.get("nickName")));
				key.add(k);
			}else if(joinMemberMap.containsKey(k)) {
				String value = joinMemberMap.get(k);
				value += ", "+String.valueOf(map.get("nickName"));
				joinMemberMap.put(k, value);
			}
		}
		
//		logger.info("joinMemberMap={}",joinMemberMap);
//		logger.info("key="+key);
		
		for(String k : key) {
			for(Map<String,Object> map : lightningList) {
				if(String.valueOf(map.get("matchNo")).equals(k)) {
					map.put("joinMemberNickName", joinMemberMap.get(k));
				}
//				logger.info("map={}",map);
			}
		}
		
		return lightningList;
	}
	
	@RequestMapping("/lightningWrite.do")
	public void lightningWrite(HttpServletRequest request) {
		//도시목록 가져오기
		List<String> cityList = lightningService.selectCityList();
		//분류목록 가져오기
		List<String> interestingList = lightningService.selectInterestingList();
		
		logger.info("cityList={}",cityList);
		logger.info("interestingList={}",interestingList);
		
		request.setAttribute("cityList", cityList);
		request.setAttribute("interestingList", interestingList);
	}
	
	@RequestMapping("/lightningWriteEnd.do")
	public String insertLightning(MatchManager matchManager, HttpSession session, 
								@RequestParam("uploadProfile") MultipartFile uploadProfile, HttpServletRequest request) throws ParseException {
		//세션에서 memberCode가져오기
		Member member = (Member)session.getAttribute("memberLoggedIn");
		matchManager.setMemberCode(member.getMemberCode());
		
		logger.info("uploadProfile="+uploadProfile);
//		file
		if(!uploadProfile.isEmpty()) {
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/match");
			String originalFileName = uploadProfile.getOriginalFilename();
			String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
			SimpleDateFormat fileSdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSSS");
			int rndNum = (int)(Math.random()*1000);
			String renamedFileName = fileSdf.format(new java.util.Date())+"_"+rndNum+"."+ext;
			//서버 지정위치에 파일 보관
			
			try {
				uploadProfile.transferTo(new File(saveDirectory+"/"+renamedFileName));
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			matchManager.setMatchOriginalImg(originalFileName);
			matchManager.setMatchRenamedImg(renamedFileName);
			
		}
		
		//form에서 가져온 일자와 시간을 합쳐서 sqlDate로 변경후 vo객체에 저장하기	
		String lightningEndDate = request.getParameter("lightningEndDate");
		String lightningEndTime = request.getParameter("lightningEndTime");
		logger.info("lightningEndDate={}, lightningEndTime={}", lightningEndDate, lightningEndTime);
		
		String matchEndDate = lightningEndDate+" "+lightningEndTime;
		
		Map<String, Object> map = new HashMap();
		map.put("matchManager", matchManager);
		map.put("matchEndDate" ,matchEndDate);
		
		logger.info("matchManager="+matchManager);
		int result = lightningService.insertLightning(map);
		logger.info("result="+result);
		
		String msg = result>0?"게시물 등록 성공":"게시물 등록 오류";
		String loc = "/lightning/lightningList.do";
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		return "/common/msg";
	}
	
	@RequestMapping(value="/map/findPosition", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String findPosition(@RequestParam("param") String position) throws Exception {
		
        String clientId = "l3bRNMshRGqHPXuqlMvs";//애플리케이션 클라이언트 아이디값";
        String clientSecret = "tFz7TI8MjF";//애플리케이션 클라이언트 시크릿값";
      
		String text = URLEncoder.encode(position, "UTF-8");
		String apiURL = "https://openapi.naver.com/v1/search/local.json?query=" + text; // json 결과
		// String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text;
		// // xml 결과
		URL url = new URL(apiURL);
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("X-Naver-Client-Id", clientId);
		con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
		int responseCode = con.getResponseCode();

		BufferedReader br;
		if (responseCode == 200) { // 정상 호출
			br = new BufferedReader(new InputStreamReader(con.getInputStream()));
		} else { // 에러 발생
			br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
		}

		String inputLine;
		StringBuffer response = new StringBuffer();
		while ((inputLine = br.readLine()) != null) {
			response.append(inputLine);
		}
		br.close();
		logger.info(response.toString());
		
		return response.toString();
	}
	
	//참여신청하기
	@RequestMapping("/matchJoin.do")
	@ResponseBody
	public boolean matchJoin(HttpSession session, @RequestParam int matchNo) {
		Member m = (Member)session.getAttribute("memberLoggedIn");
		int memberCode = m.getMemberCode();
		Map<String, Integer> map = new HashMap<>();
		map.put("matchNo", matchNo);
		map.put("memberCode", memberCode);
		
		logger.info("map={}", map);
		
		int result = lightningService.insertMatchJoin(map);
		
		if(result > 0) {
			return true;
		}else {
			return false;
		}
		
	}
	
	//나의 번개모임 리스트 페이지
	@RequestMapping("/lightningInfo.do")
	public void lightningInfo() {
		logger.info("나의 번개모임 정보 호출");
	}
	
	//나의 번개모임 리스트 호출
	@RequestMapping("/myLightningList.do")
	@ResponseBody
	public List<Map<String, Object>> myLightningList(HttpSession session, @RequestParam int cPage) {
//		int cPage = Integer.parseInt(cpage);
		int numPerPage = 5;
		Member member = (Member)session.getAttribute("memberLoggedIn");
		int memberCode = member.getMemberCode();
		logger.info("memberCode="+memberCode);
		//리스트 가져오기
		List<Map<String, Object>> lightningList = lightningService.selectMyLightningList(memberCode, numPerPage, cPage);
		logger.info("lightningList={}",lightningList);
		
		Map<String,List<String>> param = new HashMap();
		List<String> matchNo = new ArrayList();
		for(Map<String, Object> map : lightningList) {
			String no = String.valueOf(map.get("matchNo"));
			matchNo.add(no);
		}
		param.put("matchNo", matchNo);
		List<Map<String, Object>> joinMemberList = lightningService.selectMyMatchJoinMemberList(param);
		logger.info("joinMemberList={}",joinMemberList);
		
		Map<String, String> joinMemberMap = new HashMap();
		List<String> key = new ArrayList();
		
		for(Map<String, Object> map : joinMemberList) {
			String k = String.valueOf(map.get("matchNo"));
			if(joinMemberMap.isEmpty() || !joinMemberMap.containsKey(k)) {
				joinMemberMap.put(k, String.valueOf(map.get("nickName")));
				key.add(k);
			}else if(joinMemberMap.containsKey(k)) {
				String value = joinMemberMap.get(k);
				value += ", "+String.valueOf(map.get("nickName"));
				joinMemberMap.put(k, value);
			}
		}
//		logger.info("joinMemberMap={}",joinMemberMap);
//		logger.info("key="+key);
		
		for(String k : key) {
			for(Map<String,Object> map : lightningList) {
				if(String.valueOf(map.get("matchNo")).equals(k)) {
					map.put("joinMemberNickName", joinMemberMap.get(k));
				}
//				logger.info("map={}",map);
			}
		}
		
		key.clear();
		//미허가인 맴버리스트 가져오기
		List<Map<String, Object>> noPermitMemberList = lightningService.selectMyMatchNoPermitMemberList(param);
		Map<String, String> noPermitMemberMap = new HashMap();
		
		for(Map<String, Object> map : noPermitMemberList) {
			String k = String.valueOf(map.get("matchNo"));
			if(noPermitMemberMap.isEmpty() || !noPermitMemberMap.containsKey(k)) {
				noPermitMemberMap.put(k, String.valueOf(map.get("nickName")));
				key.add(k);
			}else if(noPermitMemberMap.containsKey(k)) {
				String value = noPermitMemberMap.get(k);
				value += ", "+String.valueOf(map.get("nickName"));
				noPermitMemberMap.put(k, value);
			}
		}
		
		for(String k : key) {
			for(Map<String,Object> map : lightningList) {
				if(String.valueOf(map.get("matchNo")).equals(k)) {
					map.put("noPermitMemberNickName", noPermitMemberMap.get(k));
				}
//				logger.info("map={}",map);
			}
		}
		logger.info("lightningList={}", lightningList);
		return lightningList;
	}
	
	//내가 참여한 번개모임 리스트 호출
	@RequestMapping("/myJoinLightningList.do")
	@ResponseBody
	public List<Map<String, Object>> myJoinLightningList(HttpSession session, @RequestParam int cPage) {
//		int cPage = Integer.parseInt(cpage);
		int numPerPage = 5;
		Member member = (Member)session.getAttribute("memberLoggedIn");
		int memberCode = member.getMemberCode();
		logger.info("memberCode="+memberCode);
		//참여한 모임코드리스트 가져오기
		List<String> matchCodeList = lightningService.selectJoinMatchCode(memberCode, numPerPage, cPage);
		logger.info("matchCodeList={}", matchCodeList);
		
		Map<String,List<String>> param = new HashMap();
		param.put("matchCodeList", matchCodeList);
		
		if(matchCodeList.isEmpty()) {
			
			List<Map<String, Object>> lightningList = new ArrayList<>();
			return lightningList;
			
		}else {
			//참여한 모임들 상세정보 가져오기
			List<Map<String, Object>> lightningList = lightningService.selectJoinLightningList(param);
			logger.info("lightningList={}",lightningList);
			
			return lightningList;			
		}
	}
	
	@RequestMapping("lightningDelete.do")
	public String lightningDelete(HttpServletRequest request ,@RequestParam int matchNo) {
		int result = lightningService.deleteLightning(matchNo);
		
		String msg = result>0?"게시물 삭제 성공":"게시물 삭제 오류";
		String loc = "/member/memberInfo.do";
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		return "/common/msg";
	}
	
	@RequestMapping("/lightningWriteUpdate.do")
	public void lightningWriteUpdate(HttpServletRequest request, @RequestParam int matchNo) {
		//번개모임정보 가져오기
		Map<String, Object> lightningMatch = lightningService.selectLightningMatch(matchNo);
		//도시목록 가져오기
		List<String> cityList = lightningService.selectCityList();
		//분류목록 가져오기
		List<String> interestingList = lightningService.selectInterestingList();
		
		String[] matchEndDate = String.valueOf(lightningMatch.get("matchEndDate")).split(" ");
		String lightningEndDate = matchEndDate[0];
		String lightningEndTime = matchEndDate[1];
		lightningMatch.put("lightningEndDate", lightningEndDate);
		lightningMatch.put("lightningEndTime", lightningEndTime);
		
		logger.info("cityList={}",cityList);
		logger.info("interestingList={}",interestingList);
		logger.info("lightningMatch={}",lightningMatch);
		
		logger.info("번개모임 수정");
		request.setAttribute("cityList", cityList);
		request.setAttribute("interestingList", interestingList);
		request.setAttribute("lightningMatch", lightningMatch);
		
	}
	
	@RequestMapping("/lightningWriteUpdateEnd.do")
	public String lightningWriteUpdateEnd(MatchManager matchManager, @RequestParam("uploadProfile") MultipartFile uploadProfile, 
										HttpServletRequest request) throws ParseException {
		
		logger.info("uploadProfile="+uploadProfile);
		//file
		if(!uploadProfile.isEmpty()) {
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/match");
			String originalFileName = uploadProfile.getOriginalFilename();
			String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
			SimpleDateFormat fileSdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSSS");
			int rndNum = (int)(Math.random()*1000);
			String renamedFileName = fileSdf.format(new java.util.Date())+"_"+rndNum+"."+ext;
			//서버 지정위치에 파일 보관
		
			try {
			uploadProfile.transferTo(new File(saveDirectory+"/"+renamedFileName));
			} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			}
		
			matchManager.setMatchOriginalImg(originalFileName);
			matchManager.setMatchRenamedImg(renamedFileName);
		
		}
		
		//form에서 가져온 일자와 시간을 합쳐서 sqlDate로 변경후 vo객체에 저장하기	
		String lightningEndDate = request.getParameter("lightningEndDate");
		String lightningEndTime = request.getParameter("lightningEndTime");
		logger.info("lightningEndDate={}, lightningEndTime={}", lightningEndDate, lightningEndTime);
		
		String matchEndDate = lightningEndDate+" "+lightningEndTime;
		
		Map<String, Object> map = new HashMap();
		map.put("matchManager", matchManager);
		map.put("matchEndDate" ,matchEndDate);
		
		logger.info("matchManager="+matchManager);
		int result = lightningService.updateLightning(map);
		logger.info("result="+result);
		
		String msg = result>0?"게시물 수정 성공":"게시물 수정 오류";
		String loc = "/member/memberInfo.do";
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		return "/common/msg";
	}
	
	//참여 허가
	@RequestMapping("/memberPermit.do")
	@ResponseBody
	public boolean memberPermit(@RequestBody Map map) {
		/*String nickName = String.valueOf(map.get("nickName"));
		int matchNo = Integer.parseInt(String.valueOf(map.get("matchNo")));
		logger.info("nickName="+nickName);
		logger.info("matchNo="+matchNo);
		logger.info("map={}",map);*/
		
		int result = lightningService.updatePermit(map);
		
		if(result > 0) {
			return true;
		}else {
			return false;
		}
	}
	
	//참여 거부
	@RequestMapping("/memberNoPermit.do")
	@ResponseBody
	public boolean memberNoPermit(@RequestBody Map map) {
		/*String nickName = String.valueOf(map.get("nickName"));
		int matchNo = Integer.parseInt(String.valueOf(map.get("matchNo")));
		logger.info("nickName="+nickName);
		logger.info("matchNo="+matchNo);
		logger.info("map={}",map);*/
		
		int result = lightningService.deleteNoPermit(map);
		
		if(result > 0) {
			return true;
		}else {
			return false;
		}
	}
	
	//참여 거부
	@RequestMapping("/matchJoinCancle.do")
	@ResponseBody
	public boolean matchJoinCancle(@RequestParam int matchNo, HttpSession session) {
		/*String nickName = String.valueOf(map.get("nickName"));
		int matchNo = Integer.parseInt(String.valueOf(map.get("matchNo")));
		logger.info("nickName="+nickName);
		logger.info("matchNo="+matchNo);
		logger.info("map={}",map);*/
		Member m = (Member)session.getAttribute("memberLoggedIn");
		int memberCode = m.getMemberCode();
		Map<String, Integer> param = new HashMap<>();
		param.put("memberCode", memberCode);
		param.put("matchNo", matchNo);
		
		int result = lightningService.deleteJoinCancle(param);
		
		if(result > 0) {
			return true;
		}else {
			return false;
		}
	}

}
