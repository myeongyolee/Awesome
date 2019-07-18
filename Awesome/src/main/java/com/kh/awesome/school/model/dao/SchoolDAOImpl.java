package com.kh.awesome.school.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SchoolDAOImpl implements SchoolDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insertSchool(Map<String, String> param) {
		
		return sqlSession.insert("school.insertSchool", param);
	}

	@Override
	public int checkSchool(String memberCode) {
		
		return sqlSession.selectOne("school.checkSchool", memberCode);
	}

	@Override
	public List<Map<String, String>> schoolList(int cPage, int numPerPage, List list) {
		
		RowBounds rowBounds = new RowBounds(numPerPage*(cPage-1), numPerPage);
		
		return sqlSession.selectList("school.schoolList", list, rowBounds);
		
	}

	@Override
	public List MySchoolIdCheck(String memberCode) {
		
		return sqlSession.selectList("school.MySchoolIdCheck", memberCode);
	}

	@Override
	public int totalContent(List list) {
		
		return sqlSession.selectOne("school.totalContent", list);
	}

	@Override
	public int makeSchoolEnd(Map<String, String> param) {
		
		return sqlSession.insert("school.makeSchoolEnd", param);
	}

	@Override
	public List<Map<String, String>> MyList(String memberCode) {
		
		return sqlSession.selectList("school.MyList", memberCode);
	}

	@Override
	public List<Map<String, String>> findPeople(int cPage, int numPerPage,Map<String, String> param) {
		
		RowBounds rowBounds = new RowBounds(numPerPage*(cPage-1), numPerPage);
		
		return sqlSession.selectList("school.findPeople", param, rowBounds);
	}

	@Override
	public int totalCountfindPeople(Map<String, String> param) {
		
		return sqlSession.selectOne("school.totalCountfindPeople", param);
	}

}
