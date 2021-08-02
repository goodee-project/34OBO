package com.gd.obo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gd.obo.service.AnimalService;
import com.gd.obo.service.DonationService;
import com.gd.obo.vo.PeriodicallyDonation;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class OBOScheduler {
	@Autowired
	DonationService donationService;
	@Autowired
	AnimalService animalService;
	
	//안락사 실행
	@Scheduled(cron = "0 0 14 * * *")
	public void modifyAnimalByEuthanasia() {
		log.debug("■■■■■■ 스케줄러 실행!");
		List<Integer> animalId = animalService.getAnimalListByEuthanasia();
		animalService.modifyAnimalByEuthanasia(animalId);
	}
	
	// 초 분 시 일 월 요일 -> 매월 1일 오전 10시에 정기결제 실시 // test 용: 0 * * * * * -
	@Scheduled(cron = "0 0 10 1 * *")
	public void addPeriodicallyDonationList() {
		log.debug("■■■■■■ 스케줄러 실행!");
		List<PeriodicallyDonation> list = donationService.getPeriodicallyDonationBYEndDateISNULL();
		
		for(PeriodicallyDonation p : list) {
			log.debug("■■■■■■■■■■■■ 확인 :" + p);
			//카카오 sid가 끊겨서(test사용) 카카오 페이 안되게 사용 안함...
			////false면 실패...
			/*
			if(donationService.addPeriodicallyDonationListByKakaoPay(p) == true) {
				donationService.addPeriodicallyDonationList(p);
			}
			*/
			donationService.addPeriodicallyDonationList(p);
		}
	}
}
