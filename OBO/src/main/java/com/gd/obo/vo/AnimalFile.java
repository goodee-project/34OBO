package com.gd.obo.vo;

import lombok.Data;

@Data
public class AnimalFile {
	int animalFileId;
	int animalId;
	String animalFileName;
	double animalFileSize; // multipartFile 때문에 double로 바꿈
	String animalFileExt;
	String animalFileDate;
}
