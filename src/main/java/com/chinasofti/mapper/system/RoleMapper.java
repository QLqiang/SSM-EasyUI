package com.chinasofti.mapper.system;

import java.util.List;

import com.chinasofti.model.system.Role;

public interface RoleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Role record);

    int insertSelective(Role record);

    Role selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);

	List<Object> selectList(Role role);

	long countList(Role role);

	List<Role> combobox();

	Role selectOne(Integer id);
}