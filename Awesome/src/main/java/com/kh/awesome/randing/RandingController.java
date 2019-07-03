package com.kh.awesome.randing;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RandingController {

	@RequestMapping("/index")
	public String index() {
		return "/common/randing";
	}
}
