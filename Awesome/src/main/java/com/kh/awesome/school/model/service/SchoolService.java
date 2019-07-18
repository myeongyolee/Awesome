package com.kh.awesome.school.model.service;

import java.util.List;
import java.util.Map;

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


}
