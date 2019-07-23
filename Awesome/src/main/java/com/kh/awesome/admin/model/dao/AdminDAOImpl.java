package com.kh.awesome.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.awesome.club.model.vo.Clubmember;
import com.kh.awesome.member.model.vo.Member;

@Repository
public class AdminDAOImpl implements AdminDAO {

 @Autowired
 SqlSession sqlSession;

@Override
public List<Map<String, String>> selectAllMembers(int cPage, int numPerPage) {
	RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
	return sqlSession.selectList("admin.selectAllMembers", null, rowBounds);
}

@Override
public int selectTotalMemberNum() {
	return sqlSession.selectOne("admin.selectTotalMemberNum");
}

@Override
public Member seeOneMember(int memberCode) {
	return sqlSession.selectOne("admin.seeOneMember", memberCode);
}
/*
@Override
public Clubmember seeClubJoined(int memberCode) {
	return sqlSession.selectOne("admin.seeClubJoined", memberCode);
}*/
 
 
 
 
 
 
 
}
