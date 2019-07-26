package com.kh.awesome.map.model.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.codehaus.plexus.logging.Logger;
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

		return mapDAO.sendFriend(param);
	}

	@Override
	public int checkFriend(Map<String, String> param) {
		
		return mapDAO.checkFriend(param);
	}

	@Override
	public List<Integer> friendList(String memberCode) {
		List<Integer> list = new ArrayList<Integer>();
		
		list = mapDAO.friendList(memberCode); // 내가 친구요청보낸 친구목록
		
		Map param = new HashMap<>();
		param.put("list", list);
		param.put("memberCode", memberCode);
		
		if(list.size() != 0) {
			System.out.println("@@@@@@@@@@@@@ 내가 친구요청보낸적이 있다! @@@@@@@@@@@@@");
			list = mapDAO.otherFriendList(param); // 내가 친구요청보낸 친구목록의 친구들이 나에게 친구요청 수락했는지 여부 확인
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> showMyFriend(List<String> list) {
		
		return mapDAO.showMyFriend(list);
	}

	@Override
	public int deleteFriend(Map<String, String> param) {
		
		return mapDAO.deleteFriend(param);
	}


}
