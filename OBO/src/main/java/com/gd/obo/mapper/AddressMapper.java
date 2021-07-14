package com.gd.obo.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.Address;

@Mapper
public interface AddressMapper {
	int insertAddress(Address address);
}
