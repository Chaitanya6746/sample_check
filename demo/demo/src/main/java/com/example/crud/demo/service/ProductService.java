package com.example.crud.demo.service;

import com.example.crud.demo.model.*;
import com.example.crud.demo.repository.*;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class ProductService {
	@Autowired
	private productRepository repo;
	
	public void insertProduct(Product product) {
		repo.save(product);
	}
	public List<Product> getAllProducts(){
		return repo.findAll();
	}
	public void deleteProduct(Long id) {
		repo.deleteById(id);
	}
	public Product getProductById(Long id) {
		return repo.findById(id).get();
	}
	public List<Product> getProductByName(String name) {
		return repo.findByName(name);
	}
}
