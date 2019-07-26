package com.kh.awesome.lightning.model.service;

import java.util.List;
import java.util.Map;

import com.kh.awesome.matchManager.model.vo.MatchManager;

public interface LightningService {

	List<Map<String, Object>> selectLightningList(Map<String, String> search, int cPage, int numPerPage);

	int insertLightning(Map<String, Object> map);

	List<Map<String, Object>> selectJoinMemberList(Map<String, List<String>> param);

	List<String> selectCityList();

	List<Map<String, Object>> selectLocalList(int city);

	List<String> selectInterestingList();

	List<Map<String, String>> selectMyLightningList(int memberCode, int numPerPage, int cPage);

	Map<String, String> selectLightningMatch(int matchNo);


}
