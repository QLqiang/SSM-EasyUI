package com.chinasofti.service.system;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.chinasofti.easyui.DataGridResult;
import com.chinasofti.model.system.Role;

public interface RoleService {

	DataGridResult query(Role role);

	int add(Role role, HttpSession session);

	Role selectOne(Integer id);

	int edit(Role role, HttpSession session);

	int remove(String ids);

	List<Role> combobox();

}
