package com.kh.awesome.socket.stomp.model.vo;

import java.sql.Date;

public class ChatRoom {

	private String chatId;
	private int memberCode;
	private String status;
	private Date startDate;
	private Date endDate;
	
	public ChatRoom() {}
	
	public ChatRoom(String chatId, int memberCode, String status, Date startDate, Date endDate) {
		super();
		this.chatId = chatId;
		this.memberCode = memberCode;
		this.status = status;
		this.startDate = startDate;
		this.endDate = endDate;
	}

	public String getChatId() {
		return chatId;
	}

	public void setChatId(String chatId) {
		this.chatId = chatId;
	}

	public int getMemberCode() {
		return memberCode;
	}

	public void setMemberCode(int memberCode) {
		this.memberCode = memberCode;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	@Override
	public String toString() {
		return "ChatRoom [chatId=" + chatId + ", memberCode=" + memberCode + ", status=" + status + ", startDate="
				+ startDate + ", endDate=" + endDate + "]";
	}
	
	
	
}
