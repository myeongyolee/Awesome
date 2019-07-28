package com.kh.awesome.board.controller;


import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.awesome.board.model.exception.BoardException;
import com.kh.awesome.board.model.service.BoardService;
import com.kh.awesome.board.model.vo.QuestionBoard;
import com.kh.awesome.board.model.vo.QuestionComment;

@Controller
@RequestMapping("/questionBoard")
public class BoardController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private BoardService boardService;
	
	/*@RequestMapping("/boardForm.do")
	public void boardForm() {
		if(logger.isDebugEnabled())
			logger.debug("게시판 글쓰기 페이지 요청");
		
		
		logger.info("게시판 글쓰기 페이지 요청");
	}*/
	
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
	public String insertBoard(QuestionBoard qBoard, 
								   MultipartFile upFile,
			HttpServletRequest request) {
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
			String questionOriginalFilename = upFile.getOriginalFilename();
			String ext = questionOriginalFilename.substring(questionOriginalFilename.lastIndexOf(".")+1);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
			int rndNum = (int) (Math.random()*1000);
			
			String qeustionRenamedFilename = sdf.format(new Date()) +"_" + rndNum +"." + ext;
			//서버지정위치에 파일 보관
			try {
				upFile.transferTo(new File(saveDirectory + "/" + qeustionRenamedFilename));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) { 
				e.printStackTrace();
			}
			
			qBoard.setQuestionOriginalFilename(questionOriginalFilename);
			qBoard.setQuestionRenamedFilename(qeustionRenamedFilename);
		}
	
		//2.업무로직:DB 에 게시물 등록
		result = boardService.insertBoard(qBoard);
	}catch(Exception e) {
		logger.error("게시물 등록에러",e);
		throw new BoardException("게시물 등록 중 오류가 발생했습니다. ");
	}
		
		return "redirect:/questionBoard/questionBoard.do";
		
	}
	
	
	@RequestMapping(value="/updateBoard.do")
	public String updateBoard(QuestionBoard qBoard, 
								   MultipartFile upFile,
			HttpServletRequest request) {
		if(logger.isDebugEnabled())
		logger.debug("update 등록 요청~!");
		logger.info("boardUpdate' qBoard@Controller== " + qBoard);
		int result =0;
		try{//1. 파일 업로드
		String saveDirectory = request.getSession()
									.getServletContext()
									.getRealPath("/resources/upload/qBoard");
		
		if(!upFile.isEmpty()) {
			//filerename policy
			String questionOriginalFilename = upFile.getOriginalFilename();
			String ext = questionOriginalFilename.substring(questionOriginalFilename.lastIndexOf(".")+1);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
			int rndNum = (int) (Math.random()*1000);
			
			String qeustionRenamedFilename = sdf.format(new Date()) +"_" + rndNum +"." + ext;
			//서버지정위치에 파일 보관
			try {
				upFile.transferTo(new File(saveDirectory + "/" + qeustionRenamedFilename));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) { 
				e.printStackTrace();
			}
			
			qBoard.setQuestionOriginalFilename(questionOriginalFilename);
			qBoard.setQuestionRenamedFilename(qeustionRenamedFilename);
		}
	
		//2.업무로직:DB 에 게시물 등록
		result = boardService.updateBoard(qBoard);
	}catch(Exception e) {
		logger.error("게시물 등록에러",e);
		throw new BoardException("게시물 등록 중 오류가 발생했습니다. ");
	}
		
		return "redirect:/questionBoard/questionBoard.do";
		
	}
	
		
	@RequestMapping(value="/boardView.do", method=RequestMethod.POST,
			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)	
	@ResponseBody
	public Map<String, Object> selectOneBoard(
			@RequestParam ("questionNo") int questionNo, HttpServletRequest request) {
		Map<String, String> b = new HashMap<>();
				b= boardService.selectOneQuestion(questionNo);
				logger.info("selectedQ={}", b);
		String html = "";
		String question_No=String.valueOf(b.get("questionNo"));
		String questionTitle= b.get("questionTitle");
		String memberName= b.get("memberName");
		String memberCode = String.valueOf(b.get("memberCode"));
		String questionContent = b.get("questionContent");
		String questionOriginalFilename = b.get("questionOriginalFilename");
		String questionRenamedFilename = b.get("questionRenamedFilename");
		
		List<Map<String, String>>showCmt =boardService.showCmt(questionNo); 
//		String questionCommentContent = showCmt.get("questionCommentContent");
		
		html += "<img src='"+request.getContextPath()+"/resources/upload/qBoard/"+b.get("questionRenamedFilename")
		+"' id='board_img' style=\"width: 250px; height: 250px; position: block;\"/>";
		
		Map<String, Object> htmlMap = new HashMap<String, Object>();
		htmlMap.put("html", html);
		htmlMap.put("question_No", question_No);
		htmlMap.put("memberCode", memberCode);
		htmlMap.put("questionTitle", questionTitle);
		htmlMap.put("questionContent", questionContent);
		htmlMap.put("memberName", memberName);
		htmlMap.put("questionOriginalFilename", questionOriginalFilename);
		htmlMap.put("questionRenamedFilename", questionRenamedFilename);
		htmlMap.put("showCmt", showCmt);
		
		return htmlMap;
	}
	
	/*@RequestMapping(value="/boardView.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)	
	@ResponseBody
	public String selectOneBoard(
			@RequestParam ("questionNo") int questionNo) throws IOException {
		String request = "http://localhost/awesome/questionBoard/questionBoard?"
				+"questionNo="+ questionNo;
		URL url = new URL(request);
		String line= "";
		StringBuilder sb = new StringBuilder();
		
		BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()));
		while((line=br.readLine())!=null) {
			sb.append(line);
		}
		return sb.toString();
	}
	*/
	 @RequestMapping("/deleteQuestion.do")
		public String deleteQ(@RequestParam ("questionNo") int no){
			logger.debug("질문 삭제");
			/*Map<String, String> map = new HashMap<>();
			map.put("no", questionNo);*/
			boardService.deleteQuestion(no);
			
			return "redirect:/questionBoard/questionBoard.do";
		}

	 	@RequestMapping("/insertComment.do")
		@ResponseBody
		public int addComment(@RequestBody Map requestMap)
		throws Exception{
	 		logger.info("requestMap={}", requestMap);
	 	   int questionNo = Integer.parseInt((String)requestMap.get("questionNo"));
	       String questionCommentContent = (String)requestMap.get("questionCommentContent");
	       
			QuestionComment questionComment = new QuestionComment();
			questionComment.setQuestionNo(questionNo);
			questionComment.setQuestionCommentContent(questionCommentContent);
			
			int result = 0;
			try { 
				result = boardService.insertComment(questionComment);
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			return result;
		}
	
}
