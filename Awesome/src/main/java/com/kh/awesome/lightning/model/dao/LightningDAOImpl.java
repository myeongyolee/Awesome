package com.kh.awesome.lightning.model.dao;

import java.util.List;
import java.util.Map;

<<<<<<< HEAD
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.awesome.matchManager.model.vo.MatchManager;

@Repository
public class LightningDAOImpl implements LightningDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<Map<String, Object>> selectLightningList(Map<String, String> search, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		RowBounds rowBounds = new RowBounds(numPerPage*(cPage-1), numPerPage);
		
		return sqlSession.selectList("selectLightningList", search, rowBounds);
	}

	@Override
	public int insertLightning(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.insert("insertLightning", map);
	}

	@Override
	public List<Map<String, Object>> selectJoinMemberList(Map<String, List<String>> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectJoinMemberList", param);
	}

	@Override
	public List<String> selectCityList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectCityList");
	}

	@Override
	public List<Map<String, Object>> selectLocalList(int city) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectLocalList", city);
	}

	@Override
	public List<String> selectInterestingList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectInterestingList");
=======
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.awesome.matchManager.model.vo.MatchManager;

@Repository
public class LightningDAOImpl implements LightningDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<Map<String, String>> selectLightningList(char matchingType) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectLightningList", matchingType);
>>>>>>> refs/remotes/origin/jinwoo
	}

}
