package com.bjtu.cloud.user.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.bjtu.cloud.user.entity.User;
import com.bjtu.cloud.user.service.UserService;
import com.bjtu.cloud.util.MD5;

@Controller
public class UserLoginController {

	@Autowired
	private UserService userService;
	
	//跳转登录界面
	@RequestMapping("")
	public String loginPage(){
		return "login";
	}
	
	//验证登录
	@RequestMapping("login")
	public String login(User user,HttpSession session,Model model){
		User exitUser = userService.login(user);
		if(exitUser != null){
			if(exitUser.getState()==0){
				model.addAttribute("error","用户被禁用！");
				return "login";
			}
			session.setAttribute("user", exitUser);
			if(exitUser.getRole()==0){
				return "admin/home";
			}else{
				model.addAttribute("userId", exitUser.getUserId());
				return "common/home";
			}
		}else{
			model.addAttribute("error","登录账号或者密码错误！！！");
			return "login";
		}
	}
	
	//登录注销
	@RequestMapping("logout")
	public String logout(HttpSession session,HttpServletRequest request){
		
		session = request.getSession();
		session.invalidate();
		return "login";
	}
	
	//用户注册页面
	@RequestMapping("registPage")
	public String registPage(){
		return "regist";
	}
	//用户注册
	@RequestMapping("regist")
	public String regist(User user,Model model){
		User u=userService.findByName(user.getUserName());
		if(u!=null){
			model.addAttribute("exit","用户名已存在!");
			return "regist";
		}
		String password = MD5.getMD5Value(user.getPassword());
		user.setPassword(password);
		userService.addUser(user);
		System.out.println("执行了执行了add");
		return "login";
	}
	
}
