package mun.guk.secondpj.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mun.guk.secondpj.vo.ExcelVO;
import mun.guk.secondpj.vo.MemberVO;
import mun.guk.secondpj.vo.OrderVO;
import mun.guk.secondpj.vo.ProductVO;

@Repository
public class SellerDAO {
	@Autowired
	SqlSession session;

	public void registproduct(ProductVO vo)
	{
		SellerMapper mapper = session.getMapper(SellerMapper.class);
		mapper.registproduct(vo);
	}

	public ArrayList<ProductVO> setplist(MemberVO vo) 
	{
		SellerMapper mapper = session.getMapper(SellerMapper.class);
		return mapper.setplist(vo);
	}

	public ArrayList<ProductVO> sortlist(HashMap<String, String> map) 
	{
		SellerMapper mapper = session.getMapper(SellerMapper.class);
		return mapper.sortlist(map);
	}

	public ArrayList<ProductVO> setslist(MemberVO vo) 
	{
		SellerMapper mapper = session.getMapper(SellerMapper.class);
		return mapper.setslist(vo);
	}

	public ProductVO selectone(ProductVO vo) 
	{
		SellerMapper mapper = session.getMapper(SellerMapper.class);
		return mapper.selectone(vo);
	}

	public OrderVO totalvalue(ProductVO vo) 
	{
		SellerMapper mapper = session.getMapper(SellerMapper.class);
		return mapper.totalqt(vo);
	}

	public ProductVO totalend(ProductVO vo) 
	{
		SellerMapper mapper = session.getMapper(SellerMapper.class);
		return mapper.totalend(vo);
	}

	public ProductVO totalpro(ProductVO vo) {
		SellerMapper mapper = session.getMapper(SellerMapper.class);
		return mapper.totalpro(vo);
	}

	public ProductVO totalready(ProductVO vo) {
		SellerMapper mapper = session.getMapper(SellerMapper.class);
		return mapper.totalready(vo);
	}

	public ProductVO totalpay(ProductVO vo) {
		SellerMapper mapper = session.getMapper(SellerMapper.class);
		return mapper.totalpay(vo);
	}

	public ProductVO totalconf(ProductVO vo) {
		SellerMapper mapper = session.getMapper(SellerMapper.class);
		return mapper.totalconf(vo);
	}

	public ArrayList<OrderVO> detailship(OrderVO vo) 
	{
		SellerMapper mapper = session.getMapper(SellerMapper.class);
		return mapper.detailship(vo);
	}

	public ArrayList<ExcelVO> getlist(ArrayList<String> list) 
	{
		SellerMapper mapper = session.getMapper(SellerMapper.class);
		return mapper.getlist(list);
	}
}
