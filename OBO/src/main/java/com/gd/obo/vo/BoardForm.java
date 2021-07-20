package com.gd.obo.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardForm {
	private Board board;
	private List<MultipartFile> boardFile;
}
