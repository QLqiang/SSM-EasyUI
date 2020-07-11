package com.chinasofti.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 
 * @author ThinkPad
 * @since 项目架构中各个公共部分跳转使用
 */
@Controller
@RequestMapping("/page")
public class PageController {
	
	@RequestMapping("/login.action")
	public String login() {
		return "login";
	}
	
	@RequestMapping("/index.action")
	public String index() {
		return "index";
	}
	
	@RequestMapping("/south.action")
	public String south() {
		return "/layout/south";
	}
	

	@RequestMapping("/north.action")
	public String north() {
		return "/layout/north";
	}
	

	@RequestMapping("/west.action")
	public String west() {
		return "/layout/west";
	}
	

	@RequestMapping("/center.action")
	public String center() {
		return "/layout/center";
	}
	
	@RequestMapping("/noSession.action")
	public String noSession() {
		return "/error/noSession";
	}
	
	@RequestMapping("/noAuth.action")
	public String noAuth() {
		return "/error/noAuth";
	}
}
