package com.gd.obo.mapper.manager;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.obo.vo.manager.Manager;

@Mapper
public interface ManagerMapper {
	Manager selectManagerByLogin(Manager manager);
}
