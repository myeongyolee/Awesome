package com.kh.awesome.randing;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.google.connect.GoogleOAuth2Template;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.awesome.member.model.vo.AuthInfo;
import com.kh.awesome.member.model.vo.NaverLoginBO;

@Controller
public class RandingController {
	
	//20190709 09:55 김용빈
	/* naver login */
		private NaverLoginBO naverLoginBO;
		private String apiResult = null;
		
		@Autowired
		private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
			this.naverLoginBO = naverLoginBO;
		}
	
	//20190706 23:22 김용빈
	/* google Login */
	 @Inject
	    private AuthInfo authInfo;
	    
	 @Autowired
	    private GoogleOAuth2Template googleOAuth2Template;
	    
	 @Autowired
	    private OAuth2Parameters googleOAuth2Parameters;
	 
	@RequestMapping("/index")
	public String index(HttpServletResponse response, Model model,HttpSession session) {
		
		//20190706 23:22 김용빈
		/* googleLogin */
	        //URL을 생성한다.
	        String url = googleOAuth2Template.buildAuthenticateUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
	        
	        System.out.println("/googleLogin, url : " + url);
	        model.addAttribute("google_url", url);
	        
		//20190709 09:55 김용빈
		/* naver Login */	        
	        //* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
	        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
	        //https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
	        //redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
	        System.out.println("/naverLogin, url : " + naverAuthUrl);
	        //네이버
	        model.addAttribute("naver_url", naverAuthUrl);
		
		return "/common/randing";
	}
	
	@RequestMapping("/indexAfter")
	public String indexAfter() {
		return "/common/loginAfter";
	}
}
