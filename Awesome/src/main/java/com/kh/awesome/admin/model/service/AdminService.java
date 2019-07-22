package com.kh.awesome.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.awesome.admin.model.vo.Report;

public interface AdminService {

	List<Map<String, String>> selectAllMembers(int cPage, int numPerPage);

	int selectTotalMemberNum();

	List<Map<String, String>> drawChart();

	List<String> selectCityList();

	List<Report> selectReportList(int memberCode);

	int insertReport(Report report);

}
