package com.kh.awesome.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.awesome.admin.model.dao.AdminDAO;
import com.kh.awesome.club.model.vo.Clubmember;
import com.kh.awesome.member.model.vo.Member;

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
	public Member seeOneMember(int memberCode) {
		return adminDAO.seeOneMember(memberCode);
	}

	/*@Override
	public Clubmember seeClubJoined(int memberCode) {
		return adminDAO.seeClubJoined(memberCode);
	}*/
	
	
	
}
