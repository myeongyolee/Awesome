package com.kh.awesome.lightning.controller;

import java.io.File;
import java.io.IOException;
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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.awesome.lightning.model.service.LightningService;
import com.kh.awesome.matchManager.model.vo.MatchManager;

@Controller
@RequestMapping("/lightning")
public class LightningController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private LightningService lightningService;
	
	@RequestMapping("/lightningList.do")
	public void selectlightningList() {}
	
	@RequestMapping("/lightningListPage.do")
	@ResponseBody
	public List<Map<String, Object>> lightningListPage(@RequestBody Map requestMap){
		int cPage = Integer.parseInt((String)requestMap.get("cPage"));
		logger.info("cPage="+cPage);
		char matchingType = 'L';
		int numPerPage = 5;
		List<Map<String, Object>> lightningList = lightningService.selectLightningList(matchingType, cPage, numPerPage);
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
		
		logger.info("joinMemberMap={}",joinMemberMap);
		logger.info("key="+key);
		
		for(String k : key) {
			for(Map<String,Object> map : lightningList) {
				if(String.valueOf(map.get("matchNo")).equals(k)) {
					map.put("joinMemberNickName", joinMemberMap.get(k));
				}
			}
		}
		
		return lightningList;
	}
	
	@RequestMapping("/lightningWrite.do")
	public void lightningWrite() {
		
	}
	
	@RequestMapping("/lightningWriteEnd.do")
	public String insertLightning(MatchManager matchManager, @RequestParam String lightningEndDate, @RequestParam String lightningEndTime,
								  HttpSession session, @RequestParam("uploadProfile") MultipartFile uploadProfile, HttpServletRequest request) throws ParseException {
		//세션에서 memberCode가져오기
//		session.getAttribute("memberLoggedIn");
		matchManager.setMemberCode(63);
		
//		test용 
		matchManager.setPlaceName(null);;
		matchManager.setPlaceId(null);;
		
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
		
		logger.info("lightningEndDate={}, lightningEndTime={}", lightningEndDate, lightningEndTime);
		//form에서 가져온 일자와 시간을 합쳐서 sqlDate로 변경후 vo객체에 저장하기		
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
	
}
