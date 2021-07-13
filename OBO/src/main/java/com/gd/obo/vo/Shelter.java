package com.gd.obo.vo;

import lombok.Data;

@Data
public class Shelter {
	private int shelterId;
	private int addressId;
	private String shelterName;
	private String createDate;
	private String introduction;
	private int protextDuration;
	private String shelterPhone;
	private String account;
	private int active;
}
