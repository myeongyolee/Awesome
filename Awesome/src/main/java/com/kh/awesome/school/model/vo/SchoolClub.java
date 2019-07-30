package com.kh.awesome.school.model.vo;

public class SchoolClub {
	private int schoolClubCode;
	private int memberCode;
	private String schoolClubTitle;
	private String schoolName;
	private String schoolId;
	private String schoolAddress;
	private String club_info;
	private String club_info_long;
	private String originalFileName;
	private String renamedFileName;

	public SchoolClub() {}
	
	public SchoolClub(int schoolClubCode, int memberCode, String schoolClubTitle, String schoolName, String schoolId,
			String schoolAddress, String club_info, String club_info_long, String originalFileName,
			String renamedFileName) {
		super();
		this.schoolClubCode = schoolClubCode;
		this.memberCode = memberCode;
		this.schoolClubTitle = schoolClubTitle;
		this.schoolName = schoolName;
		this.schoolId = schoolId;
		this.schoolAddress = schoolAddress;
		this.club_info = club_info;
		this.club_info_long = club_info_long;
		this.originalFileName = originalFileName;
		this.renamedFileName = renamedFileName;
	}

	public int getSchoolClubCode() {
		return schoolClubCode;
	}

	public void setSchoolClubCode(int schoolClubCode) {
		this.schoolClubCode = schoolClubCode;
	}

	public int getMemberCode() {
		return memberCode;
	}

	public void setMemberCode(int memberCode) {
		this.memberCode = memberCode;
	}

	public String getSchoolClubTitle() {
		return schoolClubTitle;
	}

	public void setSchoolClubTitle(String schoolClubTitle) {
		this.schoolClubTitle = schoolClubTitle;
	}

	public String getSchoolName() {
		return schoolName;
	}

	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	public String getSchoolId() {
		return schoolId;
	}

	public void setSchoolId(String schoolId) {
		this.schoolId = schoolId;
	}

	public String getSchoolAddress() {
		return schoolAddress;
	}

	public void setSchoolAddress(String schoolAddress) {
		this.schoolAddress = schoolAddress;
	}

	public String getClub_info() {
		return club_info;
	}

	public void setClub_info(String club_info) {
		this.club_info = club_info;
	}

	public String getClub_info_long() {
		return club_info_long;
	}

	public void setClub_info_long(String club_info_long) {
		this.club_info_long = club_info_long;
	}

	public String getOriginalFileName() {
		return originalFileName;
	}

	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}

	public String getRenamedFileName() {
		return renamedFileName;
	}

	public void setRenamedFileName(String renamedFileName) {
		this.renamedFileName = renamedFileName;
	}

	@Override
	public String toString() {
		return "SchoolClub [schoolClubCode=" + schoolClubCode + ", memberCode=" + memberCode + ", schoolClubTitle="
				+ schoolClubTitle + ", schoolName=" + schoolName + ", schoolId=" + schoolId + ", schoolAddress="
				+ schoolAddress + ", club_info=" + club_info + ", club_info_long=" + club_info_long
				+ ", originalFileName=" + originalFileName + ", renamedFileName=" + renamedFileName + "]";
	}

	
	
	
	
	
	
	
}

