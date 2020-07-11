package com.chinasofti.model.system;

import java.util.List;

public class Auth {
    private Integer id;

    private String name;

    private String mark;

    private Integer seq;

    private String url;

    private Integer pid;
    
    private List<Auth> children;

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

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

	public List<Auth> getChildren() {
		return children;
	}

	public void setChildren(List<Auth> children) {
		this.children = children;
	}
}