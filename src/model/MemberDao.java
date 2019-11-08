package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import model.mapper.MemberMapper;

// Model����� ����ϴ� Ŭ������ ����(����)
// Dao : �����ͺ��̽��� �������� �����ϴ� ��� Data Access Object
public class MemberDao {
	// param���� �����
	private Map<String,Object> map = new HashMap<String,Object>();
	private Class<MemberMapper> cls = MemberMapper.class; // MemberMapper.class�� ����ؼ� ��
	
	// id : ȭ�鿡 �Էµ� ���̵�
	public Member selectOne(String id) {
		SqlSession session = DBConnection.getConnection();
		
		try {
			map.clear();
			map.put("id", id);
			List<Member> list = session.getMapper(cls).select(map);
			return list.get(0); // list�� �ִ� ù��° ���ڵ带 ������
		} catch(Exception e) {
			e.printStackTrace();
		} finally { // return�� ������ finally�� �ݵ�� ����
			DBConnection.close(session); // DBConnectionŬ������ close()�޼���
		}
		return null;
	}
	
	// ȭ�����κ��� �Է¹��� ������ �����ϰ� �ִ� ��ü m
	// insert()�� ���ϰ��� join.jsp�� int result ���� ��.
	public int insert(Member m) { // ����� �޾Ƽ� ����� �����ϴ���
		// ������ connection �ٽ� ����
		SqlSession session = DBConnection.getConnection();
				
		try {
			return session.getMapper(cls).insert(m);	
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0; // insert ���и� ���� (return -1;�� ����)
	}
	
	// MemberDao().list()
	// ����� �ִ� ����Ʈ�� �ҷ���..?
	public List<Member> list() {
		SqlSession session = DBConnection.getConnection();
		
		try {
			return session.getMapper(cls).select(null); // map==null�� ���� ���Ǿ��� ��� ����
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null; // ������ ���� null���� ����
	}

	// ȭ�����κ��� �Է¹��� ����(���� �� ����)�� �����ϰ� �ִ� ��ü m
	// insert()�� ���ϰ��� update.jsp�� int result ���� ��.
	public int update(Member m) {
		SqlSession session = DBConnection.getConnection();
		
		try {
			return session.getMapper(cls).update(m);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0; // insert ���и� ���� (return -1;�� ����)
	}
	
	public int delete(String id) {
		SqlSession session = DBConnection.getConnection();

		try {
			return session.getMapper(cls).delete(id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0; // insert ���и� ���� (return -1;�� ����)
	}
	
	public int updatepass(String id, String new_pass) {
		// ������ connection �ٽ� ����
		SqlSession session = DBConnection.getConnection();
		
		try {
//			map.clear();
//			map.put("id", id);
//			map.put("new_pass", new_pass);
			return session.getMapper(cls).updatepass(id, new_pass);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0; // insert ���и� ���� (return -1;�� ����)
	}
		
	public String findId(String email, String tel) {
		SqlSession session = DBConnection.getConnection();

		try {
			map.clear();
			map.put("email", email);
			map.put("tel", tel);
			return session.getMapper(cls).findId(map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}

	public String findPass(String id, String email, String tel) {
		SqlSession session = DBConnection.getConnection();

		try {
			return session.getMapper(cls).findPass(id, email, tel);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null;
	}
}
