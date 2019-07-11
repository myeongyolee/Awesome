package com.kh.awesome.club.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.awesome.club.model.vo.Club;
import com.kh.awesome.club.model.vo.Clubmember;

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

	@Override
	public int insertClub(Club club) {
		return sqlSession.insert("insertClub", club);
	}

	@Override
	public int insertClubAdmin(Club club) {
		return sqlSession.insert("insertClubAdmin",club);
	}

	@Override
	public List<Clubmember> searchClubMemberList(int clubCode) {
		return sqlSession.selectList("searchClubMemberList", clubCode);
	}

	@Override
	public Club selectOneClub(int clubCode) {
		return sqlSession.selectOne("club.selectOneClub",clubCode);
	}

	@Override
	public String searchClubAdmin(int memberCode) {
		return sqlSession.selectOne("searchClubAdmin",memberCode);
	}

	
	
	
}
