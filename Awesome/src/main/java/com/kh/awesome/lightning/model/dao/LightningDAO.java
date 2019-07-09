package com.kh.awesome.lightning.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.awesome.matchManager.model.vo.MatchManager;

public interface LightningDAO {

	List<Map<String, Object>> selectLightningList(char matchingType, int cPage, int numPerPage);

	int insertLightning(Map<String, Object> map);

	List<Map<String, Object>> selectJoinMemberList(Map<String, List<String>> param);

}
