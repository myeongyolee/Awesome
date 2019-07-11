package com.kh.awesome.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import org.apache.commons.codec.binary.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpRequest;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.social.google.connect.GoogleOAuth2Template;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.kh.awesome.member.model.exception.MemberException;
import com.kh.awesome.member.model.service.MemberService;
import com.kh.awesome.member.model.vo.Address;
import com.kh.awesome.member.model.vo.AuthInfo;
import com.kh.awesome.member.model.vo.Member;
import com.kh.awesome.member.model.vo.NaverLoginBO;
import com.kh.awesome.sms.TempKey;

import net.nurigo.java_sdk.Coolsms;
import net.nurigo.java_sdk.api.Message;

import java.util.HashMap;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
@RequestMapping("/member")
//attr중에 key값이 memberLoggedIn라면 sessionScope에 저장해라~
@SessionAttributes(value= {"memberLoggedIn"})
public class MemberController {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	//20190709 09:55 김용빈
	/* naver login */
		private NaverLoginBO naverLoginBO;
		private String apiResult = null;
		
		@Autowired
		private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
			this.naverLoginBO = naverLoginBO;
		}
		
	@Autowired
	private MemberService memberService;
	
	//\WEB-INF\spring\security-context.xml 내에 정의된 bean을 통해 DI을 받아옴
	@Autowired
	BCryptPasswordEncoder bCryptPasswordEncoder; 
	
	/* google Login */
		 @Inject
		    private AuthInfo authInfo;
		    
		 @Autowired
		    private GoogleOAuth2Template googleOAuth2Template;
		    
		 @Autowired
		    private OAuth2Parameters googleOAuth2Parameters;
	
	
	@RequestMapping("/findAddr")
	public String findAddr() {
		if(logger.isInfoEnabled()) logger.info("주소 검색 페이지!");
		return "common/findAddr";
	}
	
	@RequestMapping("/jusoPopup")
	public String jusoPopup() {
		if(logger.isInfoEnabled()) logger.info("주소 검색 팝업!");
		return "member/jusoPopup";
	}
	
	@RequestMapping("/memberEnroll.do")
	public void memberEnroll() {
		if(logger.isInfoEnabled()) logger.info("회원 가입 페이지 요청!");
	}
	
	@RequestMapping(value="/memberEnrollEnd.do", method = RequestMethod.POST )
	public String memberEnrollEnd(Address address, 
						Member member,
						@RequestParam("upfile") MultipartFile upfile, 
						Model model,
						HttpServletRequest request) {
		if(logger.isInfoEnabled()) logger.info("회원 등록 페이지 요청!");
		logger.info("!!!!!!!!!!!!!!member={}",member);

		//프로파일 사진 처리
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/member");
			if(!upfile.isEmpty()) {
				String originalFileName = upfile.getOriginalFilename();
				String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
				int rndNum =(int)(Math.random()*1000);
				
				String renamedFileName = sdf.format(new Date())+"_"+rndNum+"."+ext;
				
				//서버지정위치에 파일보관
				try {
					upfile.transferTo(new File(saveDirectory+"/"+renamedFileName));
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				member.setProfile(originalFileName);
				member.setRenamedProfile(renamedFileName);
			}
		

		//암호 암호화처리
			String rawPwd = member.getPassword();
			String encodedPwd = bCryptPasswordEncoder.encode(rawPwd);
			System.out.println("암호화전: "+rawPwd);
			System.out.println("암호화후: "+encodedPwd);
			
			if(member.getFriendOpen()!='Y') member.setFriendOpen('N'); 
			if(member.getBlindDateOpen()!='Y') member.setBlindDateOpen('N'); 
			if(member.getSearchOpen()!='Y') member.setSearchOpen('N'); 
			member.setPassword(encodedPwd);
		
		//회원 등급처리(관리자,일반회원)
			member.setVerify('M');
		
		logger.info("member={}",member);
		
		int result = memberService.insertMember(member,address);
		
		return "redirect:/index";
	}
	
	@RequestMapping("/checkIdDuplicate.do")
	@ResponseBody
	public Map<String,Object> checkIdDuplicate3(@RequestParam String memberId){
		Map<String,Object> map = new HashMap<String, Object>();
		
		Member m = new Member();
		m.setMemberId(memberId);
		
		boolean isUsable = memberService.selectOneMember(m)==null?true:false;
		logger.info("아이디중복체크 : "+isUsable);
		map.put("isUsable", isUsable);
		
		return map;
	}
	
	@RequestMapping("/checkNickNameDuplicate.do")
	@ResponseBody
	public Map<String,Object> checkNickNameDuplicate(@RequestParam String nickName){
		Map<String,Object> map = new HashMap<String, Object>();
		
		Member m = new Member();
		m.setNickName(nickName);
		
		boolean isUsable = memberService.selectOneMember(m)==null?true:false;
		logger.info("닉네임중복체크 : "+isUsable);
		map.put("isUsable", isUsable);
		
		return map;
	}
	
	@RequestMapping("/memberLogin.do")
	public String memberLogin(@RequestParam("memberId") String memberId,
							@RequestParam("password") String password,
							Model model,
							HttpServletRequest request) {
		
		logger.info("회원 로그인 요청!");
		String encodedPassword = bCryptPasswordEncoder.encode(password);
	
		try {
			
			Member member =new Member();
			member.setMemberId(memberId);
			
			Member m = memberService.selectOneMember(member);
			logger.info("memberId="+memberId);
			logger.info("Member="+m);
			
			String msg = "";
			String loc = "/";
			
			if(m ==null) {
				msg="회원이 존재하지 않습니다.";
			}else {
				boolean bool = bCryptPasswordEncoder.matches(password, m.getPassword());
				
				if(bool) {
					msg="로그인성공!"+m.getMemberName()+"님, 반갑습니다.";
					model.addAttribute("memberLoggedIn",m);
				}else {
					msg="비밀번호가 틀렸습니다.";
				}
			}
				
				String referer= request.getHeader("Referer");  //http://localhost/awesome/index
				String origin= request.getHeader("Origin"); // http://localhost (port)
				String url = request.getRequestURL().toString(); //url=http://localhost/awesome/member/memberLogin.do
				String uri = request.getRequestURI(); //uri=/awesome/member/memberLogin.do
	
				if(origin ==null) {
					origin = url.replace(uri, "");
				}
				
				loc = referer.replace(origin+request.getContextPath(),"");
				
				model.addAttribute("msg",msg);
				model.addAttribute("loc",loc);
		}catch(Exception e) {
			logger.error("로그인 요청에러 : ",e);
			
			//error페이지 호출을 위해 RuntimeException 던짐
			throw new MemberException("로그인 요청에러 : "+e.getMessage());
		}
		
		return "common/msg";
	}
	
	@RequestMapping("/memberLogout.do")
	public String memeberLogOut(SessionStatus sessionStatus) {
		
		logger.info("회원 로그아웃 요청!");
		
		//로그인하였을때HttpSession객체 .setAttribute을 통해 
		//로그인 사용자 정보을 담았다면, httpSession .invalidate() 호출하여야한다.
		if(!sessionStatus.isComplete()) {
			sessionStatus.setComplete();
		}
	
		return "redirect:/index";
	}
	
	 
	//google Login
	    @RequestMapping(value = "/googlecallback")
	    public String doSessionAssignActionPage(HttpServletRequest request,Model model) throws Exception {

	    	logger.info("여기는 google callback");
	    	
	        String code = request.getParameter("code");
	        
	        //RestTemplate을 사용하여 Access Token 및 profile을 요청한다.
	        RestTemplate restTemplate = new RestTemplate();
	        MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
	        parameters.add("code", code);
	        parameters.add("client_id", authInfo.getClientId());
	        parameters.add("client_secret", authInfo.getClientSecret());
	        parameters.add("redirect_uri", googleOAuth2Parameters.getRedirectUri());
	        parameters.add("grant_type", "authorization_code");
	        
	        org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
	        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
	        HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<MultiValueMap<String, String>>(parameters, headers);
	        ResponseEntity<Map> responseEntity = restTemplate.exchange("https://www.googleapis.com/oauth2/v4/token", HttpMethod.POST, requestEntity, Map.class);
	        Map<String, Object> responseMap = responseEntity.getBody();
	 
	        // id_token 라는 키에 사용자가 정보가 존재한다.
	        // 받아온 결과는 JWT (Json Web Token) 형식으로 받아온다. 콤마 단위로 끊어서 첫 번째는 현 토큰에 대한 메타 정보, 두 번째는 우리가 필요한 내용이 존재한다.
	        // 세번째 부분에는 위변조를 방지하기 위한 특정 알고리즘으로 암호화되어 사이닝에 사용한다.
	        //Base 64로 인코딩 되어 있으므로 디코딩한다.
	        String[] tokens = ((String)responseMap.get("id_token")).split("\\.");
	        Base64 base64 = new Base64(true);
	        String body = new String(base64.decode(tokens[1]));
	        System.out.println(tokens.length);
	        System.out.println(new String(Base64.decodeBase64(tokens[0]), "utf-8"));
	        System.out.println(new String(Base64.decodeBase64(tokens[1]), "utf-8"));
	 
	        //필요한 데이터 가져오기 
	        //방법1
		        JSONParser parser = new JSONParser(); 
		        JSONObject obj = (JSONObject)parser.parse( new String(Base64.decodeBase64(tokens[1]))); 
		        System.out.println(obj.get("email"));
		        
		    //방법2
		        //Jackson을 사용한 JSON을 자바 Map 형식으로 변환
		        ObjectMapper mapper = new ObjectMapper();
		        Map<String, String> result = mapper.readValue(body, Map.class);
		        System.out.println(result.get("email"));
		        
		        
		    //awesome 로그인처리
		        String memberId =(String) obj.get("email");
		        
		        String returnResult ="";
		        try {
					Member member =new Member();
					member.setMemberId(memberId);
					
					Member m = memberService.selectOneMember(member);
					logger.info("memberId="+memberId);
					logger.info("Member="+m);
					
					String msg = "";
					String loc = "/";
					
					if(m ==null) {
						msg="해당 아이디의 회원이 존재하지 않습니다. 가입이 필요합니다.";
						model.addAttribute("OAuth","NoMember");
						returnResult="redirect:/index";
					}else {
						msg="로그인성공!"+m.getMemberName()+"님, 반갑습니다.";
						model.addAttribute("memberLoggedIn",m);
						returnResult="common/msg";
					}
						
						String referer= request.getHeader("Referer");  //http://localhost/awesome/index
						String origin= request.getHeader("Origin"); // http://localhost (port)
						String url = request.getRequestURL().toString(); //url=http://localhost/awesome/member/memberLogin.do
						String uri = request.getRequestURI(); //uri=/awesome/member/memberLogin.do
			
						if(origin ==null) {
							origin = url.replace(uri, "");
						}
						
						loc = referer.replace(origin+request.getContextPath(),"");
						
						model.addAttribute("msg",msg);
						model.addAttribute("loc",loc);
						model.addAttribute("memberId",memberId);
						
				}catch(Exception e) {
					logger.error("로그인 요청에러 : ",e);
					//error페이지 호출을 위해 RuntimeException 던짐
					throw new MemberException("로그인 요청에러 : "+e.getMessage());
				}
				
	        return returnResult;
	    }
	    
	 //naver Login
	  //네이버 로그인 성공시 callback호출 메소드
	    @RequestMapping(value = "/navercallback", method = { RequestMethod.GET, RequestMethod.POST })
	    public String callback(Model model, 
	    			@RequestParam String code, 
	    			@RequestParam String state, 
	    			HttpSession session,HttpServletRequest request) 
	    		throws IOException, ParseException {
	    	
		    logger.info("여기는 naver callback");
		    
		    OAuth2AccessToken oauthToken;
		    oauthToken = naverLoginBO.getAccessToken(session, code, state);
		    
		    //1. 로그인 사용자 정보를 읽어온다.
		    apiResult = naverLoginBO.getUserProfile(oauthToken); //String형식의 json데이터
			    /** apiResult json 구조
			    {"resultcode":"00",
			    "message":"success",
			    "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"shinn0608@naver.com","name":"\uc2e0\ubc94\ud638"}}
			    **/
		    
		    //2. String형식인 apiResult를 json형태로 바꿈
			    JSONParser parser = new JSONParser();
			    Object obj = parser.parse(apiResult);
			    JSONObject jsonObj = (JSONObject) obj;
			    
		    //3. 데이터 파싱
		    //Top레벨 단계 _response 파싱
			    JSONObject response_obj = (JSONObject)jsonObj.get("response");
			    //response의 nickname값 파싱
			    String email = (String)response_obj.get("email");
			    System.out.println("naveremail"+email);
			    
		    //4.파싱 닉네임 세션으로 저장
			    //session.setAttribute("sessionId",email); //세션 생성
			    
			    //Member m = memberService.selectOneMember(memberId);
			    
			    //model.addAttribute("memberLoggedIn",m);
			    model.addAttribute("result", apiResult);
			    
			    //return "redirect:/index";
			    
			//awesome 로그인처리
		        String memberId =email;
		        
		        String returnResult ="";
		        try {
					Member member =new Member();
					member.setMemberId(memberId);
					
					Member m = memberService.selectOneMember(member);
					logger.info("memberId="+memberId);
					logger.info("Member="+m);
					
					String msg = "";
					String loc = "/";
					
					if(m ==null) {
						msg="해당 아이디의 회원이 존재하지 않습니다. 가입이 필요합니다.";
						model.addAttribute("OAuth","NoMember");
						loc="http://localhost/awesome/index";
						returnResult="redirect:/index";
					}else {
						msg="로그인성공!"+m.getMemberName()+"님, 반갑습니다.";
						model.addAttribute("memberLoggedIn",m);
						loc="/index";
						returnResult="common/msg";
					}
						
						String referer= request.getHeader("Referer");  //http://localhost/awesome/index
						String origin= request.getHeader("Origin"); // http://localhost (port)
						String url = request.getRequestURL().toString(); //url=http://localhost/awesome/member/memberLogin.do
						String uri = request.getRequestURI(); //uri=/awesome/member/memberLogin.do
			
						logger.info("naver Login="+referer+","+origin+","+url);
						if(origin ==null) {
							origin = url.replace(uri, "");
						}
						
						model.addAttribute("msg",msg);
						model.addAttribute("loc",loc);
						model.addAttribute("memberId",memberId);
						
				}catch(Exception e) {
					logger.error("로그인 요청에러 : ",e);
					//error페이지 호출을 위해 RuntimeException 던짐
					throw new MemberException("로그인 요청에러 : "+e.getMessage());
				}
				
	        return returnResult;  
	    }
		
	    
	    @ResponseBody
	    @RequestMapping(value = "/sendSMS", method = RequestMethod.POST, 
	    		produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	    public String sendSMS(String userPhoneNumber,
	    		@CookieValue(value="JSESSIONID", required=false) Cookie jid,
	    						HttpServletRequest request) throws Exception { // 휴대폰 문자보내기
	    	int result=0;
	    	String jsessionid="";
	    	String msg="";
	    	
	    	if(jid != null)
	    		jsessionid=jid.getValue();
	    	
	    	String api_key = "NCSWCYIP6WSDRQDJ";
	    	String api_secret = "P7PIX6GNPW4FAHOKKYLF9KGLPVRFW4SO";
	    	Message coolsms = new Message(api_key, api_secret); // 메시지보내기 객체 생성
	    	
	    	String key = new TempKey().getKey(4); // 인증키 생성
	    	//userService.insertAuthCode(userPhoneNumber, key); // 휴대폰 인증 관련 서비스
	    	
	    	 //* Parameters 관련정보 : http://www.coolsms.co.kr/SDK_Java_API_Reference_ko#toc-0
	    	 
	    	HashMap<String, String> set = new HashMap<String, String>();
	    	set.put("to", userPhoneNumber); // 수신번호
	    	set.put("from", "01089721172"); // 발신번호
	    	set.put("text", "안녕하세요 awesome입니다. 가입인증번호는 [" + key + "] 입니다."); // 문자내용
	    	set.put("type", "sms"); // 문자 타입

	    	Map<String, String> map = new HashMap<>();
	    	map.put("jsessionid", jsessionid);
	    	map.put("sms", key);
	    	
	    	result = memberService.insertSms(map);

	    	JSONObject obj=null;
	    	try {
	    	      obj = (JSONObject) coolsms.send(set);
	    	      System.out.println(obj.toString());
	    	      // 메시지 보내기 성공 및 전송결과 출력
	    	      System.out.println("성공");
	    	      System.out.println(obj.get("group_id")); // 그룹아이디
	    	      System.out.println(obj.get("result_code")); // 결과코드
	    	      System.out.println(obj.get("result_message")); // 결과 메시지
	    	      System.out.println(obj.get("success_count")); // 메시지아이디
	    	      System.out.println(obj.get("error_count")); // 여러개 보낼시 오류난 메시지 수
	    	      msg="전송 성공";
	    	    } catch (CoolsmsException e) {
	    	      System.out.println(e.getMessage());
	    	      System.out.println(e.getCode());
	    	      // 메시지 보내기 실패
	    	      System.out.println("실패");
	    	      System.out.println(obj.get("code")); // REST API 에러코드
	    	      System.out.println(obj.get("message")); // 에러메시지
	    	      
	    	      msg="전송 실패";
	    	    }

	    	return msg;
	    }
	    
	    @ResponseBody
	    @RequestMapping(value = "/chkSmsAuth", 
	    		method = RequestMethod.POST, 
	    		produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	    public String chkSmsAuth(@RequestParam("authNum") String authNum,
	    		@CookieValue(value="JSESSIONID", required=false) Cookie jid,
	    						HttpServletRequest request) {
			
	    	String jsessionid="";
	    	
	    	if(jid != null)
	    		jsessionid=jid.getValue();
	    	
	    	Map<String, String> map = new HashMap<>();
	    	map.put("jsessionid", jsessionid);
	    	map.put("sms", authNum);
	    	
	    	int result = memberService.chkSms(map);

	    	if(result!=0) {
	    		int delResult=memberService.deleteSms(map);
	    		return "success";
	    	}
	    	else return "fail";
	    }

}
