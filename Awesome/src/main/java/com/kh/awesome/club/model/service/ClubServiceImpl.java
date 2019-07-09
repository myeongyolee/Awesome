package com.kh.awesome.club.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.awesome.club.model.dao.ClubDAO;
import com.kh.awesome.club.model.vo.Club;
import com.kh.awesome.club.model.vo.Clubmember;

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

	@Override
	public int insertClub(Club club) {
		return clubDAO.insertClub(club);
	}

	@Override
	public int insertClubAdmin(Club club) {
		return clubDAO.insertClubAdmin(club);
	}

	@Override
	public List<Clubmember> searchClubMemberList(int clubCode) {
		return clubDAO.searchClubMemberList(clubCode);
	}

	@Override
	public Club selectOneClub(int clubCode) {
		return clubDAO.selectOneClub(clubCode);
	}

	
	

}
