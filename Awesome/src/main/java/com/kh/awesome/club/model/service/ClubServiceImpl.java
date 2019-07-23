package com.kh.awesome.club.model.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.awesome.club.model.dao.ClubDAO;
import com.kh.awesome.club.model.vo.Club;
import com.kh.awesome.club.model.vo.Clubcomment;
import com.kh.awesome.club.model.vo.Clubcontent;
import com.kh.awesome.club.model.vo.Clublocal;
import com.kh.awesome.club.model.vo.Clubmember;
import com.kh.awesome.club.model.vo.Clubphoto;

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

	@Override
	public String searchClubAdmin(int memberCode) {
		return clubDAO.searchClubAdmin(memberCode);
	}

	@Override
	public int insertclubContent1(Clubcontent clubcontent) {
		return clubDAO.insertclubContent1(clubcontent);
	}

	@Override
	public List<Clubcontent> selectcontentList(int clubCode, int cPage, int numPerPage) {
		return clubDAO.selectcontentList(clubCode,cPage,numPerPage);
	}

	@Override
	public Clubcontent selectClubcontentOne(int contentCode) {
		return clubDAO.selectClubcontentOne(contentCode);
	}

	@Override
	public int insertclubContent0(Clubcontent clubcontent) {
		return clubDAO.insertclubContent0(clubcontent);
	}

	@Override
	public int insertClubLocal(Clublocal insertlocal) {
		return clubDAO.insertClubLocal(insertlocal);
	}

	@Override
	public int insertClubCity(Clublocal insertcity) {
		return clubDAO.insertClubCity(insertcity);
	}

	@Override
	public int insertclubContent2(Clubcontent clubcontent) {
		return clubDAO.insertclubContent2(clubcontent);
	}

	@Override
	public int insertClubphoto(List<Clubphoto> clubphotoList) {
		int result = 0;
		if(clubphotoList.size()>0) {
			for(Clubphoto c:clubphotoList) {
				result = clubDAO.insertClubphoto(c);
			}
		}
		return result;
	}

	@Override
	public List<Clubcontent> selectphotocontentList(int clubCode) {
		return clubDAO.selectphotocontentList(clubCode);
	}

	@Override
	public int addComment(Clubcomment clubComment) {
		return clubDAO.addComment(clubComment);
	}

	@Override
	public List<Clubcomment> selectBoardCommentByCode(Clubcomment clubComment) {
		return clubDAO.selectBoardCommentByCode(clubComment);
	}

	@Override
	public List<Clubcontent> selectseephotoList(int seephotoCode) {
		return clubDAO.selectseephotoList(seephotoCode);
	}


	
}
