package com.chinasofti.mapper.system;

import java.util.List;

import com.chinasofti.model.system.Auth;

public interface AuthMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Auth record);

    int insertSelective(Auth record);

    Auth selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Auth record);

    int updateByPrimaryKey(Auth record);

	List<Auth> query();
	
	List<Auth> queryRoot();

	Auth selectByPK(Integer id);
}