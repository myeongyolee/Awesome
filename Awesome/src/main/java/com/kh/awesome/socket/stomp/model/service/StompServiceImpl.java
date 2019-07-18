package com.kh.awesome.socket.stomp.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.awesome.socket.stomp.model.dao.StompDAO;
import com.kh.awesome.socket.stomp.model.vo.ChatRoom;
import com.kh.awesome.socket.stomp.model.vo.Msg;

@Service
public class StompServiceImpl implements StompService{

	@Autowired
	StompDAO stompDAO;
	
	@Override
	public String findChatIdByMemberId(Map<String,Integer> chatUser) {
		return stompDAO.findChatIdByMemberId(chatUser);
	}
	@Override
	public void insertChatRoom(List<ChatRoom> list) {
		stompDAO.insertChatRoom(list) ;
	}
	@Override
	public List<Msg> findChatListByChatId(String chatId) {
		return stompDAO.findChatListByChatId(chatId);
	}
	@Override
	public void insertChatLog(Msg fromMessage) {
		stompDAO.insertChatLog(fromMessage);
	}
	
	@Override
	public String codeToId(int memberCode) {
		return stompDAO.codeToId(memberCode);
	}
}
