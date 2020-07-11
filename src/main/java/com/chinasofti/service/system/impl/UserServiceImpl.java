package com.chinasofti.service.system.impl;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import com.chinasofti.easyui.DataGridResult;
import com.chinasofti.mapper.system.RoleMapper;
import com.chinasofti.mapper.system.UserMapper;
import com.chinasofti.mapper.system.UserRoleMapper;
import com.chinasofti.model.system.Auth;
import com.chinasofti.model.system.Role;
import com.chinasofti.model.system.User;
import com.chinasofti.model.system.UserRole;
import com.chinasofti.service.system.UserService;
import com.chinasofti.util.Md5Util;
import com.chinasofti.util.UserUtil;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private UserRoleMapper userRoleMapper;
	
	@Autowired
	private RoleMapper roleMapper;

	@Override
	public User login(String id, String password) {
		User user = userMapper.selectOne(id);
		if (user == null || !Md5Util.md5(password).equals(user.getPassword())) {
			user = null;
		}else {
			//通过用户的角色获取用户的所有权限
			List<Auth> auths = new ArrayList<Auth>();
			List<Role> roles = user.getRoles();
			if(roles != null) {
				for(Role role : roles) {
					Role r = roleMapper.selectOne(role.getId());
					auths.addAll(r.getAuths());
				}
				List<String> authList = new ArrayList<String>();
				for(Auth auth : auths) {
					authList.add(auth.getUrl());
				}
				user.setAhthStr(String.join(",", authList));
			}
		}
		return user;
	}

	@Override
	public int editPassword(String id, String oldPassword, String newPassword) {
		return userMapper.editPassword(id, Md5Util.md5(oldPassword), Md5Util.md5(newPassword));
	}

	@Override
	public DataGridResult query(User user) {
		DataGridResult rs = new DataGridResult();
		user.setPage((user.getPage()-1)*user.getRows());
		rs.setRows(userMapper.selectList(user));
		rs.setTotal(userMapper.countList(user));
		return rs;
	}

	@Override
	@Transactional
	public int remove(String ids) {
		int count = 0;
		String[] data = ids.split(",");
		for(String id : data) {
			userRoleMapper.deleteByUserId(id);
			count += userMapper.deleteByPrimaryKey(id);
		}
		return count;
	}

	@Override
	@Transactional
	public int add(User user, HttpSession session) {
		user.setStatus("0");
		user.setCreateid(UserUtil.userid(session));
		user.setCreatetime(new Date());
		user.setPassword(Md5Util.md5(user.getPassword()));
		//同时需要增userrole中间表
		int count = userMapper.insertSelective(user);
		if(user.getRoleids() != null) {
			for(String roleid : user.getRoleids()) {
				UserRole ur = new UserRole();
				ur.setUserid(user.getId());
				ur.setRoleid(Integer.parseInt(roleid));
				userRoleMapper.insert(ur);
			}
		}
		return count;
	}

	@Override
	public User checkid(String id) {
		return userMapper.selectByPrimaryKey(id);
	}
	
	@Override
	public User selectOne(String id) {
		User user = userMapper.selectOne(id);
		List<Role> roles = user.getRoles();
		List<String> roleids = new ArrayList<String>();
		for(int i = 0 ; i < roles.size(); i++) {
			roleids.add(String.valueOf(roles.get(i).getId()));
		}
		user.setRoleStr(String.join(",",roleids));
		return user;
	}

	@Override
	@Transactional
	public int edit(User user, HttpSession session) {
		user.setModifyid(UserUtil.userid(session));
		user.setModifytime(new Date());
		if(!StringUtils.isEmpty(user.getPassword())) {
			user.setPassword(Md5Util.md5(user.getPassword()));
		}
		userRoleMapper.deleteByUserId(user.getId());
		if(user.getRoleids() != null) {
			for(String roleid : user.getRoleids()) {
				UserRole ur = new UserRole();
				ur.setUserid(user.getId());
				ur.setRoleid(Integer.parseInt(roleid));
				userRoleMapper.insertSelective(ur);
			}
		}
		return userMapper.updateByPrimaryKeySelective(user);
	}

	@Override
	@Transactional
	public int resetPassword(String ids) {
		int count = 0;
		String[] data = ids.split(",");
		for(String id : data) {
			User user = userMapper.selectByPrimaryKey(id);
			user.setPassword(Md5Util.md5("1234"));
			count += userMapper.updateByPrimaryKeySelective(user);
		}
		return count;
	}

	@Override
	@Transactional
	public int imp(MultipartFile userFile, HttpSession session) throws Exception {
		int count = 0;
		Workbook readwb = null;
		if (!userFile.isEmpty()) {
			InputStream instream = userFile.getInputStream();
			readwb = Workbook.getWorkbook(instream);
			Sheet readsheet = readwb.getSheet(0);
			int rsColumns = readsheet.getColumns();
			int rsRows = readsheet.getRows();
			for (int i = 1; i < rsRows; i++) {
				User user = new User();
				user.setStatus("0");
				user.setCreateid(UserUtil.userid(session));
				user.setCreatetime(new Date());
				for (int j = 0; j < rsColumns; j++) {
					Cell cell = readsheet.getCell(j, i);
					switch (j) {
					case 0:
						user.setId(cell.getContents());
						continue;
					case 1:
						user.setName(cell.getContents());
						continue;
					case 2:
						user.setPassword(Md5Util.md5(cell.getContents()));
						continue;
					default:
						break;
					}
				}
				count += this.userMapper.insertSelective(user);
			}
		}
		return count;
	}

}
