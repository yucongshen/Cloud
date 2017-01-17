package com.bjtu.cloud.process.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjtu.cloud.container.entity.Container;
import com.bjtu.cloud.container.service.ContainerService;
import com.bjtu.cloud.process.entity.Process;
import com.bjtu.cloud.process.service.ProcessService;
import com.bjtu.cloud.user.entity.EchartData;
import com.bjtu.cloud.user.entity.Series;

@Controller
@RequestMapping("processManage")
public class processManageController {
	
	@Autowired
	private ProcessService processService;
	
	@Autowired
	private ContainerService containerService;
	//Queue<String> queue = new LinkedList<String>();
	private Map<Integer,Queue<Float>> map=new HashMap<Integer,Queue<Float>>();
	private Queue<Integer> time=new LinkedList<Integer>();
	private Integer startTime=0;
	
	private Map<Integer,Queue<Float>> sendmap=new HashMap<Integer,Queue<Float>>();
	private Queue<Integer> sendtime=new LinkedList<Integer>();
	private Integer sendstartTime=0;
	
	private Map<Integer,Queue<Float>> acceptmap=new HashMap<Integer,Queue<Float>>();
	private Queue<Integer> accepttime=new LinkedList<Integer>();
	private Integer acceptstartTime=0;
	//进程管理-显示所有的进程
	@RequestMapping("list")
	public String list(Model model){
		List<Process> list = processService.findProcessList();
		model.addAttribute("processList", list);
		return "admin/process/list";
	}
	//通过pid显示进程的cpu等信息
	@RequestMapping("findByPid")
	public String findByPid(Integer pid,Model model){
		Process process=processService.findByPid(pid);
		model.addAttribute("process", process);
		return "admin/process/details";
	}
	//进程管理-模糊查询
	@RequestMapping("findByKeyPid")
	public String findByName(Integer pid,Model model){
		List<Process> list = processService.findProcessListByPid(pid);
		model.addAttribute("processList", list);
		model.addAttribute("pid", pid);
		//System.out.println(list.get(0).getPname());
		return "admin/process/list";
	}
	//docker内部进程模糊查询
	@RequestMapping("findByKeyPidAndCid")
	public String findByKeyPidAndCid(Integer pid,Integer containerId,Model model){
		List<Process> list = processService.findByKeyPidAndCid(pid,containerId);
		model.addAttribute("processList", list);
		model.addAttribute("containerId", containerId);
		model.addAttribute("pid", pid);
		return "admin/process/listByContainer";
	}
	//启动进程
	@RequestMapping("startProcess")
	@ResponseBody
	public String startProcess(Integer pid,Integer containerId){
		System.out.println(pid+"......"+containerId);
		
		//container_NameByCid/10004
		List<Container> list=containerService.findCnameById(containerId);
		Container container=list.get(0);
		String flag=processService.startProcess(pid,container.getContainerName());
		return flag;
	}
	//挂起进程
	@RequestMapping("stopProcess")
	@ResponseBody
	public String stopProcess(Integer pid,Integer containerId){
		List<Container> list=containerService.findCnameById(containerId);
		Container container=list.get(0);
		String flag=processService.stopProcess(pid,container.getContainerName());
		return flag;
	}
	//container管理-进入
	@RequestMapping("findByContainerId")
	public String findProcessByContainerId(Integer containerId,Model model){
		List<Process> list = processService.findByContainerId(containerId);
		model.addAttribute("containerId", containerId);
		model.addAttribute("processList", list);
		return "admin/process/listByContainer";
	}
	
    @SuppressWarnings("unchecked")
	@RequestMapping("findMemory")
    @ResponseBody
    public EchartData memoryData(Integer pid) {
    	System.out.println("内存图");
    	//System.out.println("pidpidpid"+pid);
    	
    	Process process=processService.findByPid(pid);
    	Integer containerId=process.getContainerId();
    	List<Container> list=containerService.findCnameById(containerId);
    	Container container=list.get(0);
    	String containerName=container.getContainerName();
    	Process processDocker=processService.findProcessFromDocker(containerName);
    	//System.out.println("process"+process);
    	float used=processDocker.getMemory_used();
    	float total=processDocker.getMemory_total();
    	float rest=total-used;
        List<String> legend = new ArrayList<String>();
        legend.add("已用内存");
        legend.add("未用内存");
        List<Map> serisData=new ArrayList<Map>();
        Map map1 =new HashMap();
        map1.put("value",used);
        map1.put("name","已用内存");
        Map map2 =new HashMap();
        map2.put("value",rest);
        map2.put("name","未用内存");
        serisData.add(map1);
        serisData.add(map2);
        List<Series> series = new ArrayList<Series>();// 纵坐标
        series.add(new Series("内存", "pie",serisData));
        EchartData data = new EchartData(legend,null, series);
        return data;
    }
    @RequestMapping("findCpu")
    @ResponseBody
    public EchartData findCpu(Integer pid) {
    	Process process =processService.findByPid(pid);
    	Integer containerId=process.getContainerId();
    	List<Container> list=containerService.findCnameById(containerId);
    	Container container=list.get(0);
    	String containerName=container.getContainerName();
    	//String flag=processService.openStates(containerId,containerName);
        System.out.println("CPU图");
        List<String> category = new ArrayList<String>();
        List<Float> serisData=new ArrayList<Float>();
        
        Process processDocker=processService.findProcessFromDocker(containerName);
        //Process process=new Process();
        //process.setCpu_percent((float) (Math.random()*50));
        //包括当前pid，将时间和cpu压入队列，如果超过6，队头出队列
    	if(map.containsKey(pid)){ 	
    		Queue<Float> queue=map.get(pid);
    		if(queue.size()>=6){
    			queue.poll();
    			time.poll();
    		}
    		queue.offer(processDocker.getCpu());
    		time.offer(startTime);
    		startTime=startTime+10;
    		map.put(pid, queue);
    		for(Integer t:time){
    			System.out.println(pid+"不是第一次list:"+"00:"+t);
        	}
    		for(Float s : queue){
    			System.out.println(pid+"不是第一次list:"+s);
    		}
    	//第一次查看当前进程，将进程放入队列
        }else{
    		System.out.println("第一次执行:"+pid);
    		Queue<Float> queue=new LinkedList<Float>();
    		queue.offer(processDocker.getCpu());
    		time.offer(startTime);
    		startTime=startTime+10;
    		map.put(pid, queue);
    		for(Integer t:time){
    			System.out.println(pid+"...第一次执行完list中:,"+"00:"+t);
        	}
    		for(Float s : queue){
    			System.out.println(pid+"...第一次执行完list中:,"+s);
    		}
    	}
    	Queue<Float> queue=map.get(pid);
    	for(Integer t:time){
    		category.add("00:"+t);
    	}
    	for(Float f :queue){
    		serisData.add(f);
    	}
//        category.add("00:10");
//        category.add("00:20");
//        category.add("00:30");
//        
//        serisData.add((float)(Math.random()*50));
//        serisData.add((float)(Math.random()*50));
//        serisData.add((float)(Math.random()*50));
        

        List<String> legend = new ArrayList<String>(Arrays.asList(new String[] { "cpu使用情况" }));// 数据分组
        List<Series> series = new ArrayList<Series>();// 纵坐标
        series.add(new Series("cpu", "line", serisData));
        EchartData data = new EchartData(legend, category, series);
        return data;
    }
    
    @RequestMapping("findNetSend")
    @ResponseBody
    public EchartData findNetSend(Integer pid) {
        System.out.println("netSend图");
        List<String> category = new ArrayList<String>();
        List<Float> serisData=new ArrayList<Float>();
        Process process =processService.findByPid(pid);
        Integer containerId=process.getContainerId();
    	List<Container> list=containerService.findCnameById(containerId);
    	Container container=list.get(0);
    	String containerName=container.getContainerName();
    	Process processDocker=processService.findProcessFromDocker(containerName);
        //Process process=new Process();
        //process.setCpu_percent((float) (Math.random()*50));
        //包括当前pid，将时间和cpu压入队列，如果超过6，队头出队列
    	if(sendmap.containsKey(pid)){ 	
    		Queue<Float> queue=sendmap.get(pid);
    		if(queue.size()>=6){
    			queue.poll();
    			sendtime.poll();
    		}
    		queue.offer(processDocker.getNetSend());
    		sendtime.offer(sendstartTime);
    		sendstartTime=sendstartTime+10;
    		sendmap.put(pid, queue);
    		for(Integer t:sendtime){
    			System.out.println(pid+"不是第一次list:"+"00:"+t);
        	}
    		for(Float s : queue){
    			System.out.println(pid+"不是第一次list:"+s);
    		}
    	//第一次查看当前进程，将进程放入队列
        }else{
    		System.out.println("第一次执行:"+pid);
    		Queue<Float> queue=new LinkedList<Float>();
    		queue.offer(processDocker.getNetSend());
    		sendtime.offer(sendstartTime);
    		sendstartTime=sendstartTime+10;
    		sendmap.put(pid, queue);
    		for(Integer t:sendtime){
    			System.out.println(pid+"...第一次执行完list中:,"+"00:"+t);
        	}
    		for(Float s : queue){
    			System.out.println(pid+"...第一次执行完list中:,"+s);
    		}
    	}
    	Queue<Float> queue=sendmap.get(pid);
    	for(Integer t:sendtime){
    		category.add("00:"+t);
    	}
    	for(Float f :queue){
    		serisData.add(f);
    	}
//        category.add("00:10");
//        category.add("00:20");
//        category.add("00:30");
//        
//        serisData.add((float)(Math.random()*50));
//        serisData.add((float)(Math.random()*50));
//        serisData.add((float)(Math.random()*50));
        

        List<String> legend = new ArrayList<String>(Arrays.asList(new String[] { "NetSend使用情况" }));// 数据分组
        List<Series> series = new ArrayList<Series>();// 纵坐标
        series.add(new Series("NetSend", "line", serisData));
        EchartData data = new EchartData(legend, category, series);
        return data;
    }
    @RequestMapping("findNetAccept")
    @ResponseBody
    public EchartData findNetAccept(Integer pid) {
        System.out.println("NetAccept图");
        List<String> category = new ArrayList<String>();
        List<Float> serisData=new ArrayList<Float>();
        Process process =processService.findByPid(pid);
        Integer containerId=process.getContainerId();
    	List<Container> list=containerService.findCnameById(containerId);
    	Container container=list.get(0);
    	String containerName=container.getContainerName();
    	Process processDocker=processService.findProcessFromDocker(containerName);
        //Process process=new Process();
        //process.setCpu_percent((float) (Math.random()*50));
        //包括当前pid，将时间和cpu压入队列，如果超过6，队头出队列
    	if(acceptmap.containsKey(pid)){ 	
    		Queue<Float> queue=acceptmap.get(pid);
    		if(queue.size()>=6){
    			queue.poll();
    			accepttime.poll();
    		}
    		queue.offer(processDocker.getNetAccept());
    		accepttime.offer(acceptstartTime);
    		acceptstartTime=acceptstartTime+10;
    		acceptmap.put(pid, queue);
    		for(Integer t:accepttime){
    			System.out.println(pid+"不是第一次list:"+"00:"+t);
        	}
    		for(Float s : queue){
    			System.out.println(pid+"不是第一次list:"+s);
    		}
    	//第一次查看当前进程，将进程放入队列
        }else{
    		System.out.println("第一次执行:"+pid);
    		Queue<Float> queue=new LinkedList<Float>();
    		queue.offer(processDocker.getNetSend());
    		accepttime.offer(acceptstartTime);
    		acceptstartTime=acceptstartTime+10;
    		acceptmap.put(pid, queue);
    		for(Integer t:accepttime){
    			System.out.println(pid+"...第一次执行完list中:,"+"00:"+t);
        	}
    		for(Float s : queue){
    			System.out.println(pid+"...第一次执行完list中:,"+s);
    		}
    	}
    	Queue<Float> queue=acceptmap.get(pid);
    	for(Integer t:accepttime){
    		category.add("00:"+t);
    	}
    	for(Float f :queue){
    		serisData.add(f);
    	}
//        category.add("00:10");
//        category.add("00:20");
//        category.add("00:30");
//        
//        serisData.add((float)(Math.random()*50));
//        serisData.add((float)(Math.random()*50));
//        serisData.add((float)(Math.random()*50));
        

        List<String> legend = new ArrayList<String>(Arrays.asList(new String[] { "NetAccept使用情况" }));// 数据分组
        List<Series> series = new ArrayList<Series>();// 纵坐标
        series.add(new Series("NetAccept", "line", serisData));
        EchartData data = new EchartData(legend, category, series);
        return data;
        
    }

}
