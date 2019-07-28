package com.kh.awesome.school.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.awesome.school.model.dao.SchoolDAO;

@Service
public class SchoolServiceImpl implements SchoolService {

	@Autowired
	private SchoolDAO schoolDAO;
	
	@Override
	public int insertSchool(Map<String, String> param) {
		
		return schoolDAO.insertSchool(param);
	}

	@Override
	public int checkSchool(String memberCode) {
		
		return schoolDAO.checkSchool(memberCode);
	}

	@Override
	public List<Map<String, String>> schoolList(int cPage, int numPerPage, List list) {
		
		return schoolDAO.schoolList(cPage, numPerPage, list);
	}

	@Override
	public List MySchoolIdCheck(String memberCode) {
		
		return schoolDAO.MySchoolIdCheck(memberCode);
	}

	@Override
	public int totalContent(List list) {
		
		return schoolDAO.totalContent(list);
	}

	@Override
	public int makeSchoolEnd(Map<String, String> param) {
		
		return schoolDAO.makeSchoolEnd(param);
	}

	@Override
	public List<Map<String, String>> MyList(String memberCode) {
		
		return schoolDAO.MyList(memberCode);
	}

	@Override
	public List<Map<String, String>> findPeople(int cPage, int numPerPage, Map<String, String> param) {
		
		return schoolDAO.findPeople(cPage, numPerPage, param);
	}

	@Override
	public int totalCountfindPeople(Map<String, String> param) {
		
		return schoolDAO.totalCountfindPeople(param);
	}



}
