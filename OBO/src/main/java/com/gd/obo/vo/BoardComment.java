package com.gd.obo.vo;

import lombok.Data;

@Data
public class BoardComment {
	private int boardCommentId;
	private int boardId;
	private String memberId;
	private String boardCommentContent;
	private String createDate;
}
