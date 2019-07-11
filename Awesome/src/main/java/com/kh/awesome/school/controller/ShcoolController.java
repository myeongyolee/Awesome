package com.kh.awesome.school.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.awesome.school.model.service.SchoolService;

@Controller
public class ShcoolController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private SchoolService schoolService;
	
	@RequestMapping(value="/school/test", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public String test(@RequestParam("schoolName1") String ch1) throws Exception {
		logger.info("test@Controller확인");
		logger.info(ch1);
		
		String json;
		String address = "http://api.data.go.kr/openapi/elesch-mskul-lc-std"
				+ "?ServiceKey=zgXkec8mNWWtlugtL3e0YOek%2F2A1GGgirOUayagS3Lc0NnfvmpjM7f%2F3MMtyyJpxQpS6zVua3u8pJZ1bm0A6rw%3D%3D"
				+ "&pageNo=1"
				+ "&type=json"
				+ "&schoolNm="+ch1;
		BufferedReader br;
		URL url;
		HttpURLConnection conn;
		String protocol = "GET";
		
		url = new URL(address);
		conn = (HttpURLConnection)url.openConnection();
		conn.setRequestMethod(protocol);
		br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		
		json = br.readLine();
		
//		System.out.println(">>>>>>>>>>>>>>>>"+json);

        return json;
	}
	
	@RequestMapping("/school/enrollSchool")
	public String enrollSchool(@RequestParam("primary") String primary, @RequestParam("primary_id") String primary_id, @RequestParam("primary_address") String primary_address,
			                 @RequestParam("middle") String middle, @RequestParam("middle_id") String middle_id, @RequestParam("middle_address") String middle_address,
			                 @RequestParam("high") String high, @RequestParam("high_id") String high_id, @RequestParam("high_address") String high_address,
			                 @RequestParam("memberLoggedIn") String memberCode) {
		logger.info("enrollSchool@Controller 확인");
		
		//로그인된 사용자가 입력한 학교정보 DB에 저장하기
		if(!primary.equals("해당 학교가 존재하지 않습니다.")) {
			if(!primary.equals("")) {
				Map<String,String> param = new HashMap<String, String>();
				param.put("memberCode", memberCode);
				param.put("school_name", primary);
				param.put("school_code", primary_id);
				param.put("school_address", primary_address);
				
				logger.info("초등param확인:"+param);
				
				int result = schoolService.insertSchool(param);
				logger.info("초등입력확인:"+result);
			}
		}
		
		if(!middle.equals("해당 학교가 존재하지 않습니다.")) {
			if(!middle.equals("")) {
				Map<String,String> param = new HashMap<String, String>();
				param.put("memberCode", memberCode);
				param.put("school_name", middle);
				param.put("school_code", middle_id);
				param.put("school_address", middle_address);
				
				logger.info("중등param확인:"+param);
				
				int result = schoolService.insertSchool(param);
				logger.info("중등입력확인:"+result);
			}
		}
		
		if(!high.equals("해당 학교가 존재하지 않습니다.")) {
			if(!high.equals("")) {
				Map<String,String> param = new HashMap<String, String>();
				param.put("memberCode", memberCode);
				param.put("school_name", high);
				param.put("school_code", high_id);
				param.put("school_address", high_address);

				logger.info("고등param확인:"+param);
				
				int result = schoolService.insertSchool(param);
				logger.info("고등입력확인:"+result);
			}
		}
		
		return "school/school";
		
	}
	
}
