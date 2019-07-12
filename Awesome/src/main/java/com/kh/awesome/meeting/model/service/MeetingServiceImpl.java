package com.kh.awesome.meeting.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.awesome.meeting.model.dao.MeetingDAO;
import com.kh.awesome.member.model.vo.Member;

@Service
public class MeetingServiceImpl implements MeetingService{

	@Autowired
	private MeetingDAO mDAO;
	
	@Override
	public Map<String, String> selectRandomUser(Map<String,String> info) {
		return mDAO.selectRandomUser(info);
	}
	
	@Override
	public int insertBlindDate(Map<String,String> userMap) {
		return mDAO.insertBlindDate(userMap);
	}
	
	@Override
	public List<Map<String, String>> selectLikeMe(int memberCode) {
		return mDAO.selectLikeMe(memberCode);
	}
}
