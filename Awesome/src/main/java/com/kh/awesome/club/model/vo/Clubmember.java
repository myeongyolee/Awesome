package com.kh.awesome.club.model.vo;

import java.io.Serializable;

public class Clubmember implements Serializable{
	private int clubCode;
	private int clubmemberCode;
	private int clubmemGrade;
	private char clubjoinCheck;
	public Clubmember() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Clubmember(int clubCode, int clubmemberCode, int clubmemGrade, char clubjoinCheck) {
		super();
		this.clubCode = clubCode;
		this.clubmemberCode = clubmemberCode;
		this.clubmemGrade = clubmemGrade;
		this.clubjoinCheck = clubjoinCheck;
	}
	public int getClubCode() {
		return clubCode;
	}
	public void setClubCode(int clubCode) {
		this.clubCode = clubCode;
	}
	public int getClubmemberCode() {
		return clubmemberCode;
	}
	public void setClubmemberCode(int clubmemberCode) {
		this.clubmemberCode = clubmemberCode;
	}
	public int getClubmemGrade() {
		return clubmemGrade;
	}
	public void setClubmemGrade(int clubmemGrade) {
		this.clubmemGrade = clubmemGrade;
	}
	public char getClubjoinCheck() {
		return clubjoinCheck;
	}
	public void setClubjoinCheck(char clubjoinCheck) {
		this.clubjoinCheck = clubjoinCheck;
	}
	@Override
	public String toString() {
		return "Clubmember [clubCode=" + clubCode + ", clubmemberCode=" + clubmemberCode + ", clubmemGrade="
				+ clubmemGrade + ", clubjoinCheck=" + clubjoinCheck + "]";
	}
	
	
	
	
}
