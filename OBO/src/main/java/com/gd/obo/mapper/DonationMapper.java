package com.gd.obo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.DonationItemList;
import com.gd.obo.vo.DonationMoneyList;
import com.gd.obo.vo.ItemCategory;
import com.gd.obo.vo.PeriodicallyDonation;

@Mapper
public interface DonationMapper {
	Map<String, Object> selectDonationItemOne(int donationItemListId);
	int selectDonationItemByMemberIdTotal(String memberId);
	List<Map<String, Object>> selectDonationItemByMemberId(Map<String, Object> map);
	int insertDonationItemList(DonationItemList donationItemList);
	List<ItemCategory> selectItemCategoryList();
	int selectTotalMoneyByMemberId(String memberId);
	int selectFullMoneyDonationListByMemberIdTotal(String memberId);
	List<Map<String,Object>> selectFullMoneyDonationListByMemberId(Map<String, Object> map);
	int selectPeriodicallyDonationByMemberIdTotal(String memberId);
	List<Map<String,Object>> selectPeriodicallyDonationByMemberId(Map<String, Object> map);
	int updatePeriodicallyDonationByEndDate(int periodicallyDonationId);
	String selectPeriodicallyDonationByPeriodicallyDonationId(int periodicallyDonationId);
	List<PeriodicallyDonation> selectPeriodicallyDonationBYEndDateISNULL();//정기결제 중인 정기결제 리스트
	int insertPeriodicallyDonationList(int periodicallyDonationId);
	int insertPeriodicallyDonation(PeriodicallyDonation periodicallyDonation);
	int insertDonationMoneyList(DonationMoneyList donationMoneyList);
	List<Map<String, Object>> selectDonationItemList(Map<String, Object> map);
	List<Map<String, Object>> selectDonationMoneyNList(Map<String, Object> map);
	List<Map<String, Object>> selectDonationMoneyPList(Map<String, Object> map);
	Map<String, Object> selectDonationMoneyThisMonth(int shelterId);
	List<Map<String, Object>> selectDonationItemLast(int shelterId);
	List<Map<String, Object>> selectDonationMoneyByPeriod(Map<String, Object> map);
	List<Map<String, Object>> selectDonationItemByPeriod(Map<String, Object> map);
}
