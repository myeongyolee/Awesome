package com.kh.awesome.util.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.awesome.util.model.vo.Alarm;
import com.kh.awesome.util.model.vo.Chat;

public interface SocketDAO {

	void insertChatLog(Map<String, String> info);

	List<Map<String, String>> selectChat(String mCode);

	List<Chat> selectMyChat(Map<String, String> map);

	void insertAlarmLog(Map<String, String> info);

	List<Alarm> selectAlarm(String mCode);

}
