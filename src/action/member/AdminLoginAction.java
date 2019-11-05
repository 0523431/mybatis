package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;

/*
 * 1. 로그아웃 상태 : "로그인이 필요합니다" => logingForm.me로 페이지 이동
 * 2. 로그인 상태
 * 		- 일반사용자 : "관리자만 가능한 거래입니다" => main.me로 페이지 이동
 */

// 관리자용 추상클래스
// 관리자만 쓸 수 있는 기능에서 이 클래스만 상속받으면 별도의 확인 절차가 필요없어짐
public abstract class AdminLoginAction implements Action {
	
	protected String login;
	protected String id;
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		login = (String)request.getSession().getAttribute("login");
		id = request.getParameter("id");
		
		if(login ==null || login.trim().equals("")) {
			request.setAttribute("msg","로그인이 필요합니다");
			request.setAttribute("url", "loginForm.me");
			return new ActionForward(false, "../alert.jsp");
		} else {
			if(!login.equals("admin")) {
				request.setAttribute("msg","관리자만 사용이 가능한 기능입니다");
				request.setAttribute("url", "main.me");
				return new ActionForward(false, "../alert.jsp");
			}
		}
		
		return adminExecute(request, response);
	}
	
	// 추상메서드
	protected abstract ActionForward adminExecute(HttpServletRequest request, HttpServletResponse response);

}
