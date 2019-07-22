package com.kh.awesome.member.model.service;

import java.sql.Date;
import java.util.Map;

import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.awesome.member.model.dao.MemberDAO;
import com.kh.awesome.member.model.exception.MemberException;
import com.kh.awesome.member.model.vo.Address;
import com.kh.awesome.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	
	@Autowired
	private MemberDAO memberDAO;

	@Override
	@Transactional(rollbackFor=Exception.class)
	public int insertMember(Member member, Address address) {
		int result =0;
		int memberCode =0;
		
		result = memberDAO.insertMember(member);
		if(result==0) throw new MemberException("회원등록 오류");
		
		//selectKey조회문을 통한 board키값 구하기	
		memberCode=member.getMemberCode();
		
		address.setMemberCode(memberCode);
		result = memberDAO.insertAddress(address);
		if(result==0) throw new MemberException("회원 주소등록 오류");
		
		return memberCode;
	}

	@Override
	public Member selectOneMember(Member m) {
		return memberDAO.selectOneMember(m);
	}

	/*
	 * 트랜잭션 처리시 정상처리여부는 RuntimeExcpetion이 발생했는지 여부이다.
	 * 그외 Exception을 처리 하려면, rollbackFor 속성에 해당 예외 클래스을 전달하면 된다.  
	 */
	@Override
	@Transactional(rollbackFor=Exception.class)
	public int insertSms(Map<String, String> map) {
		
		int result =0;
		
		int chkresult = memberDAO.selectSms(map);
		
		if(chkresult==0) result =memberDAO.insertSms(map);
		else result =memberDAO.updateSms(map);
		
		return result;
	}

	@Override
	public int selectSms(Map<String, String> map) {
		return memberDAO.selectSms(map);
	}

	@Override
	public int deleteSms(Map<String, String> map) {
		return memberDAO.deleteSms(map);
	}

	@Override
	public int chkSms(Map<String, String> map) {
		return memberDAO.chkSms(map);
	}

	@Override
	public Address memberAddress(int memberCode) {
		return memberDAO.memberAddress(memberCode);
	}

	/*
	 * 트랜잭션 처리시 정상처리여부는 RuntimeExcpetion이 발생했는지 여부이다.
	 * 그외 Exception을 처리 하려면, rollbackFor 속성에 해당 예외 클래스을 전달하면 된다.  
	 */
	@Override
	@Transactional(rollbackFor=Exception.class)
	public int updateMember(Member member, Address address) {
		int result =0;
		if(member!=null && address!=null) {
			if(member!=null && address.getAddress() !=null) {
				
				result =memberDAO.updateMember(member);
				
				if(result==0)
					throw new MemberException("회원 정보 수정 오류");
				
				if(result!=0)
					System.out.println("전전저너memberservice ="+address);
					address.setMemberCode(member.getMemberCode());
					System.out.println("후후후후후memberservice ="+address);
					result =memberDAO.updateAddress(address);
					
				if(result==0)
					throw new MemberException("회원 주소 정보 수정 오류");
				
				return result;
			//}else if(member ==null && address.getAddress() !=null ){
			}else if(address.getAddress() !=null){
				return memberDAO.updateAddress(address);
			}else {
				return memberDAO.updateMember(member);
			}
		}else {
			return memberDAO.updateMember(member);
		}
	}

	@Override
	public void keepLogin(String memberId, String sessionId, Date next) {
		memberDAO.keepLogin(memberId, sessionId, next);
	}

	@Override
	public Member checkUserWithSessionKey(String sessionId) {
		return memberDAO.checkUserWithSessionKey(sessionId);
	}

}
