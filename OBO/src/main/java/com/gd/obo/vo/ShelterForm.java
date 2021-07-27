package com.gd.obo.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ShelterForm {
	private Shelter shelter;
	private List<MultipartFile> shelterFile;
}
