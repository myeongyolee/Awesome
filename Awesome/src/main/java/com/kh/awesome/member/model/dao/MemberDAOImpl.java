package com.kh.awesome.member.model.dao;

import java.sql.Date;
import java.util.HashMap;
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

	@Override
	public int updateMember(Member member) {
		return sqlSession.update("member.updateMember",member);
	}

	@Override
	public int updateAddress(Address address) {
		return sqlSession.update("address.updateAddress",address);
	}
	
	@Override
	public Address memberAddress(int memberCode) {
		return sqlSession.selectOne("address.memberAddress",memberCode);
	}

	@Override
    // 자동로그인 체크한 경우에 사용자 테이블에 세션과 유효시간을 저장하기 위한 메서드
    public void keepLogin(String memberId, String sessionId, Date next){
         
        Map<String, Object> map = new HashMap<String,Object>();
        map.put("memberId", memberId);
        map.put("sessionId", sessionId);
        map.put("next", next);
         
        // Mapper.xml로 데이터를 전달할 때 한 객체밖에 전달 못함으로 map으로 묶어서 보내줌 단... 주의할 점은
        // Mapper.xml 안에서 #{} 이 안에 지정한 이름이랑 같아야함.. 자동으로 매핑될 수 있도록
        // 아래가 수행되면서, 사용자 테이블에 세션id와 유효시간이 저장됨
        sqlSession.update("member.keepLogin",map);
         
    }
	
	@Override
    // 이전에 로그인한 적이 있는지, 즉 유효시간이 넘지 않은 세션을 가지고 있는지 체크한다.
    public Member checkUserWithSessionKey(String sessionId){
        // 유효시간이 남아있고(>now()) 전달받은 세션 id와 일치하는 사용자 정보를 꺼낸다.
        return sqlSession.selectOne("member.checkUserWithSessionKey",sessionId);
    }


	
}
