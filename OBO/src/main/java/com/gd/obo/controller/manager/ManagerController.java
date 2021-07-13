//작성자 : 남궁혜영
package com.gd.obo.controller.manager;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Transactional
@Controller
@Slf4j
@RequestMapping("/manager")
public class ManagerController {
	@GetMapping("/getQualificationApprovalList")
	public String getQvaList() {
		
		return "/manager/getQualificationApprovalList";
	}
}
