package com.kh.awesome.admin.model.service;

import java.util.List;
import java.util.Map;

public interface AdminService {

	List<Map<String, String>> selectAllMembers(int cPage, int numPerPage);

	int selectTotalMemberNum();

}
