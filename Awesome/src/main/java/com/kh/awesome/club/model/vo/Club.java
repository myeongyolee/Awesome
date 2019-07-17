package com.kh.awesome.club.model.vo;

import java.io.Serializable;

public class Club implements Serializable{
	private int clubCode;
	private int interestingCode;
	private int memberCode;
	private String clubName;
	private String clubsimpleInfo;
	private String clubInfo;
	
	public Club() {
		super();
	}

	public Club(int clubCode, int interestingCode, int memberCode, String clubName, String clubsimpleInfo,
			String clubInfo) {
		super();
		this.clubCode = clubCode;
		this.interestingCode = interestingCode;
		this.memberCode = memberCode;
		this.clubName = clubName;
		this.clubsimpleInfo = clubsimpleInfo;
		this.clubInfo = clubInfo;
	}

	public int getClubCode() {
		return clubCode;
	}

	public void setClubCode(int clubCode) {
		this.clubCode = clubCode;
	}

	public int getInterestingCode() {
		return interestingCode;
	}

	public void setInterestingCode(int interestingCode) {
		this.interestingCode = interestingCode;
	}

	public int getMemberCode() {
		return memberCode;
	}

	public void setMemberCode(int memberCode) {
		this.memberCode = memberCode;
	}

	public String getClubName() {
		return clubName;
	}

	public void setClubName(String clubName) {
		this.clubName = clubName;
	}

	public String getClubsimpleInfo() {
		return clubsimpleInfo;
	}

	public void setClubsimpleInfo(String clubsimpleInfo) {
		this.clubsimpleInfo = clubsimpleInfo;
	}

	public String getClubInfo() {
		return clubInfo;
	}

	public void setClubInfo(String clubInfo) {
		this.clubInfo = clubInfo;
	}

	@Override
	public String toString() {
		return "Club [clubCode=" + clubCode + ", interestingCode=" + interestingCode + ", memberCode=" + memberCode
				+ ", clubName=" + clubName + ", clubsimpleInfo=" + clubsimpleInfo + ", clubInfo=" + clubInfo + "]";
	}
	
	
	
}
