package com.kh.awesome.socket.stomp.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.awesome.socket.stomp.model.vo.ChatRoom;
import com.kh.awesome.socket.stomp.model.vo.Msg;

@Repository
public class StompDAOImpl implements StompDAO{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public String findChatIdByMemberId(Map<String,Integer> chatUser) {
		return sqlSession.selectOne("stomp.findChatIdByMemberId",chatUser);
	}
	
	@Override
	public void insertChatRoom(List<ChatRoom> list) {
		sqlSession.insert("stomp.insertChat", list);
	}
	
	@Override
	public List<Msg> findChatListByChatId(String chatId) {
		return sqlSession.selectList("stomp.findChatListByChatId",chatId);
	}
	
	@Override
	public void insertChatLog(Msg fromMessage) {
		sqlSession.insert("stomp.insertChatLog",fromMessage);
	}
	
	@Override
	public String codeToId(int memberCode) {
		return sqlSession.selectOne("stomp.codeToId", memberCode);
	}
	
}
