package com.kh.awesome.map.model.dao;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public interface MapDAO {

	String selectAddress(String memberCode);

	List<Map<BigDecimal, BigDecimal>> findFriend(Map<String, String> param);

	List<Map<BigDecimal, BigDecimal>> selectMyAddress(String memberCode);

	int enrollInfoCheck(Map<String, String> param);

	int enrollInteresting(Map<String, String> param);

	String checkInfo(String memberCode);

	int sendFriend(Map<String, String> param);

	int checkFriend(Map<String, String> param);

	List<Integer> friendList(String memberCode);

	List<Integer> otherFriendList(Map param);

	List<Map<String, Object>> showMyFriend(List<String> list);

	int deleteFriend(Map<String, String> param);



}
