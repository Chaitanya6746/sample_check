package com.example.crud.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.crud.demo.model.Comments;
import com.example.crud.demo.model.Posts;
import com.example.crud.demo.service.PostsService;

@Controller
@RequestMapping("/view")
public class postsController {
	@Autowired
	PostsService service;
	
	@GetMapping("/posts/new")
	public String showPage(Model model) {
		model.addAttribute("Posts",new Posts());
		return "addPost";
	}
	
	@GetMapping("/posts")
	public String showPosts(Model model) {
		List<Posts> posts = service.getAllposts();
		model.addAttribute("posts",posts);
		return "displayPosts";
	}
	@PostMapping("/posts/add")
	public String addPost(Model model,@ModelAttribute Posts posts) {
		service.insertPosts(posts);
		List<Posts> post = service.getAllposts();
		model.addAttribute("post",post);
		model.addAttribute("Comments",new Comments());
		return "displayPosts"; 
	}
	@PostMapping("/comments/{id}")
	public String addComment(@PathVariable Long id,Model model,@ModelAttribute Comments comments) {
		Posts post = service.getPostById(id);
		comments.setPosts(post);
		service.insertComment(comments);
		return "displayPosts";
	}
}
