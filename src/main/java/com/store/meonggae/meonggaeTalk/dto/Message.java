package com.store.meonggae.meonggaeTalk.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Message {
	private String message;
	private String nickname;
	private Date date;
 
	Message(){
		date = new Date();
	}
}
