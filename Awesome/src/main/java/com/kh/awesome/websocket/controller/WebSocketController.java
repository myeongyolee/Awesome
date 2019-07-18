package com.kh.awesome.websocket.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class WebSocketController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/websocket/chatting")
	public ModelAndView chatting() {
		logger.info("chatting 들어옴");
		ModelAndView mav = new ModelAndView();
		
//		Member member = session객체를 통해 현재 로그인된 멤버의 정보를 담는다
		
		mav.addObject("userId", "유저아이디1");
		mav.setViewName("chatting/chatting");		
		return mav;
	}
}
