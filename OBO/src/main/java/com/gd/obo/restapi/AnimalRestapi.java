package com.gd.obo.restapi;

import java.util.List;
import java.util.Map;

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
	
	//쉘터별 보호중인 동물 종 수
	@GetMapping("/getAnimalSpeciesCount")
	public List<Map<String, Object>> getAnimalSpeciesCount(@RequestParam(value="shelterId", required = false, defaultValue = "0")int shelterId){
		return animalService.getAnimalSpeciesCount(shelterId);
	}
	
	@GetMapping("/member/getAnimalLikeByMember")
	public int getAnimalLikeByMember(HttpSession session, @RequestParam(value="animalId", required=true) int animalId) {
		String memberId = ((Member) session.getAttribute("loginMember")).getMemberId();
		log.debug("===== animalId:"+animalId);
		int ck = animalService.getAnimalLikeByMember(memberId, animalId);
		return ck;
	}
	
	//회원 동물 좋아요
	@GetMapping("/member/addAnimalLike")
	public int addAnimalLike(HttpSession session, @RequestParam(value = "animalId", required = true) int animalId) {
		String memberId = ((Member)(session.getAttribute("loginMember"))).getMemberId();
		return animalService.addAnimalLike(memberId, animalId);
	}
	
	//회원 동물 좋아요 취소
	@GetMapping("/member/removeAnimalLike")
	public int removeAnimalLike(HttpSession session, @RequestParam(value = "animalId", required = true) int animalId) {
		String memberId = ((Member)(session.getAttribute("loginMember"))).getMemberId();
		return animalService.removeAnimalLike(memberId, animalId);
	}
	
}
