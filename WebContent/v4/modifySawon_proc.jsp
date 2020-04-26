<%@page import="dbcp.DBConnectionMgr" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
	//1. 전달받은 직원 수정데이터 한글처리 
	request.setCharacterEncoding("UTF-8");	
%>		

<jsp:useBean id="dao" class="mybean.SawonDao"/>

<jsp:useBean id="dto" class="mybean.SawonDto"/>
<jsp:setProperty property="*" name="dto"/>

<%
	dao.modifySawon(dto);
%>


	<script type="text/javascript">
		alert("잘 수정되었습니다.");
		location.href = "index.jsp";
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