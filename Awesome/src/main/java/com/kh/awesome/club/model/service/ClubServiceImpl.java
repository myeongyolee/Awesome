package com.kh.awesome.club.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.awesome.club.model.dao.ClubDAO;
import com.kh.awesome.club.model.vo.Club;

@Service
public class ClubServiceImpl implements ClubService{
	
	@Autowired
	ClubDAO clubDAO;

	@Override
	public List<Club> selectClubList(int cPage, int numPerPage) {
		return clubDAO.selectClubList(cPage,numPerPage);
	}

	@Override
	public int totalclubCount() {
		return clubDAO.totalclubCount();
	}

}
