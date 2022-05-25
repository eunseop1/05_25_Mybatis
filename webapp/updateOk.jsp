<%@page import="kr.human.service.MemoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
// 한글 깨짐 방지
request.setCharacterEncoding("UTF-8");
// GET방식 막기
if(!request.getMethod().equals("POST")){
	response.sendRedirect("index.jsp");
	return;
}

//여기서 현재페이지 번호/페이지당 글수/페이지리스트 개수를 받아야 한다.
int currentPage = 1;
try{
	currentPage = Integer.parseInt(request.getParameter("p"));
}catch(Exception e){
	;
}
int pageSize = 10;
try{
	pageSize = Integer.parseInt(request.getParameter("s"));
}catch(Exception e){
	;
}
int blockSize = 10;
try{
	blockSize = Integer.parseInt(request.getParameter("b"));
}catch(Exception e){
	;
}	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%-- VO로 받자 --%>
	<jsp:useBean id="vo" class="kr.human.vo.MemoVO" />
	<jsp:setProperty property="*" name="vo"/>
	<%-- IP는 자동으로  넣어주자 --%>
	<jsp:setProperty property="ip" name="vo" value="<%=request.getRemoteAddr() %>"/>
	
	<%
		// 이제 서비스클래스를 호출하여 처리를 한다.
		if(vo!=null){
			switch(vo.getMode() ){
			case "insert":
				MemoService.getInstance().insert(vo);
				response.sendRedirect("index.jsp?p=1&s=" + pageSize + "&b=" + blockSize);
				break;
			case "update":
				MemoService.getInstance().update(vo);
				response.sendRedirect("index.jsp?p=" + currentPage + "&s=" + pageSize + "&b=" + blockSize);
				break;
			case "delete":
				MemoService.getInstance().delete(vo);
				response.sendRedirect("index.jsp?p=" + currentPage + "&s=" + pageSize + "&b=" + blockSize);
				break;
			}
		}
		// 리스트로 간다.
	%>
</body>
</html>