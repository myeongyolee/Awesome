package com.kh.awesome.map.model.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public interface MapService {

	List<Map<BigDecimal, BigDecimal>> selectAddress(String memberCode);

	List<Map<BigDecimal, BigDecimal>> selectMyAddress(String memberCode);

	int enrollInfoCheck(Map<String, String> param);

	int enrollInteresting(Map<String, String> param);

	String checkInfo(String memberCode);


}
