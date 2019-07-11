package com.kh.awesome.member.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.awesome.member.model.vo.Address;
import com.kh.awesome.member.model.vo.Member;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertMember(Member member) {
		return sqlSession.insert("member.insertMember",member);
	}

	@Override
	public int insertAddress(Address address) {
		return sqlSession.insert("address.insertAddress",address);
	}

	@Override
	public int selectSms(Map<String, String> map) {
		return sqlSession.selectOne("member.selectSms",map);
	}
	
	@Override
	public int insertSms(Map<String, String> map) {
		return sqlSession.insert("member.insertSms",map);
	}

	@Override
	public int updateSms(Map<String, String> map) {
		return sqlSession.update("member.updateSms",map);
	}

	@Override
	public int deleteSms(Map<String, String> map) {
		return sqlSession.delete("member.deleteSms",map);
	}

	@Override
	public int chkSms(Map<String, String> map) {
		return sqlSession.selectOne("member.chkSms",map);
	}

	@Override
	public Member selectOneMember(Member m) {
		return sqlSession.selectOne("member.selectOneMember",m);
	}

	
}
