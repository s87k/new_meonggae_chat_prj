package com.store.meonggae.meonggaeTalk.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ChatDomain {
	private String nickOpponent, imgOpponent, content, goodsNum, strDate;
	private int memNumOpponent, memNumSend,memNumRecv; 
	private Date inputDate;
}
