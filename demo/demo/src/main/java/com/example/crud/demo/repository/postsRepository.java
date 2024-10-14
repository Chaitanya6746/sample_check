package com.example.crud.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.crud.demo.model.Posts;

public interface postsRepository extends JpaRepository<Posts, Long> {
	
}
