package com.gd.obo.vo;

import lombok.Data;

@Data
public class BoardFile {
	private int boardFileId;
	private int boardId;
	private String createDate;
	private String boardFileOriginalName;
	private String boardFileName;
	private double boardFileSize;
	private String boardFileExt;
}
