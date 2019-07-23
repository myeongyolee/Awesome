package com.kh.awesome.club.model.vo;

import java.io.Serializable;

public class Clublocal implements Serializable{
	private int localCode;
	private int cityCode;
	private String localName;
	public Clublocal() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Clublocal(int localCode, int cityCode, String localName) {
		super();
		this.localCode = localCode;
		this.cityCode = cityCode;
		this.localName = localName;
	}
	public int getLocalCode() {
		return localCode;
	}
	public void setLocalCode(int localCode) {
		this.localCode = localCode;
	}
	public int getCityCode() {
		return cityCode;
	}
	public void setCityCode(int cityCode) {
		this.cityCode = cityCode;
	}
	public String getLocalName() {
		return localName;
	}
	public void setLocalName(String localName) {
		this.localName = localName;
	}
	@Override
	public String toString() {
		return "Clublocal [localCode=" + localCode + ", cityCode=" + cityCode + ", localName=" + localName + "]";
	}
	
	
}
