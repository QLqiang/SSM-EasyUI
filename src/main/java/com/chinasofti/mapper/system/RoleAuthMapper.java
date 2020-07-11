package com.chinasofti.mapper.system;

import com.chinasofti.model.system.RoleAuth;

public interface RoleAuthMapper {
    int insert(RoleAuth record);

    int insertSelective(RoleAuth record);
    
    int deleteByRoleId(int roleid);

	void deleteByAuthId(int id);
}