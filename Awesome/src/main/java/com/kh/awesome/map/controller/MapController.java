package com.kh.awesome.map.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.awesome.map.model.service.MapService;

@Controller
public class MapController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private MapService mapService;
	
	@RequestMapping("/map/searchMap")
	public String searchMap() {
		
		return "/map/maptest";
	}
	
	@RequestMapping("/map/selectAddress")
	@ResponseBody
	public List<Map<BigDecimal,BigDecimal>> selectAddress(@RequestParam("param") String memberCode) {
		logger.info("ajax/selectAddress 들어옴");
		
		List<Map<BigDecimal,BigDecimal>> list = mapService.selectAddress(memberCode);
		logger.info("selectAddress List@Controller:"+list);
		
		return list;
	}
	
	@RequestMapping("/map/selectMyAddress")
	@ResponseBody
	public List<Map<BigDecimal,BigDecimal>> selectMyAddress(@RequestParam("param") String memberCode) {
		logger.info("ajax/selectMyAddress 들어옴");
		
		List<Map<BigDecimal,BigDecimal>> list = mapService.selectMyAddress(memberCode);
		System.out.println("내주소>>>>>>>>>>>>>>>"+list);
		
		return list;
	}
	
	@RequestMapping("/map/enrollFriend")
	public ModelAndView enrollFriend(@RequestParam("infocheck") String infocheck, @RequestParam("interesting") String[] interesting,
			                   @RequestParam("memberLoggedIn") String memberCode) {
		logger.info("/map/enrollFriend들어옴");
		ModelAndView mav = new ModelAndView();
		
		String str = "";
		for(int i=0; i<interesting.length; i++) {
			str += interesting[i];
			if(i<=interesting.length-2) {
				str += ",";
			}
		}
		
		Map<String,String> param = new HashMap<String,String>();	
		param.put("memberCode", memberCode);
		param.put("infocheck", infocheck);
		param.put("str", str);
		System.out.println("파람확인:"+param);
		
		int result = mapService.enrollInfoCheck(param); // 동네친구에 자기정보 공개여부 'Y'로 바꾸기
		int reuslt2 = mapService.enrollInteresting(param); // 개인관심분야정보 입력하기
		
		mav.addObject("memberCode", memberCode);
		mav.setViewName("map/maptest");
		return mav;
	}
	
	@RequestMapping("/map/checkInfo")
	@ResponseBody
	public String checkInfo(@RequestParam("memberCode") String memberCode) {
		logger.info("checkInfo들어옴");
		
		String result = mapService.checkInfo(memberCode); // 해당회원의 동네친구정보 공개여부가 Y인지N인지 확인
		
		return result;
	}
	
	@RequestMapping("/map/checkFriend")
	@ResponseBody
	public int checkFriend(@RequestParam("memberCode") String memberCode, @RequestParam("friendCode") String friendCode) {
		logger.info("checkFriend들어옴");
		Map<String,String> param = new HashMap<String,String>();
		param.put("memberCode", memberCode);
		param.put("friendCode", friendCode);
		
		int result = mapService.checkFriend(param);
		
		return result;
		
	}
	
	@RequestMapping("/map/sendFriend")
	public String sendFriend(@RequestParam("memberCode") String memberCode, @RequestParam("friendCode") String friendCode) {
		logger.info("sendFriend들어옴");
		Map<String,String> param = new HashMap<String,String>();
		param.put("memberCode", memberCode);
		param.put("friendCode", friendCode);
		param.put("result", "Y");
		
		int result = mapService.sendFriend(param); // 친구목록테이블에 기록 남기기
		
		return "/map/maptest";
	}	
	
	
	@RequestMapping("/map/friendList")
	public ModelAndView friendList(@RequestParam("memberCode") String memberCode) {
		ModelAndView mav = new ModelAndView();
		logger.info("friendList 들어옴");
		
		List<Integer> list = new ArrayList<>();
		list = mapService.friendList(memberCode); // 내가 친구요청보낸 목록 확인
		logger.info("친구목록 리스트:"+list);
		
		mav.addObject("list", list);
		mav.addObject("memberCode", memberCode);
		mav.setViewName("/map/friendList");
		
		return mav;
	}
	
	@RequestMapping("/map/showMyFriend")
	@ResponseBody
	public List<Map<String,Object>> showMyFriend(@RequestParam("param") String[] param) {
		logger.info("showMyFriend들어옴");
		
		List<String> list = new ArrayList<String>();
		for(int i=0; i<param.length; i++) {
			list.add(param[i]);
		}
		logger.info("보여줄 친구목록코드:" + list);
		
		List<Map<String,Object>> result = mapService.showMyFriend(list);
		logger.info("result확인:"+result);
		
		return result;
	}
	
	@RequestMapping("/map/deleteFriend")
	@ResponseBody
	public int deleteFriend(@RequestParam("memberCode") String memberCode ,@RequestParam("friendCode") String friendCode) {
		logger.info("deleteFriend 들어옴");
		Map<String,String> param = new HashMap<String,String>();
		param.put("memberCode", memberCode);
		param.put("friendCode", friendCode);
		
		int result = mapService.deleteFriend(param);
		
		return result;
		
	}
	
	
	
	@RequestMapping(value="/map/findPosition", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String findPosition(@RequestParam("param") String position) throws Exception {
		
        String clientId = "l3bRNMshRGqHPXuqlMvs";//애플리케이션 클라이언트 아이디값";
        String clientSecret = "tFz7TI8MjF";//애플리케이션 클라이언트 시크릿값";
      
		String text = URLEncoder.encode(position, "UTF-8");
		String apiURL = "https://openapi.naver.com/v1/search/local.json?query=" + text; // json 결과

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

	
}
