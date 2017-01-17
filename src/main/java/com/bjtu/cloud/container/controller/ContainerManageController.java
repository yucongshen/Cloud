package com.bjtu.cloud.container.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bjtu.cloud.container.entity.Container;
import com.bjtu.cloud.container.service.ContainerService;

@Controller
@RequestMapping("containerManage")
public class ContainerManageController {
	
	@Autowired
	private ContainerService containerService;
	
//	@Autowired
//	private UserService userService;
	
	//用户管理-查看container列表
	@RequestMapping("containerListByUserId")
	public String containerListByUserId(Integer userId,Model model){
		List<Container> list = containerService.findContainerListByUserId(userId);
		model.addAttribute("containerList", list);
		return "admin/container/list";
	}
	
	//container管理-显示所有container
	@RequestMapping("list")
	public String list(Model model){
		List<Container> list = containerService.findContainerList();
		model.addAttribute("containerList", list);
		return "admin/container/list";
	}
	//container管理-根据containerid模糊查询
	@RequestMapping("containerListById")
	public String containerListById(Integer containerId,Model model){
		List<Container> list = containerService.findContainerById(containerId);
		model.addAttribute("containerList", list);
		return "admin/container/list";
	}
}
