package com.spring.gogidang.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.gogidang.domain.*;
import com.spring.gogidang.service.*;

@Controller
public class QnaController {
	
	@Autowired
	private QnaService qnaService;
	
	@RequestMapping("/qnalist.qn") 
	public String getQnalist(Model model, @RequestParam(value="page", required=false, defaultValue="1") int page) { 
		int limit=10;
		
		
		int listcount = qnaService.getListCount();
		
		int startrow = (page-1)*10+1;
		int endrow = startrow+limit-1;
		HashMap<String, Integer> hashmap = new HashMap<String, Integer>();
		hashmap.put("startrow", startrow);
		hashmap.put("endrow", endrow);
		List<QnaVO> qnalist = qnaService.getQnaList(hashmap);
		
		
		// 총 페이지 수
   		int maxpage=(int)((double)listcount/limit+0.95); // 0.95을 더해서 올림 처리
   		// 현재 페이지에 보여줄 시작 페이지 수 (1, 11, 21 ...)
   		int startpage = (((int) ((double)page / 10 + 0.9)) - 1) * 10 + 1;
   		// 현재 페이지에 보여줄 마지막 페이지 수 (10, 20, 30 ...)
   		int endpage = maxpage;
   		
   		if (endpage>startpage+10-1) endpage=startpage+10-1;
   		
		model.addAttribute("page", page);
		model.addAttribute("listcount", listcount);
		model.addAttribute("qnalist", qnalist);
		model.addAttribute("maxpage", maxpage);
		model.addAttribute("startpage", startpage);
		model.addAttribute("endpage", endpage);
		
		return "qna/qna_board_list";
	}
	
	@RequestMapping("qnawriteform.qn")
	public String qnaInsertForm()  {
		return "qna/qna_board_write";
	}
	
	@RequestMapping("/qnawrite.qn")
	public String qnaInsert(QnaVO qna,HttpSession session,HttpServletResponse response) throws Exception {
		int res = qnaService.qnaInsert(qna);
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		if(res == 1)
		{
			writer.write("<script>alert('작성 완료!!');location.href='./qnalist.qn';</script>");
		}
		else
		{
			writer.write("<script>alert('작성 실패!!');location.href='./qnawriteform.qn';</script>");
		}
		
		return null;
	}
	
	@RequestMapping("/qnadetail.qn") 
	public String getDetail(@RequestParam(value="qna_num", required=true) int qna_num, Model model) {
		QnaVO qna = qnaService.getDetail(qna_num); 
		
		model.addAttribute("qna", qna);
		
		return "qna/qna_board_view";
	}

	@RequestMapping("/qnadelete.qn") 
	public String noticeDelete(@RequestParam(value="qna_num", required=true) int qna_num, HttpSession session, HttpServletResponse response) throws Exception {
		String u_id = (String)session.getAttribute("u_id");
		
		HashMap<String, String> hashmap = new HashMap<String, String>();
		hashmap.put("qna_num", Integer.toString(qna_num));
		hashmap.put("u_id", u_id);
		int res =qnaService.qnaDelete(hashmap);
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		if (res == 1)
		{
			writer.write("<script>alert('삭제 성공!!');"
					+ "location.href='./qnalist.qn';</script>");
		}
		else
		{
			writer.write("<script>alert('삭제 실패!!');"
					+ "location.href='./qnalist.qn';</script>");
		}
		return null;
	}
	
	@RequestMapping("/qnaAdmin.qn")
	public String qnaAdmin() {
		
		return "admin/admin_qna";
	}
	
	// qna ajax list - admin
	@RequestMapping(value = "/qnaListAjax.re", produces="application/json; charset=UTF-8")
	@ResponseBody
	public List<QnaVO> qnaListAjax() {
		List<QnaVO> qnaList = qnaService.getList();
		
		return qnaList;
	}
		
	@RequestMapping(value = "/qnaInfoAjax.re", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> qnaInfoAjax(@RequestParam("qna_num") int qna_num) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		
		try {
			QnaVO qvo = qnaService.getDetail(qna_num);
			retVal.put("qna_num", qvo.getQna_num());
			retVal.put("u_id", qvo.getU_id());
			retVal.put("title", qvo.getTitle());
			retVal.put("content", qvo.getContent());
			retVal.put("re_content", qvo.getRe_content());
			retVal.put("res", "OK");
		} catch (Exception e) {
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		
		return retVal;
	}
	
	@RequestMapping(value = "/reQna.qn", method=RequestMethod.POST, produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> reQna(QnaVO qna) throws Exception {
		Map<String, Object> retVal = new HashMap<String, Object>();
		
		try {
			qnaService.reQna(qna);
			retVal.put("res", "reQna");
		} catch (Exception e) {
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		} 
		
		return retVal;
	}
	
}
