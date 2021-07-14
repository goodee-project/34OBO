// 작성자 : 이윤정

package com.gd.obo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.obo.mapper.DonationMapper;
import com.gd.obo.vo.DonationItemList;
import com.gd.obo.vo.DonationMoneyList;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class DonationService {
	@Autowired DonationMapper donationMapper;
	
	// staff - 물품 후원 조회
	public List<DonationItemList> getDonationItemList(int shelterId){
		return donationMapper.selectDonationItemList(shelterId);
	}
	
	// staff - 돈 후원 조회
	public List<DonationMoneyList> getDonationMoneyList(int shelterId){
		return donationMapper.selectDonationMoneyList(shelterId);
	}
}
