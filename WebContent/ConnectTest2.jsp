<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
1.JDBC라이브러리의 역할 (통역자의 역할) 
- JSP웹페이지와 DBMS간의 통신을 중간에서 번역 해주는 역할을 한다.

2. JDBC라이브러리 관련 중요 인터페이스들 
- java.sql패키지의 Driver인터페이스
	-> 모든 DBMS를 만드는 회사측에서 DB와 연결하는 Driver class를 만들때..
	   반드시 implements 해야 하는 인터페이스로 JDBC드라이버의 중심이 되는 인터페이스.
	   - java.sql패키지의 Connection인터페이스
	   -> 특정 데이터베이스와의 연결정보를 가지는 인터페이스
	   	DriverManager클래스로부터 Connection객체(특정 데이터베이스와의 연결정보를 가지고 있는 객체)를
	   	얻어와서 저장할 인터페이스
	 -java.sql패키지의 Statement 인터페이스
	  -> SQL쿼리문을 DB에 전송하는 방법을 정의한 인터페이스
 --%>    
    
<%--JSP페이지에서 JDBC라이브러리 사용을 위한 선언  --%>  
<%@ page import="java.sql.Driver" %>
  
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>DB 연결 테스트</h1>
<%

	Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/jspbeginner?serverTimezone=Asia/Seoul","root","1234");


if(con != null){
	out.println("연결 성공");
}else{
	out.println("연결 실패");
}

%>

</body>
</html>