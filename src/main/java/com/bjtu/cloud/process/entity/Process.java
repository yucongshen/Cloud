package com.bjtu.cloud.process.entity;

public class Process {
    private Integer pid;

    private Integer state;

    private Float cpu;

    private Float memory_used;

    private Float memory_total;

    private Float netSend;
    
    private Float netAccept;
    
    private String userName;
    
    private Integer containerId;

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}


	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Float getCpu() {
		return cpu;
	}

	public void setCpu(Float cpu) {
		this.cpu = cpu;
	}

	public Float getMemory_used() {
		return memory_used;
	}

	public void setMemory_used(Float memory_used) {
		this.memory_used = memory_used;
	}

	public Float getMemory_total() {
		return memory_total;
	}

	public void setMemory_total(Float memory_total) {
		this.memory_total = memory_total;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Integer getContainerId() {
		return containerId;
	}

	public void setContainerId(Integer containerId) {
		this.containerId = containerId;
	}

	public Float getNetSend() {
		return netSend;
	}

	public void setNetSend(Float netSend) {
		this.netSend = netSend;
	}

	public Float getNetAccept() {
		return netAccept;
	}

	public void setNetAccept(Float netAccept) {
		this.netAccept = netAccept;
	}
    
    
    
}