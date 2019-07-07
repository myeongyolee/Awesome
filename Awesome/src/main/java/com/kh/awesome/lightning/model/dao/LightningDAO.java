package com.kh.awesome.lightning.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.awesome.matchManager.model.vo.MatchManager;

public interface LightningDAO {

	List<Map<String, String>> selectLightningList(char matchingType);

	int insertLightning(MatchManager matchManager);

}
