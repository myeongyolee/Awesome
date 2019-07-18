package com.kh.awesome.meeting.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.awesome.member.model.vo.Member;

public interface MeetingDAO {

	Map<String, String> selectRandomUser(Map<String,String> info);

	int insertBlindDate(Map<String,String> userMap);

	List<Map<String, String>> selectLikeMe(int memberCode);

}
