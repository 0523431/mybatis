package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.Member;
import model.MemberDao;

/*
    1. 로그아웃 상태인 경우 => "로그인하세요" 메시지 출력
	   - 다른 사용자의 비밀번호 변경 불가
	   - opener페이지를 loginForm.me페이지로 이동
		
	2. old_pass와 new_pass 파라미터 값 저장 (new_pass와 con_pass와 동일)
	
	3. old_pass 비밀번호가 db에 저장된 비밀번호와 틀리면, 비밀번호 오류 메시지 출력
	   => passwordForm.me 페이지로 이동
	   
	4. old_pass 비밀번호가 db에 저장된 비밀번호와 같으면 비밀번호 수정
	   - opener페이지를 info.me페이지로 이동
	   - 현재 페이지 닫기
*/

public class PwchangeAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String login = (String)request.getSession().getAttribute("login");
				
		String old_pass = request.getParameter("old_pass"); // 입력한 비번
		String new_pass = request.getParameter("new_pass"); // 변경 비번
		
		boolean opener = false;
		boolean closer = false;
		
		String msg = null;
		String url = null;
		
		if(login == null || login.trim().equals("")) { // 로그아웃 상태
			opener = true;
			closer = true;
			
			msg = "로그인하세요";
			url = "loginForm.me";

		} else { // 로그인 상태
			
			if(!login.equals("admin")) {
				// 저장되어있던 db정보 불러오기
				MemberDao dao = new MemberDao();
				Member dbmem = dao.selectOne(login);

				if (!old_pass.equals(dbmem.getPass())) {
					opener = false;
					closer = false;
					msg = "비밀번호가 일치하지 않습니다";
					url = "passwordForm.me?id=" + login;
				} else { // 비밀번호 일치
					int result = dao.updatepass(login, new_pass);
					if (result > 0) {
						opener = true;
						closer = true;
						msg = "비밀번호가 성공적으로 변경되었습니다";
						url = "info.me?id=" + login;
					}
				}
			} else {
				msg = "관리자라도 비밀번호는 바꿀 수 없습니다.";
				url = "list.me";
				opener = true;
				closer = true;
			}
		}
		// 새창을 열기위한 속성정보
		request.setAttribute("opener", opener);
		request.setAttribute("closer", closer);

		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward();
	}
}
