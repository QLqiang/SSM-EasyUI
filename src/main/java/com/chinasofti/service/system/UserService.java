package com.chinasofti.service.system;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.chinasofti.easyui.DataGridResult;
import com.chinasofti.model.system.User;

public interface UserService {

	User login(String id, String password);

	int editPassword(String id, String oldPassword, String newPassword);

	DataGridResult query(User user);

	int remove(String ids);

	int add(User user, HttpSession session);

	User checkid(String id);

	int edit(User user, HttpSession session);

	int resetPassword(String ids);

	User selectOne(String id);

	int imp(MultipartFile userFile, HttpSession session)  throws Exception;

}
