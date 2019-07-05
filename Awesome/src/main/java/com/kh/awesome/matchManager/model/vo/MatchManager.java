package com.kh.awesome.matchManager.model.vo;

import java.sql.Date;

public class MatchManager {
	private int matchNo;
	private String matchTitle;
	private int memberCode;
	private int interestingCode;
	private int localCode;
	private String placeId;
	private String placeName;
	private int placeLat;
	private int placeLng;
	private char matchingType;
	private String matchContent;
	private Date matchEndDate;
	
	public MatchManager() {}

	public MatchManager(int matchNo, String matchTitle, int memberCode, int interestingCode, int localCode,
			String placeId, String placeName, int placeLat, int placeLng, char matchingType, String matchContent,
			Date matchEndDate) {
		super();
		this.matchNo = matchNo;
		this.matchTitle = matchTitle;
		this.memberCode = memberCode;
		this.interestingCode = interestingCode;
		this.localCode = localCode;
		this.placeId = placeId;
		this.placeName = placeName;
		this.placeLat = placeLat;
		this.placeLng = placeLng;
		this.matchingType = matchingType;
		this.matchContent = matchContent;
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

	public String getPlaceId() {
		return placeId;
	}

	public void setPlaceId(String placeId) {
		this.placeId = placeId;
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

	public Date getMatchEndDate() {
		return matchEndDate;
	}

	public void setMatchEndDate(Date matchEndDate) {
		this.matchEndDate = matchEndDate;
	}

	@Override
	public String toString() {
		return "MatchManager [matchNo=" + matchNo + ", matchTitle=" + matchTitle + ", memberCode=" + memberCode
				+ ", interestingCode=" + interestingCode + ", localCode=" + localCode + ", placeId=" + placeId
				+ ", placeName=" + placeName + ", placeLat=" + placeLat + ", placeLng=" + placeLng + ", matchingType="
				+ matchingType + ", matchContent=" + matchContent + ", matchEndDate=" + matchEndDate + "]";
	}
	
	
}
