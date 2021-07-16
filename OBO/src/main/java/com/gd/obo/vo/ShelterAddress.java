package com.gd.obo.vo;

import lombok.Data;

@Data
public class ShelterAddress {
	private int addressId;
	private String postCode;
	private String doro;
	private String detailAddress;
	private int shelterId;
	private String shelterName;
	private String createDate;
	private String introduction;
	private int protectDuration;
	private String shelterPhone;
	private String account;
	private int active;
}
