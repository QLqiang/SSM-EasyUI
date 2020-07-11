package com.chinasofti.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.chinasofti.model.system.User;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		Object obj = request.getSession().getAttribute("user");
		User user = (User)obj;
		if(user.getId().equals("admin")) return true;
		String authUrls = user.getAhthStr();
		if(!authUrls.contains(request.getRequestURI().substring(request.getContextPath().length()))) {
			response.sendRedirect(request.getContextPath() + "/page/noAuth.action");
			return false;
		}
		return true;
	}
	
}
