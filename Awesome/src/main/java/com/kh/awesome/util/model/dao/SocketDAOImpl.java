package com.kh.awesome.util.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.awesome.util.model.vo.Chat;

@Repository
public class SocketDAOImpl implements SocketDAO{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertChatLog(Map<String, String> info) {
		sqlSession.insert("stomp.insertChatLog", info);
	}
	
	@Override
	public List<Map<String, String>> selectChat(String mCode) {
		return sqlSession.selectList("stomp.selectChat");
	}
	
	@Override
	public List<Chat> selectMyChat(Map<String, String> map) {
		return sqlSession.selectList("stomp.selectMyChat",map);
	}
	@Override
	public void insertAlarmLog(Map<String, String> info) {
		sqlSession.insert("stomp.insertAlarm", info);
	}
}
