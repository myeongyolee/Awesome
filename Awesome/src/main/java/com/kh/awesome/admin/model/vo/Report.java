package com.kh.awesome.admin.model.vo;

public class Report {
	private int memberCode;
	private String reportType;
	private int reportedCode;
	private String reportedType;
	private String reportComment;
	
	public Report() {}

	public Report(int memberCode, String reportType, int reportedCode, String reportedType, String reportComment) {
		super();
		this.memberCode = memberCode;
		this.reportType = reportType;
		this.reportedCode = reportedCode;
		this.reportedType = reportedType;
		this.reportComment = reportComment;
	}

	public int getMemberCode() {
		return memberCode;
	}

	public void setMemberCode(int memberCode) {
		this.memberCode = memberCode;
	}

	public String getReportType() {
		return reportType;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	public int getReportedCode() {
		return reportedCode;
	}

	public void setReportedCode(int reportedCode) {
		this.reportedCode = reportedCode;
	}

	public String getReportedType() {
		return reportedType;
	}

	public void setReportedType(String reportedType) {
		this.reportedType = reportedType;
	}

	public String getReportComment() {
		return reportComment;
	}

	public void setReportComment(String reportComment) {
		this.reportComment = reportComment;
	}

	@Override
	public String toString() {
		return "Report [memberCode=" + memberCode + ", reportType=" + reportType + ", reportedCode=" + reportedCode
				+ ", reportedType=" + reportedType + ", reportComment=" + reportComment + "]";
	}
	
	
}
