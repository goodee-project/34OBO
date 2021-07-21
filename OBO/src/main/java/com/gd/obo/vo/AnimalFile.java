package com.gd.obo.vo;

import lombok.Data;

@Data
public class AnimalFile {
	int animalFileId;
	int animalId;
	String animalFileName;
	int animalFileSize;
	String animalFileExt;
	String animalFileDate;
}
