package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CalcAction implements Action {
	
	// 인터페이스 구현했으니까, 추상메서드 역시 구현해줘야함
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		try {
			int num1 = Integer.parseInt(request.getParameter("num1"));
			int num2 = Integer.parseInt(request.getParameter("num2"));
			String op = request.getParameter("op");
			
			if(op.equals("+")) {
				request.setAttribute("result", num1+num2);
			} else if(op.equals("-")) {
				request.setAttribute("result", num1-num2);
			} else if(op.equals("*")) {
				request.setAttribute("result", num1*num2);
			} else if(op.equals("/")) {
				request.setAttribute("result", num1/num2);
			}
		} catch(NumberFormatException e) {
			request.setAttribute("result", 0);
		}
		return new ActionForward(false, "calc.jsp");
	}
	
}
