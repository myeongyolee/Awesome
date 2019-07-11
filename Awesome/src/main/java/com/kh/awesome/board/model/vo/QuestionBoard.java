package com.kh.awesome.board.model.vo;

import java.sql.Date;


public class QuestionBoard {
	private int questionNo;
	private int memberCode;
	private String questionTitle;
	private String questionContent;
	private String questionOriginalFilename;
	private String questionRenamedFilename;
	private Date questionDate;
	private char questionOpen;
	
	public QuestionBoard() {
		super();
	}

	public QuestionBoard(int questionNo, int memberCode, String questionTitle, String questionContent,
			String questionOriginalFilename, String questionRenamedFilename, Date questionDate, char questionOpen) {
		super();
		this.questionNo = questionNo;
		this.memberCode = memberCode;
		this.questionTitle = questionTitle;
		this.questionContent = questionContent;
		this.questionOriginalFilename = questionOriginalFilename;
		this.questionRenamedFilename = questionRenamedFilename;
		this.questionDate = questionDate;
		this.questionOpen = questionOpen;
	}

	public int getQuestionNo() {
		return questionNo;
	}

	public void setQuestionNo(int questionNo) {
		this.questionNo = questionNo;
	}

	public int getMemberCode() {
		return memberCode;
	}

	public void setMemberCode(int memberCode) {
		this.memberCode = memberCode;
	}

	public String getQuestionTitle() {
		return questionTitle;
	}

	public void setQuestionTitle(String questionTitle) {
		this.questionTitle = questionTitle;
	}

	public String getQuestionContent() {
		return questionContent;
	}

	public void setQuestionContent(String questionContent) {
		this.questionContent = questionContent;
	}

	public String getQuestionOriginalFilename() {
		return questionOriginalFilename;
	}

	public void setQuestionOriginalFilename(String questionOriginalFilename) {
		this.questionOriginalFilename = questionOriginalFilename;
	}

	public String getQuestionRenamedFilename() {
		return questionRenamedFilename;
	}

	public void setQuestionRenamedFilename(String questionRenamedFilename) {
		this.questionRenamedFilename = questionRenamedFilename;
	}

	public Date getQuestionDate() {
		return questionDate;
	}

	public void setQuestionDate(Date questionDate) {
		this.questionDate = questionDate;
	}

	public char getQuestionOpen() {
		return questionOpen;
	}

	public void setQuestionOpen(char questionOpen) {
		this.questionOpen = questionOpen;
	}
	

	@Override
	public String toString() {
		return "QuestionBoard [questionNo=" + questionNo + ", memberCode=" + memberCode + ", questionTitle="
				+ questionTitle + ", questionContent=" + questionContent + ", questionOriginalFilename="
				+ questionOriginalFilename + ", questionRenamedFilename=" + questionRenamedFilename + ", questionDate="
				+ questionDate + ", questionOpen=" + questionOpen + "]";
	}
	
	
}