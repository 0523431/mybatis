package action.board;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import action.ActionForward;
import model.Board;
import model.BoardDao;

public class BoardAllAction {
	// db연결용
	private BoardDao dao = new BoardDao();
	
	public ActionForward hello(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("hello", "Hello, World");
		return new ActionForward();
	}
	
	/* <할 일>
	 * 1. multipart/form-data 타입의 전송이므로, MultipartRequest 객체 생성
	 * 2. 파라미터 값을 model.Board 객체에 저장
	 * 3. 게시물 번호 num은 현재 등록된 num의 최대값을 조회 후 +1
	   => 등록된 게시물의 번호 : 최대값 +1
	   => db에서 maxnum을 구해서 1을 더한 값으로 num을 설정
	   
	 * 4. board내용(입력된 내용)을 db에 등록하기
	   - 등록성공 : 메시지 출력 => list.jsp 페이지 이동
	   - 등록실패 : 메시지 출력 => writeForm.jsp 페이지 이동
	 */
	public ActionForward write(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		// msg, url default값
		String msg = "게시물 등록 실패";
		String url = "writeForm.do";
		
		// 1번
		String ulpath = request.getServletContext().getRealPath("/") + "model2/board/file/";
		try {
			File f = new File(ulpath);
			if(!f.exists()) { // 존재하지 않으면 폴더를 만들어
				f.mkdirs();
			}
			MultipartRequest multi = new MultipartRequest(request, ulpath, 10*1024*1024,"euc-kr");
			
			// 2번
			Board b = new Board();
			b.setName(multi.getParameter("name"));
			b.setPass(multi.getParameter("pass"));
			b.setTitle(multi.getParameter("title"));
			b.setContent(multi.getParameter("content"));
			b.setFile1(multi.getFilesystemName("file1"));
			
			// 3번
			int num = dao.maxnum();
			b.setNum(++num);
			b.setGrp(num);
			
			// 4번
			if(dao.insert(b)) { // boolean타입
				msg = "게시물 등록 성공";
				url = "list.do";
			}
		} catch(IOException e) {
			e.printStackTrace();
			throw new ServletException(e);
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	/* <할 일>
	 * 1. 한페이지 당 10건의 게시물
	 *    - pageNum 파라미터값을 저장 / 없는 경우 1로설정(강제)
	 * 2. 최근에 등록된 게시물을 가장 위에 배치
	 *    - 이미 db에서 설정함
	 * 3. 화면에 필요한 정보를 속성으로 등록 => view로 전송
	 */
	public ActionForward list(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		// 1번
		int limit =10;
		int pageNum =1;
		
		try {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		} catch(NumberFormatException e) {
			e.printStackTrace();
		}
		
		// 게시물 검색하기에서 <검색조건>
		String column = request.getParameter("column");
		String find = request.getParameter("find");
		if(column !=null && column.trim().equals("")) {
			column = null;
		}
		if(find !=null && find.trim().equals("")) { // find를 선택하지않아도 검색 가능
			find = null;
		}
		if(column == null || find == null) { // 전체를 검색하겠다
			column = null;
			find = null;
		}
		
		// 2번
		// int boardcnt = dao.boardCount();
		int boardcnt = dao.boardCount(column, find);
		List<Board> list = dao.list(pageNum, limit, column, find);
		int maxpage = (int)((double)boardcnt/limit + 0.95);
		int startpage = ((int)(pageNum/10.0 + 0.9) -1) *10 +1;
		int endpage = startpage +9;
		if(endpage > maxpage) {
			endpage = maxpage;
		}
		/*
		 *  maxpage : 총페이지 개수
			전체 게시물 건수 : 21건 => 3페이지 => pageNum=3
			---> 21.0/10 + 0.95 = (int)(3.05) = 3;
			---> 101.0/10 + 0.95 = (int)(10.1+0.95) = (int)(11.05) = 11;
		 * 
		 * 	pageNum : 2 => 1페이지
			---> (2/10.0 + 0.9) = ((int)(1.1) *10) +1 = 페이지시작이 1부터
			pageNum : 10 => 1페이지
			---> (10/10.0 +0.9) = ((int)(1.9) -1) *10 = 1부터 statpage를 표시
			pageNum : 101 => 11
			---> (11/10.0 +0.9) = ((int))
		 */
		
		// 게시물 번호를 등록한 순서에 상관없이 차례로 나타내고자 할 때,
		int boardnum = boardcnt - (pageNum -1) *limit;
		
		// 3번
		request.setAttribute("boardcnt", boardcnt);
		request.setAttribute("list", list);
		request.setAttribute("maxpage", maxpage);
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		request.setAttribute("boardnum", boardnum);
		request.setAttribute("pageNum", pageNum);
		return new ActionForward();
	}

	/*  <할 일>
	 *  1. num 파라미터 정보를 저장
		2. num을 이용하여 db에서 게시물 정보를 조회
	   	   Board BoardDao.selectOne(num)
	
		3. 조회수 증가시키기
	       void BoardDao.readcntadd(num)
	
	 	4. 조회된 게시물 화면에 출력
	 */
	public ActionForward info(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		Board info = dao.selectOne(num); // num에 해당하는 게시물 조회
		
		// 상세경로가 info.do인 경우에만 num에 해당하는 조회수 증가
		// 즉, /jsp_study2/model2/board/info.do인 경우
		if(request.getRequestURI().contains("info.do")) {
			dao.readcntadd(num);
		}
		
		request.setAttribute("num", num); // 잊지말자
		request.setAttribute("info", info);
		return new ActionForward();
	}

	/* <답글 달기>
		1. 파라미터 값을 Board 객체에 저장하기 =============> useBean액션태크 사용 불가
	    - 원글 정보 : num / grp / grplevel / grpstep
	    - 답글 정보 : name / pass / title / content  ======> 수정 정보
	
		2. 같은 grp값을 사용하는 게시물들의 grpstep 값을 1증가하기 (기존글의 grpStep에 +1)
	    - void BoardDao.grpStepAdd(grp, grpstep)

		3. Board 객체를 db에 insert하기
	    - num : maxnum+1
	    - grp : 원글과 동일하게 유지
	    - grplevel : 원글 +1 (답글 단계)
	    - grpstep : 원급 +1
	
		4. - 등록 성공시 : "답변등록 완료" 메시지 출력 => list.jsp로 이동
	       - 등록 실패시 : "답변등록 오류발생" 메시지 출력 => replyForm.jsp로 이동
	 */
	public ActionForward reply(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		
		// 1번내용
		Board b = new Board();
		b.setNum(Integer.parseInt(request.getParameter("num")));
		b.setGrp(Integer.parseInt(request.getParameter("grp")));
		b.setGrplevel(Integer.parseInt(request.getParameter("grplevel")));
		b.setGrpstep(Integer.parseInt(request.getParameter("grpstep")));
		b.setName(request.getParameter("name"));
		b.setPass(request.getParameter("pass"));
		b.setTitle(request.getParameter("title"));
		b.setContent(request.getParameter("content"));
		
		// 2번내용 : 기존 글의 grpStep에 +1 해주는 함수
		dao.grpStepAdd(b.getGrp(), b.getGrpstep());
		System.out.println("num이랑 동일한 Grp(group)값 : "+b.getGrp());
		
		// 3번내용
		int grplevel = b.getGrplevel(); // 원글정보
		int grpstep = b.getGrpstep(); // 원글정보
		int num = dao.maxnum();
		
		String msg = "답변등록시 오류 발생";
		String url = "replyForm.do?num="+b.getNum();
		
		b.setNum(++num);
		b.setGrplevel(grplevel +1);
		b.setGrpstep(grpstep +1);
		
		if(dao.insert(b)) {
			msg = "답변글 등록 완료";
			url = "list.do";
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	/* <할 일>
	 * 	1. 파라미터정보들을 Board 객체에 저장 ==> multipartRequest
	
		2. 비밀번호 검증
	    - 일치하는 경우 => 파라미터의 내용으로 해당 게시물의 내용을 수정
	              => 첨부파일의 변경이 없는 경우 file2 파라미터의 내용을 다시 저장
	    - 불일치하는 경우 : 오류메시지 출력 & updateForm.do로 이동
	
		3. - 수정성공 : 수정성공 메시지 출력 후 info.do 이동
	       - 수정실패 : 수정실패 메시지 출력 후 updateForm.do 이동
	*/
	public ActionForward update(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		
		String msg =null;
		String url =null;
		
		// useBean액션테그를 사용할 수 없으니까
		// Board객체에 파라미터 정보를 일일히 저장해줌
		Board b = new Board();
		String uploadpath = request.getServletContext().getRealPath("/") + "model2/board/file/";
		try {
			MultipartRequest multi = new MultipartRequest(request, uploadpath, 10*1024*1024, "euc-kr");
			
			b.setNum(Integer.parseInt(multi.getParameter("num")));
			b.setName(multi.getParameter("name"));
			b.setPass(multi.getParameter("pass"));
			b.setTitle(multi.getParameter("title"));
			b.setContent(multi.getParameter("content"));
			b.setFile1(multi.getFilesystemName("file1"));
			
			// => 첨부파일의 변경이 없는 경우 file2 파라미터의 내용을 다시 저장
			// 파일수정을 하지 않음 - 그래서 multi.getParameter("file2")의 내용을 setFile1 해줌
			if(b.getFile1() ==null || b.getFile1().equals("")) {
				b.setFile1(multi.getParameter("file2"));
			}
			
			// 2 비밀번호 검증
			Board dbboard = dao.selectOne(b.getNum());
			
			msg = "비밀번호가 틀렸습니다 == 수정실패";
			url = "updateForm.do?num="+b.getNum();
			
			if(b.getPass().equals(dbboard.getPass())) {
				
				if(dao.update(b)) {
					msg = "게시물 수정에 성공했습니다";
					url = "info.do?num=" +b.getNum();
				} else {
					msg = "수정에 실패했습니다";
					url = "updateForm.do?num=" +b.getNum();
				}
			}
		} catch(IOException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

	/*  <delete 할 일>
	 *  1. num, pass 파라미터를 변수에 저장
	
		2. 입력된 비밀번호와 db 비밀번호 검증
	   	- 틀린 경우, 비밀번호 오류 메시지 출력 & deleteForm.jsp로 이동
	
		3. 비밀번호가 맞는 경우,
	    - 삭제 성공 : 삭제 성공 메시지 출력 후, list.jsp로 이동
	    - 삭제 실패 : 삭제 실패 메시지 출력 후, info.jsp로 이동
	*/
	public ActionForward delete(HttpServletRequest request, HttpServletResponse response) throws ServletException {
		
		int num = Integer.parseInt(request.getParameter("num"));
		String pass = request.getParameter("pass");
		
		String msg =null;
		String url =null;
		
		Board b = dao.selectOne(num);
		
		if(b ==null) { // 없는 글 삭제하려고 할 때,
			msg = "이미 삭제해서 없는 게시글입니다";
			url = "list.do";
		} else {
			if(pass.equals(b.getPass()) && !pass.trim().equals("")) {
				if(dao.deleteB(b)) {
					msg = "게시글 삭제에 성공했습니다";
					url = "list.do";
					request.getSession().invalidate();
				} else {
					msg = "게시글 삭제에 실패했습니다";
					url = "info.do?num=" +b.getNum();
				}
			} else {
				msg = "비밀번호가 일치하지 않습니다. 확인해주세요";
				url = "deleteForm.do?num="+b.getNum();
			}
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
	
	public ActionForward imgupload(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String path = request.getServletContext().getRealPath("/") + "model2/board/imgfile/";
		File f = new File(path);
		if(!f.exists()) {
			f.mkdirs();
		}
		
		MultipartRequest multi = new MultipartRequest(request, path, 10*1024*1024, "euc-kr");
		String fileName = multi.getFilesystemName("upload");
		
		// "CKEditorFuncNum" : 이미 정해진거야, ck editor에게 파일이름을 전달해줘
		request.setAttribute("fileName", fileName);
		request.setAttribute("CKEditorFuncNum", request.getParameter("CKEditorFuncNum"));
		return new ActionForward(false, "ckeditor.jsp");
	}
	
}
