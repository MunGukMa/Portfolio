package mun.guk.secondpj.controller;

import java.util.ArrayList;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import mun.guk.secondpj.service.BuyerService;
import mun.guk.secondpj.service.HomeService;
import mun.guk.secondpj.vo.OrderVO;
import mun.guk.secondpj.vo.ProductVO;

@Controller
@RequestMapping("/buyer")
public class BuyerController 
{
	
	@Autowired
	BuyerService service;
	
	
	@RequestMapping(value = "buyform", method = RequestMethod.GET)
	public String buyform(OrderVO vo,Model model) 
	{
		ProductVO result = service.selectone(vo);
		model.addAttribute("prdt", result);
		model.addAttribute("qt", vo.getOrderqt());
		return "buyform";
	}
	
	@RequestMapping(value = "goorder", method = RequestMethod.POST)
	@ResponseBody
	public void goorder(OrderVO vo,HttpSession session) 
	{
		ProductVO result = service.selectone(vo);
		service.goorder(vo,result,session);
	}
	

	
}
