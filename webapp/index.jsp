<%@page import="kr.human.service.MemoService"%>
<%@page import="kr.human.vo.MemoVO"%>
<%@page import="kr.human.vo.PagingVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
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

	// DB에서 글 목록을 읽어온다.
	PagingVO<MemoVO> pagingVO = MemoService.getInstance().selectList(currentPage, pageSize, blockSize);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1줄 메모장</title>
<link href="${pageContext.request.servletContext.contextPath }/webjars/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.servletContext.contextPath }/webjars/jquery/3.6.0/jquery.min.js" ></script>
<script type="text/javascript" src="${pageContext.request.servletContext.contextPath }/webjars/bootstrap/5.1.3/js/bootstrap.min.js" ></script>
<script type="text/javascript">
	$(function(){
		$("#cancelBtn").css('display','none');
	});
	
	function updateComment(idx, name, content){ // 수정하기 누르면 작동
		$("#cancelBtn").css('display','inline'); // 취소버튼 보이고
		// alert(idx + "\n" + name + "\n" + content);
		$("#idx").val(idx); // 글번호 넣고
		$("#name").val(name); // 이름넣고
		$("#content").val(content); // 내용넣고
		$("#submitBtn").val("수정"); // 버튼이름을 수정으로 변경
		$("#mode").val("update"); // 모드를 update로 변경
		$("#password").focus(); // 비번입력자리에 커서 보내기
	}
	function deleteComment(idx, name, content){ // 삭제하기 누르면 작동
		$("#cancelBtn").css('display','inline');
		// alert(idx + "\n" + name + "\n" + content);
		$("#idx").val(idx); // 글번호 넣고
		$("#name").val(name); // 이름넣고
		$("#content").val(content); // 내용넣고
		$("#submitBtn").val("삭제"); // 버튼이름을 삭제으로 변경
		$("#mode").val("delete"); // 모드를 delete로 변경
		$("#password").focus(); // 비번입력자리에 커서 보내기
	}
	function resetComment(){ // 취소하기 누르면 작동
		$("#cancelBtn").css('display','none');
		$("#idx").val("0"); // 글번호 넣고
		$("#name").val(""); // 이름넣고
		$("#content").val(""); // 내용넣고
		$("#submitBtn").val("저장"); // 버튼이름을 저장으로 변경
		$("#mode").val("insert"); // 모드를 delete로 변경
		$("#name").focus(); // 이름입력자리에 커서 보내기
	}
	
</script>
<style type="text/css">
	table{ width: 900px; margin: auto; border: none; padding: 5px;}
	td {padding: 5px; border: 1px solid gray;}
	th {padding: 5px; border: 1px solid gray; background-color: silver; text-align: center;}
	.title {font-size: 18pt; border: none; text-align: center;}
</style>
</head>
<body>
	<table>
		<tr>
			<td colspan="5" class="title">1줄 메모장</td>
		</tr>
		<tr>
			<td colspan="5" align="right" style="border: none;"><%=pagingVO.getPageInfo() %></td>
		</tr>
		<tr>
			<th width="5%">No</th>
			<th>작성자</th>
			<th width="60%">내용</th>
			<th>작성일</th>
			<th>IP</th>
		</tr>
		<%
			if(pagingVO.getTotalCount()==0){
		%>
		<tr>
			<td colspan="5" align="center">등록된 글이 없습니다.</td>
		</tr>		
		<% 
			}else{ 
				for(MemoVO vo : pagingVO.getList()){
		%>
		<tr align="center">
			<td><%=vo.getIdx() %></td>		
			<td><%=vo.getName() %></td>		
			<td title="<%=vo.getContent() %>" align="left">
			<%
			String content = vo.getContent();
			if(content.length()>30){
				content = content.substring(0,30) + "....";
			}
			content = content.replaceAll("<", "&lt;"); // < 를 특수문자로 만든다. 
			out.println(content);
			%>
			<input type="button" onclick="updateComment(<%=vo.getIdx() %>,'<%=vo.getName() %>','<%=vo.getContent() %>')" value="수정" class="btn btn-outline-success btn-sm" />
			<input type="button" onclick="deleteComment(<%=vo.getIdx() %>,'<%=vo.getName() %>','<%=vo.getContent() %>')"  value="삭제" class="btn btn-outline-success btn-sm" />
			</td>		
			<td>
			<%
			Date date = vo.getRegDate();
			SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd hh:mm");
			out.println(sdf.format(date));
			%>
			</td>		
			<td><%=vo.getIp() %></td>		
		</tr>
		<% 		
				}
			}
		%>	
		<tr>
			<td colspan="5" style="border: none;" align="center">
				<%-- 페이지 리스트를 찍자 --%>
				<%=pagingVO.getPageList() %>
			</td>
		</tr>
		<tr>
		
			<td colspan="5" style="border: none;" align="center">
				<%-- 여기에 폼을 달자!!!! --%>
				<form action="updateOk.jsp" method="post">
					<input type="hidden" name="idx" id="idx" value="0">
					<input type="hidden" name="p" id="p" value="<%=pagingVO.getCurrentPage()%>">
					<input type="hidden" name="s" id="s" value="<%=pagingVO.getPageSize()%>">
					<input type="hidden" name="b" id="b" value="<%=pagingVO.getBlockSize()%>">
					<input type="hidden" name="mode" id="mode" value="insert"> <%-- 저장/수정/삭제 표시 --%>
					<input type="text" name="name" id="name" required="required" size="5"/>
					<input type="password" name="password" id="password" required="required" size="5"/>
					<input type="text" name="content" id="content" required="required" size="75"/>
					<input type="submit" id="submitBtn" value="저장" class="btn btn-outline-success btn-sm" />
					<input type="button" id="cancelBtn" value="취소" class="btn btn-outline-success btn-sm" onclick="resetComment()" />
				</form>
			</td>
		</tr>
	</table>
	
</body>
</html>