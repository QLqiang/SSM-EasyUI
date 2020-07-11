package com.chinasofti.service.system;

import java.util.List;

import com.chinasofti.model.TreeNode;
import com.chinasofti.model.system.Auth;

public interface AuthService {

	List<Auth> query();

	List<TreeNode> combotree();

	int add(Auth auth);

	Auth selectByPrimaryKey(int id);

	int edit(Auth auth);

	int remove(int id);

}
