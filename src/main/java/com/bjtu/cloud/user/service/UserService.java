package com.bjtu.cloud.user.service;

import java.util.List;

import com.bjtu.cloud.user.entity.User;

public interface UserService {

	User login(User user);

	List<User> findUserList();

	List<User> findUserListByName(String username);

	void addUser(User user);

	User findUserById(Integer userid);

	void updateUser(User user);

	public User findByName(String userName);

	
}
