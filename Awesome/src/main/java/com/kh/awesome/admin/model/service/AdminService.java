package com.kh.awesome.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.awesome.admin.model.vo.Report;
import com.kh.awesome.board.model.vo.QuestionComment;
import com.kh.awesome.club.model.vo.Clubmember;
import com.kh.awesome.member.model.vo.Member;

public interface AdminService {

	List<Map<String, String>> selectAllMembers(int cPage, int numPerPage);

	int selectTotalMemberNum();

	List<Map<String, String>> drawChart();

	List<String> selectCityList();

	List<Report> selectReportList(int memberCode);

	int insertReport(Report report);

	Map<String, Object> seeOneMember(int memberCode);

	List<Map<String, Object>> searchPpl(Map<String, String> search, int cPage, int numPerPage);

	String seeClubJoined(int memberCode);

	
}
