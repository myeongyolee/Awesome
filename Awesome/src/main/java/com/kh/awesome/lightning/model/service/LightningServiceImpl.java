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
	public List<Map<String, Object>> selectLightningList(Map<String, String> search, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		return lightningDAO.selectLightningList(search, cPage, numPerPage);
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

	@Override
	public List<String> selectCityList() {
		// TODO Auto-generated method stub
		return lightningDAO.selectCityList();
	}

	@Override
	public List<Map<String, Object>> selectLocalList(int city) {
		// TODO Auto-generated method stub
		return lightningDAO.selectLocalList(city);
	}

	@Override
	public List<String> selectInterestingList() {
		// TODO Auto-generated method stub
		return lightningDAO.selectInterestingList();

	}

	@Override
	public List<Map<String, Object>> selectMyLightningList(int memberCode, int numPerPage, int cPage) {
		// TODO Auto-generated method stub
		return lightningDAO.selectMyLightningList(memberCode, numPerPage, cPage);
	}

	@Override
	public Map<String, Object> selectLightningMatch(int matchNo) {
		// TODO Auto-generated method stub
		return lightningDAO.selectLightningMatch(matchNo);
	}

	@Override
	public int updateLightning(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return lightningDAO.updateLightning(map);
	}

	@Override
	public int deleteLightning(int matchNo) {
		// TODO Auto-generated method stub
		return lightningDAO.deleteLightning(matchNo);
	}

	@Override
	public List<Integer> selectJoinMatchCode(int memberCode, int numPerPage, int cPage) {
		// TODO Auto-generated method stub
		return lightningDAO.selectJoinMatchCode(memberCode, numPerPage, cPage);
	}

	@Override
	public List<Map<String, Object>> selectJoinLightningList(List<Integer> matchCodeList) {
		// TODO Auto-generated method stub
		return lightningDAO.selectJoinLightningList(matchCodeList);
	}

	@Override
	public int insertMatchJoin(Map<String, Integer> map) {
		// TODO Auto-generated method stub
		return lightningDAO.insertMatchJoin(map);
	}

	@Override
	public List<Map<String, Object>> selectMyMatchJoinMemberList(Map<String, List<String>> param) {
		// TODO Auto-generated method stub
		return lightningDAO.selectMyMatchJoinMemberList(param);
	}

}
