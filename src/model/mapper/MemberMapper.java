package model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Member;

public interface MemberMapper {
	
	// 동적쿼리
	@Select({"<script>",
				"select * from member", // 무조건 실행되고
				"<if test='id !=null'> where binary id =#{id} </if>",
			 "</script>"})
	List<Member> select(Map<String, Object> map);
	
	@Insert("insert into member"
			+ " (id,pass,name,gender,email,tel,picture) "
			+ " values(#{id},#{pass},#{name},#{gender},#{email},#{tel},#{picture})")
	int insert(Member m);
	
	@Update("update member set"
			+ " name=#{name},gender=#{gender},email=#{email},tel=#{tel},picture=#{picture} "
			+ " where id=#{id} ")
	int update(Member m);

	@Delete("delete from member where id=#{id}")
	int delete(String id);

	@Update("update member set pass=#{new_pass}"
			+ " where id=#{id} ")
	int updatepass(@Param("id") String id, @Param("new_pass") String new_pass);
	
//	@Select({"<script>",
//				"select * from member",
//				"<if test='email !=null && tel !=null> where binary email=#{email} and tel=#{tel} </if>",
//			 "</script>"})
	@Select("select * from member where binary email=#{email} and tel=#{tel}")
	String findId(Map<String, Object> map);
	
//	@Select("select * from member where binary email=#{email} and tel=#{tel}")
//	String findId(@Param("email") String email, @Param("tel") String tel);
	
	@Select("select * from member where binary id=#{id} and binary email=#{email} and tel=#{tel}")
	String findPass(@Param("id") String id, @Param("email") String email, @Param("tel") String tel);



}
