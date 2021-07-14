package com.gd.obo.vo;


import lombok.Data;

@Data //@Setter, @Getter 해도댐
public class Page {
	private int rowPerPage;
	private int beginRow;
	private String searchWord;
}
