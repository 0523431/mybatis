package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Controller에서 Action타입이니까 해줘야하는 약속
public class AddAction implements Action {

	// Action의 추상메서드 강제 구현
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		try {
			int num1 = Integer.parseInt(request.getParameter("num1"));
			int num2 = Integer.parseInt(request.getParameter("num2"));
			
			// 속성이름 result에 num1+num2를 넣어줌
			request.setAttribute("result", num1+num2);
		} catch(NumberFormatException e) {
			request.setAttribute("result", 0);
		}
		return new ActionForward(false, "addForm.jsp");
		/*
		 * ActionForwrd객체를 만들어줌
		 * 
		 * 	- false => redirect? forward?
		 * 	- 출력하는 장소 => addForm.jsp에서
		 */
	}
	
}
