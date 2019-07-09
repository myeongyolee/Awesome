package com.kh.awesome.lightning.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.awesome.lightning.model.dao.LightningDAO;
import com.kh.awesome.matchManager.model.vo.MatchManager;

@Service
public class LightningServiceImpl implements LightningService {
	
	@Autowired
	private LightningDAO lightningDAO;
	
	@Override
	public List<Map<String, Object>> selectLightningList(char matchingType, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return lightningDAO.selectLightningList(matchingType, cPage, numPerPage);
	}

	@Override
	public int insertLightning(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return lightningDAO.insertLightning(map);
	}

	@Override
	public List<Map<String, Object>> selectJoinMemberList(Map<String, List<String>> param) {
		// TODO Auto-generated method stub
		return lightningDAO.selectJoinMemberList(param);
	}

}
