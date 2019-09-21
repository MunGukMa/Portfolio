package mun.guk.secondpj.dao;

import java.util.ArrayList;

import mun.guk.secondpj.vo.MemberVO;
import mun.guk.secondpj.vo.OrderVO;
import mun.guk.secondpj.vo.ProductVO;

public interface BuyerMapper {

	ProductVO productread(ProductVO vo);

	ProductVO selectone(OrderVO vo);

	void goorder(OrderVO vo);


}
