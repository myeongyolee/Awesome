package com.kh.awesome.club.model.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

public class Clubcontent implements Serializable{
	private int clubcontentCode;
	private int clubCode;
	private int memberCode;
	private String contentTitle;
	private String content;
	private int writeLevel;
	private Date writeDate;
	private String memberNickname;
	private List<Clubphoto> clubPhotos;
	public Clubcontent() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Clubcontent(int clubcontentCode, int clubCode, int memberCode, String contentTitle, String content,
			int writeLevel, Date writeDate, String memberNickname, List<Clubphoto> clubPhotos) {
		super();
		this.clubcontentCode = clubcontentCode;
		this.clubCode = clubCode;
		this.memberCode = memberCode;
		this.contentTitle = contentTitle;
		this.content = content;
		this.writeLevel = writeLevel;
		this.writeDate = writeDate;
		this.memberNickname = memberNickname;
		this.clubPhotos = clubPhotos;
	}
	public int getClubcontentCode() {
		return clubcontentCode;
	}
	public void setClubcontentCode(int clubcontentCode) {
		this.clubcontentCode = clubcontentCode;
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
	public String getContentTitle() {
		return contentTitle;
	}
	public void setContentTitle(String contentTitle) {
		this.contentTitle = contentTitle;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getWriteLevel() {
		return writeLevel;
	}
	public void setWriteLevel(int writeLevel) {
		this.writeLevel = writeLevel;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	public String getMemberNickname() {
		return memberNickname;
	}
	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}
	public List<Clubphoto> getClubPhotos() {
		return clubPhotos;
	}
	public void setClubPhotos(List<Clubphoto> clubPhotos) {
		this.clubPhotos = clubPhotos;
	}
	@Override
	public String toString() {
		return "Clubcontent [clubcontentCode=" + clubcontentCode + ", clubCode=" + clubCode + ", memberCode="
				+ memberCode + ", contentTitle=" + contentTitle + ", content=" + content + ", writeLevel=" + writeLevel
				+ ", writeDate=" + writeDate + ", memberNickname=" + memberNickname + ", clubPhotos=" + clubPhotos
				+ "]";
	}
	
	
	
	
}
