package com.kh.awesome.board.controller;


import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.awesome.board.model.exception.BoardException;
import com.kh.awesome.board.model.service.BoardService;
import com.kh.awesome.board.model.vo.QuestionBoard;

@Controller
@RequestMapping("/questionBoard")
public class BoardController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping("/boardForm.do")
	public void boardForm() {
		if(logger.isDebugEnabled())
			logger.debug("게시판 글쓰기 페이지 요청");
		
		
		logger.info("게시판 글쓰기 페이지 요청");
	}
	
	//게시판 목록 페이지
	@RequestMapping("/questionBoard.do")
	public ModelAndView questionBoard(
			@RequestParam(value="cPage", required = false, 
			defaultValue = "1") int cPage) {
	
	ModelAndView mav = new ModelAndView();
	int numPerPage = 10;//한페이지당 수 
	
	//업무로직처리
	//1. 현재페이지 컨텐츠 구하기
	List<Map<String,String>> list = boardService.selectBoardList(cPage, numPerPage);
	
	
	//2. 전체컨텐츠수 구하기
	int totalContents = boardService.selectBoardTotalContents();
	
	mav.addObject("list",list);
	mav.addObject("totalContents",totalContents);
	mav.addObject("numPerPage",numPerPage);
	mav.addObject("cPage", cPage);
	//mav.setViewName("questionBoard/questionBoard");
	return mav;
		
	}
	
	
	@RequestMapping(value="/boardFormEnd.do")
	public ModelAndView insertBoard(QuestionBoard qBoard, 
								   MultipartFile upFile,
			HttpServletRequest request, ModelAndView mav) {
		if(logger.isDebugEnabled())
		logger.debug("게시판 페이지 등록 요청~!");
		logger.debug("boardFormEnd' qBoard@Controller== " + qBoard);
		int result =0;
		try{//1. 파일 업로드
		String saveDirectory = request.getSession()
									.getServletContext()
									.getRealPath("/resources/upload/qBoard");
		
		if(!upFile.isEmpty()) {
			//filerename policy
			String questionOriginalFileName = upFile.getOriginalFilename();
			String ext = questionOriginalFileName.substring(questionOriginalFileName.lastIndexOf(".")+1);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
			int rndNum = (int) (Math.random()*1000);
			
			String qeustionRenamedFileName = sdf.format(new Date()) +"_" + rndNum +"." + ext;
			//서버지정위치에 파일 보관
			try {
				upFile.transferTo(new File(saveDirectory + "/" + qeustionRenamedFileName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) { 
				e.printStackTrace();
			}
			
			qBoard.setQuestionOriginalFilename(questionOriginalFileName);
			qBoard.setQuestionRenamedFilename(qeustionRenamedFileName);
		}
	
		//2.업무로직:DB 에 게시물 등록
		result = boardService.insertBoard(qBoard);
	}catch(Exception e) {
		logger.error("게시물 등록에러",e);
		throw new BoardException("게시물 등록 중 오류가 발생했습니다. ");
	}
		String msg = result > 0? "게시물 등록성공~!": "게시물 등록 실패~!";
		String loc= "/";
		mav.addObject("loc", loc);
		mav.addObject("msg", msg);
		mav.setViewName("common/msg");
		return mav;	
		
	}
	
	@RequestMapping("/boardView.do")
	public void selectOneBoard(@RequestParam ("questionNo") int questionNo, 
							Model model) {
		logger.debug("게시판 상세보기 요청!@*** ");
		logger.debug("questionNo@controller"+ questionNo);
		//my batis 에서 한방에 끝내는 방법으로 
		QuestionBoard b =boardService.selectOneQuestion(questionNo);
		
		model.addAttribute("board",b);
		
	}
	
	@RequestMapping("/fileDownload.do")
	@ResponseBody
	public byte[] fileDownload(@RequestParam String oName,
							@RequestParam String rName, 
							HttpServletRequest request, 
							HttpServletResponse response) throws IOException {
		logger.debug(oName +","+rName);
		
		//저장된 파일 디렉토리 
		//예전 getServletConxt(): application, 지금은 여러개가 될수 있다. application Context 객체 
		String saveDirectory = request.getSession().getServletContext().
								getRealPath("/resources/upload/qBoard");
		File savedFile = new File(saveDirectory +"/" +rName);
		
		response.setHeader("Content-Type",
				"application/octet-stream; charset=utf-8");
		response.setHeader("Content-Disposition", 
				"attachment;fileName=\"" + new String(oName.getBytes("UTF-8"), "ISO-8859-1")+"\"");
		response.setHeader("Content-Length", Long.toString(savedFile.length()));
		return Files.readAllBytes(savedFile.toPath());
	}
}
