package com.gd.obo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.obo.mapper.CareMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class CareService {
	@Autowired CareMapper careMapper;
	
	public List<Map<String, Object>> getCareInfoList(String searchWord, String species, String careSorting){
		return careMapper.selectCareInfoList(searchWord, species, careSorting);
	}
}
