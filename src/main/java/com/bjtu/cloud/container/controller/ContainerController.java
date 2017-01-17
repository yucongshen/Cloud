package com.bjtu.cloud.container.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bjtu.cloud.container.entity.Container;
import com.bjtu.cloud.container.service.ContainerService;
import com.bjtu.cloud.user.service.UserService;
@Controller
@RequestMapping("container")
public class ContainerController {
	
	@Autowired
	private ContainerService containerService;
	 
	@Autowired
	private UserService userService;
	
	@RequestMapping("list")
	public String list(Integer userId,Model model){
		List<Container> list = containerService.findContainerListByUserId(userId);
		model.addAttribute("containerList", list);
		model.addAttribute("userId", userId);
		return "common/container/list";
	}
	//在某一用户的基础上模糊查询container列表
	@RequestMapping("containerListById")
	public String containerListById(Integer containerId, Integer userId,Model model){
		List<Container> list = containerService.findByContainerIdAndUserId(containerId, userId);
		model.addAttribute("containerList", list);
		model.addAttribute("userId", userId);
		return "common/container/list";
	}
	//申请一个container
	@RequestMapping("addContainer")
	public void addContainer(Integer userId){
		System.out.println(",,,,userId,"+userId);
		containerService.addContainer(userId);
	}
	
}
