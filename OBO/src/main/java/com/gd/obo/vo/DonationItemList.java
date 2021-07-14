package com.gd.obo.vo;

import lombok.Data;

@Data
public class DonationItemList {
	private int donationItemListId;
	private String memberId;
	private int shelterId;
	private int itemCategoryId;
	private String donationDate;
	private String itemName;
	private int itemQuantity;
	private String itemDescription;
}
