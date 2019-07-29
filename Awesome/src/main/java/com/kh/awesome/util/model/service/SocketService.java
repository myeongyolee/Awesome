package com.kh.awesome.util.model.service;

import java.util.List;
import java.util.Map;

import com.kh.awesome.util.model.vo.Alarm;
import com.kh.awesome.util.model.vo.Chat;

public interface SocketService {

	void insertChatLog(Map<String, String> info);

	List<Map<String, String>> selctChat(String mCode);

	List<Chat> selectMyChat(Map<String, String> map);

	void insertAlarmLog(Map<String, String> info);

	List<Alarm> selectAlarm(String mCode);

}
