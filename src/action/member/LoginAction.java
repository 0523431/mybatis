package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.Member;
import model.MemberDao;

/*
 * 1. id, pass 파라미터 저장
 * 2. id에 해당하는 정보를 db에서 조회
 *    - 존재하면, 비밀번호 확인
 *    - 존재하지 않으면 id 없음 메시지를 출력하고 loginForm.me페이지로 이동
 * 3. id가 존재하면, 비밀번호 검증
 *    - 비밀번호가 맞는 경우 : session 로그인 정보 저장
 *                     로그인 성공 메시지를 출력 / main.me 페이지로 이동
 *    - 비밀번호가 틀린 경우 : 로그인 실패 메시지 출력, loginForm.me 페이지로 이동
 * 
 */

public class LoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 1번 실행
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		
		String msg = "해당 id가 존재하지않습니다.";
		String url = "loginForm.me";
		
		Member mem = new MemberDao().selectOne(id);
		
		if(mem !=null) { // db에 정보가 있으면(id 존재)
			
			if(pass.contentEquals(mem.getPass())) {
				
				// session.setAttribute("login", id);
				// session은 jsp의 내장객체이지, java의 내장객체가 아니니까 
				request.getSession().setAttribute("login", id);
				
				msg = mem.getName() + "님이 로그인하셨습니다";
				url = "main.me";
			} else { // 비밀번호가 다른 경우
				msg = "비밀번호가 틀립니다.";
			}
		}
		
		// 음..
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
}
