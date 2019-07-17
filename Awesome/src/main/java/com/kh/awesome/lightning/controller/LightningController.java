package com.kh.awesome.lightning.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.awesome.lightning.model.service.LightningService;
import com.kh.awesome.matchManager.model.vo.MatchManager;

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
	
	@RequestMapping("lightningWrite.do")
	public void lightningWrite() {
		
	}
	
	@RequestMapping("lightningWriteEnd.do")
	public String insertLightning(MatchManager matchManager, @RequestParam String lightningEndDate, @RequestParam String lightningEndTime,
								  HttpSession session) {
		
		
		
		return "";
	}
	
}
