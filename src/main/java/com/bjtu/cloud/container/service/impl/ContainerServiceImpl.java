package com.bjtu.cloud.container.service.impl;

import java.util.List;

import com.bjtu.cloud.container.entity.Container;
import com.bjtu.cloud.container.service.ContainerService;
import com.bjtu.cloud.util.HttpRequestUtil;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

public class ContainerServiceImpl implements ContainerService{
	private static List<Container> common(String url){
		String data=HttpRequestUtil.httpRequest(url);
		System.out.println(data);
	   	Gson gson=new Gson();
		List<Container> list = gson.fromJson(data.replaceAll(" ", ""),
				new TypeToken<List<Container>>() {  
		}.getType());
		if(list!=null&&list.size()>0){
			return list;
		}else{
			return null;
		}
	}
	@Override
	public List<Container> findContainerList() {
		String url="container_list";
		return common(url);
//		String data=HttpRequestUtil.httpRequest(url);
//	   	Gson gson=new Gson();
//		List<Container> list = gson.fromJson(data.replaceAll(" ", ""),
//				new TypeToken<List<Container>>() {  
//		}.getType());
//		if(list!=null&&list.size()>0){
//			return list;
//		}else{
//			return null;
//		}
	}

	@Override
	public List<Container> findContainerListByUserId(Integer userId) {
		String url="container_findByUserId/"+userId;
		return common(url);
	}

	@Override
	public List<Container> findContainerById(Integer keyContainerId) {
		String url="container_findByKeyId/%"+keyContainerId+"%";
		return common(url);
	}

	@Override
	public List<Container> findByContainerIdAndUserId(Integer containerId, Integer userId) {
		String url="container_findByKeyIdAndUserId/%"+containerId+"%"+","+userId;
		return common(url);
	}
	//向container发送请求
	@Override
	public void addContainer(Integer userId) {
		String url=""+userId;
		
	}
	@Override
	public List<Container> findCnameById(Integer containerId) {
		String url="container_NameByCid/"+containerId;
		return common(url);
	}
}
