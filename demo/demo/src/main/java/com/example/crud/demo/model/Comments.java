package com.example.crud.demo.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class Comments {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long com_id;
	private String comment;
	@ManyToOne
	@JoinColumn(name="posts")
	private Posts posts;
	
	public Long getCom_id() {
		return com_id;
	}
	public void setCom_id(Long com_id) {
		this.com_id = com_id;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Posts getPosts() {
		return posts;
	}
	public void setPosts(Posts posts) {
		this.posts = posts;
	}
}
