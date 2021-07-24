package com.gd.obo.vo;

import lombok.Data;

@Data
public class CarePlan {
	private int carePlanId;
	private int animalId;
	private String memberId;
	private String staffId;
	private int careInfoId;
	private String careDate;
	private String createDate;
}
