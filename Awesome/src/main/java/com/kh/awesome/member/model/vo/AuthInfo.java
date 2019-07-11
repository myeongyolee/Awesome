package com.kh.awesome.member.model.vo;

import java.io.Serializable;


/* #googleLogin#1 :  Client Id와 Secret Key를 담을 VO 객체를 정의 */
public class AuthInfo implements Serializable {
	
	 private static final long serialVersionUID = 1L;

    private String clientId;
    private String clientSecret;
    
    
    public AuthInfo(String clientId, String clientSecret) {
        this.clientId = clientId;
        this.clientSecret = clientSecret;
    }
 
 
    public String getClientId() {
        return clientId;
    }
 
 
    public String getClientSecret() {
        return clientSecret;
    }
    
    
}
