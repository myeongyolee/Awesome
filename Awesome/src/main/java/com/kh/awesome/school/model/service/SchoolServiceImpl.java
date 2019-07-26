package com.kh.awesome.school.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.awesome.club.model.vo.Clubcontent;
import com.kh.awesome.club.model.vo.Clubphoto;
import com.kh.awesome.school.model.dao.SchoolDAO;

@Service
public class SchoolServiceImpl implements SchoolService {

	@Autowired
	private SchoolDAO schoolDAO;
	
	@Override
	public int insertSchool(Map<String, String> param) {
		
		return schoolDAO.insertSchool(param);
	}

	@Override
	public int checkSchool(String memberCode) {
		
		return schoolDAO.checkSchool(memberCode);
	}

	@Override
	public List<Map<String, String>> schoolList(int cPage, int numPerPage, List list) {
		
		return schoolDAO.schoolList(cPage, numPerPage, list);
	}

	@Override
	public List MySchoolIdCheck(String memberCode) {
		
		return schoolDAO.MySchoolIdCheck(memberCode);
	}

	@Override
	public int totalContent(List list) {
		
		return schoolDAO.totalContent(list);
	}

	@Override
	public int makeSchoolEnd(Map<String, String> param) {
		
		return schoolDAO.makeSchoolEnd(param);
	}

	@Override
	public List<Map<String, String>> MyList(String memberCode) {
		
		return schoolDAO.MyList(memberCode);
	}

	@Override
	public List<Map<String, String>> findPeople(int cPage, int numPerPage, Map<String, String> param) {
		
		return schoolDAO.findPeople(cPage, numPerPage, param);
	}

	@Override
	public int totalCountfindPeople(Map<String, String> param) {
		
		return schoolDAO.totalCountfindPeople(param);
	}

	@Override
	public List<Map<String, String>> selectSchoolOne(int clubCode) {
		
		return schoolDAO.selectSchoolOne(clubCode);
	}

	@Override
	public int totalMemberCount(Map<String, Object> param) {
		
		return schoolDAO.totalMemberCount(param);
	}

	@Override
	public List<Map<String, String>> selectClubMember(Map<String, Object> param) {
		
		return schoolDAO.selectClubMember(param);
	}

	@Override
	public List<Map<String, String>> schoolView(int clubCode, int cPage, int numPerPage) {
		
		return schoolDAO.schoolView(clubCode, cPage, numPerPage);
	}

	@Override
	public int totalClubContent(int clubCode) {
		
		return schoolDAO.totalClubContent(clubCode);
	}
	
	@Override
	public List AllContentCode(int clubCode) {
		
		return schoolDAO.AllContentCode(clubCode);
	}

	@Override
	public List<Map<String, String>> schoolPhoto(List list) {
		
		return schoolDAO.schoolPhoto(list);
	}

	@Override
	public int insertSchoolContent(Map<String, Object> param) {
		
		return schoolDAO.insertSchoolContent(param);
	}

	@Override
	public String checkClubSchool(Map<String, Object> param) {
		String result;
		
		result = schoolDAO.checkClubSchool(param);
		
		if(!result.equals("0")) {
			String str = schoolDAO.checkClubSchool2(param);
			result = str;
		}
		
		return result;
	}

	@Override
	public int enrollSchoolClub(Map<String, Object> param) {
		
		return schoolDAO.enrollSchoolClub(param);
	}

	@Override
	public List<Map<String,Object>> waitingList(Map<String, Object> param) {
		
		return schoolDAO.waitingList(param);
	}

	@Override
	public int acceptMember(Map<String, Object> param) {
		
		return schoolDAO.acceptMember(param);
	}

	@Override
	public List<Map<String, Object>> checkClubMember(Map<String, Object> param) {
		
		return schoolDAO.checkClubMember(param);
	}

	@Override
	public int updateGrade(Map<String, Object> param) {
		
		return schoolDAO.updateGrade(param);
	}

	@Override
	public List<Map<String, String>> searchMySchoolClub(Map<String, String> param) {
		
		return schoolDAO.searchMySchoolClub(param);
	}

	@Override
	public int insertSchoolImg(Clubcontent clubcontent) {
		
		return schoolDAO.insertSchoolImg(clubcontent);
	}

	@Override
	public int insertSchoolImg2(List<Clubphoto> clubphotoList) {
		int result = 0;
		if(clubphotoList.size()>0) {
			for(Clubphoto c:clubphotoList) {
				result = schoolDAO.insertSchoolImg2(c);
			}
		}
		return result;
	}

	@Override
	public Map<String, String> schoolContentView(Map<String, Integer> param) {
		
		return schoolDAO.schoolContentView(param);
	}

	@Override
	public int insertSchoolComment(Map<String, String> param) {  
		
		return schoolDAO.insertSchoolComment(param);
	}

	@Override
	public List<Map<String,String>> schoolCommentList(int meetingcontentCode) {
		
		return schoolDAO.schoolCommentList(meetingcontentCode);
	}

	@Override
	public Map<String, String> updateSchoolContent(int clubContentCode) {
		
		return schoolDAO.updateSchoolContent(clubContentCode);
	}

	@Override
	public int updateContentEnd(Map<String, Object> param) {
		
		return schoolDAO.updateContentEnd(param);
	}

	@Override
	public int deleteSchoolContent(int clubContentCode) {
		int result = 0;
		
		result = schoolDAO.deleteSchoolContent(clubContentCode); // club_content 테이블에서 지우기 , on delete cascade로 설정할 것
		
		return result;
	}

	@Override
	public Map<String, String> selectOneCalender(int clubCode) {
		
		return schoolDAO.selectOneCalender(clubCode);
	}




}
