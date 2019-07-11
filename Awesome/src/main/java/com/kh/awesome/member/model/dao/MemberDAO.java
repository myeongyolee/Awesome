package com.kh.awesome.member.model.dao;

import java.util.Map;

import com.kh.awesome.member.model.vo.Address;
import com.kh.awesome.member.model.vo.Member;

public interface MemberDAO {

	int insertMember(Member member);

	int insertAddress(Address address);

	Member selectOneMember(String memberId);

	int selectSms(Map<String, String> map);
	
	int insertSms(Map<String, String> map);

	int updateSms(Map<String, String> map);

	int deleteSms(Map<String, String> map);

	int chkSms(Map<String, String> map);

}
