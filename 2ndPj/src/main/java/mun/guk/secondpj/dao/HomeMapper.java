package mun.guk.secondpj.dao;

import java.util.ArrayList;

import mun.guk.secondpj.vo.MemberVO;
import mun.guk.secondpj.vo.OrderVO;
import mun.guk.secondpj.vo.ProductVO;

public interface HomeMapper {

	ArrayList<ProductVO> setmainlist(ProductVO vo);
	
	ProductVO productread(ProductVO vo);

	void updateview(ProductVO vo);

	ArrayList<ProductVO> productboard(ProductVO vo);

	ArrayList<ProductVO> searchitem(String searchkey);

	ArrayList<OrderVO> selectall(MemberVO member);
}
