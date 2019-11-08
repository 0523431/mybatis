package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import model.mapper.BoardMapper;

public class BoardDao {
	// param���� �����
		private Map<String,Object> map = new HashMap<String,Object>();
		private Class<BoardMapper> cls = BoardMapper.class;
		
	// ���� ��ϵ��ִ� �Խù� ��ȣ �� �ִ밪�� ����
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

	// �Խù� ���
	public boolean insert(Board board) {
		SqlSession session = DBConnection.getConnection();
		
		try {
			int cnt = session.getMapper(cls).insert(board);
			if(cnt >0) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally { // return������, �� �ϰ� �������� �Ѿ
			DBConnection.close(session);
		}
		return false;
	}
	
	// �Խù� �Ǽ�
	// public int boardCount() {
	public int boardCount(String column, String find) {
		SqlSession session = DBConnection.getConnection();
		try {
			map.clear();
			// �˻���ɿ� �Խù� �Ǽ����� ǥ���ϰ� ..
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
	
	// �Խ��� ����Ʈ
	public List<Board> list(int pageNum, int limit, String column, String find) { // String column, String find �߰�
		SqlSession session = DBConnection.getConnection();
	
		try {
			map.clear();
			map.put("start", (pageNum-1)*limit); // 0�̸� ù��° ���ڵ�
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
	
	// ��ȸ�� ����
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
	
	// ��� ���� ����
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

	// �Խñ� ����
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
	
	// �Խñ� ����
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
