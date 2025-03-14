package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Product;

@Mapper
public interface ProductMapper {

	List<Product> selectProductList(HashMap<String, Object> map);

	Product selectProduct(HashMap<String, Object> map);
	
	List<Product> selectProductImg(HashMap<String, Object> map);

	int itemInsertProduct(HashMap<String, Object> map);

	void insertProductFile(HashMap<String, Object> map);



}