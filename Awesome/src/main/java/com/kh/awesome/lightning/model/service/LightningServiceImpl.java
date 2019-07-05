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
	public List<Map<String, String>> selectLightningList(char matchingType) {
		// TODO Auto-generated method stub
		return lightningDAO.selectLightningList(matchingType);
	}

}
