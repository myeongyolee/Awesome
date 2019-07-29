package com.kh.awesome.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.social.google.connect.GoogleOAuth2Template;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;
//import com.kh.awesome.mail.controller.MailController;
import com.kh.awesome.member.model.exception.MemberException;
import com.kh.awesome.member.model.service.MemberService;
import com.kh.awesome.member.model.vo.Address;
import com.kh.awesome.member.model.vo.AuthInfo;
import com.kh.awesome.member.model.vo.Member;
import com.kh.awesome.member.model.vo.NaverLoginBO;
import com.kh.awesome.recaptcha.VerifyRecaptcha;
import com.kh.awesome.sms.TempKey;

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
		private JavaMailSender mailSender;
		
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
	
	@RequestMapping("/smartEditor")
	public String smartEditor() {
		if(logger.isInfoEnabled()) logger.info("스마트에디터 팝업!");
		return "common/smartEditor";
	}
	
	@RequestMapping("/memberEnroll.do")
	public void memberEnroll() {
		if(logger.isInfoEnabled()) logger.info("회원 가입 페이지 요청!");
	}
	
	@RequestMapping("/findMember.do")
	public void findMember() {
		if(logger.isInfoEnabled()) logger.info("회원 찾기 페이지 요청!");
	}
	
	@RequestMapping("/memberSecession.do")
	public void memberSecession(HttpSession session,Model model) {
		if(logger.isInfoEnabled()) logger.info("회원 탈퇴 페이지 요청!");
		Member member=(Member) session.getAttribute("memberLoggedIn");
		
		member=memberService.selectOneMember(member);
		Address address=memberService.memberAddress(member.getMemberCode());
		
		model.addAttribute("member", member);
		model.addAttribute("address", address);
		
	}
	
	//회원 아이디 가져오기
	@RequestMapping("/getMemberId.do")
	@ResponseBody
	public String getMemberId(Member member,Model model, 
			@RequestParam String phone,
			@RequestParam String memberName) {
		if(logger.isInfoEnabled()) logger.info("회원 정보 페이지 요청!");
		System.out.println("전="+member);
		member=memberService.selectOneMember(member);
		System.out.println("후="+member);
		if(member !=null) {
			return member.getMemberId();
		}
		return "fail";
	}
	
	//회원 정보 보기
	@RequestMapping("/memberInfo.do")
	public void memberInfo(HttpSession session,Model model) {
		if(logger.isInfoEnabled()) logger.info("회원 정보 페이지 요청!");
		
		Member member=(Member) session.getAttribute("memberLoggedIn");
		System.out.println("test member!!!!!+"+member);
		member=memberService.selectOneMember(member);
		
		model.addAttribute("member", member);
	}
	
	//회원 정보 수정
	@RequestMapping("/memberInfoUpdate.do")
	public void memberInfoUpdate(HttpSession session,Model model) {
		if(logger.isInfoEnabled()) logger.info("회원 수정 페이지 요청!");
		
		Member member=(Member) session.getAttribute("memberLoggedIn");
		
		member=memberService.selectOneMember(member);
		Address address=memberService.memberAddress(member.getMemberCode());
		
		model.addAttribute("member", member);
		model.addAttribute("address", address);
	}
	
	//회원 탈퇴
	@RequestMapping("/sucessionMemberEnd.do")
	public String sucessionMember(Member member,Model model,
							@RequestParam(value="reason",required=false) String reason,
							SessionStatus sessionStatus,HttpSession session,
							HttpServletRequest request, HttpServletResponse response
							) {
		if(logger.isInfoEnabled()) logger.info("회원 탈퇴 엔드 요청!");
		String msg = "";
		String loc = "";
		
		int memberCode = member.getMemberCode();
		logger.info("회원 탈퇴 엔드1111(memberCode,reason)= "+memberCode+", "+reason);
		
		Member memberLoggedIn=(Member) session.getAttribute("memberLoggedIn");
		
		if(member.getMemberId().equals(memberLoggedIn.getMemberId()) && member.getMemberCode() == memberLoggedIn.getMemberCode()) {
			int result=memberService.deleteMember(member);
			if(result>0) {
				logger.info("회원 탈퇴 엔드2222(memberCode,reason)= "+memberCode+", "+reason);
				memberService.updateReason(memberCode,reason);
				
				if(session.getAttribute("memberLoggedIn")!=null) {
					session.removeAttribute("memberLoggedIn");
					session.invalidate();
					
					Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		            if ( loginCookie != null ){
		                // null이 아니면 존재하면!
		                loginCookie.setPath("/");
		                // 쿠키는 없앨 때 유효시간을 0으로 설정하는 것 !!! invalidate같은거 없음.
		                loginCookie.setMaxAge(0);
		                // 쿠키 설정을 적용한다.
		                response.addCookie(loginCookie);
		                 
		                // 사용자 테이블에서도 유효기간을 현재시간으로 다시 세팅해줘야함.
		                java.sql.Date date = new java.sql.Date(System.currentTimeMillis());
		                memberService.updateKeepLogin(member.getMemberId(), session.getId(), date);
		            }
				}
				
				//로그인하였을때HttpSession객체 .setAttribute을 통해 
				//로그인 사용자 정보을 담았다면, httpSession .invalidate() 호출하여야한다.
				if(!sessionStatus.isComplete()) {
					sessionStatus.setComplete();
				}
				msg="회원 탈퇴 성공! 안녕히 가세요. ";
				loc="/index";
			}else {
				msg="회원 탈퇴 실패! 관리자에게 문의하세요. ";
				loc="/index";				
			}
		}
		
		model.addAttribute("msg",msg);
		model.addAttribute("loc",loc);
		return "common/msg";
	}
	
	//회원 정보 수정
	@RequestMapping(value="/memberUpdate.do", method = RequestMethod.POST )
	@ResponseBody
	public String memberUpdate(Model model,
			 Member member,
			Address address,
			//@ModelAttribute(value="member") Member member,
			//@ModelAttribute(value="address") Address address,
			@RequestParam(value="upfile",required=false) MultipartFile upfile,
			HttpServletRequest request) {
		if(logger.isInfoEnabled()) logger.info("회원 정보 수정 페이지 요청!");
		
		//패스워드 암호처리
		
		if(member.getPassword() !=null) {
			String encodedPwd = bCryptPasswordEncoder.encode(member.getPassword());
			member.setPassword(encodedPwd);
		}
		
		
		//프로파일 사진 처리
		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/member");
		if(upfile!=null) {
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
		}
		
		System.out.println(member+","+address);
		int result = memberService.updateMember(member,address);
		System.out.println(result);
		
		Member m = memberService.selectOneMember(member);
		
		if(result>0) {
			model.addAttribute("memberLoggedIn",m);
			return member.getPhone();
		}else {
			return "fail";
		}
		
	}
	
	//회원가입
	@RequestMapping(value="/memberEnrollEnd.do", method = RequestMethod.POST )
	public String memberEnrollEnd(Address address,
						Member member,
						@RequestParam(value="upfile",required=false) MultipartFile upfile, 
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
			
//			if(member.getFriendOpen()!='Y') member.setFriendOpen('N'); 
//			if(member.getBlindDateOpen()!='Y') member.setBlindDateOpen('N'); 
//			if(member.getSearchOpen()!='Y') member.setSearchOpen('N'); 
			member.setFriendOpen('N'); 
			member.setBlindDateOpen('N'); 
			member.setSearchOpen('N');
			
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
	
	@RequestMapping("/checkPhoneDuplicate.do")
	@ResponseBody
	public Map<String,Object> checkPhoneDuplicate(@RequestParam String userPhoneNumber){
		Map<String,Object> map = new HashMap<String, Object>();
		
		System.out.println("번호 중복체크:"+userPhoneNumber);
		Member m = new Member();
		m.setPhone(userPhoneNumber);
		
		boolean isUsable = memberService.selectOneMember(m)==null?true:false;
		logger.info("닉네임중복체크 : "+isUsable);
		map.put("isUsable", isUsable);
		
		return map;
	}
	
	@RequestMapping("/checkPwd.do")
	@ResponseBody
	public String checkPwd(@RequestParam("memberId") String memberId,
								@RequestParam("password") String password) {
		
		logger.info("회원 패스워드 체크 요청!");
		Member member =new Member();
		member.setMemberId(memberId);
		
		Member m = memberService.selectOneMember(member);
		
		boolean bool = bCryptPasswordEncoder.matches(password, m.getPassword());
		
		System.out.println(bool);
		String str = "";
		if(bool) {
			str = "success";
		}else {
			str = "fail";
		}
		
		return str;
	}
	
	@RequestMapping("/memberLogin.do")
	public String memberLogin(@RequestParam("memberId") String memberId,
								@RequestParam("password") String password,
								@RequestParam(value="autoLogin", required=false) String autoLogin,
							Model model,
							HttpSession session,
							HttpServletResponse response,
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
		            // 1. 로그인이 성공하면, 그 다음으로 로그인 폼에서 쿠키가 체크된 상태로 로그인 요청이 왔는지를 확인한다.
		            if ( autoLogin !=null ){ 
		                // 쿠키 사용한다는게 체크되어 있으면...
		                // 쿠키를 생성하고 현재 로그인되어 있을 때 생성되었던 세션의 id를 쿠키에 저장한다.
		                Cookie cookie = new Cookie("loginCookie", session.getId());
		                // 쿠키를 찾을 경로를 컨텍스트 경로로 변경해 주고...
		                cookie.setPath("/");
		                int amount = 60 * 60 * 24 * 7;
		                cookie.setMaxAge(amount); // 단위는 (초)임으로 7일정도로 유효시간을 설정해 준다.
		                // 쿠키를 적용해 준다.
		                response.addCookie(cookie);
		                 
		                // currentTimeMills()가 1/1000초 단위임으로 1000곱해서 더해야함
		                java.sql.Date sessionLimit = new java.sql.Date(System.currentTimeMillis() + (1000*amount));
		                System.out.println("sessionLimit="+sessionLimit);
		                // 현재 세션 id와 유효시간을 사용자 테이블에 저장한다.
		                memberService.keepLogin(member.getMemberId(), session.getId(), sessionLimit);
		            }
		                
					msg="로그인성공!"+m.getMemberName()+"님, 반갑습니다.";
					model.addAttribute("memberLoggedIn",m);
					
					Member test=(Member) session.getAttribute("memberLoggedIn");
					logger.info("member="+test); //null
					
					
				}else {
					msg="비밀번호가 틀렸습니다.";
				}
			}
				
	/*			String referer= request.getHeader("Referer");  //http://localhost/awesome/index
				String origin= request.getHeader("Origin"); // http://localhost (port)
				String url = request.getRequestURL().toString(); //url=http://localhost/awesome/member/memberLogin.do
				String uri = request.getRequestURI(); //uri=/awesome/member/memberLogin.do
	
				if(origin ==null) {
					origin = url.replace(uri, "");
				}
				
				loc = referer.replace(origin+request.getContextPath(),"");*/
			loc= "/index";
				
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
	public String memeberLogOut(SessionStatus sessionStatus,HttpSession session,
						HttpServletRequest request, HttpServletResponse response) {

		logger.info("회원 로그아웃 요청!");
		
		Member member = (Member) session.getAttribute("memberLoggedIn");
		
		if(session.getAttribute("memberLoggedIn")!=null) {
			session.removeAttribute("memberLoggedIn");
			session.invalidate();
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
            if ( loginCookie != null ){
                // null이 아니면 존재하면!
                loginCookie.setPath("/");
                // 쿠키는 없앨 때 유효시간을 0으로 설정하는 것 !!! invalidate같은거 없음.
                loginCookie.setMaxAge(0);
                // 쿠키 설정을 적용한다.
                response.addCookie(loginCookie);
                 
                // 사용자 테이블에서도 유효기간을 현재시간으로 다시 세팅해줘야함.
                java.sql.Date date = new java.sql.Date(System.currentTimeMillis());
                memberService.updateKeepLogin(member.getMemberId(), session.getId(), date);
            }
		}
		
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
						
						System.out.println("로그인 성공");
						msg="로그인성공!"+m.getMemberName()+"님, 반갑습니다.";
						model.addAttribute("memberLoggedIn",m);
						loc="/index";
						returnResult="common/msg";
					}
						
						/*String referer= request.getHeader("Referer");  //http://localhost/awesome/index
						String origin= request.getHeader("Origin"); // http://localhost (port)
						String url = request.getRequestURL().toString(); //url=http://localhost/awesome/member/memberLogin.do
						String uri = request.getRequestURI(); //uri=/awesome/member/memberLogin.do
			
						if(origin ==null) {
							origin = url.replace(uri, "");
						}
						
						loc = referer.replace(origin+request.getContextPath(),"");*/
						
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
						//loc="http://localhost/awesome/index";
						returnResult="redirect:/index";
					}else {
						msg="로그인성공!"+m.getMemberName()+"님, 반갑습니다.";
						model.addAttribute("memberLoggedIn",m);
						loc="/index";
						returnResult="common/msg";
					}
						
						/*String referer= request.getHeader("Referer");  //http://localhost/awesome/index
						String origin= request.getHeader("Origin"); // http://localhost (port)
						String url = request.getRequestURL().toString(); //url=http://localhost/awesome/member/memberLogin.do
						String uri = request.getRequestURI(); //uri=/awesome/member/memberLogin.do
			
						logger.info("naver Login="+referer+","+origin+","+url);
						if(origin ==null) {
							origin = url.replace(uri, "");
						}*/
					
						
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
		
	    
	    //문자 보내기
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
	    	
	    	HashMap<String, String> set = new HashMap<String, String>();
	    	set.put("to", userPhoneNumber); // 수신번호
	    	set.put("from", "01089721172"); // 발신번호
	    	set.put("text", "안녕하세요 awesome입니다. 인증번호는 [" + key + "] 입니다."); // 문자내용
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
	    		@RequestParam(value="phone",required=false) String phone,
	    		@RequestParam(value="memberName",required=false) String memberName,
	    		@RequestParam(value="enrollMemberId",required=false) String enrollMemberId,
	    		@CookieValue(value="JSESSIONID", required=false) Cookie jid,
	    						HttpServletRequest request) {

	    	String jsessionid="";
	    	
	    	System.out.println(authNum+","+phone+","+memberName+","+enrollMemberId);
	    	
	    	if(jid != null)
	    		jsessionid=jid.getValue();
	    	
	    	Map<String, String> map = new HashMap<>();
	    	map.put("jsessionid", jsessionid);
	    	map.put("sms", authNum);
	    	
	    	int result = memberService.chkSms(map);

	    	if(result!=0) {
	    		int delResult=memberService.deleteSms(map);
	    		
	    		
	    	//계정찾기
	    		if(phone!=null && memberName!=null && enrollMemberId==null) {
	    			Member member = new Member();
	    			member.setPhone(phone);
	    			member.setMemberName(memberName);
	    			member=memberService.selectOneMember(member);
	    			return member.getMemberId();	    			
	    		}
	    		
	    	//비밀번호 찾기
	    		if(phone!=null && memberName!=null && enrollMemberId!=null) {
	    			
	    			String mailResult=mailSending(enrollMemberId);
	    			System.out.println("메일 보내고 난후 "+mailResult);
	    			return mailResult;
	    		}
	    		
	    	//가입시에 문자인증
	    		return "success";
	    	}
	    	else return "fail";
	    }
	    
	    @ResponseBody
	    @RequestMapping(value = "/chkNamePhone.do", 
	    		method = RequestMethod.POST, 
	    		produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	    public String chkNamePhone(Member m,
	    			@CookieValue(value="JSESSIONID", required=false) Cookie jid){
	    	
	    	String result ="";
	    	
	    	System.out.println(m);
	    	
	    	Member member=memberService.selectOneMember(m);

	    	if(member !=null) {
	    		try {
					if("전송 성공".equals(sendSMS(member.getPhone(),jid,null)))
						result= "success";
				} catch (Exception e) {
					e.printStackTrace();
				}
	    	}
	    	else {
	    		result= "fail";
	    	}
	    	
	    	System.out.println(result);
	    	return result;
	    }
	    
	    @ResponseBody
	    @RequestMapping(value = "/VerifyRecaptcha", method = RequestMethod.POST)
	    public int verifyRecaptcha(HttpServletRequest request) {
	    	logger.info("google recaptcha!!!!!!!!!!!!!!!!!!!!!");
	       VerifyRecaptcha.setSecretKey("6LfzMK0UAAAAANGEUfhQ6WMnYWoAGvyjK7sYo_cj");
	        String gRecaptchaResponse = request.getParameter("recaptcha");
	        
	        System.out.println(gRecaptchaResponse);
	        //0 = 성공, 1 = 실패, -1 = 오류
	        try {
	            if(VerifyRecaptcha.verify(gRecaptchaResponse))
	                return 0;
	            else return 1;
	        } catch (IOException e) {
	            e.printStackTrace();
	            return -1;
	        }
	    }
	    
		// mailSending 임시비번 코드
		@RequestMapping("/mailSending.do")
		@ResponseBody
		public String mailSending(String email) {
			
			System.out.println("메일 발송");
			System.out.println(email);

			String setfrom = "AwesomeAdmin@awesome.com";
			String tomail = email; // 받는 사람 이메일
			String title = "안녕하세요 awsome 입니다."; // 제목
			
			Member member = new Member();
			String tempPwd = new TempKey().getKey(8); // 인증키 생성
			String encodedPwd = bCryptPasswordEncoder.encode(tempPwd);
			member.setPassword(encodedPwd);
			member.setMemberId(email);
			
			int result = memberService.updateMember(member,null);
			System.out.println("멤버 업데이트 후:"+result);
			String content = "임시비밀번호는 "+tempPwd+"입니다. 로그인 후 보안을 위해 암호을 변경하세요."; // 내용

			if(result==1) {
				try {
					MimeMessage message = mailSender.createMimeMessage();
					MimeMessageHelper messageHelper = new MimeMessageHelper(message,true, "UTF-8");
	
					messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
					messageHelper.setTo(tomail); // 받는사람 이메일
					messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
					messageHelper.setText(content); // 메일 내용
	
					mailSender.send(message);
				} catch (Exception e) {
					System.out.println(e);
				}
	
				return "success";
			}
			return "fail";
		}
		
		
		// mailSending 이메일 인증 코드
		@RequestMapping("/authMailSending.do")
		@ResponseBody
		public String authMailSending(String memberId,
				@CookieValue(value="JSESSIONID", required=false) Cookie jid) {

			String setfrom = "AwesomeAdmin@awesome.com";
			String tomail = memberId; // 받는 사람 이메일
			String title = "안녕하세요 awsome 입니다."; // 제목
			
	    	int result=0;
	    	String jsessionid="";
	    	String msg="";
			
			Member member = new Member();
			String key = new TempKey().getKey(4); // 인증키 생성
	    	
	    	if(jid != null)
	    		jsessionid=jid.getValue();
	    	
	    	Map<String, String> map = new HashMap<>();
	    	map.put("jsessionid", jsessionid);
	    	map.put("sms", key);
	    	
	    	result = memberService.insertSms(map);
			
			String content = "인증코드는  "+key+"입니다. 탈퇴을 진행하시려면 해당 코드을 입력하세요"; // 내용

			if(result==1) {
				try {
					MimeMessage message = mailSender.createMimeMessage();
					MimeMessageHelper messageHelper = new MimeMessageHelper(message,true, "UTF-8");
	
					messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
					messageHelper.setTo(tomail); // 받는사람 이메일
					messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
					messageHelper.setText(content); // 메일 내용
	
					mailSender.send(message);
				} catch (Exception e) {
					System.out.println(e);
				}
	
				return "success";
			}
			return "fail";
		}
}
