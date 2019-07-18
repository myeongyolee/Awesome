package com.kh.awesome.sms;

import java.util.Random;

public class TempKey {
	private int size;	
	private boolean lowerCheck;
    
    public String getKey(int size) {
        this.size = size;
        return init();
    }
    
    private String init() {
        Random ran = new Random();
        
        String num = "";

        for(int i=0;i<size;i++) {
            num += ran.nextInt(10);
        }

        return num;
    }
}