package com.kh.awesome.member.model.vo;

public class Address {
	
	private int memberCode;
	private int postNo;
	private String address;
	private String roadAddress;
	private String detailAddress;
	private double placeLat;
	private double placeLng;
	
	public Address() {
	}

	public Address(int memberCode, int postNo, String address, String roadAddress, String detailAddress,
			double placeLat, double placeLng) {
		this.memberCode = memberCode;
		this.postNo = postNo;
		this.address = address;
		this.roadAddress = roadAddress;
		this.detailAddress = detailAddress;
		this.placeLat = placeLat;
		this.placeLng = placeLng;
	}

	public int getMemberCode() {
		return memberCode;
	}

	public void setMemberCode(int memberCode) {
		this.memberCode = memberCode;
	}

	public int getPostNo() {
		return postNo;
	}

	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getRoadAddress() {
		return roadAddress;
	}

	public void setRoadAddress(String roadAddress) {
		this.roadAddress = roadAddress;
	}

	public String getDetailAddress() {
		return detailAddress;
	}

	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}

	public double getPlaceLat() {
		return placeLat;
	}

	public void setPlaceLat(double placeLat) {
		this.placeLat = placeLat;
	}

	public double getPlaceLng() {
		return placeLng;
	}

	public void setPlaceLng(double placeLng) {
		this.placeLng = placeLng;
	}

	@Override
	public String toString() {
		return "Address [memberCode=" + memberCode + ", postNo=" + postNo + ", address=" + address + ", roadAddress="
				+ roadAddress + ", detailAddress=" + detailAddress + ", placeLat=" + placeLat + ", placeLng=" + placeLng
				+ "]";
	}
	
}
