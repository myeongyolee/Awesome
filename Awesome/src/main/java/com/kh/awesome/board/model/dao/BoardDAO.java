package com.kh.awesome.board.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.awesome.board.model.vo.QuestionBoard;
import com.kh.awesome.board.model.vo.QuestionComment;

public interface BoardDAO {

	List<Map<String, String>> selectBoardList(int cPage, int numPerPage);

	int selectBoardTotalContents();

	int insertBoard(QuestionBoard qBoard);

	Map<String, String> selectOneQuestion(int questionNo);

	int deleteQuestion(int no);

	int updateBoard(QuestionBoard qBoard);
	
	int insertComment(QuestionComment questionComment);

	List<Map<String, String>> showCmt(int questionNo);

}