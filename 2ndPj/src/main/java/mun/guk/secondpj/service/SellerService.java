package mun.guk.secondpj.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import mun.guk.secondpj.dao.SellerDAO;
import mun.guk.secondpj.vo.ExcelVO;
import mun.guk.secondpj.vo.MemberVO;
import mun.guk.secondpj.vo.OrderVO;
import mun.guk.secondpj.vo.ProductVO;

@Service
public class SellerService {
	
	@Autowired
	SellerDAO dao;
	
	public String filechk(String originalfilename)
	{
		String[] chk =originalfilename.split("\\.");
		String value=chk[chk.length-1];
		if(value.equals("jpg")||value.equals("bmp")||value.equals("gif")||value.equals("png")||value.equals("raw")||value.equals("tiff"))
		{
			return "good";
		} else return "bad";
	}

	public void registproduct(ProductVO vo, MultipartFile prdtfile,HttpSession session) 
	{
		MemberVO temp = (MemberVO) session.getAttribute("user");
		vo.setSellerid(temp.getUserid());
		try
		{
			if(!prdtfile.isEmpty())
			{
				String originalFileName = prdtfile.getOriginalFilename();
				String[] tem = originalFileName.split("\\.");
				String savedFileName = UUID.randomUUID().toString()+"."+tem[tem.length-1];
				vo.setOrginalfilename(originalFileName);
				vo.setSavefilename(savedFileName);
				prdtfile.transferTo(new File("C:/springworkspace/2ndPj/src/main/webapp/resources/img/product/"+ savedFileName));
			} 
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		dao.registproduct(vo);
	}

	public ArrayList<ProductVO> setplist(HttpSession session) 
	{
		MemberVO vo = (MemberVO) session.getAttribute("user");
		return dao.setplist(vo);
	}

	public ArrayList<ProductVO> sortlist(HashMap<String, String> map, HttpSession session) 
	{
		MemberVO vo = (MemberVO) session.getAttribute("user");
		map.put("userid", vo.getUserid());
		return dao.sortlist(map);
	}

	public ArrayList<ProductVO> setslist(HttpSession session) {
		MemberVO vo = (MemberVO) session.getAttribute("user");
		return dao.setslist(vo);
	}

	public ProductVO selectone(ProductVO vo) 
	{
		return dao.selectone(vo);
	}

	public int totalvalue(ProductVO vo) 
	{
		OrderVO temp = dao.totalvalue(vo);
		try{
			return temp.getOrderqt();
		}
		catch (Exception e) 
		{
			return 0;
		}
	}

	public int totalend(ProductVO vo) 
	{
		vo=dao.totalend(vo);
		try{
			return Integer.parseInt(vo.getPrdtorder());
		}
		catch (Exception e) 
		{
			return 0;
		}
	}

	public int totalpro(ProductVO vo) {
		vo=dao.totalpro(vo);
		try{
			return Integer.parseInt(vo.getPrdtorder());
		}
		catch (Exception e) 
		{
			return 0;
		}
	}

	public int totalready(ProductVO vo) {
		vo=dao.totalready(vo);
		try{
			return Integer.parseInt(vo.getPrdtorder());
		}
		catch (Exception e) 
		{
			return 0;
		}
	}

	public int totalpay(ProductVO vo) {
		vo=dao.totalpay(vo);
		try{
			return Integer.parseInt(vo.getPrdtorder());
		}
		catch (Exception e) 
		{
			return 0;
		}
	}

	public int totalconf(ProductVO vo) {
		vo=dao.totalconf(vo);
		try{
			return Integer.parseInt(vo.getPrdtorder());
		}
		catch (Exception e) 
		{
			return 0;
		}
	}

	public ArrayList<OrderVO> detailship(OrderVO vo) 
	{
		return dao.detailship(vo);
	}

	public ArrayList<ExcelVO> getlist(ArrayList<String> list) 
	{
		return dao.getlist(list);
	}

}
