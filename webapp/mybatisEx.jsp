<%@page import="kr.human.vo.TestDTO"%>
<%@page import="java.util.List"%>
<%@page import="kr.human.vo.TestVO"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="kr.human.mybatis.MybatisApp"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		SqlSessionFactory factory = MybatisApp.getSqlSessionFactory();
		out.println(factory + "<br>");
				
		try (SqlSession sqlSession = factory.openSession()) { //자동 닫기
			String today = sqlSession.selectOne("test.selectToday");
			out.println("DB 날짜: " + today + "<br>");
			
			HashMap<String, Integer> map = new HashMap<>();
			map.put("num1", 12);
			map.put("num2", 33);
			
			int result = sqlSession.selectOne("test.selectCalc", map);
			out.println("12 * 33 = " + result + "<br>");
			
			TestVO testVO = sqlSession.selectOne("test.selectVO", map);
			out.println(testVO + "<br>");
			
			HashMap<String, Object> map2 = sqlSession.selectOne("test.selectMap", map);
			out.println(map2.get("TODAY") + "<br>");
			out.println(map2.get("RESULT") + "<br>");
			
			//맵리스트로 받기
			List<HashMap<String , Object>> mapList = sqlSession.selectList("test.selectList1");
			out.println(mapList.size() + "개<br>");
			for(HashMap<String, Object> m : mapList){
				out.println(m + "<br>");
			}
			out.println("<hr>");
			
			//DTO 리스트로 받기
			List<TestDTO> list = sqlSession.selectList("test.selectList2");
			out.println(mapList.size() + "개<br>");
			for(TestDTO dto : list){
				out.println(dto + "<br>");
			}
			out.println("<hr>");
		}
	%>
</body>
</html>