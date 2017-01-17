package com.bjtu.cloud.process.service;

import java.util.List;

import com.bjtu.cloud.container.entity.Container;
import com.bjtu.cloud.process.entity.Process;

public interface ProcessService {

	List<Process> findProcessList();

	Process findByPid(Integer pid);

	List<Process> findProcessListByPid(Integer pid);

	List<Process> findByContainerId(Integer containerId);

	List<Process> findListByUserId(Integer userid);


	String changeProcessState(Integer pid);

	void updateProcess(Process process);

	String addProcess(Integer pid, String fileName, Integer containerCount);

	List<Process> findByKeyPidAndUserId(Integer pid, Integer userId);

	List<Process> findByKeyPidAndCid(Integer pid, Integer containerId);

	List<Process> findByKeyPidAndUid(Integer pid, Integer userId);

	String startProcess(Integer pid, String containerName);

	String stopProcess(Integer pid, String userName);

	String openStates(Integer containerId, String containerName);

	Process findProcessFromDocker(String containerName);


	//Integer containerNumber(Integer userId);



}
