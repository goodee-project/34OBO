package com.gd.obo.vo;

import lombok.Data;

@Data
public class Animal {
	private int animalId;
	private int animalCategoryId;
	private int shelterId;
	private String animalName;
	private int animalAge; // 개월
	private String animalSex; // '수컷','암컷' => ENUM
	private double animalWeight;
	private String animalKind;
	private String animalFindPlace;
	private String animalNote; // 회원들한테 보여줄 소개 ex 추정나이
	private String animalEnterDate;
	private String animalExitDate;
	private String animalIntroduce;
	private String animalState; // '입양','보호중','안락사','자연사' => ENUM
}
