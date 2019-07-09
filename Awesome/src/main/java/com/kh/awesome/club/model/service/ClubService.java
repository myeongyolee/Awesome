package com.kh.awesome.club.model.service;

import java.util.List;
import java.util.Map;

import com.kh.awesome.club.model.vo.Club;
import com.kh.awesome.club.model.vo.Clubmember;

public interface ClubService {

	List<Club> selectClubList(int cPage, int numPerPage);

	int totalclubCount();

	int insertClub(Club club);

	int insertClubAdmin(Club club);

	List<Clubmember> searchClubMemberList(int clubCode);

	Club selectOneClub(int clubCode);

}
