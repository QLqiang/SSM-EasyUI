package com.chinasofti.model.system;

import java.util.Date;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;

public class Role {
    private Integer id;

    private String name;

    private String mark;

    private String createid;

    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date createtime;

    private String modifyid;

    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date modifytime;
    
    //自定义属性，用于分页
    private int page;
    
    private int rows;
    
    private String sort;//需要排序的列名
    
    private String order;//排序的规则 asc或者desc
    
    private List<Auth> auths;
    
    private String[] authids;//保存前台传过来的所有权限ID
    
    private String authStr;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getMark() {
        return mark;
    }

    public void setMark(String mark) {
        this.mark = mark == null ? null : mark.trim();
    }

    public String getCreateid() {
        return createid;
    }

    public void setCreateid(String createid) {
        this.createid = createid == null ? null : createid.trim();
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public String getModifyid() {
        return modifyid;
    }

    public void setModifyid(String modifyid) {
        this.modifyid = modifyid == null ? null : modifyid.trim();
    }

    public Date getModifytime() {
        return modifytime;
    }

    public void setModifytime(Date modifytime) {
        this.modifytime = modifytime;
    }

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public List<Auth> getAuths() {
		return auths;
	}

	public void setAuths(List<Auth> auths) {
		this.auths = auths;
	}

	public String[] getAuthids() {
		return authids;
	}

	public void setAuthids(String[] authids) {
		this.authids = authids;
	}

	public String getAuthStr() {
		return authStr;
	}

	public void setAuthStr(String authStr) {
		this.authStr = authStr;
	}
    
}