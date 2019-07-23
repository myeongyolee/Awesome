package com.kh.awesome.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.awesome.club.model.vo.Clubmember;
import com.kh.awesome.member.model.vo.Member;

public interface AdminService {

	List<Map<String, String>> selectAllMembers(int cPage, int numPerPage);

	int selectTotalMemberNum();

	Member seeOneMember(int memberCode);

	/*Clubmember seeClubJoined(int memberCode);*/

}
