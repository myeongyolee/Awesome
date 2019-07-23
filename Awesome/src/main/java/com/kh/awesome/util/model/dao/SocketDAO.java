package com.kh.awesome.util.model.dao;

import java.util.List;
import java.util.Map;

public interface SocketDAO {

	void insertChatLog(Map<String, String> info);

	List<Map<String, String>> selectChat(String mCode);

}
