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
	
	// �Խñ� ���
	@Insert("insert into board"
			 + " (num,name,pass,title,content,file1,regdate,readcnt,grp,grplevel,grpstep) "
			 + " values (#{num},#{name},#{pass},#{title},#{content},#{file1},now(),0,#{grp},#{grplevel},#{grpstep})")
	int insert(Board board);
	
	// �Խù� �Ǽ�(�� ����)
	@Select({"<script>",
			" select count(*) from board ",
				" <if test='col1 !=null'> where ${col1} like '%${find}%' </if>",
				" <if test='col2 !=null'> or ${col2} like '%${find}%' </if>",
			"</script>"})
	Integer boardCount(Map<String, Object> map);
	
	// �Խñ� ���(�˻� ��ϱ���)
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

	// ��ȸ��
	@Update("update board set readcnt=readcnt+1 where num=#{num}")
	void readcntadd(int num);
	
	// ��� ����
	@Update("update board set grpstep=grpstep+1 where grp=#{grp} and grpstep >#{grpstep}")
	void grpSepAdd(Map<String, Object> map);
	
	// �Խñ� ����
	@Update("update board set name=#{name}, title=#{title}, content=#{content}, file1=#{file1} "
			+ " where num=#{num}")
	int update(Board board);
	
	// �Խñ� ����
	@Delete("delete from board where num=#{num}")
	int deleteB(Board b);
	
}
