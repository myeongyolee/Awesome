package com.kh.awesome.map.model.dao;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MapDAOImpl implements MapDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String selectAddress(String memberCode) {
		
		return sqlSession.selectOne("map.selectAddress", memberCode);
	}

	@Override
	public List<Map<BigDecimal, BigDecimal>> findFriend(Map<String, String> param) {
		
		return sqlSession.selectList("map.findFriend", param);
	}

	@Override
	public List<Map<BigDecimal, BigDecimal>> selectMyAddress(String memberCode) {
		
		return sqlSession.selectList("map.selectMyAddress", memberCode);
	}

	@Override
	public int enrollInfoCheck(Map<String, String> param) {
		
		return sqlSession.update("map.enrollInfoCheck", param);
	}

	@Override
	public int enrollInteresting(Map<String, String> param) {
		
		return sqlSession.insert("map.enrollInteresting", param);
	}

	@Override
	public String checkInfo(String memberCode) {
		
		return sqlSession.selectOne("map.checkInfo", memberCode);
	}

	@Override
	public int sendFriend(Map<String, String> param) {
		
		return sqlSession.insert("map.sendFriend", param);
	}

	@Override
	public int checkFriend(Map<String, String> param) {
		
		return sqlSession.selectOne("map.checkFriend", param);
	}

}
