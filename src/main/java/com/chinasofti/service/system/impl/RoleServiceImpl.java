package com.chinasofti.service.system.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinasofti.easyui.DataGridResult;
import com.chinasofti.mapper.system.RoleAuthMapper;
import com.chinasofti.mapper.system.RoleMapper;
import com.chinasofti.model.system.Auth;
import com.chinasofti.model.system.Role;
import com.chinasofti.model.system.RoleAuth;
import com.chinasofti.service.system.RoleService;
import com.chinasofti.util.UserUtil;

@Service
public class RoleServiceImpl implements RoleService {
	
	@Autowired
	private RoleMapper roleMapper;
	
	@Autowired
	private RoleAuthMapper roleAuthMapper;

	@Override
	public DataGridResult query(Role role) {
		DataGridResult rs = new DataGridResult();
		role.setPage((role.getPage()-1)*role.getRows());
		rs.setRows(roleMapper.selectList(role));
		rs.setTotal(roleMapper.countList(role));
		return rs;
	}

	@Override
	@Transactional
	public int add(Role role, HttpSession session) {
		role.setCreateid(UserUtil.userid(session));
		role.setCreatetime(new Date());
		int count = roleMapper.insertSelective(role);
		for(String authid : role.getAuthids()) {
			RoleAuth  ra = new RoleAuth();
			ra.setAuthid(Integer.parseInt(authid));
			ra.setRoleid(role.getId());
			roleAuthMapper.insert(ra);
		}
		return count;
	}

	@Override
	public Role selectOne(Integer id) {
		Role role = roleMapper.selectOne(id);
		List<String> list = new ArrayList<String>();
		for(Auth auth : role.getAuths()) {
			list.add(String.valueOf(auth.getId()));
		}
		role.setAuthStr(String.join(",", list));//id,id,id,id
		return role;
	}

	@Override
	@Transactional
	public int edit(Role role, HttpSession session) {
		role.setModifyid(UserUtil.userid(session));
		role.setModifytime(new Date());
		//修改权限分2部分 1、删除原来的权限 2、新增修改的权限
		roleAuthMapper.deleteByRoleId(role.getId());
		for(String authid : role.getAuthids()) {
			RoleAuth  ra = new RoleAuth();
			ra.setAuthid(Integer.parseInt(authid));
			ra.setRoleid(role.getId());
			roleAuthMapper.insert(ra);
		}
		return roleMapper.updateByPrimaryKeySelective(role);
	}

	@Override
	@Transactional
	public int remove(String ids) {
		int count = 0;
		String[] data = ids.split(",");
		for(String id : data) {
			roleAuthMapper.deleteByRoleId(Integer.parseInt(id));
			count += roleMapper.deleteByPrimaryKey(Integer.parseInt(id));
		}
		return count;
	}

	@Override
	public List<Role> combobox() {
		return roleMapper.combobox();
	}

}
