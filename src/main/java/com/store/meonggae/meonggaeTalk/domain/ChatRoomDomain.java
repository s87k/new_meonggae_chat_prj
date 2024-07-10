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
public class ChatRoomDomain {
	private String nickOpponent, imgOpponent, goodsNum, content;
	private int memNumOpponent;
	private Date inputDate;
	private boolean readFlag;
}
