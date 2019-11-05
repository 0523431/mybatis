package action.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import model.Member;
import model.MemberDao;

public class ListAction extends AdminLoginAction {
	
	// 상속받으면, 부모클래스의 추상메서드를 강제로 오버라이딩해야함
	@Override
	protected ActionForward adminExecute(HttpServletRequest request, HttpServletResponse response) {
		
		// MemberDao()의 list()메서드를 통해서 가져와
		List<Member> list = new MemberDao().list();
		request.setAttribute("list", list);
		return new ActionForward();
	}
}

/*
 * MemberDao dao = new Member();
 * request.setAttribute("list", dao.list());
 */
