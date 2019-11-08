package model;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

/*
 * 접근제어자를 쓰지 않았다 : 같은 패키지에서만 접근이 가능한거야
 */

// 같은 패키지 model패키지에서만 사용이 가능함
// static이니까 DBConnection을 .으로 연결해오면 당연히 실행되는 거야?

public class DBConnection {
	
	// static : 전체 객체에서 한번만 쓸거야
	// sqlMap : 컨테이너 객체
	private static SqlSessionFactory sqlMap;
	
	// static초기화 블럭
	static {
		// 파일이기때문에 파일명으로 접근할 수 있게 model.mapper이지만 폴더로 표시
		// mybatis-config.xml 파일의 위치
		String resource = "model/mapper/mybatis-config.xml";
		Reader reader = null;
		try {
			reader = Resources.getResourceAsReader(resource);
		} catch(IOException e) {
			e.printStackTrace();
		}
		// build : Connection 객체 설정
		//         SQL 구문을 저장하는 컨테이너 설정 (reader로 부터 읽어서)
		sqlMap = new SqlSessionFactoryBuilder().build(reader);
	}
	
	static SqlSession getConnection() {
		return sqlMap.openSession(); // 성공시=> DB와 연결 (sqlMap에 있는 Connection 객체를 통해)
	}
	
	static void close(SqlSession session) {
		session.commit();
		session.close();
	}
}
