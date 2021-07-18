package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.DonationItemList;
import com.gd.obo.vo.DonationMoneyList;
import com.gd.obo.vo.PeriodicallyDonation;

@Mapper
public interface DonationMapper {
	List<Map<String,Object>> selectPeriodicallyDonationByMemberId(String memberId);
	int updatePeriodicallyDonationByEndDate(int periodicallyDonationId);
	String selectPeriodicallyDonationByPeriodicallyDonationId(int periodicallyDonationId);
	List<PeriodicallyDonation> selectPeriodicallyDonationBYEndDateISNULL();//정기결제 중인 정기결제 리스트
	int insertPeriodicallyDonationList(int periodicallyDonationId);
	int insertPeriodicallyDonation(PeriodicallyDonation periodicallyDonation);
	int insertDonationMoneyList(DonationMoneyList donationMoneyList);
	List<DonationItemList> selectDonationItemList(int shelterId);
	List<DonationMoneyList> selectDonationMoneyList(int shelterId);
}
