package com.kh.awesome.map.model.service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.awesome.map.model.dao.MapDAO;

@Service
public class MapServiceImpl implements MapService {

	@Autowired
	private MapDAO mapDAO;
	
	@Override
	public List<Map<BigDecimal, BigDecimal>> selectAddress(String memberCode) {
		
		String center = mapDAO.selectAddress(memberCode);
		System.out.println("center@MapServiceImple:"+center);
		
		String strAddr[] = center.split("\\s");

		String result = strAddr[0]+" "+strAddr[1]+" "+strAddr[2]+" "+strAddr[3];
		System.out.println("result@MapServiceImpl:"+result);
		
		String searchCode = "Y";
		Map<String,String> param = new HashMap<String, String>();
		param.put("memberCode", memberCode);
		param.put("searchCode", searchCode);
		param.put("result", result);
		
		List<Map<BigDecimal,BigDecimal>> list = mapDAO.findFriend(param);
		System.out.println("list@MapServiceImpl:"+list);
		
		return list;
	}

	@Override
	public List<Map<BigDecimal, BigDecimal>> selectMyAddress(String memberCode) {
		
		return mapDAO.selectMyAddress(memberCode);
	}

	@Override
	public int enrollInfoCheck(Map<String, String> param) {
		
		return mapDAO.enrollInfoCheck(param);
	}

	@Override
	public int enrollInteresting(Map<String, String> param) {
		
		return mapDAO.enrollInteresting(param);
	}

	@Override
	public String checkInfo(String memberCode) {
		
		return mapDAO.checkInfo(memberCode);
	}


}
