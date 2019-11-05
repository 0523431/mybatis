package controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;

// 확장자가 .me가 되면, 지금 만든 이 survlet이 적용됨
@WebServlet(urlPatterns= {"*.me"}, initParams = {@WebInitParam(name="properties", value="action.properties")})
public class ControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private Map<String,Action> commandMap = new HashMap<String,Action>();
	
    public ControllerServlet() {
        super();
    }
    
    // 내가 필요한 
    @Override
    public void init(ServletConfig config) throws ServletException {
    	String props = config.getInitParameter("properties");
    	Properties pr = new Properties(); // Properties의 상위 클래스 : Hashtable < Map을 구현
    	FileInputStream f = null;
    	try {
    		f = new FileInputStream(config.getServletContext().getRealPath("/")+"WEB-INF/"+props);
    		pr.load(f); // action.properties파일을 읽어서 properties객체로 만들어줌
    	} catch(IOException e) {
    		throw new ServletException(e);
    	} finally {
    		try {
    			if(f !=null) {
    				f.close();
    			}
    		} catch(IOException e) { }
    	}
    	for(Object k : pr.keySet()) {
    		String command = (String)k;
    		String className = pr.getProperty(command);
    		
    		try {
    			// 여기가 연계된게 action.properties
    			Class commandClass = Class.forName(className.trim()); // 공백이 들어가도 에러가 나지 않음
    			Object commandObj = commandClass.newInstance(); // class의 객체화(해당 클래스로부터 직접만들어줌 === 원래 이렇게 만들면 안되는거라서 줄이 그어짐)
    			commandMap.put(command, (Action)commandObj); // commandMap객체에 값을 넣어줌
    		} catch(Exception e) {
    			throw new ServletException(e);
    		}
    	}
    }
    
    // commandMap
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("euc-kr"); // 한글 파라미터를 읽기 위해서
		
		Action action = null;
		ActionForward forward = null;
		String command = null;
		try {
			// command : /model2/hello.me값을 읽어오게 되고 이 값이 key값이 됨
			command = request.getRequestURI().substring(request.getContextPath().length());
			// action : Action인터페이스를 구현한 구현 객체
			//          action.HelloAction 값이 들어가 있음
			action = commandMap.get(command);
			forward = action.execute(request, response);
		} catch(NullPointerException e) {
			e.printStackTrace();
			forward = new ActionForward(false, null);
			// forward = new ActionForward(); ()값이 없어도 무방
		} catch(Exception e) {
			throw new ServletException(e);
		}
		
		if(forward !=null) {
			if(forward.isRedirect()) { // isRedirect()이건 boolean자료형 : true or false
				response.sendRedirect(forward.getView());
			} else {
				
				// forward.getView() : action()클래스에서 전달 view 이름
				//                     addForm.jsp
				// 
				if(forward.getView() == null) {
					forward.setView(command.replace(".me",".jsp"));
				}
				RequestDispatcher disp = request.getRequestDispatcher(forward.getView());
				disp.forward(request, response);
			}
		} else response.sendRedirect("nopage.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
