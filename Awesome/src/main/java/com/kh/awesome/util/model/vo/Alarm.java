package com.kh.awesome.util.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Alarm implements Serializable{

	private static final long serialVersionUID = 1L;

	private String memberCode;
	private String receiveMemberCode;
	private String status;
	private String alarmContent;
	private Date log_date;
	
	public Alarm() {}

	public Alarm(String memberCode, String receiveMemberCode, String status, String alarmContent, Date log_date) {
		super();
		this.memberCode = memberCode;
		this.receiveMemberCode = receiveMemberCode;
		this.status = status;
		this.alarmContent = alarmContent;
		this.log_date = log_date;
	}

	public String getMemberCode() {
		return memberCode;
	}

	public void setMemberCode(String memberCode) {
		this.memberCode = memberCode;
	}

	public String getReceiveMemberCode() {
		return receiveMemberCode;
	}

	public void setReceiveMemberCode(String receiveMemberCode) {
		this.receiveMemberCode = receiveMemberCode;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getAlarmContent() {
		return alarmContent;
	}

	public void setAlarmContent(String alarmContent) {
		this.alarmContent = alarmContent;
	}

	public Date getLog_date() {
		return log_date;
	}

	public void setLog_date(Date log_date) {
		this.log_date = log_date;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
}
