package com.kh.awesome.club.model.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.awesome.club.model.dao.ClubDAO;
import com.kh.awesome.club.model.vo.Club;
import com.kh.awesome.club.model.vo.Clubcomment;
import com.kh.awesome.club.model.vo.Clubcontent;
import com.kh.awesome.club.model.vo.Clublocal;
import com.kh.awesome.club.model.vo.Clubmember;
import com.kh.awesome.club.model.vo.Clubphoto;

@Repository
public class ClubDAOImpl implements ClubDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<Club> selectClubList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds(numPerPage*(cPage-1), numPerPage);
		return sqlSession.selectList("selectClubList",null,rowBounds);
	}

	@Override
	public int totalclubCount() {
		return sqlSession.selectOne("totalclubCount");
	}

	@Override
	public int insertClub(Club club) {
		return sqlSession.insert("insertClub", club);
	}

	@Override
	public int insertClubAdmin(Club club) {
		return sqlSession.insert("insertClubAdmin",club);
	}

	@Override
	public List<Clubmember> searchClubMemberList(int clubCode) {
		return sqlSession.selectList("searchClubMemberList", clubCode);
	}

	@Override
	public Club selectOneClub(int clubCode) {
		return sqlSession.selectOne("club.selectOneClub",clubCode);
	}

	@Override
	public String searchClubAdmin(int memberCode) {
		return sqlSession.selectOne("searchClubAdmin",memberCode);
	}

	@Override
	public int insertclubContent1(Clubcontent clubcontent) {
		return sqlSession.insert("insertclubContent1",clubcontent);
	}

	@Override
	public List<Clubcontent> selectcontentList(int clubCode, int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds(numPerPage*(cPage-1), numPerPage);
		return sqlSession.selectList("selectcontentList",clubCode,rowBounds);
	}

	@Override
	public Clubcontent selectClubcontentOne(int contentCode) {
		return sqlSession.selectOne("selectClubcontentOne",contentCode);
	}

	@Override
	public int insertclubContent0(Clubcontent clubcontent) {
		return sqlSession.insert("insertclubContent0",clubcontent);
	}

	@Override
	public int insertClubLocal(Clublocal insertlocal) {
		return sqlSession.insert("insertclubLocal",insertlocal);
	}

	@Override
	public int insertClubCity(Clublocal insertcity) {
		return sqlSession.insert("insertclubCity",insertcity);
	}

	@Override
	public int insertclubContent2(Clubcontent clubcontent) {
		return sqlSession.insert("insertclubContent2",clubcontent);
	}

	@Override
	public int insertClubphoto(Clubphoto c) {
		return sqlSession.insert("insertClubphoto",c);
	}

	@Override
	public List<Clubcontent> selectphotocontentList(int clubCode) {
		return sqlSession.selectList("selectphotocontentList",clubCode);
	}

	@Override
	public int addComment(Clubcomment clubComment) {
		return sqlSession.insert("addComment",clubComment);
	}

	@Override
	public List<Clubcomment> selectBoardCommentByCode(Clubcomment clubComment) {
		return sqlSession.selectList("selectBoardCommentByCode", clubComment);
	}

	@Override
	public List<Clubcontent> selectseephotoList(int seephotoCode) {
		return sqlSession.selectList("selectseephotoList",seephotoCode);
	}

	

}
