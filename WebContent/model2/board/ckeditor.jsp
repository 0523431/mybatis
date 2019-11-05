<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%-- 업로드된 위치를 ck editor에게 알려주는 기능을 하는 jsp

	(??? , 경로, alert창)
--%>
<script type="text/javascript">
	window.parent.CKEDITOR.tools.callFunction(${param.CKEditorFuncNum}, 'imgfile/${fileName}','이미지 업로드 완료')
</script>;
