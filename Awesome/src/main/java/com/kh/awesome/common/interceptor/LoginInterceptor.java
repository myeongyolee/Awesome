package com.kh.awesome.common.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.kh.awesome.member.model.service.MemberService;
import com.kh.awesome.member.model.vo.Member;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private MemberService memberService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
		
			if(memberLoggedIn == null) { // 로그인된 세션이 없는 경우...
				// 우리가 만들어 논 쿠키를 꺼내온다.
	            Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
	            if ( loginCookie != null ){ // 쿠키가 존재하는 경우(이전에 로그인때 생성된 쿠키가 존재한다는 것)
	                // loginCookie의 값을 꺼내오고 -> 즉, 저장해논 세션Id를 꺼내오고
	                String sessionId = loginCookie.getValue();
	                System.out.println("interceprt@sessionId="+sessionId);
	                // 세션Id를 checkUserWithSessionKey에 전달해 이전에 로그인한적이 있는지 체크하는 메서드를 거쳐서
	                // 유효시간이 > now() 인 즉 아직 유효시간이 지나지 않으면서 해당 sessionId 정보를 가지고 있는 사용자 정보를 반환한다.
	                Member member = memberService.checkUserWithSessionKey(sessionId);
	                 
	                if ( member != null ){ // 그런 사용자가 있다면
	                    // 세션을 생성시켜 준다.
	                    session.setAttribute("memberLoggedIn", member);
	                    //return super.preHandle(request, response, handler);
	                }
	            }
				
//				String referer= request.getHeader("Referer");
//				String origin= request.getHeader("Origin"); // http://localhost:9090
//				String url = request.getRequestURL().toString();
//				String uri = request.getRequestURI();
//				
//	//			System.out.println("referer="+referer);
//	//			System.out.println("Origin="+origin);
//	//			System.out.println("url="+url);
//	//			System.out.println("uri="+uri);
//				
//					if(origin ==null) {
//						origin = url.replace(uri, "");
//					}
//				
//				String loc = referer.replace(origin+request.getContextPath(),"");
//				
//				request.setAttribute("msg", "로그인 후 이용할수 있습니다.");
//				request.setAttribute("loc", loc);
//				request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp")
//						.forward(request, response);
//				
//				return false;
			}
			
			//항상 true을 리턴한다.
			return super.preHandle(request, response, handler);
	}
}
