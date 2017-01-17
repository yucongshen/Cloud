package com.bjtu.cloud.process.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.bjtu.cloud.container.entity.Container;
import com.bjtu.cloud.container.service.ContainerService;
import com.bjtu.cloud.process.entity.Process;
import com.bjtu.cloud.process.service.ProcessService;

@Controller
@RequestMapping("process")
public class ProcessController {

	@Autowired
	private ProcessService processService;
	@Autowired
	private ContainerService containerService;
	//查询用户的所有进程列表
	@RequestMapping("list")
	public String list(Integer userId, Model model) {
		List<Process> list = processService.findListByUserId(userId);
		model.addAttribute("processList", list);
		model.addAttribute("userId", userId);
		return "common/process/list";
	}
	//模糊查询process列表
	@RequestMapping("findByName")
	public String findByName(Integer pid,Integer userId,Model model){
		List<Process> list = processService.findByKeyPidAndUserId(pid, userId);
		model.addAttribute("userId",userId);
		model.addAttribute("pid", pid);
		model.addAttribute("processList", list);
		return "common/process/list";
	}
	
	//进程管理-模糊查询
	@RequestMapping("findByKeyPidAndUid")
	public String findByKeyPidAndUid(Integer pid,Model model,Integer userId){
		List<Process> list = processService.findByKeyPidAndUid(pid,userId);
		model.addAttribute("processList", list);
		model.addAttribute("pid", pid);
		model.addAttribute("userId", userId);
		//System.out.println(list.get(0).getPname());
		return "common/process/list";
	}
	@RequestMapping("processByContainer")
	public String processByContainer(Integer userId,Integer containerId,Model model){
		List<Process> list = processService.findByContainerId(containerId);
		model.addAttribute("userId", userId);
		model.addAttribute("containerId", containerId);
		model.addAttribute("processList", list);
		return "common/process/listByContainer";
	}
	//docker内部进程模糊查询
		@RequestMapping("findByKeyPidAndCid")
		public String findByKeyPidAndCid(Integer pid,Integer containerId,Model model){
			List<Process> list = processService.findByKeyPidAndCid(pid,containerId);
			model.addAttribute("processList", list);
			model.addAttribute("containerId", containerId);
			model.addAttribute("pid", pid);
			return "common/process/listByContainer";
		}
/*	//增加一个进程
	@RequestMapping("changeProcessState")
	public String changeProcessState(Integer pid, Integer containerId){
		String flag=processService.changeProcessState(pid);
		Process process=processService.findByPid(pid);
		if(process.getState()==1){
			process.setState(0);
		}else{
			process.setState(1);
		}
		if(flag=="1"){
			processService.updateProcess(process);
		}else{
		}
		if(containerId==null){
			return "redirect:list";
		}else{
			return "";
		}
	}*/
    @RequestMapping("upload")  
    public String upload(@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, ModelMap model,Integer userId) {  
  
        System.out.println("开始");  
        String path = request.getSession().getServletContext().getRealPath("upload");  
        String fileName = file.getOriginalFilename();  
        System.out.println(path);  
        File targetFile = new File("D:\\tomcat-7\\webapps\\jarFile", fileName); 
        System.out.println(fileName);
        if(!targetFile.exists()){  
            targetFile.mkdirs();  
        }
        //保存  
        try {  
            file.transferTo(targetFile);  
        } catch (Exception e) {  
            e.printStackTrace();
        }
        List<Container> list=containerService.findContainerListByUserId(userId);
        Integer containerCount;
        if(list!=null){
        	containerCount=list.size();
        }else{
        	containerCount=1;
        }
        
        String flag=processService.addProcess(userId,fileName,containerCount);
        if(flag.equals("1")){
        	model.addAttribute("message", "上传成功");
        }else{
        	model.addAttribute("message", "上传失败");
        }
        return "common/process/uploadSuccess";
    }
}
