package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;

/* <추상클래스>
 * 	==> 로그인여부를 확인해주는 클래스
 * 		매번 로그인 여부를 확인하지않고 한번에 처리할 수 있는 페이지
 * 
 * 		무조건 로그인이 필요한 기능들은 이 클래스를 상속받으면 됨
 *  ==> 부모가 Action클래스를 구현했기때문에, 자식은 별도로 구현할 필요가 없음
 */
public abstract class UserLoginAction implements Action {
	
	// 상속관계에서는 접근이 가능한 접근 제어자
	protected String login;	// 로그인 정보
	protected String id;	// 파라미터 정보
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		login = (String)request.getSession().getAttribute("login");
		id = request.getParameter("id");
		
		if(login ==null || login.trim().equals("")) {
			request.setAttribute("msg", "로그인 후 거래하세요");
			request.setAttribute("url", "loginForm.me");
			return new ActionForward(false, "../alert.jsp");
		} else {
			// (info, update에서 필요한 조건 id !=null)
			if(!login.equals("admin") && id !=null && !login.equals(id)) {
				request.setAttribute("msg", "본인만 가능합니다");
				request.setAttribute("url", "main.me");
				return new ActionForward(false, "../alert.jsp");
			}
		}
		return doExecute(request, response);
	}

	// 추상메서드
	protected abstract ActionForward doExecute(HttpServletRequest request, HttpServletResponse response);

}
