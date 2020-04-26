<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%--순서1. addSawon.jsp의 폼태그에서 요청한 추가할 직원정보 받아오기 --%>
<%
//한글처리 
	request.setCharacterEncoding("UTF-8");
//추가 할 직원 정보 중 id,name,pw,age,addr,extension,dept 받아오기
	String s_id = request.getParameter("s_id");
	String s_name = request.getParameter("s_name");
	String s_pw = request.getParameter("s_pw");
	String s_age = request.getParameter("s_age");
	String s_addr = request.getParameter("s_addr");
	String s_extension = request.getParameter("s_extension");
	String s_dept = request.getParameter("s_dept");
	System.out.println(s_addr);
	
//DB에 전달할 sql명령어 준비
//insert
String sql = "insert into tblSawon(id,name,pass,age,addr,extension,dept)" + 
	"values(?,?,?,?,?,?,?)"; 
	
	
	/*DB작업을 위한 java.sql패키지에 있는 삼총사 객체 중 2개 */
	//DB연결을 위한 객체
	Connection con = null;
	//DB연결 후 DB에 sql쿼리 전달 및 sql쿼리를 실행하고 그결과값까지 가져오는 객체
	PreparedStatement stmt = null;
	
	//연결할 DB주소, DB접속 id,DB접속 pw
	String url = "jdbc:mysql://localhost:3307/jspbeginner?serverTimezone=Asia/Seoul";
	String id ="jspid", pw = "jsppass";
	
	try{
		//1단계 (JDBC 드라이버 로딩)
		//MYSQL회사에서 제공해주는 DB연결 드라이버를 -> [JDBC프로그램]에 로딩시킨다.
		Class.forName("com.mysql.jdbc.Driver");
		
		//2단계 DB연결 시도(DB접속)
		con = DriverManager.getConnection(url,id,pw);
		
		//3단계 DB에 sql쿼리 전달 및 sql쿼리를 실행 Statement객체 반환
		stmt = con.prepareStatement(sql);
		
		
		stmt.setString(1,s_id);
		stmt.setString(2,s_name);
		stmt.setString(3,s_pw);
		stmt.setInt(4,Integer.parseInt(s_age));
		stmt.setString(5,s_addr);
		stmt.setString(6,s_extension);
		stmt.setString(7,s_dept);
		
		//4단계 DB에 insert쿼리 실행하고 끝낸다.
		stmt.executeUpdate();
%>
		<h2>직원 정보가 잘 추가되었습니다.</h2>
		<a href="addSawon.jsp">입력 화면으로</a><br/>
		<a href="index.jsp">메인 화면으로</a>		
<% 	
	}
	catch(Exception err){
		System.out.println("addSawon_proc.jsp에서 오류 : " + err);
	}
	finally{
		if(stmt != null)
			stmt.close();
		if(con != null)
			con.close();
	}
%>
</body>
</html>