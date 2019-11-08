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

// Model기능을 담당하는 클래스로 설정(내가)
// Dao : 데이터베이스를 가져오고 전달하는 기능 Data Access Object
public class MemberDao {
	// param으로 쓸라고
	private Map<String,Object> map = new HashMap<String,Object>();
	private Class<MemberMapper> cls = MemberMapper.class; // MemberMapper.class를 대신해서 씀
	
	// id : 화면에 입력된 아이디
	public Member selectOne(String id) {
		SqlSession session = DBConnection.getConnection();
		
		try {
			map.clear();
			map.put("id", id);
			List<Member> list = session.getMapper(cls).select(map);
			return list.get(0); // list에 있는 첫번째 레코드를 가져와
		} catch(Exception e) {
			e.printStackTrace();
		} finally { // return을 만나도 finally는 반드시 실행
			DBConnection.close(session); // DBConnection클래스의 close()메서드
		}
		return null;
	}
	
	// 화면으로부터 입력받은 내용을 저장하고 있는 객체 m
	// insert()의 리턴값은 join.jsp의 int result 값이 됨.
	public int insert(Member m) { // 어떤값을 받아서 어떤값을 리턴하느냐
		// 끊어진 connection 다시 연결
		SqlSession session = DBConnection.getConnection();
				
		try {
			return session.getMapper(cls).insert(m);	
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0; // insert 실패를 뜻함 (return -1;도 가능)
	}
	
	// MemberDao().list()
	// 멤버에 있는 리스트를 불러와..?
	public List<Member> list() {
		SqlSession session = DBConnection.getConnection();
		
		try {
			return session.getMapper(cls).select(null); // map==null인 상태 조건없이 모든 정보
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return null; // 오류가 나면 null값을 전달
	}

	// 화면으로부터 입력받은 내용(변경 될 내용)을 저장하고 있는 객체 m
	// insert()의 리턴값은 update.jsp의 int result 값이 됨.
	public int update(Member m) {
		SqlSession session = DBConnection.getConnection();
		
		try {
			return session.getMapper(cls).update(m);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(session);
		}
		return 0; // insert 실패를 뜻함 (return -1;도 가능)
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
		return 0; // insert 실패를 뜻함 (return -1;도 가능)
	}
	
	public int updatepass(String id, String new_pass) {
		// 끊어진 connection 다시 연결
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
		return 0; // insert 실패를 뜻함 (return -1;도 가능)
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
