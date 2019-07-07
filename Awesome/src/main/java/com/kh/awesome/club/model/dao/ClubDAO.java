package com.kh.awesome.club.model.dao;

import java.util.List;

import com.kh.awesome.club.model.vo.Club;

public interface ClubDAO {

	List<Club> selectClubList(int cPage, int numPerPage);

	int totalclubCount();

}
