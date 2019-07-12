package com.kh.awesome.board.model.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.awesome.board.model.dao.BoardDAO;
import com.kh.awesome.board.model.exception.BoardException;
import com.kh.awesome.board.model.vo.QuestionBoard;

@Service
public class BoardServiceImpl implements BoardService{
	Logger logger = LoggerFactory.getLogger(BoardServiceImpl.class);

	@Autowired
	BoardDAO boardDAO;
	// 전체 게시판 가지고 오기
	@Override
	public List<Map<String, String>> selectBoardList(int cPage, int numPerPage) {
		return boardDAO.selectBoardList(cPage, numPerPage);
	}
	
	//게시판 갯수
	@Override
	public int selectBoardTotalContents() {
		return boardDAO.selectBoardTotalContents();
	}

	//
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int insertBoard(QuestionBoard qBoard) {
		int result = 0;
		int boardNo = 0;
		
		result = boardDAO.insertBoard(qBoard);
		if(result ==0) throw new BoardException("게시물 등록 오류~!");
		
		boardNo = qBoard.getQuestionNo();
		
		return boardNo;
	}

	@Override
	public QuestionBoard selectOneQuestion(int questionNo) {
		return boardDAO.selectOneQuestion(questionNo);
	}

}

