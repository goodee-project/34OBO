package com.gd.obo.vo;

import lombok.Data;

@Data
public class BoardFile {
	int boardFileId;
	int boardId;
	String createDate;
	String boardFileOriginalName;
	String boardFileName;
	double boardFileSize;
	String boardFileExt;
}
