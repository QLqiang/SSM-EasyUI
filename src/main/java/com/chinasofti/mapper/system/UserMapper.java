package com.chinasofti.mapper.system;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.chinasofti.model.system.User;

public interface UserMapper {
    int deleteByPrimaryKey(String id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

	int editPassword(@Param("id")String id, @Param("oldPassword")String oldPassword, @Param("newPassword")String newPassword);

	List<Object> selectList(User user);

	long countList(User user);

	User selectOne(String id);
}