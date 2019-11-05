package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import model.Member;
import model.MemberDao;
/*
 *  들어오는 경로에 따라 파라미터가 2개가 됨
	
	1. 로그아웃 상태 : "로그인하세요" 메시치 출력 => login.jsp 페이지 이동

	2. 로그인 상태
	   - 관리자가 아니고, id와 login이 다른 경우
	     "본인만 탈퇴가 가능합니다" 메세지 출력 => main.jsp 페이지로 이동
	------------------------------------------------------------ UserLoginAction에서 
	   <id가 관리자인 경우>
	     "관리자는 탈퇴가 불가능합니다" 메세지 출력 => list.me 페이지 이동
	   --------------------------------------------------------- 유효성 검증
	   <탈퇴 조건>
	   - 입력된 비밀번호와 db의 비밀번호를 검증
	     => 관리자가 아니면서 비밀번호 불일치
	   - 일반 사용자  :(1) 아이디, 비밀번호 정보를 파라미터로 전송
	   			  (2) 비밀번호 불일치, 입력된 비밀번호와 db의 비밀번호를 검증
	   			      "비밀번호가 틀립니다.=>메시지 출력 deleteForm 페이지 이동
	   - 관리자 : (1) id 정보를 파라미터로 전송

	   <관리자 로그인, 또는 비밀번호가 일치하는 경우 db에서 회원정보 삭제하기>
	   - 삭제 성공 : 일반사용자 : 로그아웃 후, "탈퇴" 메세지출력 => loginForm.jsp로 페이지 이동
	   		            관리자 : "탈퇴" 메세지출력 => list.jsp로 페이지 이동
	   - 삭제 실패 : 일반사용자, "삭제실패" 메시지 출력 => info.me 페이지 이동
	     		   관리자 : "삭제실패 " 메시지 출력 => list.me 페이지 이동

 */
public class DeleteAction extends UserLoginAction { // 로그인여부, admin로그인 여부 미리 확인해줌

	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		
		String pass = request.getParameter("pass");
		
		String msg = null;
		String url = null;
		
		// 관리자인 경우
		if(id.equals("admin")) {
			msg = "관리자는 탈퇴가 불가능합니다";
			url = "list.me";
		} else { // 관리자가 아닌경우
			Member dbmem = new MemberDao().selectOne(id);
			System.out.println(dbmem);
			
			// 관리자이거나 비밀번호가 맞거나
			if(login.equals("admin") || pass.equals(dbmem.getPass())) {
				int result = new MemberDao().delete(id);
				if (result > 0) { // 삭제 성공
					if (login.equals("admin")) {
						msg = id + "강제탈퇴 성공 시킴";
						url = "list.me";
					} else {
						msg = id + "님이 스스로 탈퇴에 성공하였습니다";
						url = "loginForm.me";
						request.getSession().invalidate(); // 로그인 정보 삭제
					}
				} else {
					msg = id + "님의 탈퇴 과정에서 오류가 발생했습니다";
					if (login.equals("admin")) {
						url = "list.me";
					} else
						url = "info.jsp?id=" + id;
				}
								
			} else {
				msg = "비밀번호가 틀립니다";
				url = "deleteForm.jsp?id="+id;
			}
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url",url);
		return new ActionForward(false, "../alert.jsp");
	}

}
