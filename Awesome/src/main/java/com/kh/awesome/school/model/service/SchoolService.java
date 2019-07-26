package com.kh.awesome.school.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.awesome.club.model.vo.Clubcontent;
import com.kh.awesome.club.model.vo.Clubphoto;

public interface SchoolService {

	int insertSchool(Map<String, String> param);

	int checkSchool(String memberCode);

	List<Map<String, String>> schoolList(int cPage, int numPerPage, List list);

	List MySchoolIdCheck(String memberCode);

	int totalContent(List list);

	int makeSchoolEnd(Map<String, String> param);

	List<Map<String, String>> MyList(String memberCode);

	List<Map<String, String>> findPeople(int cPage, int numPerPage, Map<String, String> param);

	int totalCountfindPeople(Map<String, String> param);

	List<Map<String, String>> selectSchoolOne(int clubCode);

	int totalMemberCount(Map<String, Object> param);

	List<Map<String, String>> selectClubMember(Map<String, Object> param);

	List<Map<String, String>> schoolView(int clubCode, int cPage, int numPerPage);

	int totalClubContent(int clubCode);
	
	List AllContentCode(int clubCode);

	List<Map<String, String>> schoolPhoto(List list);

	int insertSchoolContent(Map<String, Object> param);

	String checkClubSchool(Map<String, Object> param);

	int enrollSchoolClub(Map<String, Object> param);

	List<Map<String,Object>> waitingList(Map<String, Object> param);

	int acceptMember(Map<String, Object> param);

	List<Map<String, Object>> checkClubMember(Map<String, Object> param);

	int updateGrade(Map<String, Object> param);

	List<Map<String, String>> searchMySchoolClub(Map<String, String> param);

	int insertSchoolImg(Clubcontent clubcontent);

	int insertSchoolImg2(List<Clubphoto> clubphotoList);

	Map<String, String> schoolContentView(Map<String, Integer> param);

	int insertSchoolComment(Map<String, String> param);

	List<Map<String, String>> schoolCommentList(int meetingcontentCode);

	Map<String, String> updateSchoolContent(int clubContentCode);

	int updateContentEnd(Map<String, Object> param);

	int deleteSchoolContent(int clubContentCode);

	Map<String, String> selectOneCalender(int clubCode);

	int deleteCalender(int matchNo);

	int logoutClub(Map<String, Integer> param);



	

	

}
