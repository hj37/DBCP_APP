<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	//1. index.jsp에서 받아온 삭제할 직원 번호 받아오기 
	String no = request.getParameter("no");
	
	//2. 받아온 삭제할 직원번호에 해당하는 직원레코드 삭제 쿼리 
	String sql = "delete from tblSawon where no=?";
	
	//3. 직원레코드 삭제 DB작업을 위한 java.sql패키지에 있는 객체를 담을 준비
	Connection con = null;
	PreparedStatement stmt = null;
	
	//4. 연결할 DB주소,DB접속 id, DB접속pw
	String url = "jdbc:mysql://localhost:3307/jspbeginner?serverTimezone=Asia/Seoul";
	String id = "jspid", pw = "jsppass";
	
	//5.
	try{
		//1단계 (JDBC드라이버 로딩)
		//MYSQL회사에서 제공해주는 DB연결 드라이버를 ->[JDBC프로그램]에 로딩시킨다.
		Class.forName("com.mysql.jdbc.Driver");
		
		
		//2단계 DB연결 시도(DB접속)
		con = DriverManager.getConnection(url, id, pw);
		
		//3단계 DB에 delete쿼리 전달 및 delete쿼리를 실행 Statement객체 반환
		stmt = con.prepareStatement(sql);
		
		stmt.setInt(1,Integer.parseInt(no));
		//4단계 DB에 delete쿼리 실행하고 끝낸다.
		stmt.executeUpdate();	
		
%>
		<script type="text/javascript">
		alert("잘 삭제되었습니다.");
		location.href="index.jsp";
		</script>
<% 
	}
	catch(Exception err){
		System.out.println("delSawon_proc.jsp에서 오류 : " + err);
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