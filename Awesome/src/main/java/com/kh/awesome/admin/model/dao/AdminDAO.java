package com.kh.awesome.admin.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.awesome.admin.model.vo.Report;
import com.kh.awesome.club.model.vo.Clubmember;
import com.kh.awesome.member.model.vo.Member;

public interface AdminDAO {

	List<Map<String, String>> selectAllMembers(int cPage, int numPerPage);

	int selectTotalMemberNum();

	List<Map<String, String>> drawChart();

	List<String> selectCityList();

	List<Report> selectReportList(int memberCode);

	int insertReport(Report report);

	Member seeOneMember(int memberCode);

/*	Clubmember seeClubJoined(int memberCode);*/


}
