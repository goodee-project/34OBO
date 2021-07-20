package com.gd.obo.vo;

import lombok.Data;

@Data
public class CareInfo {
	private int careInfoId;
	private int animalCategoryId;
	private int careTime;
	private String careInfoContent;
	private String careSorting;
}
