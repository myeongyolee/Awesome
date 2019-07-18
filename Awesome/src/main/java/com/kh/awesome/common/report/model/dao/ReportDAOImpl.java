package com.kh.awesome.common.report.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.awesome.common.report.model.vo.Report;

@Repository
public class ReportDAOImpl implements ReportDAO {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public int insertReport(Report report) {
		return sqlSession.insert("insertReport", report);
	}
	
}
