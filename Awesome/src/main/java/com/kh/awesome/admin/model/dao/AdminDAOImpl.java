package com.kh.awesome.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
public Map<String, Integer> memberStatistics() {
	// TODO Auto-generated method stub
	return sqlSession.selectOne("admin.memberStatistics");
}

@Override
public Map<String, Integer> matchStatistics() {
	// TODO Auto-generated method stub
	return sqlSession.selectOne("admin.matchStatistics");
}

@Override
public Map<String, Integer> clubStatistics() {
	// TODO Auto-generated method stub
	return sqlSession.selectOne("admin.clubStatistics");
}
 
 
 
 
 
 
 
}
