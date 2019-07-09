package com.kh.awesome.lightning.model.dao;

import java.util.List;
import java.util.Map;

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
	public List<Map<String, Object>> selectLightningList(char matchingType, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		RowBounds rowBounds = new RowBounds(numPerPage*(cPage-1), numPerPage);
		
		return sqlSession.selectList("selectLightningList", matchingType, rowBounds);
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

}
