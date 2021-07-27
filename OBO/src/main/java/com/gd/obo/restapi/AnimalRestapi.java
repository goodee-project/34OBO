package com.gd.obo.restapi;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.obo.service.AnimalService;
import com.gd.obo.vo.Member;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class AnimalRestapi {
	@Autowired AnimalService animalService;
	@GetMapping("/getAnimalLikeByMember")
	public int getAnimalLikeByMember(HttpSession session, @RequestParam(value="animalId", required=true) int animalId) {
		String memberId = ((Member) session.getAttribute("loginMember")).getMemberId();
		log.debug("===== animalId:"+animalId);
		int ck = animalService.getAnimalLikeByMember(memberId, animalId);
		return ck;
	}
}
