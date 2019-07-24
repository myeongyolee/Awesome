package com.kh.awesome.club.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Clubcomment implements Serializable{

	private int meetingcommentCode;
	private int commentWriter;
	private String commentContent;
	private Date commentDate;
	private int meetingcontentCode;
	private String writerNickname;
	public Clubcomment() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Clubcomment(int meetingcommentCode, int commentWriter, String commentContent, Date commentDate,
			int meetingcontentCode, String writerNickname) {
		super();
		this.meetingcommentCode = meetingcommentCode;
		this.commentWriter = commentWriter;
		this.commentContent = commentContent;
		this.commentDate = commentDate;
		this.meetingcontentCode = meetingcontentCode;
		this.writerNickname = writerNickname;
	}
	public int getMeetingcommentCode() {
		return meetingcommentCode;
	}
	public void setMeetingcommentCode(int meetingcommentCode) {
		this.meetingcommentCode = meetingcommentCode;
	}
	public int getCommentWriter() {
		return commentWriter;
	}
	public void setCommentWriter(int commentWriter) {
		this.commentWriter = commentWriter;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public Date getCommentDate() {
		return commentDate;
	}
	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}
	public int getMeetingcontentCode() {
		return meetingcontentCode;
	}
	public void setMeetingcontentCode(int meetingcontentCode) {
		this.meetingcontentCode = meetingcontentCode;
	}
	public String getWriterNickname() {
		return writerNickname;
	}
	public void setWriterNickname(String writerNickname) {
		this.writerNickname = writerNickname;
	}
	@Override
	public String toString() {
		return "Clubcomment [meetingcommentCode=" + meetingcommentCode + ", commentWriter=" + commentWriter
				+ ", commentContent=" + commentContent + ", commentDate=" + commentDate + ", meetingcontentCode="
				+ meetingcontentCode + ", writerNickname=" + writerNickname + "]";
	}
	
	
	
}
