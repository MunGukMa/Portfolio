package mun.guk.secondpj.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mun.guk.secondpj.vo.MemberVO;
import mun.guk.secondpj.vo.OrderVO;
import mun.guk.secondpj.vo.ProductVO;

@Repository
public class HomeDAO {

	@Autowired
	SqlSession session;
	
	public ArrayList<ProductVO> setmainlist(ProductVO vo) 
	{
		HomeMapper mapper = session.getMapper(HomeMapper.class);
		return mapper.setmainlist(vo);
	}
	
	public ProductVO productread(ProductVO vo) 
	{
		HomeMapper mapper = session.getMapper(HomeMapper.class);
		return mapper.productread(vo);
	}

	public ArrayList<ProductVO> productboard(ProductVO vo) 
	{
		HomeMapper mapper = session.getMapper(HomeMapper.class);
		return mapper.productboard(vo);
	}

	public ArrayList<ProductVO> searchitem(String searchkey) 
	{
		HomeMapper mapper = session.getMapper(HomeMapper.class);
		return mapper.searchitem(searchkey);
	}
	
	public ArrayList<OrderVO> selectall(MemberVO member) 
	{
		HomeMapper mapper = session.getMapper(HomeMapper.class);
		return mapper.selectall(member);
	}
}
