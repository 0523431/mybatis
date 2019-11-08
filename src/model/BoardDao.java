package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import model.mapper.BoardMapper;

public class BoardDao {
	// param으로 쓸라고
		private Map<String,Object> map = new HashMap<String,Object>();
		private Class<BoardMapper> cls = BoardMapper.class;
		
	// 현재 등록되있는 게시물 번호 중 최대값을 리턴
	public int maxnum() {
		SqlSession session = DBConnection.getConnection();

		try {
			return session.getMapper(cls).maxmum();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0;
	}

	// 게시물 등록
	public boolean insert(Board board) {
		SqlSession session = DBConnection.getConnection();
		
		try {
			int cnt = session.getMapper(cls).insert(board);
			if(cnt >0) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally { // return했지만, 꼭 하고 다음으로 넘어가
			DBConnection.close(session);
		}
		return false;
	}
	
	// 게시물 건수
	// public int boardCount() {
	public int boardCount(String column, String find) {
		SqlSession session = DBConnection.getConnection();
		try {
			map.clear();
			// 검색기능에 게시물 건수까지 표시하게 ..
			if(column != null) {
				String[] col = column.split(",");
				map.put("col1", col[0]);
				if(col.length ==2) {
					map.put("col2", col[1]);
				}
				map.put("find", find);
			}
			return session.getMapper(cls).boardCount(map);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0;
	}
	
	// 게시판 리스트
	public List<Board> list(int pageNum, int limit, String column, String find) { // String column, String find 추가
		SqlSession session = DBConnection.getConnection();
	
		try {
			map.clear();
			map.put("start", (pageNum-1)*limit); // 0이면 첫번째 레코드
			map.put("limit", limit);
			if(column != null) {
				String[] col = column.split(",");
				map.put("col1", col[0]);
				if(col.length ==2) {
					map.put("col2", col[1]);
				}
				map.put("find", find);
			}
			return session.getMapper(cls).select(map);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}
	
	public Board selectOne(int num) {
		SqlSession session = DBConnection.getConnection();		
		
		try {
			map.clear();
			map.put("num", num);
			return session.getMapper(cls).select(map).get(0);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}
	
	// 조회수 증가
	public void readcntadd(int num) {
		SqlSession session = DBConnection.getConnection();
		try {
			session.getMapper(cls).readcntadd(num);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
	}
	
	// 답글 순서 지정
	public void grpStepAdd(int grp, int grpstep) {
		SqlSession session = DBConnection.getConnection();
		
		try {
			map.clear();
			map.put("grp", grp);
			map.put("grpstep", grpstep);
			session.getMapper(cls).grpSepAdd(map);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
	}

	// 게시글 수정
	public boolean update(Board board) {
		SqlSession session = DBConnection.getConnection();		
		
		try {
			int cnt = session.getMapper(cls).update(board);
			if(cnt >0) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return false;
	}
	
	// 게시글 삭제
	public boolean deleteB(Board b) {
		SqlSession session = DBConnection.getConnection();		
		
		try {
			int cnt = session.getMapper(cls).deleteB(b);
			if(cnt >0) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return false;
	}
}
