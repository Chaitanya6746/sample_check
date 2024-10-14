package com.example.crud.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.crud.demo.model.*;

@Repository
public interface productRepository extends JpaRepository<Product ,Long>{
	List<Product> findByName(String name);
}
