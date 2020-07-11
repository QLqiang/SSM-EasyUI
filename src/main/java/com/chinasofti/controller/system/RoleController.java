package com.chinasofti.controller.system;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.alibaba.fastjson.JSON;
import com.chinasofti.easyui.DataGridResult;
import com.chinasofti.model.system.Role;
import com.chinasofti.service.system.RoleService;
import com.chinasofti.util.MsgUtil;

@Controller
@RequestMapping("/system/role")
public class RoleController {
	
	@Autowired
	private RoleService roleService;
	
	@RequestMapping("/role.action")
	public String role() {
		return "system/role";
	}
	
	@RequestMapping("/roleAdd.action")
	public String roleAdd() {
		return "system/roleAdd";
	}
	

	@RequestMapping("/roleEdit.action")
	public ModelAndView roleEdit(Integer id) {
		ModelAndView mav = new ModelAndView();
		Role role = roleService.selectOne(id);
		mav.setViewName("system/roleEdit");
		mav.addObject("role", role);
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/query.action")
	public String query(Role role) {
		DataGridResult rs = roleService.query(role);
		return JSON.toJSONString(rs);
	}
	
	@ResponseBody
	@RequestMapping("/add.action")
	public String add(Role role, HttpSession session) {
		MsgUtil msg = new MsgUtil();
		try {
			int count = roleService.add(role, session);
			msg.setSuccess(true);
			msg.setMessage("成功新增[" + count + "]条数据");
		} catch (Exception e) {
			msg.setSuccess(false);
			msg.setMessage(e.getMessage());
		}
		return JSON.toJSONString(msg);
	}
	
	@ResponseBody
	@RequestMapping("/edit.action")
	public String edit(Role role, HttpSession session) {
		MsgUtil msg = new MsgUtil();
		try {
			int count = roleService.edit(role, session);
			msg.setSuccess(true);
			msg.setMessage("成功修改[" + count + "]条数据");
		} catch (Exception e) {
			msg.setSuccess(false);
			msg.setMessage(e.getMessage());
		}
		return JSON.toJSONString(msg);
	}


	@ResponseBody
	@RequestMapping("/remove.action")
	public String remove(String ids) {
		MsgUtil msg = new MsgUtil();
		try {
			int count = roleService.remove(ids);
			msg.setSuccess(true);
			msg.setMessage("成功删除[" + count + "]条数据");
		} catch (Exception e) {
			msg.setSuccess(false);
			msg.setMessage(e.getMessage());
		}
		return JSON.toJSONString(msg);
	}
	
	@ResponseBody
	@RequestMapping("/combobox.action")
	public String query() {
		List<Role> roleList = roleService.combobox();
		return JSON.toJSONString(roleList);
	}


}
