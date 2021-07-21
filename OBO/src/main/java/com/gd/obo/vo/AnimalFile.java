package com.gd.obo.vo;

import lombok.Data;

@Data
public class AnimalFile {
	private int animalFileId;
	private int animalId;
	private String animalFileName;
	private double animalFileSize; // multipartFile 때문에 double로 바꿈
	private String animalFileExt;
	private String animalFileDate;
}
