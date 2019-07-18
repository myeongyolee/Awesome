package com.kh.awesome.matchManager.model.vo;

import java.sql.Date;

public class MatchManager {
	private int matchNo;
	private String matchTitle;
	private int memberCode;
	private int interestingCode;
	private int localCode;
	private String placeName;
	private int placeLat;
	private int placeLng;
	private char matchingType;
	private String matchContent;
	private String matchOriginalImg;
	private String matchRenamedImg;
	private Date matchWriteDate;
	private Date matchEndDate;
	
	public MatchManager() {}

	public MatchManager(int matchNo, String matchTitle, int memberCode, int interestingCode, int localCode,
			String placeName, int placeLat, int placeLng, char matchingType, String matchContent,
			String matchOriginalImg, String matchRenamedImg, Date matchWriteDate, Date matchEndDate) {
		super();
		this.matchNo = matchNo;
		this.matchTitle = matchTitle;
		this.memberCode = memberCode;
		this.interestingCode = interestingCode;
		this.localCode = localCode;
		this.placeName = placeName;
		this.placeLat = placeLat;
		this.placeLng = placeLng;
		this.matchingType = matchingType;
		this.matchContent = matchContent;
		this.matchOriginalImg = matchOriginalImg;
		this.matchRenamedImg = matchRenamedImg;
		this.matchWriteDate = matchWriteDate;
		this.matchEndDate = matchEndDate;
	}

	public int getMatchNo() {
		return matchNo;
	}

	public void setMatchNo(int matchNo) {
		this.matchNo = matchNo;
	}

	public String getMatchTitle() {
		return matchTitle;
	}

	public void setMatchTitle(String matchTitle) {
		this.matchTitle = matchTitle;
	}

	public int getMemberCode() {
		return memberCode;
	}

	public void setMemberCode(int memberCode) {
		this.memberCode = memberCode;
	}

	public int getInterestingCode() {
		return interestingCode;
	}

	public void setInterestingCode(int interestingCode) {
		this.interestingCode = interestingCode;
	}

	public int getLocalCode() {
		return localCode;
	}

	public void setLocalCode(int localCode) {
		this.localCode = localCode;
	}

	public String getPlaceName() {
		return placeName;
	}

	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}

	public int getPlaceLat() {
		return placeLat;
	}

	public void setPlaceLat(int placeLat) {
		this.placeLat = placeLat;
	}

	public int getPlaceLng() {
		return placeLng;
	}

	public void setPlaceLng(int placeLng) {
		this.placeLng = placeLng;
	}

	public char getMatchingType() {
		return matchingType;
	}

	public void setMatchingType(char matchingType) {
		this.matchingType = matchingType;
	}

	public String getMatchContent() {
		return matchContent;
	}

	public void setMatchContent(String matchContent) {
		this.matchContent = matchContent;
	}

	public String getMatchOriginalImg() {
		return matchOriginalImg;
	}

	public void setMatchOriginalImg(String matchOriginalImg) {
		this.matchOriginalImg = matchOriginalImg;
	}

	public String getMatchRenamedImg() {
		return matchRenamedImg;
	}

	public void setMatchRenamedImg(String matchRenamedImg) {
		this.matchRenamedImg = matchRenamedImg;
	}

	public Date getMatchWriteDate() {
		return matchWriteDate;
	}

	public void setMatchWriteDate(Date matchWriteDate) {
		this.matchWriteDate = matchWriteDate;
	}

	public Date getMatchEndDate() {
		return matchEndDate;
	}

	public void setMatchEndDate(Date matchEndDate) {
		this.matchEndDate = matchEndDate;
	}

	@Override
	public String toString() {
		return "MatchManager [matchNo=" + matchNo + ", matchTitle=" + matchTitle + ", memberCode=" + memberCode
				+ ", interestingCode=" + interestingCode + ", localCode=" + localCode + ", placeId=" 
				+ ", placeName=" + placeName + ", placeLat=" + placeLat + ", placeLng=" + placeLng + ", matchingType="
				+ matchingType + ", matchContent=" + matchContent + ", matchOriginalImg=" + matchOriginalImg
				+ ", matchRenamedImg=" + matchRenamedImg + ", matchWriteDate=" + matchWriteDate + ", matchEndDate="
				+ matchEndDate + "]";
	}
	
}
