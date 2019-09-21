package mun.guk.secondpj.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mun.guk.secondpj.service.MemberService;
import mun.guk.secondpj.vo.MemberVO;

@Controller
@RequestMapping(value="/member")
public class MemberController {

	@Autowired
	private MemberService service;
	
	
	@RequestMapping(value="login",method=RequestMethod.POST)
	@ResponseBody
	public void login(MemberVO vo,HttpSession session)
	{
		MemberVO result = null;
		result = service.login(vo);
		if(result!=null)
		{
			session.setAttribute("user", result);
		}
		
	}
	
	@RequestMapping(value="idchk",method=RequestMethod.POST)
	@ResponseBody
	public String idchk(MemberVO vo)
	{
		int temp = service.idchk(vo);
		String result = null; 
		if(temp==0)
		{
			result="able";
		}

		return result;
		
	}
	
	@RequestMapping(value="signup",method=RequestMethod.POST)
	@ResponseBody
	public void signup(MemberVO vo)
	{
		service.signup(vo);
	}
	
	@RequestMapping(value="signupform",method=RequestMethod.GET)
	public String signupform(MemberVO vo,HttpSession session)
	{
		return "signupform";
	}
	
	@RequestMapping(value="logout",method=RequestMethod.GET)
	public String logout(MemberVO vo,HttpSession session)
	{
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value="editprofile",method=RequestMethod.GET)
	public String editprofile(HttpSession session)
	{
		return "editprofile";
	}
	
	@RequestMapping(value="setinfo",method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public MemberVO setinfo(HttpSession session)
	{
		MemberVO vo = (MemberVO) session.getAttribute("user");
		return vo;
	}
	
	@RequestMapping(value="infoupdate",method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public void infoupdate(MemberVO vo)
	{
		service.infoupdate(vo);
	}
	
}
