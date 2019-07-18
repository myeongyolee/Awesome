package com.kh.awesome.socket.stomp.model.vo;

public class Msg {
	
	private long chatNo;
	private String chatId;
	private int memberCode;
	private String msg;
	private long time;
	private MsgType type;
	
	public Msg() {}

	public Msg(long chatNo, String chatId, int memberCode, String msg, long time, MsgType type) {
		super();
		this.chatNo = chatNo;
		this.chatId = chatId;
		this.memberCode = memberCode;
		this.msg = msg;
		this.time = time;
		this.type = type;
	}

	public long getChatNo() {
		return chatNo;
	}

	public void setChatNo(long chatNo) {
		this.chatNo = chatNo;
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

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public long getTime() {
		return time;
	}

	public void setTime(long time) {
		this.time = time;
	}

	public MsgType getType() {
		return type;
	}

	public void setType(MsgType type) {
		this.type = type;
	}

	@Override
	public String toString() {
		return "Msg [chatNo=" + chatNo + ", chatId=" + chatId + ", memberCode=" + memberCode + ", msg=" + msg
				+ ", time=" + time + ", type=" + type + "]";
	}
	
	
}
