package com.example.test1.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.BoardService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

@Controller
public class BoardController {
	
	@Autowired
	BoardService boardService; //객체 호출할땐 첫글자 소문자로 해야함--안그러면 클래스를 호출하는 걸로 오류남.
	
	@RequestMapping("/board/list.do") 
    public String login(Model model) throws Exception{

        return "/board/board-list"; //login.jsp ==> .jsp가 생략되어있음.
    }
	
	@RequestMapping("/board/add.do") 
    public String add(Model model) throws Exception{

        return "/board/board-add"; //login.jsp ==> .jsp가 생략되어있음.
    }
	@RequestMapping("/board/view.do") 
    public String view(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
        return "/board/board-view"; //login.jsp ==> .jsp가 생략되어있음.
    }
	@RequestMapping("/board/edit.do") 
    public String edit(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
        return "/board/board-edit"; //login.jsp ==> .jsp가 생략되어있음.
    }
	
	//게시글 목록
	@RequestMapping(value = "/board/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.getBoardList(map);
		
		return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
		//return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "/board/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.addBoard(map);
		
		return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
		//return new Gson().toJson(resultMap);
	}
	//게시글 상세보기
	@RequestMapping(value = "/board/info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.getBoard(map);
		
		return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
		//return new Gson().toJson(resultMap);
	}
	//게시글 수정하기
	@RequestMapping(value = "/board/edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.boardEdit(map);
		
		return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
		//return new Gson().toJson(resultMap);
	}
	//게시글 삭제
	@RequestMapping(value = "/board/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = boardService.boardRemove(map);
		return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
	}
	//게시글 여러개 삭제
	@RequestMapping(value = "/board/remove-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removeList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String json = map.get("selectList").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);

		
//		resultMap = memberService.getMember(map); 
		resultMap = boardService.boardRemoveList(map);
		return new Gson().toJson(resultMap);
	}
	//댓글 삭제
		@RequestMapping(value = "/board/CommentRemove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String CommentRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
			resultMap = boardService.CommentRemove(map);
			return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
		}
	//댓글 수정
	@RequestMapping(value = "/board/CommentEdit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String CommentEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = boardService.CommentEdit(map);
		return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
	}
	//댓글 작성
	@RequestMapping(value = "/board/CommentAdd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String CommentAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = boardService.CommentAdd(map);
		return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
	}	
}
