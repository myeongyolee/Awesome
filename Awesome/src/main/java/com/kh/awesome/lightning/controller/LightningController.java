package com.kh.awesome.lightning.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
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
	public void selectlightningList() {
		/*char matchingType = 'L';*/
		
		/*List<Map<String, String>> lightningList = lightningService.selectLightningList(matchingType);
		model.addAttribute("lightningList", lightningList);
		logger.info("lightningList@Controller="+lightningList);*/
	}
	
	@RequestMapping("/lightningListPage/cPage/{cPage}")
	@ResponseBody
	public List<Map<String, Object>> lightningListPage(@PathVariable("cPage") int cPage){
		logger.info("cPage="+cPage);
		char matchingType = 'L';
		int numPerPage = 5;
		List<Map<String, Object>> lightningList = lightningService.selectLightningList(matchingType, cPage, numPerPage);
		logger.info("lightningList={}", lightningList);
		
		Map<String, Map<String, Object>> map = new HashMap();
		List<Map<String, Object>> resultList = new ArrayList();
		
		//참여회원 리스트 만들기
		if(lightningList.size() > numPerPage) {
			for(Map<String, Object> resultMap : lightningList) {
				String matchNo = (String)resultMap.get("matchNo");
				logger.info("matchNo ["+matchNo+"]");
				
				if(map.isEmpty()) {
					map.put(matchNo, resultMap);
				}else {
					if(map.containsKey(matchNo)) {
						String joinMemberId = (String)map.get(matchNo).get("joinMemberId");
						joinMemberId += ","+(String)resultMap.get("joinMemberId");
						map.get(matchNo).put("joinMemberId", joinMemberId);
					}else {
						map.put(matchNo, resultMap);
					}
				}
			}
			
			for(int i=0; i<map.size(); i++) {
				
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
