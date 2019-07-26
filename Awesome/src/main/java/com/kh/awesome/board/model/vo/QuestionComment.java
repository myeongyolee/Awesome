package com.kh.awesome.board.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class QuestionComment implements Serializable{
	private int questionCommentNo;
	private int questionNo;
	private String questionCommentContent;
	private Date questionCommentDate;
	
	public QuestionComment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public QuestionComment(int questionCommentNo, int questionNo, String questionCommentContent,
			Date questionCommentDate) {
		super();
		this.questionCommentNo = questionCommentNo;
		this.questionNo = questionNo;
		this.questionCommentContent = questionCommentContent;
		this.questionCommentDate = questionCommentDate;
	}

	public int getQuestionCommentNo() {
		return questionCommentNo;
	}

	public void setQuestionCommentNo(int questionCommentNo) {
		this.questionCommentNo = questionCommentNo;
	}

	public int getQuestionNo() {
		return questionNo;
	}

	public void setQuestionNo(int questionNo) {
		this.questionNo = questionNo;
	}

	public String getQuestionCommentContent() {
		return questionCommentContent;
	}

	public void setQuestionCommentContent(String questionCommentContent) {
		this.questionCommentContent = questionCommentContent;
	}

	public Date getQuestionCommentDate() {
		return questionCommentDate;
	}

	public void setQuestionCommentDate(Date questionCommentDate) {
		this.questionCommentDate = questionCommentDate;
	}

	@Override
	public String toString() {
		return "QuestionComment [questionCommentNo=" + questionCommentNo + ", questionNo=" + questionNo
				+ ", questionCommentContent=" + questionCommentContent + ", questionCommentDate=" + questionCommentDate
				+ "]";
	}
	
	
	
	
}
