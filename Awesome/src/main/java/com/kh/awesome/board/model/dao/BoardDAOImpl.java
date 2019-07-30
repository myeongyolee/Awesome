package com.kh.awesome.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.awesome.board.model.vo.QuestionBoard;
import com.kh.awesome.board.model.vo.QuestionComment;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Autowired
	private SqlSession sqlSession;
	
	Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public List<Map<String, String>> selectBoardList(int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlSession.selectList("qBoard.selectBoardList", null, rowBounds);
	}

	@Override
	public int selectBoardTotalContents() {
		return sqlSession.selectOne("qBoard.selectBoardTotalContents");
	}

	@Override
	public int insertBoard(QuestionBoard qBoard) {
		logger.info("qBoard@DAOImpl===" + qBoard);
		return sqlSession.insert("qBoard.insertBoard",qBoard);
	}

	@Override
	public Map<String, String> selectOneQuestion(int questionNo) {
		return sqlSession.selectOne("qBoard.selectOneQuestion",questionNo);
	}

	@Override
	public int deleteQuestion(int no) {
		return sqlSession.delete("qBoard.deleteQuestion", no);
	}

	@Override
	public int updateBoard(QuestionBoard qBoard) {
		return sqlSession.update("qBoard.updateQuestion",qBoard);
	}

	@Override
	public int insertComment(QuestionComment questionComment) {
		return sqlSession.insert("qBoard.insertComment", questionComment);
	}

	@Override
	public List<Map<String, String>> showCmt(int questionNo) {
		return sqlSession.selectList("qBoard.showCmt", questionNo);
	}

	@Override
	public int deleteCom(int questionCommentNo) {
		return sqlSession.delete("qBoard.deleteCom", questionCommentNo);
	}
	
	
}