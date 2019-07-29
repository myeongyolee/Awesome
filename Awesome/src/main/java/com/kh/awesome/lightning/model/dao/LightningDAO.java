package com.kh.awesome.lightning.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.awesome.matchManager.model.vo.MatchManager;

public interface LightningDAO {

	List<Map<String, Object>> selectLightningList(Map<String, String> search, int cPage, int numPerPage);

	int insertLightning(Map<String, Object> map);

	List<Map<String, Object>> selectJoinMemberList(Map<String, List<String>> param);

	List<String> selectCityList();

	List<Map<String, Object>> selectLocalList(int city);

	List<String> selectInterestingList();

	List<Map<String, Object>> selectMyLightningList(int memberCode, int numPerPage, int cPage);

	Map<String, Object> selectLightningMatch(int matchNo);

	int updateLightning(Map<String, Object> map);

	int deleteLightning(int matchNo);

	List<String> selectJoinMatchCode(int memberCode, int numPerPage, int cPage);

	List<Map<String, Object>> selectJoinLightningList(Map<String,List<String>> param);

	int insertMatchJoin(Map<String, Integer> map);

	List<Map<String, Object>> selectMyMatchJoinMemberList(Map<String, List<String>> param);

	List<Map<String, Object>> selectMyMatchNoPermitMemberList(Map<String, List<String>> param);

	int updatePermit(Map map);

	int deleteNoPermit(Map map);

	int deleteJoinCancle(Map<String, Integer> param);

}
