package com.kh.awesome.socket.stomp.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.awesome.socket.stomp.model.vo.ChatRoom;
import com.kh.awesome.socket.stomp.model.vo.Msg;

public interface StompDAO {

	String findChatIdByMemberId(Map<String, Integer> chatUser);

	void insertChatRoom(List<ChatRoom> list);

	List<Msg> findChatListByChatId(String chatId);

	void insertChatLog(Msg fromMessage);

	String codeToId(String memberCode);

}
