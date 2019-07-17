package com.kh.awesome.club.model.service;

import java.util.List;
<<<<<<< HEAD
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.kh.awesome.club.model.vo.Club;
import com.kh.awesome.club.model.vo.Clubcontent;
import com.kh.awesome.club.model.vo.Clubmember;

public interface ClubService {

	List<Club> selectClubList(int cPage, int numPerPage);

	int totalclubCount();

	int insertClub(Club club);

	int insertClubAdmin(Club club);

	List<Clubmember> searchClubMemberList(int clubCode);

	Club selectOneClub(int clubCode);

	String searchClubAdmin(int memberCode);

	int insertclubContent1(Clubcontent clubcontent);

	List<Clubcontent> selectcontentList(int clubCode, int cPage, int numPerPage);

	Clubcontent selectClubcontentOne(int contentCode);
=======

import com.kh.awesome.club.model.vo.Club;

public interface ClubService {

	List<Club> selectClubList(int cPage, int numPerPage);

	int totalclubCount();
>>>>>>> refs/remotes/origin/jinwoo

}
