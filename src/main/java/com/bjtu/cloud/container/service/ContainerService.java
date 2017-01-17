package com.bjtu.cloud.container.service;

import java.util.List;

import com.bjtu.cloud.container.entity.Container;

public interface ContainerService {

	List<Container> findContainerList();

	List<Container> findContainerListByUserId(Integer userid);

	List<Container> findContainerById(Integer containerId);

	List<Container> findByContainerIdAndUserId(Integer containerid, Integer userid);

	void addContainer(Integer userId);
	List<Container> findCnameById(Integer containerId);

}
