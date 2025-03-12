package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Member;

@Mapper
public interface MemberMapper {

	Member getMember(HashMap<String, Object> map);

	void insertMember(HashMap<String, Object> map);

	Member checkMemberId(HashMap<String, Object> map);

	List<Member> getMemberList(HashMap<String, Object> map);

	void memberDelete(HashMap<String, Object> map);

	Member selectMember(HashMap<String, Object> map);

	void memberDeleteList(HashMap<String, Object> map);

	void UpdateMemberPwd(HashMap<String, Object> map);



	
}
