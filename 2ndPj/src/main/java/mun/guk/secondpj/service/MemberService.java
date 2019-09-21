package mun.guk.secondpj.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mun.guk.secondpj.dao.MemberDAO;
import mun.guk.secondpj.vo.MemberVO;

@Service
public class MemberService {

	@Autowired
	private MemberDAO dao;
	
	
	public MemberVO login(MemberVO vo) 
	{
		return dao.login(vo);
	}


	public int idchk(MemberVO vo) {
		return dao.idchk(vo);
	}


	public void signup(MemberVO vo) {
		if(vo.getRegistnumber().equals("")) 
		{
			vo.setUsertype("buyer");
		}else 
		{
			vo.setUsertype("seller");
		}
		dao.signup(vo);
	}


	public void infoupdate(MemberVO vo) 
	{
		dao.infoupdate(vo);
	}



}
