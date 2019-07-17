package com.kh.awesome.member.model.service;

import java.util.Map;

import com.kh.awesome.member.model.vo.Address;
import com.kh.awesome.member.model.vo.Member;

public interface MemberService {

	int insertMember(Member member, Address address);

	Member selectOneMember(String memberId);

	int insertSms(Map<String, String> map);

	int selectSms(Map<String, String> map);

	int deleteSms(Map<String, String> map);

	int chkSms(Map<String, String> map);


}
