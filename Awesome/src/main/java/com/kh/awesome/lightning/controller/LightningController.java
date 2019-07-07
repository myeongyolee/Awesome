package com.kh.awesome.lightning.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.awesome.lightning.model.service.LightningService;
import com.kh.awesome.matchManager.model.vo.MatchManager;
import com.sun.xml.internal.ws.api.message.Attachment;

@Controller
@RequestMapping("/lightning")
public class LightningController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private LightningService lightningService;
	
	@RequestMapping("/lightningList.do")
	public void selectlightningList(Model model) {
		char matchingType = 'L';
		
		List<Map<String, String>> lightningList = lightningService.selectLightningList(matchingType);
		model.addAttribute("lightningList", lightningList);
		logger.info("lightningList@Controller="+lightningList);
	}
	
	@RequestMapping("/lightningWrite.do")
	public void lightningWrite() {
		
	}
	
	@RequestMapping("/lightningWriteEnd.do")
	public String insertLightning(MatchManager matchManager, @RequestParam String lightningEndDate, @RequestParam String lightningEndTime,
								  HttpSession session, @RequestParam("uploadProfile") MultipartFile uploadProfile, HttpServletRequest request) throws ParseException {
		//세션에서 memberCode가져오기
//		session.getAttribute("memberLoggedIn");
		matchManager.setMemberCode(1);
		
//		test용 
		matchManager.setMatchNo(0);
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
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		java.util.Date date = sdf.parse(matchEndDate);
		logger.info("date="+date);
		Date sqlDate = new Date(date.getTime());
		logger.info("sqlDate"+sqlDate);
		matchManager.setMatchEndDate(sqlDate);
		
		logger.info("matchManager="+matchManager);
		int result = lightningService.insertLightning(matchManager);
		logger.info("result="+result);
		
		String msg = result>0?"게시물 등록 성공":"게시물 등록 오류";
		String loc = "/lightning/lightningList.do";
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		return "/common/msg";
	}
	
}
