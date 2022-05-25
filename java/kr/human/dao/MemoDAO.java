package kr.human.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.human.vo.MemoVO;

public class MemoDAO {
	private static MemoDAO instance = new MemoDAO();
	private MemoDAO() {}
	public static MemoDAO getInstance() { return instance; }
	//----------------------------------------------------------
	public int selectCount(SqlSession sqlSession) {
		return sqlSession.selectOne("memo.selectCount");
	}
	public MemoVO selectByIdx(SqlSession sqlSession, int idx) {
		return sqlSession.selectOne("memo.selectByIdx", idx);
	}
	public List<MemoVO> selectList(SqlSession sqlSession, HashMap<String, Integer> map){
		return sqlSession.selectList("memo.selectList", map);
	}
	public void insert(SqlSession sqlSession, MemoVO memoVO) {
		sqlSession.insert("memo.insert", memoVO);
	}
	public void update(SqlSession sqlSession, MemoVO memoVO) {
		sqlSession.update("memo.update", memoVO);
	}
	public void delete(SqlSession sqlSession, int idx) {
		sqlSession.delete("memo.delete", idx);
	}
}
