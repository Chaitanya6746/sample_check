package com.example.crud.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.crud.demo.model.Product;
import com.example.crud.demo.model.User;
import com.example.crud.demo.service.ProductService;
import com.example.crud.demo.service.UserService;

@Controller
@RequestMapping("/view")
public class userController {
	@Autowired
	UserService service;
	@Autowired
	ProductService prod_service;
	
	
	@GetMapping("/register")
	public String showPage(Model model) {
		model.addAttribute("User",new User());
		return "resgistration";
	}
//	@GetMapping("/products")
//	public String showProducts(Model model) {
//		model.addAttribute("name"," ");
//		return "products";
//	}
	
	@PostMapping("/register")
	public String registerUser(Model model,@ModelAttribute User user) {
		service.insertUser(user);
		model.addAttribute("name",user.getName());
		return "home";
	}
	@GetMapping("/products")
	public String showAllProducts(Model model) {
		List<Product> products = prod_service.getAllProducts();
		model.addAttribute("products",products);
		return "products";
	}
	@GetMapping("/products/search")
	public String ShowByName(@RequestParam("name") String name ,Model model) {
		List<Product> products = prod_service.getProductByName(name);
		model.addAttribute("products",products);
		return "products";
	}
}
