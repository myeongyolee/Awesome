package com.kh.awesome.admin.model.vo;

public class BlindDateLike {

	private int memberCode;
	private int receiveMemberCode;
	private char likeCheck;
	
	public BlindDateLike() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BlindDateLike(int memberCode, int receiveMemberCode, char likeCheck) {
		super();
		this.memberCode = memberCode;
		this.receiveMemberCode = receiveMemberCode;
		this.likeCheck = likeCheck;
	}

	public int getMemberCode() {
		return memberCode;
	}

	public void setMemberCode(int memberCode) {
		this.memberCode = memberCode;
	}

	public int getReceiveMemberCode() {
		return receiveMemberCode;
	}

	public void setReceiveMemberCode(int receiveMemberCode) {
		this.receiveMemberCode = receiveMemberCode;
	}

	public char getLikeCheck() {
		return likeCheck;
	}

	public void setLikeCheck(char likeCheck) {
		this.likeCheck = likeCheck;
	}
	
	
	
	
	
}
