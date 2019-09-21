package mun.guk.secondpj.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mun.guk.secondpj.dao.BuyerDAO;
import mun.guk.secondpj.vo.MemberVO;
import mun.guk.secondpj.vo.OrderVO;
import mun.guk.secondpj.vo.ProductVO;

@Service
public class BuyerService {
	
	@Autowired
	BuyerDAO dao;


	public ProductVO selectone(OrderVO vo) 
	{
		return dao.selectone(vo);
	}


	public void goorder(OrderVO vo, ProductVO result, HttpSession session) 
	{
		MemberVO member = (MemberVO) session.getAttribute("user");
		vo.setBuyeraddress(member.getAddress());
		vo.setBuyerid(member.getUserid());
		vo.setBuyertel(member.getUsertel());
		vo.setPrdtname(result.getPrdtname());
		vo.setPrdtprice(Integer.parseInt(result.getPrdtprice()));
		vo.setSellerid(result.getSellerid());
		dao.goorder(vo);
	}



}
