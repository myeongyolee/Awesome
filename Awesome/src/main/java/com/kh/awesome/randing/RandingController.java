package com.kh.awesome.randing;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RandingController {

	@RequestMapping("/index")
	public String index() {
		return "/common/randing";
	}
	
	@RequestMapping("/indexAfter")
	public String indexAfter() {
		
		
		
		return "/common/header";
	}
	
	@RequestMapping("/meeting")
	public String meeting() {
		return "/meeting/meeting";
	}
	
	@RequestMapping("/vicinage")
	public String vicinage() {
		return "vicinage-friend/vicinageFriend";
	}
	
	@RequestMapping("lightning")
	public String lighting() {
		return "lightning/lightningList";
	}
}
