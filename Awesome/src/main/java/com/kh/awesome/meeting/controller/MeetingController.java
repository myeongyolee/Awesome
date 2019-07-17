package com.kh.awesome.meeting.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.awesome.meeting.model.service.MeetingService;
import com.kh.awesome.member.model.vo.Member;

@Controller
@RequestMapping("/meeting")
public class MeetingController {

	@Autowired
	private MeetingService mService;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/profile")
	@ResponseBody
	public Map<String,String> userProfile(HttpServletRequest request){
		HttpSession session = request.getSession();
		
		Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
		Map<String,String> info = new HashMap<String, String>();
		info.put("memberCode", ""+memberLoggedIn.getMemberCode());
		Map<String,String> user = mService.selectRandomUser(info);
		
		logger.info("user : "+user);
		
		return user;
	}
	
	@RequestMapping(value="/changeUser", method=RequestMethod.GET, produces=MediaType.APPLICATION_PROBLEM_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String,String> changeUser(@RequestParam String memberCode,
											@RequestParam String receiveMemberCode,
											@RequestParam String like,
											HttpServletRequest request){
		Map<String, String> userMap = new HashMap<String, String>();
		userMap.put("memberCode", memberCode);
		userMap.put("receiveMemberCode", receiveMemberCode);
		userMap.put("like", like);
		mService.insertBlindDate(userMap);
		
		Map<String, String> machting = mService.selectRandomUser(userMap);
		
		String html ="";
		html += "<img src='"+request.getContextPath()+"/resources/images/sampleimage.png' alt='' width='300px' height='504px'>";
		html += "<div class='user-id-addr'>";
		html += 	"<input type='hidden' id='memberCode' name='memberCode' value='"+String.valueOf(machting.get("MCODE"))+"' />";
<<<<<<< HEAD
		html += 	"<input type='hidden' name='receiveMemberCode' id='receiveMemberCode' value='"+machting.get("RECEIVE_MEMBERCODE")+"'/>";
		html += 	"<p id='userId'>"+machting.get("MEMBER_ID")+"</p>";
		html += 	"<p id='address'>"+machting.get("ROAD_ADDRESS")+"</p>";
=======
		html += 	"<input type='hidden' name='receiveMemberCode' id='receiveMemberCode' value='"+machting.get("RECEIVEMEMBERCODE")+"'/>";
		html += 	"<p id='userId'>"+machting.get("MEMBERID")+"</p>";
		html += 	"<p id='address'>"+machting.get("ADDRESS")+"</p>";
>>>>>>> refs/remotes/origin/jinwoo
		html += "</div>";
		 
		Map<String,String> htmlMap = new HashMap<String,String>();
		htmlMap.put("html",html);
		
		return htmlMap;
	}
	
	@RequestMapping(value="/likeMeMember", method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String, String>> likeMeMember(HttpServletRequest request){
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute("memberLoggedIn");
		
		List<Map<String,String>> likeMe = mService.selectLikeMe(member.getMemberCode());
		
		return likeMe;
	}
	
	@RequestMapping(value="/chatting.do", method=RequestMethod.GET)
	public ModelAndView chat(ModelAndView mav) {
		
		
		return mav;
	}
}
