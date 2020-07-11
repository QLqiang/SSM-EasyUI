package com.chinasofti.controller.system;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.chinasofti.model.TreeNode;
import com.chinasofti.model.system.Auth;
import com.chinasofti.service.system.AuthService;
import com.chinasofti.util.MsgUtil;

@Controller
@RequestMapping("/system/auth")
public class AuthController {
	
	@Autowired
	private AuthService authService;
	
	@RequestMapping("/auth.action")
	public String auth() {
		return "system/auth";
	}
	
	@RequestMapping("/authAdd.action")
	public String authAdd() {
		return "system/authAdd";
	}
	
	@RequestMapping("/authEdit.action")
	public ModelAndView authEdit(int id) {
		ModelAndView mav = new ModelAndView();
		Auth auth = authService.selectByPrimaryKey(id);
		mav.addObject("auth", auth);
		mav.setViewName("system/authEdit");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/query.action")
	public String query() {
		List<Auth> list = authService.query();
		return JSON.toJSONString(list);
	}
	
	@ResponseBody
	@RequestMapping("/combotree.action")
	public String combotree() {
		List<TreeNode> tree = authService.combotree();
		return JSON.toJSONString(tree);
	}
	
	@ResponseBody
	@RequestMapping("/add.action")
	public String add(Auth auth) {
		MsgUtil msg = new MsgUtil();
		try {
			int count = authService.add(auth);
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
	public String edit(Auth auth) {
		MsgUtil msg = new MsgUtil();
		try {
			int count = authService.edit(auth);
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
	public String remove(int id) {
		MsgUtil msg = new MsgUtil();
		try {
			int count = authService.remove(id);
			msg.setSuccess(true);
			msg.setMessage("成功删除[" + count + "]条数据");
		} catch (Exception e) {
			msg.setSuccess(false);
			msg.setMessage("请先删除子项目!");
		}
		return JSON.toJSONString(msg);
	}

}
