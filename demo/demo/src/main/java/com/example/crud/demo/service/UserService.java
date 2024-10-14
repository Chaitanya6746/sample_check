package com.example.crud.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.crud.demo.model.User;
import com.example.crud.demo.repository.UserRepository;

@Service
public class UserService {
	@Autowired
	private UserRepository repo;
	
	public void insertUser(User user) {
		repo.save(user);
	}
}	
