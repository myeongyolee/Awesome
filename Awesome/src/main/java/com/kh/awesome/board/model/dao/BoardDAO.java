package com.kh.awesome.board.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.awesome.board.model.vo.QuestionBoard;

public interface BoardDAO {

	List<Map<String, String>> selectBoardList(int cPage, int numPerPage);

	int selectBoardTotalContents();

	int insertBoard(QuestionBoard qBoard);

	QuestionBoard selectOneQuestion(int questionNo);

}