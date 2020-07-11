package com.chinasofti.easyui;

import java.io.Serializable;
import java.util.List;

public class DataGridResult implements Serializable {

	private static final long serialVersionUID = 1L;

	private long total;
	
	private List<Object> rows;

	public long getTotal() {
		return total;
	}

	public void setTotal(long total) {
		this.total = total;
	}

	public List<Object> getRows() {
		return rows;
	}

	public void setRows(List<Object> rows) {
		this.rows = rows;
	}

}
