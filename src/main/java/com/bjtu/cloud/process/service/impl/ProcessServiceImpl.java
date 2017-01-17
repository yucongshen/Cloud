package com.bjtu.cloud.process.service.impl;

import java.util.List;

import com.bjtu.cloud.container.entity.Container;
import com.bjtu.cloud.process.entity.Process;

import com.bjtu.cloud.process.service.ProcessService;
import com.bjtu.cloud.util.HttpRequestUtil;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

public class ProcessServiceImpl implements ProcessService {
	private static List<Process> common(String url){
		String data=HttpRequestUtil.httpRequest(url);
		System.out.println(data);
	   	Gson gson=new Gson();
		List<Process> list = gson.fromJson(data.replaceAll(" ", ""),
				new TypeToken<List<Process>>() {  
		}.getType());
		if(list!=null&&list.size()>0){
			return list;
		}else{
			return null;
		}
	}
	@Override
	public List<Process> findProcessList() {
		String url="process_list";
		return common(url);
	}

	@Override
	public Process findByPid(Integer pid) {
		String url="process_findByPid/"+pid;
	   	Gson gson=new Gson();
	   	String data=HttpRequestUtil.httpRequest(url);
	   	//System.out.println("data:"+data);
		List<Process> list = gson.fromJson(data.replaceAll(" ", ""),
				new TypeToken<List<Process>>() {  
		}.getType());
		if(list!=null&&list.size()>0){
			return list.get(0);
		}else{
			return null;
		}
	}

	@Override
	public List<Process> findProcessListByPid(Integer pid) {
		System.out.println(pid);
		String url="process_findByKeyPid/%"+pid+"%";
		System.out.println(".......+"+url);
		return common(url);
	}

	@Override
	public List<Process> findByContainerId(Integer containerId) {
		String url="process_findByContainerId/"+containerId;
		return common(url);
	}

	@Override
	public List<Process> findListByUserId(Integer userId) {
		String url="process_findByUserId/"+userId;
		return common(url);
	}

	//向container发送请求
	@Override
	public String changeProcessState(Integer pid) {
		String url=""+pid;
		String data=HttpRequestUtil.httpRequest(url);
		return data;
	}
	@Override
	public void updateProcess(Process process) {
		Integer pid=process.getPid();
		Integer state=process.getState();
		Integer containerId=process.getContainerId();
		if(state==null){
			return;
		}
		String url="process_update/"+state+","+containerId+","+pid;
		HttpRequestUtil.httpRequest(url);
	}
	//向container发送请求,增加一个进程
	@Override
	public String addProcess(Integer userId,String fileName,Integer count) {
		String path="http://192.168.43.12:8080/jarFile/"+fileName;
		String url="file*"+path+","+userId+","+count;
		System.out.println(url);
		String flag=HttpRequestUtil.httpRequestDocker(url);
		System.out.println("flage"+flag);
		return flag;
	}
	@Override
	public List<Process> findByKeyPidAndUserId(Integer pid, Integer userId) {
		String url="process_findByKeyPidAndUserId/"+userId;
		return common(url);
	}
	@Override
	public List<Process> findByKeyPidAndCid(Integer pid,Integer containerId) {
		String url="process_findByKeyPidAndCid/%"+pid+"%"+","+containerId;
		return common(url);
	}
	@Override
	public List<Process> findByKeyPidAndUid(Integer pid,Integer userId) {
		String url="process_findByKeyPidAndUid/%"+pid+"%"+","+userId;
		return common(url);
	}
	/*@Override
	public Integer containerNumber(Integer userId) {
		String url="container_containerNumber/"+userId;
		return common(url);
	}*/
	@Override
	public String startProcess(Integer pid, String containerName) {
		String url="start_container*"+pid+","+containerName;
		String flag=HttpRequestUtil.httpRequestDocker(url);
		return flag;
	}
	@Override
	public String stopProcess(Integer pid, String containerName) {
		String url="stop_container*"+pid+","+containerName;
		String flag=HttpRequestUtil.httpRequestDocker(url);
		return flag;
	}
	@Override
	public String openStates(Integer containerId, String containerName) {
		String url="open_stats_container*"+containerId+","+containerName;
		String flag=HttpRequestUtil.httpRequestDocker(url);
		return flag;
	}
	@Override
	public Process findProcessFromDocker(String containerName) {
		String url="stats_container*"+containerName;
		String data=HttpRequestUtil.httpRequestDocker(url);
		System.out.println("cpudocker......."+data);
	   	Gson gson=new Gson();
		List<Process> list = gson.fromJson(data.replaceAll(" ", ""),
				new TypeToken<List<Process>>() {  
		}.getType());
		if(list!=null&&list.size()>0){
			return list.get(0);
		}else{
			return null;
		}
	}
}
