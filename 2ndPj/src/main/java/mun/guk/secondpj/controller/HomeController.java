package mun.guk.secondpj.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mun.guk.secondpj.service.HomeService;
import mun.guk.secondpj.vo.OrderVO;
import mun.guk.secondpj.vo.ProductVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController 
{
	@Autowired
	HomeService service;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) 
	{
		return "home";
	}
	
	@RequestMapping(value = "setmainlist", method = RequestMethod.GET)
	@ResponseBody
	public ArrayList<ProductVO> setmainlist(ProductVO vo) 
	{
		ArrayList<ProductVO> result = service.setmainlist(vo);
		return result;
	}
	
	@RequestMapping(value = "productread", method = RequestMethod.GET)
	public String productread(ProductVO vo,Model model) 
	{
		vo = service.productread(vo);
		model.addAttribute("prdt", vo);
		return "productread";
	}
	
	@RequestMapping(value = "testpage", method = RequestMethod.GET)
	public String testpage(ProductVO vo,Model model) 
	{
		return "testpage";
	}
	
	@RequestMapping(value = "productboard", method = RequestMethod.GET)
	@ResponseBody
	public ArrayList<ProductVO> productboard(ProductVO vo,Model model) 
	{
		ArrayList<ProductVO> result = service.productboard(vo);
		return result;
	}
	
	@RequestMapping(value = "searchitem", method = RequestMethod.GET)
	@ResponseBody
	public ArrayList<ProductVO> searchitem(String searchkey) 
	{
		ArrayList<ProductVO> result = service.searchitem(searchkey);
		return result;
	}
	
	@RequestMapping(value = "callmypage", method = RequestMethod.GET)
	public String callmypage(HttpSession session,Model model) 
	{
		return "mypage";
	}
	
	@RequestMapping(value = "callmylist", method = RequestMethod.POST)
	@ResponseBody
	public ArrayList<OrderVO> callmylist(HttpSession session) 
	{
		ArrayList<OrderVO> result = service.selectall(session);
		return result;
	}
}
