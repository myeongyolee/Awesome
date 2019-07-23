package com.kh.awesome.school.model.service;

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

}
