package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Member;
import com.example.test1.model.User;

@Mapper //이런거 필수임
public interface UserMapper {
	
	User userMapperLogin(HashMap<String, Object> map);
	//최대 1개만 넘어오니까--(단일)
	List<Member> getUserList(HashMap<String, Object> map);
	//리스트형태로 여러개 받아오니깐 List< >
	void memberDelete(HashMap<String, Object> map);
	//삭제만 할 것--그래서 몇 개를 삭제할 것 인가? 여서 int
	void testDelete(HashMap<String, Object> map);
	
	/* List<Test> getTestList(HashMap<String, Object> map); */
	
	
}
