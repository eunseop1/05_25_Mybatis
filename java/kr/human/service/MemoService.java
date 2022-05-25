package kr.human.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.human.dao.MemoDAO;
import kr.human.mybatis.MybatisApp;
import kr.human.vo.MemoVO;
import kr.human.vo.PagingVO;

public class MemoService {
	private static MemoService instance = new MemoService();
	private MemoService() {}
	public static MemoService getInstance() { return instance; }
	//----------------------------------------------------------
	
	// 1. 목록보기
	public PagingVO<MemoVO> selectList(int currentPage, int pageSize, int blockSize){
		PagingVO<MemoVO> pagingVO = null;
		MemoDAO dao = MemoDAO.getInstance();
		SqlSession sqlSession = null;
		try{
			sqlSession = MybatisApp.getSqlSessionFactory().openSession();
			int totalCount = dao.selectCount(sqlSession);
			pagingVO = new PagingVO<MemoVO>(totalCount, currentPage, pageSize, blockSize);
			
			HashMap<String, Integer> map = new HashMap<>();
			map.put("startNo", pagingVO.getStartNo());
			map.put("endNo", pagingVO.getEndNo());
			
			List<MemoVO> list = dao.selectList(sqlSession, map);
			pagingVO.setList(list);
			sqlSession.commit();
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return pagingVO;
	}
	
	// 2. 저장
	public void insert(MemoVO memoVO) {
		SqlSession sqlSession = null;
		try{
			sqlSession = MybatisApp.getSqlSessionFactory().openSession();
			if(memoVO!=null) {
				MemoDAO.getInstance().insert(sqlSession, memoVO);
			}
			sqlSession.commit();
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
	}
	// 3. 수정
	public void update(MemoVO memoVO) {
		SqlSession sqlSession = null;
		try{
			sqlSession = MybatisApp.getSqlSessionFactory().openSession();
			if(memoVO!=null) {
				MemoVO dbVO = MemoDAO.getInstance().selectByIdx(sqlSession, memoVO.getIdx());
				if(dbVO!=null && dbVO.getPassword().equals(memoVO.getPassword())) {
					MemoDAO.getInstance().update(sqlSession, memoVO);
				}
			}
			sqlSession.commit();
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
	}
	
	// 4. 삭제
	public void delete(MemoVO memoVO) {
		SqlSession sqlSession = null;
		try{
			sqlSession = MybatisApp.getSqlSessionFactory().openSession();
			if(memoVO!=null) {
				MemoVO dbVO = MemoDAO.getInstance().selectByIdx(sqlSession, memoVO.getIdx());
				if(dbVO!=null && dbVO.getPassword().equals(memoVO.getPassword())) {
					MemoDAO.getInstance().delete(sqlSession, memoVO.getIdx());
				}
			}
			sqlSession.commit();
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
	}
}
