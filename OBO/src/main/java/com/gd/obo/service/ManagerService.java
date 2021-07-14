//작성자 : 남궁혜영
package com.gd.obo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gd.obo.controller.ManagerHomeController;
import com.gd.obo.mapper.ManagerMapper;
import com.gd.obo.vo.Manager;

import lombok.extern.slf4j.Slf4j;

@Transactional
@Service
@Slf4j
public class ManagerService {
	@Autowired ManagerMapper managerMapper;

	//매니저 로그인
	public Manager login(Manager manager) {
		log.debug("======매니저 로그인");
		return managerMapper.selectManagerByLogin(manager);
	}
	
	//자격 승인 내역
	public List<String> getQualificationApprovalList(){
		List<String> list = managerMapper.selectQualificationApprovalList();
		log.debug("======자격 승인 리스트 : "+list);
		return list;
	}
}
