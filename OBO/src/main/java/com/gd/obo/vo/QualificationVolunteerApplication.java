package com.gd.obo.vo;

import lombok.Data;

@Data
public class QualificationVolunteerApplication {
	private int qualificationVolunteerApplicationId;
	private String memberId;
	private int volunteerCategoryId;
	private int qualificationTypeId;
	private int qualificationFileId;
	private String applicateDate;
	
}
