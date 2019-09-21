package mun.guk.secondpj.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mun.guk.secondpj.vo.MemberVO;

@Repository
public class MemberDAO {

	@Autowired
	private SqlSession session;
	
	
	public MemberVO login(MemberVO vo) 
	{
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		return mapper.login(vo);
	}


	public int idchk(MemberVO vo) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		return mapper.idchk(vo);
	}


	public void signup(MemberVO vo) 
	{
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		mapper.signup(vo);
	}


	public void infoupdate(MemberVO vo) 
	{
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		mapper.infoupdate(vo);
	}

	




}
