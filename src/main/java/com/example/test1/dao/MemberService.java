package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Member;

@Service
public class MemberService {


	//get, select
	//add. insert
	//edit, update
	//remove, delete
	//헷갈리니까 이렇게 나눠서 구분함.
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	HttpSession session;
	
	public HashMap<String, Object> memberLogin(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
		Member member = memberMapper.getMember(map);
			
			if(member != null) {
				System.out.println("성공");
				session.setAttribute("sessionId", member.getUserId());
				session.setAttribute("sessionName", member.getUserName());
				session.setAttribute("sessionStatus", member.getStatus());
				session.setMaxInactiveInterval(60 * 60 ); // 60*60초
				
				//session.invalidate(); 세션 정보 삭제
//				session.removeAttribute("sessionId"); 1개씩 삭제할때
				
				resultMap.put("member", member);
				resultMap.put("result", "success");
			} else {
				System.out.println("실패");
				resultMap.put("result", "fail");
			}
						
			return resultMap;
	}

	public HashMap<String, Object> memberAdd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		memberMapper.insertMember(map);
		return resultMap;
	}

	public HashMap<String, Object> memberCheckID(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Member member = memberMapper.checkMemberId(map);
		
		int count = member != null ? 1 : 0;
		resultMap.put("count", count);
		return resultMap;
	}

	public HashMap<String, Object> memberList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Member> list = memberMapper.getMemberList(map);
		resultMap.put("list", list);
		return resultMap;
		
	}
	public HashMap<String, Object> memberRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		if(map.get("userId") == null) {
			map.put("userId", "");
		} 
		memberMapper.memberDelete(map);
		resultMap.put("result","success");
		return resultMap;
	}

	public HashMap<String, Object> getMember(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Member member = memberMapper.selectMember(map);
		if(member != null) {
			resultMap.put("member", member);
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> memberRemoveList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		
		memberMapper.memberDeleteList(map);
		return null;
	}

	public HashMap<String, Object> memberAddPwd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		memberMapper.UpdateMemberPwd(map);
		return resultMap;
	}

}
