package com.kh.awesome.school.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.awesome.club.model.vo.Clubcontent;
import com.kh.awesome.club.model.vo.Clubphoto;

@Repository
public class SchoolDAOImpl implements SchoolDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insertSchool(Map<String, String> param) {
		
		return sqlSession.insert("school.insertSchool", param);
	}

	@Override
	public int checkSchool(String memberCode) {
		
		return sqlSession.selectOne("school.checkSchool", memberCode);
	}

	@Override
	public List<Map<String, String>> schoolList(int cPage, int numPerPage, List list) {
		
		RowBounds rowBounds = new RowBounds(numPerPage*(cPage-1), numPerPage);
		
		return sqlSession.selectList("school.schoolList", list, rowBounds);
		
	}

	@Override
	public List MySchoolIdCheck(String memberCode) {
		
		return sqlSession.selectList("school.MySchoolIdCheck", memberCode);
	}

	@Override
	public int totalContent(List list) {
		
		return sqlSession.selectOne("school.totalContent", list);
	}

	@Override
	public int makeSchoolEnd(Map<String, String> param) {
		
		return sqlSession.insert("school.makeSchoolEnd", param);
	}

	@Override
	public List<Map<String, String>> MyList(String memberCode) {
		
		return sqlSession.selectList("school.MyList", memberCode);
	}

	@Override
	public List<Map<String, String>> findPeople(int cPage, int numPerPage,Map<String, String> param) {
		
		RowBounds rowBounds = new RowBounds(numPerPage*(cPage-1), numPerPage);
		
		return sqlSession.selectList("school.findPeople", param, rowBounds);
	}

	@Override
	public int totalCountfindPeople(Map<String, String> param) {
		
		return sqlSession.selectOne("school.totalCountfindPeople", param);
	}

	@Override
	public List<Map<String, String>> selectSchoolOne(int clubCode) {
		
		return sqlSession.selectList("school.selectSchoolOne", clubCode);
	}

	@Override
	public int totalMemberCount(Map<String, Object> param) {
		
		return sqlSession.selectOne("school.totalMemberCount", param);
	}

	@Override
	public List<Map<String, String>> selectClubMember(Map<String, Object> param) {
		
		return sqlSession.selectList("school.selectClubMember", param);
	}

	@Override
	public List<Map<String, String>> schoolView(int clubCode, int cPage, int numPerPage) {
		
		RowBounds rowBounds = new RowBounds(numPerPage*(cPage-1), numPerPage);
		
		return sqlSession.selectList("school.schoolView", clubCode, rowBounds);
	}

	@Override
	public int totalClubContent(int clubCode) {
		
		return sqlSession.selectOne("school.totalClubContent", clubCode);
	}
	
	@Override
	public List AllContentCode(int clubCode) {
		
		return sqlSession.selectList("school.AllContentCode", clubCode);
	}

	@Override
	public List<Map<String, String>> schoolPhoto(List list) {
		
		return sqlSession.selectList("school.schoolPhoto", list);
	}

	@Override
	public int insertSchoolContent(Map<String, Object> param) {
		
		return sqlSession.insert("school.insertSchoolContent", param);
	}

	@Override
	public String checkClubSchool(Map<String, Object> param) {
		
		return sqlSession.selectOne("school.checkClubSchool", param);
	}

	@Override
	public String checkClubSchool2(Map<String, Object> param) {
		
		return sqlSession.selectOne("school.checkClubSchool2", param);
	}
	
	@Override
	public int enrollSchoolClub(Map<String, Object> param) {
		
		return sqlSession.insert("school.enrollSchoolClub", param);
	}

	@Override
	public List<Map<String,Object>> waitingList(Map<String, Object> param) {
		
		return sqlSession.selectList("school.waitingList", param);
	}

	@Override
	public int acceptMember(Map<String, Object> param) {
		
		return sqlSession.update("school.acceptMember", param);
	}

	@Override
	public List<Map<String, Object>> checkClubMember(Map<String, Object> param) {
		
		return sqlSession.selectList("school.checkClubMember", param);
	}

	@Override
	public int updateGrade(Map<String, Object> param) {
		
		return sqlSession.update("school.updateGrade", param);
	}

	@Override
	public List<Map<String, String>> searchMySchoolClub(Map<String, String> param) {
		
		return sqlSession.selectList("school.searchMySchoolClub", param);
	}

	@Override
	public int insertSchoolImg(Clubcontent clubcontent) {
		
		return sqlSession.insert("school.insertSchoolImg", clubcontent);
	}

	@Override
	public int insertSchoolImg2(Clubphoto c) {
		
		return sqlSession.insert("school.insertSchoolImg2", c);
	}

	@Override
	public Map<String, String> schoolContentView(Map<String, Integer> param) {
		
		return sqlSession.selectOne("school.schoolContentView", param);
	}

	@Override
	public int insertSchoolComment(Map<String, String> param) {
	
		return sqlSession.insert("school.insertSchoolComment", param);
	}

	@Override
	public List<Map<String,String>> schoolCommentList(int meetingcontentCode) {
		
		return sqlSession.selectList("school.schoolCommentList", meetingcontentCode);
	}

	@Override
	public Map<String, String> updateSchoolContent(int clubContentCode) {
		
		return sqlSession.selectOne("school.updateSchoolContent", clubContentCode);
	}

	@Override
	public int updateContentEnd(Map<String, Object> param) {
		
		return sqlSession.update("school.updateContentEnd", param);
	}

	@Override
	public int deleteSchoolContent(int clubContentCode) {
		
		return sqlSession.delete("school.deleteSchoolContent", clubContentCode);
	}

	@Override
	public Map<String, String> selectOneCalender(int clubCode) {
		
		return sqlSession.selectOne("school.selectOneCalender", clubCode);
	}

	@Override
	public int deleteCalender(int matchNo) {
		
		return sqlSession.delete("school.deleteCalender", matchNo);
	}

	@Override
	public int logoutClub(Map<String, Integer> param) {
		
		return sqlSession.delete("school.logoutClub", param);
	}

	@Override
	public int deleteSchoolContent2(Map<String, Integer> param) {
		
		return sqlSession.delete("school.deleteSchoolContent2", param);
	}



}
