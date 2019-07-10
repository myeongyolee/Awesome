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


}
