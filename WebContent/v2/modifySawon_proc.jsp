<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
	//1. 전달받은 직원 수정데이터 한글처리 
	request.setCharacterEncoding("UTF-8");	
	//2. 수정할 직원정보 전달받아 저장
	String no = request.getParameter("no");
	String s_id = request.getParameter("s_id");
	String s_name = request.getParameter("s_name");
	String s_pw = request.getParameter("s_pw");
	String s_age = request.getParameter("s_age");
	String s_addr = request.getParameter("s_addr");
	String s_extension = request.getParameter("s_extension");
	String s_dept = request.getParameter("s_dept");
	
	//3. hidden으로 넘겨받은 직원번호에 해당하는 직원 정보 업데이트 쿼리 
	String sql = "update tblSawon set id=?, name=?, pass=?, age=?, addr=?, extension=?, dept=? where no=?";

	//4. DB작업을 위한 java.sql패키지에 있는 삼총사 객체를 담을 준비
	Connection con = null;
	PreparedStatement stmt = null;
	
	//5.연결할 DB주소, DB접속id, DB접속 pw
	String url = "jdbc:mysql://localhost:3307/jspbeginner?serverTimezone=Asia/Seoul";
	String id = "jspid", pw = "jsppass";
	
	//6
	try{
		//1단계 (JDBC 드라이버 로딩)
		//MYSQL회사에서 제공해주는 DB연결 드라이버를 ->[JDBC프로그램]에 로딩시킨다.
		Class.forName("com.mysql.jdbc.Driver");
		
		//2단계 DB연결 시도 (DB접속)
		con = DriverManager.getConnection(url, id, pw);
		
		//3단계 DB에 update쿼리 전달 및 update쿼리를 실행 Statement객체 반환
		stmt = con.prepareStatement(sql);
		
		stmt.setString(1,s_id);
		stmt.setString(2,s_name);
		stmt.setString(3, s_pw);
		stmt.setInt(4, Integer.parseInt(s_age));
		stmt.setString(5,s_addr);
		stmt.setString(6,s_extension);
		stmt.setString(7,s_dept);
		stmt.setInt(8,Integer.parseInt(no));
		
		//4단계 DB에 update쿼리 실행하고 끝낸다.
		stmt.executeUpdate();
%>		
	<script type="text/javascript">
		alert("잘 수정되었습니다.");
		location.href = "index.jsp";
	</script>		
		
<% 
	}
	catch(Exception err){
		System.out.println("modifySawon_proc.jsp에서 오류 : " + err);
	}finally{
		if(stmt != null)
			stmt.close();
		if(con != null)
			con.close();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>