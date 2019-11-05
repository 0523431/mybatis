package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;

/*
 * 매번 로그인 여부를 확인하던 절차를
 * UserLoginAction <<<<<<<<<<<<을 상속받음으로써 해결
 * 
 * 이 페이지에는 아무 기능이 없지만,
 * 부모클래스에 있는 기능이 
 */

public class MainAction extends UserLoginAction {
	
	// 로그인이 되어있는 경우에만 doExecute메서드를 실행하지
	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		return new ActionForward();
	}

}
