package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import model.Member;
import model.MemberDao;

/* < 이 페이지의 기능 >
 * 
 * 1. 모든 파라미터 Member 객체에 저장
 * 2. 입력된 비밀번호와 db에 저장된 비밀번호가 같지않으면, "비밀번호가 틀렸습니다" => udateForm.me페이지 이동
 * 3. 1번의 내용 db에 수정하기 => int MemberDao.update(Member)
 *    결과가 0보다 크면 수정성공 메시지 출력 => info.me 이동
 *    결과가 0이하이면  수정실패 메시지 출력 => main.me 이동
 */

public class UpdateAction extends UserLoginAction { // 상속받음 ==> 반드시 로그인이 되야하는 페이지
	
	@Override
	protected ActionForward doExecute(HttpServletRequest request, HttpServletResponse response) {
		
		// 1번
		Member upmem = new Member();
		upmem.setId(request.getParameter("id"));
		upmem.setPass(request.getParameter("pass"));
		upmem.setName(request.getParameter("name"));
		upmem.setGender(Integer.parseInt(request.getParameter("gender")));
		upmem.setTel(request.getParameter("tel"));
		upmem.setEmail(request.getParameter("email"));
		upmem.setPicture(request.getParameter("picture"));
		
		Member dbmem = new MemberDao().selectOne(upmem.getId()); // id를 넣어도 됨
		// String login = (String)request.getSession().getAttribute("login"); 상속받은 존재
		
		String msg = null;
	    String url = null;
		System.out.println(dbmem);
		
		if(!login.equals("admin") && !upmem.getPass().equals(dbmem.getPass())) {
			msg = "비밀번호가 틀렸습니다";
			url = "updateForm.me?id="+upmem.getId();

		} else { // 비밀번호가 맞을때
			int result = new MemberDao().update(upmem);
			if(result >0) {
				msg = "수정완료";
				url = "info.me?id="+upmem.getId();
				
			} else {
				msg = "수정실패";
				url = "main.me";
				
			}
		}
		request.setAttribute("msg",msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");

	}
}
