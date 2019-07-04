package com.kh.awesome.lightning.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.awesome.matchManager.model.vo.MatchManager;

@Repository
public class LightningDAOImpl implements LightningDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<MatchManager> selectLightningList(char matchingType) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectLightningList", matchingType);
	}

}
