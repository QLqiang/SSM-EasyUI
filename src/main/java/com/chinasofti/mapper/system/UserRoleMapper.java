package com.chinasofti.mapper.system;

import com.chinasofti.model.system.UserRole;

public interface UserRoleMapper {
    int insert(UserRole record);

    int insertSelective(UserRole record);
    
    int deleteByUserId(String userid);
}