package com.kh.awesome.board.model.exception;

public class BoardException extends RuntimeException {
//spring 에서는 runtimeException 을 상속하도록 한다. 
	public BoardException() {
		super();
	}

	public BoardException(String message) {
		super(message);
	}

	public BoardException(String message, Throwable cause) {
		super(message, cause);
	}

	public BoardException(Throwable cause) {
		super(cause);
	}
	
	
}