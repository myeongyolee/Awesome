package com.kh.awesome.util.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Chat implements Serializable{

	private static final long serialVersionUID = 1L;

	private String memberCode;
	private String receiveMemberCode;
	private String chatContent;
	private Date logDate;
	private String status;
	
	public Chat() {
	}

	public Chat(String memberCode, String receiveMemberCode, String chatContent, Date logDate, String status) {
		super();
		this.memberCode = memberCode;
		this.receiveMemberCode = receiveMemberCode;
		this.chatContent = chatContent;
		this.logDate = logDate;
		this.status = status;
	}

	public String getMemberCode() {
		return memberCode;
	}

	public void setMemberCode(String memberCode) {
		this.memberCode = memberCode;
	}

	public String getReceiveMemberCode() {
		return receiveMemberCode;
	}

	public void setReceiveMemberCode(String receiveMemberCode) {
		this.receiveMemberCode = receiveMemberCode;
	}

	public String getChatContent() {
		return chatContent;
	}

	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}

	public Date getLogDate() {
		return logDate;
	}

	public void setLogDate(Date logDate) {
		this.logDate = logDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
}
