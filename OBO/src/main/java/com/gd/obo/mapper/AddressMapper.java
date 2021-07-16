package com.gd.obo.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Address;

@Mapper
public interface AddressMapper {
	//주소 수정
	int updateAddress(Address address);
	//주소추가
	int insertAddress(Address address);
}
