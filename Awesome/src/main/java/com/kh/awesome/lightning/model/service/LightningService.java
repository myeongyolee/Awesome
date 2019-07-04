package com.kh.awesome.lightning.model.service;

import java.util.List;

import com.kh.awesome.matchManager.model.vo.MatchManager;

public interface LightningService {

	List<MatchManager> selectLightningList(char matchingType);

}
