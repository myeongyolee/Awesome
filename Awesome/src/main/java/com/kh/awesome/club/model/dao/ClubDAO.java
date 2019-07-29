package com.kh.awesome.club.model.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.kh.awesome.club.model.vo.Club;
import com.kh.awesome.club.model.vo.Clubcomment;
import com.kh.awesome.club.model.vo.Clubcontent;
import com.kh.awesome.club.model.vo.Clublocal;
import com.kh.awesome.club.model.vo.Clubmember;
import com.kh.awesome.club.model.vo.Clubphoto;

public interface ClubDAO {

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


	int insertclubContent0(Clubcontent clubcontent);

	int insertClubLocal(Clublocal insertlocal);

	int insertClubCity(Clublocal insertcity);

	int insertclubContent2(Clubcontent clubcontent);

	int insertClubphoto(Clubphoto c);

	List<Clubcontent> selectphotocontentList(int clubCode);

	int addComment(Clubcomment clubComment);

	List<Clubcomment> selectBoardCommentByCode(Clubcomment clubComment);

	List<Clubcontent> selectseephotoList(int seephotoCode);

}
