package com.bjtu.cloud.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bjtu.cloud.user.entity.User;
import com.bjtu.cloud.user.service.UserService;
import com.bjtu.cloud.util.MD5;

@Controller
@RequestMapping("user")
public class UserController {

	@Autowired
	private UserService userService;
	
	@RequestMapping("personal")
	public String personal(Integer userId,Model model){
		User user = userService.findUserById(userId);
		model.addAttribute("user", user);
		return "common/user/personal";
	}
	
	@RequestMapping("editPage")
	public String edit(Integer userId,Model model){
		User user = userService.findUserById(userId);
		model.addAttribute("user", user);
		model.addAttribute("userId", userId);
		return "common/user/edit";
	}
	
	@RequestMapping("edit")
	public String edit(Integer userId,String userName,String sex,String dept,Model model){
		User user=userService.findUserById(userId);
		user.setUserName(userName);
		user.setSex(sex);
		user.setDept(dept);
		userService.updateUser(user);
		model.addAttribute("userId", userId);
		return "redirect:personal";
	}
	
	@RequestMapping("editPasswordPage")
	public String password(Integer userId,Model model){
		User user = userService.findUserById(userId);
		model.addAttribute("user", user);
		model.addAttribute("userId", userId);
		return "common/user/password";
	}
	
	@RequestMapping("editPassword")
	public String password(String password,String newpassword,Integer userId,Model model){
		User user = userService.findUserById(userId);
		if(MD5.getMD5Value(password).equals(user.getPassword())){
			user.setPassword(MD5.getMD5Value(newpassword));
			userService.updateUser(user);
			model.addAttribute("flag", "密码修改成功！");
		}else{
			model.addAttribute("flag", "当前密码不正确!");
		}
		model.addAttribute("user", user);
		model.addAttribute("userId", userId);
		return "common/user/password";
	}
}
