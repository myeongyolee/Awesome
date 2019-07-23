package com.kh.awesome.util.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.awesome.util.model.dao.SocketDAO;

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
	
}
