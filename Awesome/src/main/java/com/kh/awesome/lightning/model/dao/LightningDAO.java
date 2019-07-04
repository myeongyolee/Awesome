package com.kh.awesome.lightning.model.dao;

import java.util.List;

import com.kh.awesome.matchManager.model.vo.MatchManager;

public interface LightningDAO {

	List<MatchManager> selectLightningList(char matchingType);

}
