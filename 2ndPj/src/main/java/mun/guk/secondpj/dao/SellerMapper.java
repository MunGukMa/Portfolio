package mun.guk.secondpj.dao;

import java.util.ArrayList;
import java.util.HashMap;

import mun.guk.secondpj.vo.ExcelVO;
import mun.guk.secondpj.vo.MemberVO;
import mun.guk.secondpj.vo.OrderVO;
import mun.guk.secondpj.vo.ProductVO;

public interface SellerMapper {

	void registproduct(ProductVO vo);

	ArrayList<ProductVO> setplist(MemberVO vo);

	ArrayList<ProductVO> sortlist(HashMap<String, String> map);

	ArrayList<ProductVO> setslist(MemberVO vo);

	ProductVO selectone(ProductVO vo);

	OrderVO totalvalue(ProductVO vo);

	OrderVO totalqt(ProductVO vo);

	ProductVO totalend(ProductVO vo);

	ProductVO totalpro(ProductVO vo);

	ProductVO totalready(ProductVO vo);

	ProductVO totalpay(ProductVO vo);

	ProductVO totalconf(ProductVO vo);

	ArrayList<OrderVO> detailship(OrderVO vo);

	ArrayList<ExcelVO> getlist(ArrayList<String> list);

}
