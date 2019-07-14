package com.kh.awesome.meeting.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MeetringDAOImpl implements MeetingDAO{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public Map<String, String> selectRandomUser(Map<String,String> info) {
		
		List<Map<String,String>> date_like = sqlSession.selectList("meeting.selectRandomUser",info);
		
		String showMember = "";
		for(int i=0;i<date_like.size();i++) {
			showMember += "'"+date_like.get(i).get("RECEIVCE_MEMBER_CODE")+"'";
			
			if(i != date_like.size()-1) showMember +=",";
		}
		info.put("showMember", showMember);
		info.put("rownum", date_like.size()+1+"");
		
		return sqlSession.selectOne("meeting.selectRandomUserEnd",info);
	}
	
	@Override
	public int insertBlindDate(Map<String,String> userMap) {
		return sqlSession.insert("meeting.insertBlindDate",userMap);
	}
	
	@Override
	public List<Map<String, String>> selectLikeMe(int memberCode) {
		List<Map<String,String>> receive = sqlSession.selectList("meeting.selectLikeMe", memberCode);
		String user = "";
		for(int i=0;i<receive.size();i++) {
			user += "'"+receive.get(i).get("RECEIVE_MEMBER_CODE")+"'";
			if(i != receive.size()-1) user += ",";
		}
		
		return sqlSession.selectList("meeting.selectLikeMeInfo", user);
	}
	
}
