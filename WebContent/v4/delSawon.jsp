<%@page import="dbcp.DBConnectionMgr" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<jsp:useBean id="dao" class="mybean.SawonDao"/>
<%
	request.setCharacterEncoding("UTF-8");
	//index.jsp에서 삭제할 직원 번호 받아오기
	int no = Integer.parseInt(request.getParameter("no"));
	//DB삭제 작업
	dao.delSawon(no);		
%>
		<script type="text/javascript">
		alert("잘 삭제되었습니다.");
		location.href="index.jsp";
		</script>
		
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>