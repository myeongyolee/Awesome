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

	@Override
	public int sendFriend(Map<String, String> param) {
		int result;
		//친구목록테이블에 입력
		result = mapDAO.sendFriend(param);

		if(result>0) {
			String a = param.get("memberCode");
			param.put("type", "동네친구");
			param.put("content", a+"님이 동네친구요청을 보냈습니다.");
			//메세지테이블입력
			//ex)user(memberCode)님이 누구누구에게(friendCode) 친구요청을 보냈습니다
			result = mapDAO.sendMessage(param);
		}
	
		return result;
	}


}
