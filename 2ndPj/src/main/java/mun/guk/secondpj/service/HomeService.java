package mun.guk.secondpj.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mun.guk.secondpj.dao.HomeDAO;
import mun.guk.secondpj.vo.MemberVO;
import mun.guk.secondpj.vo.OrderVO;
import mun.guk.secondpj.vo.ProductVO;

@Service
public class HomeService {
	
	@Autowired
	HomeDAO dao;
	
	public ArrayList<ProductVO> setmainlist(ProductVO vo) 
	{
		return dao.setmainlist(vo);
	}
	
	public ProductVO productread(ProductVO vo) 
	{
		return dao.productread(vo);
	}

	public ArrayList<ProductVO> productboard(ProductVO vo) 
	{
		String type = vo.getPrdttype();
		if(type.equals("전체"))
		{
			vo.setPrdttype("all");
		} else if (type.equals("쌀/잡곡"))
		{
			vo.setPrdttype("rice");
		} else if (type.equals("과일/견과"))
		{
			vo.setPrdttype("fruit");
		} else if (type.equals("채소/버섯"))
		{
			vo.setPrdttype("mush");
		}
		return dao.productboard(vo);
	}

	public ArrayList<ProductVO> searchitem(String searchkey) 
	{
		return dao.searchitem(searchkey);
	}
	
	public ArrayList<OrderVO> selectall(HttpSession session)
	{
		MemberVO member = (MemberVO) session.getAttribute("user");
		return dao.selectall(member);
	}
	
	
}
