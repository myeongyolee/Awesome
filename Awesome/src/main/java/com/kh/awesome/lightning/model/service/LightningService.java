package com.kh.awesome.lightning.model.service;

import java.util.List;
import java.util.Map;

import com.kh.awesome.matchManager.model.vo.MatchManager;

public interface LightningService {

	List<Map<String, String>> selectLightningList(char matchingType);

}
