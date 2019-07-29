package com.kh.awesome.lightning.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.awesome.matchManager.model.vo.MatchManager;

@Repository
public class LightningDAOImpl implements LightningDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<Map<String, Object>> selectLightningList(Map<String, String> search, int cPage, int numPerPage) {
		// TODO Auto-generated method stub
		RowBounds rowBounds = new RowBounds(numPerPage*(cPage-1), numPerPage);
		
		return sqlSession.selectList("selectLightningList", search, rowBounds);
	}

	@Override
	public int insertLightning(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.insert("insertLightning", map);
	}

	@Override
	public List<Map<String, Object>> selectJoinMemberList(Map<String, List<String>> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectJoinMemberList", param);
	}

	@Override
	public List<String> selectCityList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("lightning.selectCityList");
	}

	@Override
	public List<Map<String, Object>> selectLocalList(int city) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectLocalList", city);
	}

	@Override
	public List<String> selectInterestingList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectInterestingList");
	}

	@Override
	public List<Map<String, Object>> selectMyLightningList(int memberCode, int numPerPage, int cPage) {
		// TODO Auto-generated method stub
		RowBounds rowBounds = new RowBounds(numPerPage*(cPage-1), numPerPage);
		return sqlSession.selectList("selectMyLightningList", memberCode, rowBounds);
	}

	@Override
	public Map<String, Object> selectLightningMatch(int matchNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("selectLightningMatch", matchNo);
	}

	@Override
	public int updateLightning(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.update("updateLightning", map);
	}

	@Override
	public int deleteLightning(int matchNo) {
		// TODO Auto-generated method stub
		return sqlSession.delete("deleteLightning", matchNo);
	}

	@Override
	public List<String> selectJoinMatchCode(int memberCode, int numPerPage, int cPage) {
		// TODO Auto-generated method stub
		RowBounds rowBounds = new RowBounds(numPerPage*(cPage-1), numPerPage);
		return sqlSession.selectList("selectJoinMatchCode", memberCode, rowBounds);
	}

	@Override
	public List<Map<String, Object>> selectJoinLightningList(Map<String,List<String>> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectJoinLightningList", param);
	}

	@Override
	public int insertMatchJoin(Map<String, Integer> map) {
		// TODO Auto-generated method stub
		return sqlSession.insert("insertMatchJoin", map);
	}

	@Override
	public List<Map<String, Object>> selectMyMatchJoinMemberList(Map<String, List<String>> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectMyMatchJoinMemberList", param);
	}

	@Override
	public List<Map<String, Object>> selectMyMatchNoPermitMemberList(Map<String, List<String>> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectMyMatchNoPermitMemberList", param);
	}

	@Override
	public int updatePermit(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.update("updatePermit", map);
	}

	@Override
	public int deleteNoPermit(Map map) {
		// TODO Auto-generated method stub
		return sqlSession.delete("deleteNoPermit", map);
	}

	@Override
	public int deleteJoinCancle(Map<String, Integer> param) {
		// TODO Auto-generated method stub
		return sqlSession.delete("deleteJoinCancle", param);
	}

}
