package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BoardMapper;
import com.example.test1.model.Board;
import com.example.test1.model.BoardFile;
import com.example.test1.model.Comment;

@Service
public class BoardService<imgFile> {
	
	@Autowired
	BoardMapper boardMapper;

	//get, select
	//add. insert
	//edit, update
	//remove, delete
	//헷갈리니까 이렇게 나눠서 구분함.
	
	
	//게시글 목록 가져온다
	public HashMap<String, Object> getBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Board> list = boardMapper.selectBoardList(map);
			int count = boardMapper.selectBoardCnt(map);
			
			System.out.println(count);
			resultMap.put("count", count);
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
		System.out.println("key ==>" + map.get("boardNo"));
		resultMap.put("boardNo", map.get("boardNo"));
		resultMap.put("result", "success");
		
		return resultMap;
	}
	public HashMap<String, Object> addBoardFile(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		boardMapper.insertBoardFile(map);
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
		List<Comment> cmtList = boardMapper.selectCmtList(map);
		

		List<BoardFile> imgList = boardMapper.selectBoardImg(map);
		
		resultMap.put("imgList", imgList);
		resultMap.put("cmtList", cmtList);
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

	public HashMap<String, Object> boardRemoveList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		boardMapper.deleteBoardList(map);
		return null;
	}
	
	public HashMap<String, Object> CommentRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		boardMapper.deleteComment(map);
		return null;
	}

	public HashMap<String, Object> CommentEdit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		boardMapper.updateComment(map);
		return null;
	}

	public HashMap<String, Object> CommentAdd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.insertComment(map);

		resultMap.put("result", "success");
		return null;
	}

	public HashMap<String, Object> CommentCount(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Board> count = boardMapper.countComment(map);
		
		resultMap.put("count", count);
		resultMap.put("result","success");
		return resultMap;
	}

	public HashMap<String, Object> commentUpdate(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.commentUpdate(map);

		resultMap.put("result", "success");
		return null;
	}


}
