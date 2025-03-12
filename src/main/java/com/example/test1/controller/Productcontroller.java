package com.example.test1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.ProductService;
import com.google.gson.Gson;

@Controller
public class Productcontroller {
	
	@Autowired
	ProductService productService;
	
	@RequestMapping("/product/list.do") 
    public String login(Model model) throws Exception{

        return "/product/product-list"; //login.jsp ==> .jsp가 생략되어있음.
    }
	@RequestMapping("/product/view.do") 
    public String view(Model model) throws Exception{

        return "/product/product-view"; //login.jsp ==> .jsp가 생략되어있음.
    }
	
	@RequestMapping(value = "/product/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String list(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.productList(map);
		
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/product/view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String view(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.productView(map);
		
		return new Gson().toJson(resultMap);
	}
}
