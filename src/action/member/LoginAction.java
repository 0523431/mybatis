package action.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.ActionForward;
import model.Member;
import model.MemberDao;

/*
 * 1. id, pass �Ķ���� ����
 * 2. id�� �ش��ϴ� ������ db���� ��ȸ
 *    - �����ϸ�, ��й�ȣ Ȯ��
 *    - �������� ������ id ���� �޽����� ����ϰ� loginForm.me�������� �̵�
 * 3. id�� �����ϸ�, ��й�ȣ ����
 *    - ��й�ȣ�� �´� ��� : session �α��� ���� ����
 *                     �α��� ���� �޽����� ��� / main.me �������� �̵�
 *    - ��й�ȣ�� Ʋ�� ��� : �α��� ���� �޽��� ���, loginForm.me �������� �̵�
 * 
 */

public class LoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 1�� ����
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		
		String msg = "�ش� id�� ���������ʽ��ϴ�.";
		String url = "loginForm.me";
		
		Member mem = new MemberDao().selectOne(id);
		
		if(mem !=null) { // db�� ������ ������(id ����)
			
			if(pass.contentEquals(mem.getPass())) {
				
				// session.setAttribute("login", id);
				// session�� jsp�� ���尴ü����, java�� ���尴ü�� �ƴϴϱ� 
				request.getSession().setAttribute("login", id);
				
				msg = mem.getName() + "���� �α����ϼ̽��ϴ�";
				url = "main.me";
			} else { // ��й�ȣ�� �ٸ� ���
				msg = "��й�ȣ�� Ʋ���ϴ�.";
			}
		}
		
		// ��..
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return new ActionForward(false, "../alert.jsp");
	}
}
