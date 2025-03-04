package com.example.test1.model;

import lombok.Data; //롬복이가 GET, SET해줌

@Data
public class Board {

	private String boardNo;
	private String title;
	private String contents;
	private String userId;
	private String userName;
	private String kind;
	private String favorite;
	private String cnt;
	private String subtitle;
	private String deleteYn;
	private String cDateTime;
	private String uDateTime;

}
