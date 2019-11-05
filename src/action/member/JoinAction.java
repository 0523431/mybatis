package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.Member;
import model.MemberDao;
/*
 * 1. parameter 정보를 Member 객체에 저장 (jsp가 아니기때문에 useBean액션 태그를 쓸 수 없음)
 * 2. Member 객체를 db에 추가
 *    - 성공 : 메세지 출력, loginForm.me 페이지로 이동
 *    - 실패 : 메시지 출력, joinForm.me 페이지로 이동
 */
public class JoinAction implements Action {
	
	// request.setCharacterEncoing("euc-kr");을 할 필요없음
	// 왜? Controller에서 설정해줬으니까
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 1번
		Member mem = new Member();
		mem.setId(request.getParameter("id"));
		mem.setPass(request.getParameter("pass"));
		mem.setName(request.getParameter("name"));
		mem.setGender(Integer.parseInt(request.getParameter("gender")));
		mem.setTel(request.getParameter("tel"));
		mem.setEmail(request.getParameter("email"));
		mem.setPicture(request.getParameter("picture"));
		
		// 2번
		MemberDao dao = new MemberDao();
		String msg = "회원가입 실패";
		String url = "joinForm.me";
		
		if(dao.insert(mem) >0) {
			msg = mem.getName() + "님 회원가입 성공";
			url = "loginForm.me";
		}
		
		System.out.println(mem);

		request.setAttribute("msg",msg);
		request.setAttribute("url",url);
		return new ActionForward(false, "../alert.jsp");
	}
	
}
