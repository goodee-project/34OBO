package com.gd.obo.vo;

import lombok.Data;

@Data
public class ShelterFile {
	private int shelterFileId;
	private int shelterId;
	private String shelterFileName;
	private double shelterFileSize;  // multipartFile 때문에 double로 바꿈
	private String shelterFileExt;
	private String uploadDate;
}
