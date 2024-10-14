package com.example.crud.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.crud.demo.model.Comments;

public interface commentsRepository extends JpaRepository<Comments, Long> {

}
