package com.kh.awesome.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.awesome.admin.model.dao.AdminDAO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDAO adminDAO;

	@Override
	public List<Map<String, String>> selectAllMembers(int cPage, int numPerPage) {
		return adminDAO.selectAllMembers(cPage, numPerPage);
	}

	@Override
	public int selectTotalMemberNum() {
		return adminDAO.selectTotalMemberNum();
	}

	@Override
	public List<Map<String, String>> drawChart() {
		// TODO Auto-generated method stub
		return adminDAO.drawChart();
	}
	
	
	
}
