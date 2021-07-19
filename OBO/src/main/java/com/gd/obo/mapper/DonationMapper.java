package com.gd.obo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.DonationItemList;
import com.gd.obo.vo.DonationMoneyList;
import com.gd.obo.vo.PeriodicallyDonation;

@Mapper
public interface DonationMapper {
	int insertDonationMoneyList(DonationMoneyList donationMoneyList);
	List<DonationItemList> selectDonationItemList(int shelterId);
	List<DonationMoneyList> selectDonationMoneyNList(int shelterId);
	List<PeriodicallyDonation> selectDonationMoneyPList(int shelterId);
}
