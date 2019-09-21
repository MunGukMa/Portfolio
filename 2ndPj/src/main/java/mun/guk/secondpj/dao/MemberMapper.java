package mun.guk.secondpj.dao;

import mun.guk.secondpj.vo.MemberVO;

public interface MemberMapper {

	MemberVO login(MemberVO vo);

	int idchk(MemberVO vo);

	void signup(MemberVO vo);

	void infoupdate(MemberVO vo);

}
