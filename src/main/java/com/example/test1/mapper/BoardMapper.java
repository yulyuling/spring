package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
import com.example.test1.model.Comment;

@Mapper
public interface BoardMapper {

	List<Board> selectBoardList(HashMap<String, Object> map);
	//Board는 하나만 리턴해줌.
	//그래서 리스트 형태로 받아와서 import까지 해줘야한다.

	void insertBoard(HashMap<String, Object> map);

	Board selectBoard(HashMap<String, Object> map);
	//딱 한개만 넘겨줄거라서 Board. 

	void updateBoard(HashMap<String, Object> map);

	void updateCnt(HashMap<String, Object> map); //조회수 올릴겨

	void deleteBoard(HashMap<String, Object> map);

	void deleteBoardList(HashMap<String, Object> map);

	int selectBoardCnt(HashMap<String, Object> map);

	List<Comment> selectCmtList(HashMap<String, Object> map);

	void deleteComment(HashMap<String, Object> map);

	void updateComment(HashMap<String, Object> map);

	void insertComment(HashMap<String, Object> map);
	

}
