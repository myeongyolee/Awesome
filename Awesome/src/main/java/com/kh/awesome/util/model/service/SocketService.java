package com.kh.awesome.util.model.service;

import java.util.List;
import java.util.Map;

public interface SocketService {

	void insertChatLog(Map<String, String> info);

	List<Map<String, String>> selctChat(String mCode);

}
