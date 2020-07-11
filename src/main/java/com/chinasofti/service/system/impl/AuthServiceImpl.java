package com.chinasofti.service.system.impl;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.chinasofti.mapper.system.AuthMapper;
import com.chinasofti.mapper.system.RoleAuthMapper;
import com.chinasofti.model.TreeNode;
import com.chinasofti.model.system.Auth;
import com.chinasofti.service.system.AuthService;

@Service
public class AuthServiceImpl implements AuthService {
	
	@Autowired
	private AuthMapper authMapper;
	
	@Autowired
	private RoleAuthMapper roleAuthMapper;

	@Override
	public List<Auth> query() {
		List<Auth> list = authMapper.queryRoot();
		for(Auth auth : list) {
			if(auth.getChildren().size() > 0) {
				for(Auth au : auth.getChildren()) {
					au.setChildren(getChildren(au));
				}
			}
		}
		return list;
	}

	private List<Auth> getChildren(Auth auth) {
		List<Auth> list = new ArrayList<Auth>();
		Auth au = authMapper.selectByPK(auth.getId());
		if(au.getChildren().size() > 0) {
			for(Auth a : au.getChildren()) {
				list.add(a);
				a.setChildren(getChildren(a));
			}
		}
		return list;
	}

	@Override
	public List<TreeNode> combotree() {
		List<TreeNode> tree = new ArrayList<TreeNode>();
		List<Auth> list = this.query();
		for(Auth auth : list) {
			TreeNode node = this.changeTreeNode(auth);
			tree.add(node);
		}
		return tree;
	}
	
	private TreeNode changeTreeNode(Auth auth) {
		TreeNode node = new TreeNode();
		node.setId(String.valueOf(auth.getId()));
		node.setText(auth.getName());
		if(auth.getChildren().size() > 0) {
			node.setChildren(this.getChildren(auth.getChildren()));
		}
		return node;
	}
	
	private List<TreeNode> getChildren(List<Auth> list){
		List<TreeNode> listTree = new ArrayList<TreeNode>();
		for(Auth auth : list) {
			TreeNode node = this.changeTreeNode(auth);
			listTree.add(node);
			if(auth.getChildren().size() > 0) {
				node.setChildren(this.getChildren(auth.getChildren()));
			}
		}
		return listTree;
	}

	@Override
	public int add(Auth auth) {
		return authMapper.insertSelective(auth);
	}

	@Override
	public Auth selectByPrimaryKey(int id) {
		return authMapper.selectByPK(id);
	}

	@Override
	public int edit(Auth auth) {
		return authMapper.updateByPrimaryKeySelective(auth);
	}

	@Override
	@Transactional
	public int remove(int id) {
		roleAuthMapper.deleteByAuthId(id);
		return authMapper.deleteByPrimaryKey(id);
	}

}
