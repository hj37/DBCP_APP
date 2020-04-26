<%@page import="dbcp.DBConnectionMgr" %>
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
	DBConnectionMgr pool = null;
	//5.연결할 DB주소, DB접속id, DB접속 pw

	
	//6
	try{
		pool = DBConnectionMgr.getInstance();
		con = pool.getConnection();
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
		pool.freeConnection(con,stmt);
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