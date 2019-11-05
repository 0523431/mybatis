package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;

/*
 * doExecute메서드는 UserLoginAction에서 다 검증받은 후에 실행이 됨
 */
public class LogoutAction extends UserLoginAction  {

	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		
		String msg = login + "님이 로그아웃하셨습니다.";
		String url = "loginForm.me";
		
		request.getSession().invalidate();
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}

}
