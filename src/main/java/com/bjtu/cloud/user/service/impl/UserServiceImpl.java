package com.bjtu.cloud.user.service.impl;

import java.util.List;

import com.bjtu.cloud.user.entity.User;
import com.bjtu.cloud.user.service.UserService;
import com.bjtu.cloud.util.HttpRequestUtil;
import com.bjtu.cloud.util.MD5;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
//@Service
public class UserServiceImpl implements UserService{
	//用户登录，包括管理用和普通用户的登录
	@Override
	public User login(User user) {
		String userName=user.getUserName();
		String password = MD5.getMD5Value(user.getPassword());
		//发送请求将userName和password传入url
		if(userName==null||password==null){
			return null;
		}
		String url="user_login/"+userName+","+password;
		
		String data=HttpRequestUtil.httpRequest(url);
	   	Gson gson=new Gson();
		List<User> list = gson.fromJson(data.replaceAll(" ", ""),
				new TypeToken<List<User>>() {  
		}.getType());
		if(list!=null&&list.size()>0){
			return list.get(0);
		}else{
			return null;
		}
	}
	//查询所有用户的列表
	@Override
	public List<User> findUserList() {
		String url="user_list";
		String data=HttpRequestUtil.httpRequest(url);
	   	Gson gson=new Gson();
		List<User> list = gson.fromJson(data.replaceAll(" ", ""),
				new TypeToken<List<User>>() {  
		}.getType());
		if(list!=null&&list.size()>0){
			return list;
		}else{
			return null;
		}
	}
	//根据用户名模糊查询用户列表
	@Override
	public List<User> findUserListByName(String userName) {
		String url="user_findByKeyName/%"+userName+"%";
		String data=HttpRequestUtil.httpRequest(url);
	   	Gson gson=new Gson();
		List<User> list = gson.fromJson(data.replaceAll(" ", ""),
				new TypeToken<List<User>>() {  
		}.getType());
		if(list!=null&&list.size()>0){
			return list;
		}else{
			return null;
		}
	}
	//查询用户名是否存在
	public User findByName(String userName){
		String url="user_findByName/"+userName;
		String data=HttpRequestUtil.httpRequest(url);
	   	Gson gson=new Gson();
		List<User> list = gson.fromJson(data.replaceAll("b  ", ""),
				new TypeToken<List<User>>() {  
		}.getType());
		if(list!=null&&list.size()>0){
			return list.get(0);
		}else{
			return null;
		}
	}
	//删除用户
	public void deleteByName(String userName){
		String url="user_deleteByName/"+userName;
		HttpRequestUtil.httpRequest(url);
	}
	//增加一个用户
	@Override
	public void addUser(User user) {
		//传入userName,password,sex,dept,role,state
		String userName=user.getUserName();
		String password=user.getPassword();
		String sex=user.getSex();
		String dept=user.getDept();
		Integer role=user.getRole();
		Integer state=user.getState();
		if(userName==null||password==null||sex==null||dept==null||role==null||state==null){
			System.out.println("有空值！！！！");
			return;
		}
		String url="user_add/"+userName+","+password+","+sex+","+dept+","+role+","+state;
		
		String data=HttpRequestUtil.httpRequest(url);
		System.out.println("add成功"+data);
		//发送请求，执行数据库增加操作
	}
	@Override
	public User findUserById(Integer userId) {
		String url="user_findById/"+userId;
		String data=HttpRequestUtil.httpRequest(url);
	   	Gson gson=new Gson();
		List<User> list = gson.fromJson(data.replaceAll(" ", ""),
				new TypeToken<List<User>>() {  
		}.getType());
		if(list!=null&&list.size()>0){
			return list.get(0);
		}else{
			return null;
		}
	}
	@Override
	public void updateUser(User user) {
		//传入userId,userName,password,sex,dept,role,state
		Integer userId=user.getUserId();
		String userName=user.getUserName();
		String password=user.getPassword();
		String sex=user.getSex();
		String dept=user.getDept();
		Integer role=user.getRole();
		Integer state=user.getState();
		if(userId==null||userName==null||password==null||sex==null||dept==null||role==null||state==null){
			return;
		}
		String url="user_update/"+userName+","+password+","+sex+","+dept+","+role+","+state+","+userId;
		HttpRequestUtil.httpRequest(url);
	}

}
