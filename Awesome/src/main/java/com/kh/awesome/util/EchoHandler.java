package com.kh.awesome.util;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class EchoHandler extends TextWebSocketHandler{
	
	//전체 채팅
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		//Map
		//sessions.put(session.getId(),session);
		
		//List
		sessionList.add(session);
		
		//세션값을 불러온 0번째 중괄호에 session.getId()를 넣으라는 뜻
		logger.info("{} 연결됨",session.getId());
		
		logger.info("채팅방 입장:  "+session.getPrincipal().getName());
		
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message)throws Exception {
		
		logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
		
		//연결된 모든 클라이언트 개체에게 메세지 전송
		for(WebSocketSession sess: sessionList) {
			sess.sendMessage(new TextMessage(session.getPrincipal().getName()+"|"+message.getPayload()));
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
		//sessionList 삭제
		sessionList.remove(session);
		
		//Map 삭제
		//sessionList.remove(session.getId())
		
		logger.info("{} 연결끊김",session.getId());
	}

}
