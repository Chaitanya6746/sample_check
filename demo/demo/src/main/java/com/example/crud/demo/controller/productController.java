package com.example.crud.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.crud.demo.service.ProductService;

import com.example.crud.demo.model.Product;



@RestController
@RequestMapping("/api/products")
public class productController {
	@Autowired
	ProductService service;
	
	
	@PostMapping
	public ResponseEntity<Product> addProduct(@RequestBody Product product){
		service.insertProduct(product);
		return new ResponseEntity<>(product,HttpStatus.CREATED);
	}
	
	@GetMapping
	public ResponseEntity<List<Product>> getAllProducts(){
		return new ResponseEntity<>(service.getAllProducts(), HttpStatus.OK);
	}
	
	@GetMapping("/{id}")
	public ResponseEntity<Product> getProductById(@PathVariable Long id){
		return new ResponseEntity<>(service.getProductById(id), HttpStatus.OK);
	}
	
	@PutMapping("/{id}")
	public ResponseEntity<Product> updateProduct(@PathVariable Long id, @RequestBody Product product){
		service.insertProduct(product);
		return new ResponseEntity<>(product, HttpStatus.CREATED);
	}
	
	@DeleteMapping("/{id}")
	public ResponseEntity<String> deleteProduct(@PathVariable Long id){
		service.deleteProduct(id);
		return new ResponseEntity<>("deleted Successfully", HttpStatus.OK);
	}
}
