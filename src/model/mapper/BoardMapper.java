package model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Board;

public interface BoardMapper {
	
	@Select("select ifnull(max(num),0) from board")
	int maxmum();
	
	// 게시글 등록
	@Insert("insert into board"
			 + " (num,name,pass,title,content,file1,regdate,readcnt,grp,grplevel,grpstep) "
			 + " values (#{num},#{name},#{pass},#{title},#{content},#{file1},now(),0,#{grp},#{grplevel},#{grpstep})")
	int insert(Board board);
	
	// 게시물 건수(글 개수)
	@Select({"<script>",
			" select count(*) from board ",
				" <if test='col1 !=null'> where ${col1} like '%${find}%' </if>",
				" <if test='col2 !=null'> or ${col2} like '%${find}%' </if>",
			"</script>"})
	Integer boardCount(Map<String, Object> map);
	
	// 게시글 목록(검색 목록까지)
	@Select({"<script>",
			 " select * from board ",
			 	" <if test='col1 !=null'> where ${col1} like '%${find}%' </if>",
			 	" <if test='col2 !=null'> or ${col2} like '%${find}%' </if>",
			 	" <choose>",
			 		" <when test='num !=null'> where num =#{num} </when>",
			 		" <otherwise>"
			 + 			" order by grp desc, grpstep asc limit #{start},#{limit}"
			 + 		" </otherwise>",
			 	"</choose>",
			 "</script>"})
	List<Board> select(Map<String, Object> map);

	// 조회수
	@Update("update board set readcnt=readcnt+1 where num=#{num}")
	void readcntadd(int num);
	
	// 답글 순서
	@Update("update board set grpstep=grpstep+1 where grp=#{grp} and grpstep >#{grpstep}")
	void grpSepAdd(Map<String, Object> map);
	
	// 게시글 수정
	@Update("update board set name=#{name}, title=#{title}, content=#{content}, file1=#{file1} "
			+ " where num=#{num}")
	int update(Board board);
	
	// 게시글 삭제
	@Delete("delete from board where num=#{num}")
	int deleteB(Board b);
	
}
