package com.kh.awesome.member.model.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import com.kh.awesome.member.model.vo.Address;
import com.kh.awesome.member.model.vo.Member;

public interface MemberService {

	int insertMember(Member member, Address address);

	Member selectOneMember(Member m);

	int insertSms(Map<String, String> map);

	int selectSms(Map<String, String> map);

	int deleteSms(Map<String, String> map);

	int chkSms(Map<String, String> map);


	Address memberAddress(int memberCode);

	//int updateMember(Member member);
	
	int updateMember(Member member, Address address);


    // 자동로그인 체크한 경우에 사용자 테이블에 세션과 유효시간을 저장하기 위한 메서드
    public void keepLogin(String memberId, String sessionId, Date next);
     
    // 이전에 로그인한 적이 있는지, 즉 유효시간이 넘지 않은 세션을 가지고 있는지 체크한다.
    public Member checkUserWithSessionKey(String sessionId);
	
	int deleteMember(Member member);

	void updateReason(int memberCode, String reason);

	void updateKeepLogin(String memberId, String sessionId, Date date);

}
