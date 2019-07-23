package com.kh.awesome.club.model.vo;

import java.io.Serializable;
import java.util.List;

public class Clubphoto implements Serializable{
	private int photorowNum;
	private int clubcontentCode;
	private int clubCode;
	private String cluboriginalFilename;
	private String clubrenamedFilename;
	private String picInfo;
	private int clubphotoNum;
	private List<Clubcomment> clubComments;
	public Clubphoto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Clubphoto(int photorowNum, int clubcontentCode, int clubCode, String cluboriginalFilename,
			String clubrenamedFilename, String picInfo, int clubphotoNum, List<Clubcomment> clubComments) {
		super();
		this.photorowNum = photorowNum;
		this.clubcontentCode = clubcontentCode;
		this.clubCode = clubCode;
		this.cluboriginalFilename = cluboriginalFilename;
		this.clubrenamedFilename = clubrenamedFilename;
		this.picInfo = picInfo;
		this.clubphotoNum = clubphotoNum;
		this.clubComments = clubComments;
	}
	public int getPhotorowNum() {
		return photorowNum;
	}
	public void setPhotorowNum(int photorowNum) {
		this.photorowNum = photorowNum;
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
	public String getCluboriginalFilename() {
		return cluboriginalFilename;
	}
	public void setCluboriginalFilename(String cluboriginalFilename) {
		this.cluboriginalFilename = cluboriginalFilename;
	}
	public String getClubrenamedFilename() {
		return clubrenamedFilename;
	}
	public void setClubrenamedFilename(String clubrenamedFilename) {
		this.clubrenamedFilename = clubrenamedFilename;
	}
	public String getPicInfo() {
		return picInfo;
	}
	public void setPicInfo(String picInfo) {
		this.picInfo = picInfo;
	}
	public int getClubphotoNum() {
		return clubphotoNum;
	}
	public void setClubphotoNum(int clubphotoNum) {
		this.clubphotoNum = clubphotoNum;
	}
	public List<Clubcomment> getClubComments() {
		return clubComments;
	}
	public void setClubComments(List<Clubcomment> clubComments) {
		this.clubComments = clubComments;
	}
	@Override
	public String toString() {
		return "Clubphoto [photorowNum=" + photorowNum + ", clubcontentCode=" + clubcontentCode + ", clubCode="
				+ clubCode + ", cluboriginalFilename=" + cluboriginalFilename + ", clubrenamedFilename="
				+ clubrenamedFilename + ", picInfo=" + picInfo + ", clubphotoNum=" + clubphotoNum + ", clubComments="
				+ clubComments + "]";
	}
	
	
	
}
