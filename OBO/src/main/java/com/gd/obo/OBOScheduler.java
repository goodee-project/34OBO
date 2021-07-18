package com.gd.obo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gd.obo.service.DonationService;
import com.gd.obo.vo.PeriodicallyDonation;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class OBOScheduler {
	@Autowired
	DonationService donationService;
	
	// 초 분 시 일 월 요일 -> 매월 1일 오전 10시에 정기결제 실시 // test 용: 0 * * * * * -
	@Scheduled(cron = "0 0 10 1 * *")
	public void addPeriodicallyDonationList() {
		log.debug("■■■■■■ 스케줄러 실행!");
		List<PeriodicallyDonation> list = donationService.getPeriodicallyDonationBYEndDateISNULL();
		
		for(PeriodicallyDonation p : list) {
			log.debug("■■■■■■■■■■■■ 확인 :" + p);
			donationService.addPeriodicallyDonationListByKakaoPay(p);//false면 실패...
		}
	}
}
