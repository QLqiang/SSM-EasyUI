package com.chinasofti.util;

import javax.servlet.http.HttpSession;

import com.chinasofti.model.system.User;

public class UserUtil {

	public static String userid(HttpSession session) {
		String userid = null;
		Object obj = session.getAttribute("user");
		if (obj != null) {
			User user = (User) obj;
			userid = user.getId();
		}
		return userid;
	}

}
