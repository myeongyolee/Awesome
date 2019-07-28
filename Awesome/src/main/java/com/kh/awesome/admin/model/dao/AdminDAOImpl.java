package com.kh.awesome.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.awesome.admin.model.vo.Report;
import com.kh.awesome.board.model.vo.QuestionComment;
import com.kh.awesome.club.model.vo.Clubmember;
import com.kh.awesome.member.model.vo.Member;

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
	public List<Map<String, String>> drawChart() {
		List<Map<String, String>> chartMap = new ArrayList<>();
		Map<String, String> memberChart = new HashMap<>();
		Map<String, String> memberAgeChart = new HashMap<>();
		Map<String, String> matchChart = new HashMap<>();
		Map<String, String> clubChart = new HashMap<>();
		
		String memberAllCnt = sqlSession.selectOne("admin.memberAllCnt");
		memberChart.put("memberAllCnt", memberAllCnt);
		String memberMaleCnt = sqlSession.selectOne("admin.memberMaleCnt");
		memberChart.put("memberMaleCnt", memberMaleCnt);
		String memberFemaleCnt = sqlSession.selectOne("admin.memberFemaleCnt");
		memberChart.put("memberFemaleCnt", memberFemaleCnt);
		
		String member20 = sqlSession.selectOne("admin.member20");
		memberAgeChart.put("member20", member20);
		String member30 = sqlSession.selectOne("admin.member30");
		memberAgeChart.put("member30", member30);
		String member40 = sqlSession.selectOne("admin.member40");
		memberAgeChart.put("member40", member40);
		
		String matchAllCnt = sqlSession.selectOne("admin.matchAllCnt");
		matchChart.put("matchAllCnt", matchAllCnt);
		List<Map<String, String>> matchChartList = sqlSession.selectList("admin.matchCnt");
		for(Map<String, String> map : matchChartList) {
			matchChart.put(map.get("cityName"), String.valueOf(map.get("count")));
		}
		
		String clubAllCnt = sqlSession.selectOne("admin.clubAllCnt");
		clubChart.put("clubAllCnt", clubAllCnt);
		List<Map<String, String>> clubChartList = sqlSession.selectList("admin.clubCnt");
		for(Map<String, String> map : clubChartList) {
			clubChart.put(map.get("cityName"), String.valueOf(map.get("count")));
		}
		
		chartMap.add(memberChart);
		chartMap.add(memberAgeChart);
		chartMap.add(matchChart);
		chartMap.add(clubChart);
		return chartMap;
	}

	@Override
	public List<String> selectCityList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("admin.selectCityList");
	}

	@Override
	public List<Report> selectReportList(int memberCode) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("admin.selectReportList", memberCode);
	}

	@Override
	public int insertReport(Report report) {
		// TODO Auto-generated method stub
		return sqlSession.insert("admin.insertReport", report);
	}


	@Override
	public Map<String, Object> seeOneMember(int memberCode) {
		return sqlSession.selectOne("admin.seeOneMember", memberCode);
	}
	
	@Override
	public String seeClubJoined(int memberCode) {
		return sqlSession.selectOne("admin.seeClubJoined", memberCode);
	}

	@Override
	public List<Map<String, Object>> searchPpl(Map<String, String> search, int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds(numPerPage*(cPage-1), numPerPage);
		System.out.println("search@DAOimpl== " + search);
		return sqlSession.selectList("admin.searchPplList", search, rowBounds);
	}

	@Override
	public Map<String, Object> seeHotPpl(int hottestM) {
		return sqlSession.selectOne("admin.seeHotPpl", hottestM);
	}

	@Override
	public int hottestOne() {
		return sqlSession.selectOne("admin.getHottestM");
	}

	
 
 
 
 
 
 
 
}

