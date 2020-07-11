package com.chinasofti.controller.system;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.chinasofti.easyui.DataGridResult;
import com.chinasofti.model.system.User;
import com.chinasofti.service.system.UserService;
import com.chinasofti.util.MsgUtil;

@Controller
@RequestMapping("/system/user")
public class UserController {

	@Autowired
	private UserService userService;

	@RequestMapping("/user.action")
	public String user() {
		return "system/user";
	}

	@RequestMapping("/userAdd.action")
	public String userAdd() {
		return "system/userAdd";
	}
	
	@RequestMapping("/userImp.action")
	public String userImp() {
		return "system/userImp";
	}

	@RequestMapping("/userEdit.action")
	public ModelAndView userEdit(String id) {
		ModelAndView mav = new ModelAndView();
		User u = userService.selectOne(id);
		mav.setViewName("system/userEdit");
		mav.addObject("u", u);
		return mav;
	}

	@ResponseBody
	@RequestMapping("/login.action")
	public String login(String id, String password, HttpSession session) {
		MsgUtil msg = new MsgUtil();
		User user = userService.login(id, password);
		if (user != null) {
			if (user.getStatus().equals("1")) {
				msg.setSuccess(false);
				msg.setMessage("账号被冻结");
			} else {
				msg.setSuccess(true);
				session.setAttribute("user", user);
			}
		} else {
			msg.setSuccess(false);
			msg.setMessage("账号或密码错误");
		}
		return JSON.toJSONString(msg);
	}

	@ResponseBody
	@RequestMapping("/logout.action")
	public String logout(HttpSession session) {
		MsgUtil msg = new MsgUtil();
		session.invalidate();
		msg.setSuccess(true);
		return JSON.toJSONString(msg);
	}

	@ResponseBody
	@RequestMapping("/editPassword.action")
	public String editPassword(HttpSession session, String oldPassword, String newPassword) {
		Object obj = session.getAttribute("user");
		MsgUtil msg = new MsgUtil();
		if (obj != null) {
			User user = (User) obj;
			try {
				int count = userService.editPassword(user.getId(), oldPassword, newPassword);
				if (count == 1) {
					msg.setSuccess(true);
					msg.setMessage("修改成功");
				} else {
					msg.setSuccess(false);
					msg.setMessage("原密码不正确");
				}
			} catch (Exception e) {
				msg.setSuccess(false);
				msg.setMessage(e.getMessage());
			}
		} else {
			msg.setSuccess(false);
			msg.setMessage("请先登录账号");
		}
		return JSON.toJSONString(msg);
	}

	@ResponseBody
	@RequestMapping("/query.action")
	public String query(User user) {
		DataGridResult rs = userService.query(user);
		return JSON.toJSONString(rs);
	}

	@ResponseBody
	@RequestMapping("/remove.action")
	public String remove(String ids) {
		MsgUtil msg = new MsgUtil();
		try {
			int count = userService.remove(ids);
			msg.setSuccess(true);
			msg.setMessage("成功删除[" + count + "]条数据");
		} catch (Exception e) {
			msg.setSuccess(false);
			msg.setMessage(e.getMessage());
		}
		return JSON.toJSONString(msg);
	}

	@ResponseBody
	@RequestMapping("/add.action")
	public String add(User user, HttpSession session) {
		MsgUtil msg = new MsgUtil();
		try {
			int count = userService.add(user, session);
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
	public String edit(User user, HttpSession session) {
		MsgUtil msg = new MsgUtil();
		try {
			int count = userService.edit(user, session);
			msg.setSuccess(true);
			msg.setMessage("成功修改[" + count + "]条数据");
		} catch (Exception e) {
			msg.setSuccess(false);
			msg.setMessage(e.getMessage());
		}
		return JSON.toJSONString(msg);
	}

	@ResponseBody
	@RequestMapping("/checkid.action")
	public String checkid(String id) {
		MsgUtil msg = new MsgUtil();
		User user = userService.checkid(id);
		if (user != null) {
			msg.setSuccess(true);
		} else {
			msg.setSuccess(false);
		}
		return JSON.toJSONString(msg);
	}
	
	@ResponseBody
	@RequestMapping("/resetPassword.action")
	public String resetPassword(String ids) {
		MsgUtil msg = new MsgUtil();
		try {
			int count = userService.resetPassword(ids);
			msg.setSuccess(true);
			msg.setMessage("成功重置密码[" + count + "]条数据");
		} catch (Exception e) {
			msg.setSuccess(false);
			msg.setMessage(e.getMessage());
		}
		return JSON.toJSONString(msg);
	}
	
	@ResponseBody
	@RequestMapping("/imp.action")
	public String imp(MultipartFile userFile, HttpSession session) {
		MsgUtil msg = new MsgUtil();
		try {
			int count = userService.imp(userFile, session);
			msg.setSuccess(true);
			msg.setMessage("成功导入[" + count + "]条数据");
		} catch (Exception e) {
			msg.setSuccess(false);
			msg.setMessage(e.getMessage());
		}
		return JSON.toJSONString(msg);
	}

}
