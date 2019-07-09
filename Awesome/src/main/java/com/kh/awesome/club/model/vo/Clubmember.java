package com.kh.awesome.club.model.vo;

import java.io.Serializable;

public class Clubmember implements Serializable{
	private int clubCode;
	private int memberCode;
	private int clubmemGrade;
	private char clubjoinCheck;
	
	public Clubmember() {
		super();
	}

	public Clubmember(int clubCode, int memberCode, char clubjoinCheck, int clubmemGrade) {
		super();
		this.clubCode = clubCode;
		this.memberCode = memberCode;
		this.clubmemGrade = clubmemGrade;
		this.clubjoinCheck = clubjoinCheck;
	}

	public int getClubCode() {
		return clubCode;
	}

	public void setClubCode(int clubCode) {
		this.clubCode = clubCode;
	}

	public int getMemberCode() {
		return memberCode;
	}

	public void setMemberCode(int memberCode) {
		this.memberCode = memberCode;
	}

	public char getClubjoinCheck() {
		return clubjoinCheck;
	}

	public void setClubjoinCheck(char clubjoinCheck) {
		this.clubjoinCheck = clubjoinCheck;
	}

	public int getClubmemGrade() {
		return clubmemGrade;
	}

	public void setClubmemGrade(int clubmemGrade) {
		this.clubmemGrade = clubmemGrade;
	}

	@Override
	public String toString() {
		return "Clubmember [clubCode=" + clubCode + ", memberCode=" + memberCode + ", clubjoinCheck=" + clubjoinCheck
				+ ", clubmemGrade=" + clubmemGrade + "]";
	}
	
	
	
}
