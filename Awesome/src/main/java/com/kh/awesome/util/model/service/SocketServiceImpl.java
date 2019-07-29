package com.kh.awesome.util.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.awesome.util.model.dao.SocketDAO;
import com.kh.awesome.util.model.vo.Alarm;
import com.kh.awesome.util.model.vo.Chat;

@Service
public class SocketServiceImpl implements SocketService{

	@Autowired
	private SocketDAO socketDAO;


	@Override
	public void insertChatLog(Map<String, String> info) {
		socketDAO.insertChatLog(info);
	}
	
	@Override
	public List<Map<String, String>> selctChat(String mCode) {
		return socketDAO.selectChat(mCode);
	}
	@Override
	public List<Chat> selectMyChat(Map<String, String> map) {
		return socketDAO.selectMyChat(map);
	}
	@Override
	public void insertAlarmLog(Map<String, String> info) {
		socketDAO.insertAlarmLog(info); 
	}
	
	@Override
	public List<Alarm> selectAlarm(String mCode) {
		return socketDAO.selectAlarm(mCode);
	}
	
}
