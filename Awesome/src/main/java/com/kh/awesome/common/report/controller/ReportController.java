package com.kh.awesome.common.report.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.awesome.common.report.model.service.ReportService;
import com.kh.awesome.common.report.model.vo.Report;
import com.kh.awesome.member.model.vo.Member;

@Controller
public class ReportController {
	
	@Autowired
	ReportService reportService;
	
	@RequestMapping("/report.do")
	public String report(Report report, HttpSession session) {
//		Member member = (Member) session.getAttribute("memberLoggedIn");
//		int memberCode = member.getMemberCode();
//		report.setMemberCode(memberCode);
		int result = reportService.insertReport(report);
		
		return "";
	}
	
}
