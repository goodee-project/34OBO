package com.gd.obo.vo;

import lombok.Data;

@Data
public class Board {
	private int boardId;
	private int boardCategoryId;
	private String memberId;
	private int animalCategoryId;
	private String boardTitle;
	private String boardContent;
	private String createDate;
	private String updateDate;
}
