package com.kh.awesome.board.model.service;

import java.util.List;
import java.util.Map;

import com.kh.awesome.board.model.vo.QuestionBoard;

public interface BoardService {

	List<Map<String, String>> selectBoardList(int cPage, int numPerPage);

	int selectBoardTotalContents();

	int insertBoard(QuestionBoard board);

	QuestionBoard selectOneQuestion(int questionNo);

}