package com.kh.awesome.school.model.dao;

import java.util.Map;

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

}
