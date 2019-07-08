package com.kh.awesome.lightning.model.service;

import java.util.List;
import java.util.Map;

import com.kh.awesome.matchManager.model.vo.MatchManager;

public interface LightningService {

	List<Map<String, Object>> selectLightningList(char matchingType, int cPage, int numPerPage);

	int insertLightning(Map<String, Object> map);

}
