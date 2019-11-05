package action.member;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import action.Action;
import action.ActionForward;
/*
1. 파일업로드			: java 영역 =========================> 이 기능만 여기서 하는거야
2. opener 화면에 결과	: javaScript 영역
3. 현재화면 close()		: javaScript 영역
*/

public class PictureAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// application ===> request.getServletContext()
		String path = request.getServletContext().getRealPath("") + "model2/member/picture";
		String fname = null;

		try {
			File f = new File(path);
			
			if (!f.exists()) { // 해당 위치가 없으면
				f.mkdirs(); // 폴더를 만들어
			}
			
			int size = 10 * 1024 * 1024; // 10M 설정

			MultipartRequest multi = new MultipartRequest(request, path, size, "euc-kr");
			fname = multi.getFilesystemName("picture");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("fname", fname); // 이 속성값이 picture.jsp와 연계
		return new ActionForward();
	}
}
