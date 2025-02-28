package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BoardMapper;
import com.example.test1.model.Board;

@Service
public class BoardService {
	
	@Autowired
	BoardMapper boardMapper;

	//get, select
	//add. insert
	//edit, update
	//remove, delete
	//헷갈리니까 이렇게 나눠서 구분함.
	
	public HashMap<String, Object> getBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Board> list = boardMapper.selectBoardList(map);
			resultMap.put("list", list);
			resultMap.put("result","success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result","fail");
			
		}
		return resultMap;
	}
	
	public HashMap<String, Object> addBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.insertBoard(map);
		resultMap.put("result", "success");
		
		return null;
	}

	public HashMap<String, Object> getBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		if(map.get("option").equals("View")) {
//		if(map.containsKey("option")) { //얘는 한쪽만 옵션을 처리해서 얘만 불러온다.
										//위에처럼하면 너무 코드가 길어짐
			boardMapper.updateCnt(map);
		}
		
		Board info = boardMapper.selectBoard(map);
		
		resultMap.put("info", info);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> boardEdit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.updateBoard(map);
		resultMap.put("result", "success");
		
		return resultMap;
	}

	public HashMap<String, Object> boardRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.deleteBoard(map);
		resultMap.put("result", "success");
		return resultMap;
	}

}
