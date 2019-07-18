package com.kh.awesome.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

}
