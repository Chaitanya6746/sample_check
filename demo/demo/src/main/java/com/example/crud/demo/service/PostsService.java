package com.example.crud.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.crud.demo.model.Comments;
import com.example.crud.demo.model.Posts;
import com.example.crud.demo.repository.commentsRepository;
import com.example.crud.demo.repository.postsRepository;

@Service
public class PostsService {
	@Autowired
	private postsRepository repo;
	@Autowired
	private commentsRepository com_repo;

	public List<Posts> getAllposts() {
		// TODO Auto-generated method stub
		return repo.findAll();
	}
	public List<Comments> getAllComments() {
		// TODO Auto-generated method stub
		return com_repo.findAll();
	}

	public void insertPosts(Posts posts) {
		// TODO Auto-generated method stub
		repo.save(posts);
	}
	
	public void insertComment(Comments comment) {
		com_repo.save(comment);
	}
	public Posts getPostById(Long postId) {
		// TODO Auto-generated method stub
		return repo.findById(postId).get();
	}

}
