package com.example.test1.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.MemberService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

@Controller
public class MemberController {

	//get, select
	//add. insert
	//edit, update
	//remove, delete
	//헷갈리니까 이렇게 나눠서 구분함.
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping("/member/login.do") 
    public String login(Model model) throws Exception{

        return "/member/member-login"; //login.jsp ==> .jsp가 생략되어있음.
    }

	@RequestMapping("/member/add.do") 
    public String add(Model model) throws Exception{

        return "/member/member-add"; //login.jsp ==> .jsp가 생략되어있음.
    }
	@RequestMapping("/member/list.do") 
    public String list(Model model) throws Exception{

        return "/member/member-list";
    }
//	@RequestMapping("/member/remove.do") 
//    public String remove(Model model) throws Exception{
//
//        return "/member/member-remove";
//    }
	@RequestMapping("/addr.do") 
    public String addr(Model model) throws Exception{

        return "/jusoPopup";
    }
	@RequestMapping("/member/pwd.do") 
    public String pwd(Model model) throws Exception{

        return "/member/pwd-search";
    }


	//로그인 화면
	@RequestMapping(value = "/member/login.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.memberLogin(map);
		
		return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
		//return new Gson().toJson(resultMap);
	}
	
	//회원가입
	@RequestMapping(value = "/member/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String add(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.memberAdd(map);
		
		return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
	}
	@RequestMapping(value = "/member/addPwd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String addPwd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.memberAddPwd(map);
		
		return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
	}
	//리스트 출력
	@RequestMapping(value = "/member/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = memberService.memberList(map);
		return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
		//return new Gson().toJson(resultMap);
	}
	//삭제
	@RequestMapping(value = "/member/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = memberService.memberRemove(map);
		return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
	}
	//중복체크
	@RequestMapping(value = "/member/check.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberCheckID(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.memberCheckID(map);
		
		return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
	}
	// 사용자 정보 조회(pk)
	@RequestMapping(value = "/member/get.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String get(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.getMember(map); 
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/member/remove-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberRemoveList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String json = map.get("selectList").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);
		
		resultMap = memberService.memberRemoveList(map);
		return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
	}

}
