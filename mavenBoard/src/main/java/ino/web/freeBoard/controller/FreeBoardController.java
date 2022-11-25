package ino.web.freeBoard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ino.web.freeBoard.dto.FreeBoardDto;
import ino.web.freeBoard.service.FreeBoardService;

@Controller
public class FreeBoardController {

	@Autowired
	private FreeBoardService freeBoardService;

	@RequestMapping("/main.ino") //화면진입용.
	public ModelAndView main(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		List<FreeBoardDto> list = freeBoardService.freeBoardList();

		mav.setViewName("boardMain");
		mav.addObject("freeBoardList",list);
		return mav;
	}
	//ajax검색용.
	//List<FreeBoardDto> list = freeBoardService.freeBoardList(); main.ino와 같이 사용한다.
	
	
	@RequestMapping("/freeBoardInsert.ino")
	public String freeBoardInsert(){
		return "freeBoardInsert";
	}

	@ResponseBody
	@RequestMapping("/freeBoardInsertPro.ino")
	public Map<String, Object> freeBoardInsertPro(HttpServletRequest request, FreeBoardDto dto){
		Map<String, Object> map = new HashMap<>();
		try {
			freeBoardService.freeBoardInsertPro(dto);
			int num = freeBoardService.getNewNum();
			System.out.println("num : " + num);
			map.put("num", num);
			map.put("msg", 0);  // msg = false
		} catch (Exception e) {
			String msg = e.getCause().toString();
			map.put("msg", msg); // msg = true
		}
		return map;
	}

	//detail
	@ResponseBody
	@RequestMapping("/freeBoardDetail.ino")
	public ModelAndView freeBoardDetail(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		int num = Integer.parseInt(request.getParameter("num"));
		System.out.println("num의 값 : " + num);
		mav.addObject("dto",freeBoardService.getDetailByNum(num));
		mav.setViewName("freeBoardDetail");
		
		return mav;
	}

	//update
	@ResponseBody
	@RequestMapping( value="/freeBoardModify.ino", method= RequestMethod.POST )
	public Map<String, Object> freeBoardModify(HttpServletRequest request, FreeBoardDto dto){
		Map<String, Object> map = new HashMap<>();
		System.out.println("update num의 값 : " + dto.getNum());
		try {
			freeBoardService.freeBoardModify(dto);
			map.put("msg", 0);
			map.put("num", dto.getNum());
		} catch (Exception e) {
			String msg = e.getCause().toString();
			map.put("msg", msg);
		}
		return map;
	}

	
	//delete
	@ResponseBody
	@RequestMapping(value="/freeBoardDelete.ino", method = RequestMethod.POST)
	public Map<String, Object> FreeBoardDelete(int num){
		Map<String, Object> map = new HashMap<>();
		System.out.println("delete num의 값 : " + num);
		try {
			freeBoardService.FreeBoardDelete(num);
			map.put("msg", 0); // msg = false
		} catch (Exception e) {
			String msg = e.getCause().toString();
			map.put("msg", msg); // msg = true
		}
		return map;
	}
	

	@ResponseBody
	@RequestMapping(value="/freeBoardDeleteList.ino", method = RequestMethod.GET)
	public Map<String, Object> FreeBoardDeleteList( @RequestParam(value = "numList[]") List<Integer> numList) {
		Map<String, Object> map = new HashMap<>();
		System.out.println("delete numList의 값 : " + numList);
		try {
			int delCnt =freeBoardService.FreeBoardDeleteList(numList);
			System.out.println("delCnt의 값 : " + delCnt);
			map.put("msg", 0); // msg = false
			map.put("delCnt", delCnt);
		} catch (Exception e) {
			String msg = e.getCause().toString();
			System.out.println("msg의 값 : " + msg);
			map.put("msg", msg); // msg = true
		}
		return map;
	}
		
}