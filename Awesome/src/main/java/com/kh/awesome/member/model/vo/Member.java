package com.kh.awesome.member.model.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

import com.kh.awesome.club.model.vo.Clubmember;

public class Member implements Serializable{
	
	 private static final long serialVersionUID = 1L;
	 
	private int memberCode;
	private String memberId;
	private String password;
	private String memberName;
	private Date birthday;
	private String phone;
	private char gender;
	private String profile;
	private String renamedProfile;
	private char blindDateOpen;
	private char friendOpen;
	private char searchOpen;
	private String introduce;
	private char verify;
	private Date enrollDate;
	private String email;
	private List<Clubmember> clubMember;
	
	public Member() {
		super();
	}

	public Member(int memberCode, String memberId, String password, String memberName, Date birthday, String phone,
			char gender, String profile, String renamedProfile, char blindDateOpen, char friendOpen, char searchOpen,
			String introduce, char verify, Date enrollDate, String email, 
			List<Clubmember> clubMember) {
		this.memberCode = memberCode;
		this.memberId = memberId;
		this.password = password;
		this.memberName = memberName;
		this.birthday = birthday;
		this.phone = phone;
		this.gender = gender;
		this.profile = profile;
		this.renamedProfile = renamedProfile;
		this.blindDateOpen = blindDateOpen;
		this.friendOpen = friendOpen;
		this.searchOpen = searchOpen;
		this.introduce = introduce;
		this.verify = verify;
		this.enrollDate = enrollDate;
		this.email = email;
		this.clubMember = clubMember;
	}

	public int getMemberCode() {
		return memberCode;
	}

	public void setMemberCode(int memberCode) {
		this.memberCode = memberCode;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public char getGender() {
		return gender;
	}

	public void setGender(char gender) {
		this.gender = gender;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getRenamedProfile() {
		return renamedProfile;
	}

	public void setRenamedProfile(String renamedProfile) {
		this.renamedProfile = renamedProfile;
	}

	public char getBlindDateOpen() {
		return blindDateOpen;
	}

	public void setBlindDateOpen(char blindDateOpen) {
		this.blindDateOpen = blindDateOpen;
	}

	public char getFriendOpen() {
		return friendOpen;
	}

	public void setFriendOpen(char friendOpen) {
		this.friendOpen = friendOpen;
	}

	public char getSearchOpen() {
		return searchOpen;
	}

	public void setSearchOpen(char searchOpen) {
		this.searchOpen = searchOpen;
	}

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	public char getVerify() {
		return verify;
	}

	public void setVerify(char verify) {
		this.verify = verify;
	}

	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public List<Clubmember> getClubMember() {
		return clubMember;
	}
	public void setClubMember(List<Clubmember> clubMember) {
		this.clubMember = clubMember;
	}
	@Override
	public String toString() {
		return "Member [memberCode=" + memberCode + ", memberId=" + memberId + ", password=" + password
				+ ", memberName=" + memberName + ", birthday=" + birthday + ", phone=" + phone + ", gender=" + gender
				+ ", profile=" + profile + ", renamedProfile=" + renamedProfile + ", blindDateOpen=" + blindDateOpen
				+ ", friendOpen=" + friendOpen + ", searchOpen=" + searchOpen + ", introduce=" + introduce + ", verify="
				+ verify + ", enrollDate=" + enrollDate + ", email=" + email + ",clubMember" + clubMember + "]";
	}
	
	
}
