package com.kh.awesome.admin.model.dao;

import java.util.List;
import java.util.Map;

public interface AdminDAO {

	List<Map<String, String>> selectAllMembers(int cPage, int numPerPage);

	int selectTotalMemberNum();

}
