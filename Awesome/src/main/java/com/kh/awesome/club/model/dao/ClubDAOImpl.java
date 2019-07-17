package com.kh.awesome.club.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.awesome.club.model.vo.Club;

@Repository
public class ClubDAOImpl implements ClubDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<Club> selectClubList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds(numPerPage*(cPage-1), numPerPage);
		return sqlSession.selectList("selectClubList",null,rowBounds);
	}

	@Override
	public int totalclubCount() {
		return sqlSession.selectOne("totalclubCount");
	}

	
}
