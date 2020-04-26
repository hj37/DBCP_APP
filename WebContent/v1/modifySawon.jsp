<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table{border-style:solid; border-width:2px; border-color:#0000ff; width:300px}
	th{background-color:#ff6600}
	th,td{border-bottom-width:1px; border-bottom-color:#ff6600; border-bottom-style:dotted;}
</style>
</head>
<body>
<%
	//1. index.jsp에서 받아온 수정할 직원 번호 받아오기
	String no = request.getParameter("no");
	//2. 받아온 수정할 직원버호에 해당하는 직원레코드 검색 
	String sql = "select * from tblSawon where no=" + no;
	
	//3.DB작업을 위한 java.sql패키지에 있는 삼총사 객체를 담을 준비 
	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	//4.연결할 DB주소, DB접속id,DB접속 pw
	String url = "jdbc:mysql://localhost:3307/jspbeginner?serverTimezone=Asia/Seoul";
	String id ="jspid", pw="jsppass";
	
	//5.select후 수정할 직원 정보를 담을 변수들
	String s_id = null, s_name=null, s_pw = null, s_age = null,
	s_addr = null, s_extension = null, s_dept = null;
	
	//6
	try{
		//1단계 (JDBC드라이버 로딩)
		//MYSQL회사에서 제공해주는 DB연결 드라이버들 -> [JDBC프로그램]에 로딩시킨다.
		Class.forName("com.mysql.jdbc.Driver");
		
		//2단계 DB연결 시도 (DB접속)
		con = DriverManager.getConnection(url, id, pw);
		
		//3단계 DB에 SQL쿼리 전달 및 SQL쿼리를 실행하고 그 결과값까지 가져오는 Statement객체 반환
		stmt = con.createStatement();
		//DB에 sql쿼리 전달 및 sql쿼리를 실행하고 그 결과값을 ResultSet객체에 담아 리턴함
		rs = stmt.executeQuery(sql);
		
		//DB로부터 수정할 직원 한 명! 레코드 정보 가져와서 저장
		if(rs.next())
		{
			s_id = rs.getString("id");
			s_name = rs.getString("name");
			s_pw = rs.getString("pass");
			s_age = String.valueOf(rs.getInt("age"));
			s_addr = rs.getString("addr");
			s_extension = rs.getString("extension");
			s_dept = rs.getString("dept");
		}
	}catch(Exception err){
		System.out.println("modifySawon.jsp에서 오류 : " +err);	
	}finally{
		if(rs != null)rs.close();
		if(stmt != null)stmt.close();
		if(con != null) con.close();
	}
%>

<%--7.
수정할 직원정보 뿌려 주면서...
수정할 정보가 있으면 입력 후 실제 직원정보 수정을 위한 DB작업을 할 ? modifySawon_proc.jsp페이지에 요청 --%>
<form method = "post" action ="modifySawon_proc.jsp">

<%--직원번호는 hidden으로 보이지 않게 감춰서 전달 --%>
<input type="hidden" name = "no" value="<%=no%>"/>

	<div align="center">
	<h1>직원 수정</h1>
	<table>
		<tr> 
			<th>아이디</th>
			<td><input type="text" name="s_id" value="<%=s_id %>"/><td>
		</tr>
		<tr>
			<th>이름</th>
			<td><input type="text" name="s_name" value="<%=s_name%>"/></td>
		</tr>
		<tr>
			<th>패스워드</th>
			<td><input type="text" name="s_pw" value="<%=s_pw%>"/></td>
		</tr>
		<tr>
			<th>나이</th>
			<td><input type="text" name="s_age" value="<%=s_age%>"/></td>
		</tr>
		<tr>
			<th>근무지</th>
			<td>
				<select name="s_addr">
					<option value="서울" <%if(s_addr.equals("서울")){%> selected <%}%>>서울</option>
					<option value="경기" <%if(s_addr.equals("경기")){%> selected <%}%>>경기</option>
					<option value="인천" <%if(s_addr.equals("인천")){%> selected <%}%>>인천</option>
					<option value="수원" <%if(s_addr.equals("수원")){%> selected <%}%>>수원</option>				
				</select>
			</td>
		</tr>
		<tr>
			<th>내선번호</th>
			<td><input type="text" name="s_extension" value="<%=s_extension %>"/></td>
		</tr>	
		<tr>
			<th>부서명</th>
			<td>
				<select name="s_dept">
					<option value="영업" <%if(s_dept.equals("영업")) {%> selected <%}%>>영업 </option>
					<option value="기술" <%if(s_dept.equals("기술")) {%> selected <%}%>>기술</option>
					<option value="기획" <%if(s_dept.equals("기획")) {%> selected <%}%>>기획 </option>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="수정"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="취소"/>
			</td>
		</tr>			
	</table>
	</div>
</form>
</body>
</html>