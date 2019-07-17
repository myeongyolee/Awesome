package com.kh.awesome.club.model.vo;

import java.io.Serializable;
<<<<<<< HEAD
import java.util.List;

public class Club implements Serializable{
	private int clubCode;
	private int interestingCode;
	private int memberCode;
	private int localCode;
	private String clubName;
	private String clubsimpleInfo;
	private String clubInfo;
	private String mainoriginalFilename;
	private String mainrenamedFilename;
	private List<Clubmember> clubMember;
	public Club() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Club(int clubCode, int interestingCode, int memberCode, int localCode, String clubName,
			String clubsimpleInfo, String clubInfo, String mainoriginalFilename, String mainrenamedFilename,
			List<Clubmember> clubMember) {
		super();
		this.clubCode = clubCode;
		this.interestingCode = interestingCode;
		this.memberCode = memberCode;
		this.localCode = localCode;
		this.clubName = clubName;
		this.clubsimpleInfo = clubsimpleInfo;
		this.clubInfo = clubInfo;
		this.mainoriginalFilename = mainoriginalFilename;
		this.mainrenamedFilename = mainrenamedFilename;
		this.clubMember = clubMember;
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
	public int getLocalCode() {
		return localCode;
	}
	public void setLocalCode(int localCode) {
		this.localCode = localCode;
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
	public String getMainoriginalFilename() {
		return mainoriginalFilename;
	}
	public void setMainoriginalFilename(String mainoriginalFilename) {
		this.mainoriginalFilename = mainoriginalFilename;
	}
	public String getMainrenamedFilename() {
		return mainrenamedFilename;
	}
	public void setMainrenamedFilename(String mainrenamedFilename) {
		this.mainrenamedFilename = mainrenamedFilename;
	}
	public List<Clubmember> getClubMember() {
		return clubMember;
	}
	public void setClubMember(List<Clubmember> clubMember) {
		this.clubMember = clubMember;
	}
	@Override
	public String toString() {
		return "Club [clubCode=" + clubCode + ", interestingCode=" + interestingCode + ", memberCode=" + memberCode
				+ ", localCode=" + localCode + ", clubName=" + clubName + ", clubsimpleInfo=" + clubsimpleInfo
				+ ", clubInfo=" + clubInfo + ", mainoriginalFilename=" + mainoriginalFilename + ", mainrenamedFilename="
				+ mainrenamedFilename + ", clubMember=" + clubMember + "]";
=======

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
>>>>>>> refs/remotes/origin/jinwoo
	}
	
	
	
}
