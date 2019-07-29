 package com.kh.awesome.util;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.awesome.member.model.vo.Member;
import com.kh.awesome.util.model.service.SocketService;

@Component
public class EchoHandler extends TextWebSocketHandler {
	
	@Autowired
	SocketService socketService;
	
	Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	//접속중인 유저 세션 리스트
	List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	//접속중인 유저 memberLoggedIn세션 저장 맵객체
	Map<String,Member> memberlist = new HashMap<>();

	// 클라이언트와 연결 이후에 실행되는 메서드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		
		Map<String,Object> memberCode = session.getAttributes();
		memberlist.put(session.getId(), ((Member)memberCode.get("memberLoggedIn")));
		logger.info("{} 연결됨", session.getId());
	}

	// 클라이언트가 서버로 메시지를 전송했을 때 실행되는 메서드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		//client단 기본 websocket은 
		logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
		
		//세션을 memberCode로 바꿔주는 메소드
		String sender = returnMemberCode(session);
		// m[1] : 메시지 받는 상대의 memberCode
		String[] m = message.getPayload().split("|");
		String receiveMemberCode = m[1];
		String realMessage ="";
		
		// | 이 포함된 메세지 대비 코드
		for(int i=2;i<m.length;i++) realMessage += m[i];
		
		Map<String,String> info = new HashMap<>();
		info.put("memberCode", sender);
		info.put("receiveMemberCode", receiveMemberCode);
		info.put("message", realMessage);
		
		if(m[0].equals("message")) {
			socketService.insertChatLog(info);
		}
		if(m[0].equals("alarm")) {
			socketService.insertAlarmLog(info);
		}
		
		
		for (WebSocketSession sess : sessionList) {
			// 웹소켓세션 정보 가져오기
			String memberCode = returnMemberCode(sess);
			
			// 받는사람이 세션에 존재하는 사람과 나에게 메시지 전송
			if(memberCode.equals(receiveMemberCode) || sess.getId().equals(session.getId())) {
				// ex) alrem | memberCode | realMessage 
				sess.sendMessage(new TextMessage(m[0]+"|"+sender +"|"+memberCode+ "|" + realMessage));
			}
		}
	}

	// 클라이언트와 연결을 끊었을 때 실행되는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		memberlist.remove(session.getId());
		logger.info("{} 연결 끊김", session.getId());
	}
	
	private String returnMemberCode(WebSocketSession session) {
		int mCode = memberlist.get(session.getId()).getMemberCode();
		return ""+mCode;
	}
}
