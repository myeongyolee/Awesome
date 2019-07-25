package com.kh.awesome.util.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.awesome.socket.stomp.model.service.StompService;
import com.kh.awesome.util.model.service.SocketService;

@Controller
public class SocketController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private StompService stompService;
	
	@Autowired
	private SocketService socketService;
	
	@RequestMapping(value="/sock/selectChat")
	@ResponseBody
	public Map<String,String> selectChat(ModelAndView mav ,
						String mCode) {
		Map<String, String> map = new HashMap<>();
		
		List<Map<String,String>> chat = socketService.selctChat(mCode);
		String html ="";
		
		for(Map<String,String> c : chat) {
			html += "<li id='"+c.get("MEMBERCODE")+"' class='mdl-menu__item'>"+codeToId(c.get("MEMBERCODE"))+"님과의 채팅방</li>";
		}
		map.put("html", html);
		
		return map;
	}
	
	public String codeToId(String memberCode) {
		return stompService.codeToId(memberCode);
	}
}
