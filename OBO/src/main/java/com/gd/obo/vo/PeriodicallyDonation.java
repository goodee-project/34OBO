package com.gd.obo.vo;

import lombok.Data;

@Data
public class PeriodicallyDonation {
	private int periodicallyDonationId;
	private String memberId;
	private int shelterId;
	private String endDate;
	private String applyDate;
	private int amount;
	private String sid;
}
