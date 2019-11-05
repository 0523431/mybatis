package controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.ActionForward;
import action.board.BoardAllAction;

// .do 요청이들어오면 나를 호출해
@WebServlet(urlPatterns= {"*.do"}, initParams= {@WebInitParam(name="properties", value="method.properties")})

public class ControllerMethodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	// Properties : map객체로써, HashMap의 하위 객체
	private Properties pr = new Properties();
	private BoardAllAction action = new BoardAllAction();
	private Class[] paramType = new Class[] {HttpServletRequest.class, HttpServletResponse.class};
	
	// init : 서블릿이 객체화(↑↑↑) 된 이후 바로 호출되는 메서드 (======> static메서드가 아니기때문에 객체화 이후에 호출됨)
	// config 객체 : 파라미터 전달
	//             name="properties", value="method.properties"
	@Override
	public void init(ServletConfig config) throws ServletException {
		
		// props : method.properties의 값을 가지고 있게 됨.
		String props = config.getInitParameter("properties");
		FileInputStream f = null;
		try {
			// f : WEB-INF/method.properties 파일을 읽기 위한 입력 스트림
			f = new FileInputStream(config.getServletContext().getRealPath("/") + "WEB-INF/" + props);
			
			// method.properties 파일에 있는
			// /model2/hello.do=hello
			// 		- Key : /model2/hello.do
			// 		- Value : hello
			pr.load(f);
			f.close();
		} catch(IOException e) {
			e.printStackTrace();
		}
	}
	
    public ControllerMethodServlet() {
        super();
    }
    
    // 클라이언트 GET 방식 요청시 호출되는 메서드
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 한글 호환
		request.setCharacterEncoding("EUC-KR");
		
		Object[] paramObjs = new Object[] {request, response};
		ActionForward forward = null;
		String command = null;
		try {
			System.out.println(request.getRequestURI()); // /jsp_study2/model2/board/writeForm.do
			System.out.println(request.getContextPath()); // 프로젝트 이름
			
			// 어떤 url이 들어왔는지를 확인
			// key값과 같아야함 : /model2/hello.do
			command = request.getRequestURI().substring(request.getContextPath().length());
			// methodName : hello
			// 메서드 이름이 String값, 메서드 이름이 계속 바뀌게 됨
			String methodName = pr.getProperty(command);
			// method 진짜 메서드 객체 생성
			// BoardAllAction.class 클래스에서 
			// 메서드 이름이 methodName이고,
			// 매개변수가 paramType인 메서드를 객체로 리턴 (오버로딩이 되니까, 이름이 같아도 매개변수(인자)가 다르면 다른 메서드가 됨)
			Method method = BoardAllAction.class.getMethod(methodName, paramType);
			// invoke : 메서드 호출 기능
			// hello()메서드에, request, response를 매개변수로한 최종 ====> action.hello(request, response)를 호출
			// =====> action객체가 전달해주는 forward를 전달받음
			forward = (ActionForward)method.invoke(action, paramObjs);
		} catch(NullPointerException e) {
			forward = new ActionForward(); // 예외가 발생하면, 그냥 객체만 전달해줌
			e.printStackTrace();
		} catch(Exception e) {
			throw new ServletException(e);
		}
		
		if(forward !=null) {
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getView()); // 재요청 sendRedirect
			} else {
				if(forward.getView() == null) {
					forward.setView(command.replace(".do", ".jsp"));
				}
				RequestDispatcher disp = request.getRequestDispatcher(forward.getView());
				disp.forward(request, response);
			}
		} else response.sendRedirect("nopage.jsp"); // 404
	}
	
    // 클라이언트 POST 방식 요청시 호출되는 메서드
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
