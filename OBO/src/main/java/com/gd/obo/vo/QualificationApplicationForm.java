package com.gd.obo.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class QualificationApplicationForm {
	private QualificationVolunteerApplication qualificationVolunteerApplication;
	private MultipartFile qualificationFile;
}
	