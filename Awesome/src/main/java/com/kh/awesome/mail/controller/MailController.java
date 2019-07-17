package com.kh.awesome.mail.controller;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.awesome.member.model.vo.Member;
import com.kh.awesome.sms.TempKey;

@Controller
public class MailController {
	
	@Autowired
	private JavaMailSender mailSender;

	// mailSending 코드
	@RequestMapping("/mailSending.do")
	public String mailSending(String email) {
		
		System.out.println("메일 발송");

		String setfrom = "yyongpall@gmail.com";
		String tomail = email; // 받는 사람 이메일
		String title = "안녕하세요 awsome 입니다."; // 제목
		
		Member member = new Member();
		String tempPwd = new TempKey().getKey(8); // 인증키 생성
		member.setPassword(tempPwd);
		member.setMemberId(email);
		
		
		String content = "임시비밀번호는 "+tempPwd+"입니다."; // 내용

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

		return "/index";
	}
}
