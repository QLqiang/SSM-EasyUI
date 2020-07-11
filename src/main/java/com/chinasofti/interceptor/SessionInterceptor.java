package com.chinasofti.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SessionInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		Object obj = request.getSession().getAttribute("user");
		if(obj == null) {
			response.sendRedirect(request.getContextPath() + "/page/noSession.action");	
			return false;
		}
		return true;
	}
	
}
