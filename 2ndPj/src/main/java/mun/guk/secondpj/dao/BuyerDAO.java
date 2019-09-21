package mun.guk.secondpj.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mun.guk.secondpj.vo.MemberVO;
import mun.guk.secondpj.vo.OrderVO;
import mun.guk.secondpj.vo.ProductVO;

@Repository
public class BuyerDAO {
	
	@Autowired
	SqlSession session;

	public ProductVO selectone(OrderVO vo) 
	{
		BuyerMapper mapper = session.getMapper(BuyerMapper.class);
		return mapper.selectone(vo);
	}

	public void goorder(OrderVO vo) 
	{
		BuyerMapper mapper = session.getMapper(BuyerMapper.class);
		ProductMapper pmapper = session.getMapper(ProductMapper.class);
		pmapper.updateorder(vo);
		mapper.goorder(vo);
	}

	

	
}
