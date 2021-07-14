package com.gd.obo.vo;

import lombok.Data;

@Data
public class DonationMoneyList {
	private int donationMoneyListId;
	private String memberId;
	private int shelterId;
	private String donationDate;
	private int amount;
}
