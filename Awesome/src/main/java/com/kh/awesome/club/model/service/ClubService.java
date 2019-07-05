package com.kh.awesome.club.model.service;

import java.util.List;

import com.kh.awesome.club.model.vo.Club;

public interface ClubService {

	List<Club> selectClubList(int cPage, int numPerPage);

	int totalclubCount();

}
