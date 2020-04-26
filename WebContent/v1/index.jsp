<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
<%--직원데이터 삭제 한 번 더 물어보는 함수 --%>
	function fnDel(no){
		//메시지 박스에 "예","아니오" 중에서 선택했을때  true 또는 false반환
		var result = confirm("데이터를 정말로 삭제하시겠습니까?");
		
		//"예"이란? dalSawon.jsp삭제 페이지로 이동! 이동시 삭제할 직원 버호 넘겨줌 
		if(result == true){
			location.href = "delSawon.jsp?no=" + no;
		}
	}
</script>




</head>
<body>


<%
request.setCharacterEncoding("UTF-8");
String search = request.getParameter("search");
String searchText = request.getParameter("searchText");
%>

<%--순서1. --%>
<h2>직원 정보 리스트</h2>

<%--직원 추가(회원가입) 페이지로 이동하는 링크 만들기 --%>
<a href="addSawon.jsp">직원추가(회원가입)</a>

<%--검색 기능 : 검색기준 값 + 검색어  --%>
<form action="index.jsp" method="post">
	<select name= "search">
		<option value="id">id</option>
		<option value="addr">근무지</option>
		<option value="dept">부서명</option>	
	</select>
	<input type="text" name="searchText"/>
	<input type="submit" name="검색"/>
</form>

<%--직원 정보 리스트 --%>
<table border="1">
	<tr>
		<th>ID</th>
		<th>이름</th>
		<th>나이</th>
		<th>근무지</th>
		<th>부서명</th>
		<th>내선번호</th>
		<th>수정</th>
		<th>삭제</th>	
	</tr>
<%--순서2. --%>
	<%
	/*DB작업을 위한 java.sql패키지에 있는 삼총사 객체*/
		//DB연결 객체를 저장할 변수 선언
		Connection con = null;
		//DB연결후 DB에 SQL쿼리 전달 및 sql쿼리를 실행하고 그 결과값까지 가져오는 객체를 저장할 변수 선언
		Statement stmt = null;
		//ResultSet객체
		//-DB로부터 실행될 결과값을 임시로 저장하는 객체
		//-단 !! 하나의 테이블을 저장할 수 있는 구조
		//-연결 지향성
		//-반드시 처음에는 데이터를 가리키는 포인터를 한칸 이동시켜야함.
		ResultSet rs = null;

/* 연결할 DB주소, DB접속 id, DB접속pw*/
	String url ="jdbc:mysql://localhost:3307/jspbeginner?serverTimezone=Asia/Seoul";
	String id ="jspid", pw="jsppass";
	
	//실행할 SQL문을 저장할 변수 선언
	String sql="";
%>
<%--순서3. 하기전에.. 맨윗부분에 searchText변수 선언하기 --%>
	<%
	/*select SQL문 준비, 검색어가 입력되었는지? 입력되지 않았는지 파악 */
	try{
		//검색어가 입력되어 있지 않다면?
		if(searchText.isEmpty()){
			//직원정보를 모두검색하는 Select문 만들기 
			sql ="select * from tblSawon";
		//검색어가 입력 되어 있다면?
		}else{
			//기준기준값에 해당하는 검색어인 직원정보를 모두 검색하는 Select문 만들기 
			sql ="select * from tblSawon where " + search + " like '%" + searchText + "%'";
		}//처음에 검색어가 입력되지 않았을때 모든 직원정보 리스트 뿌려주기 예외처리
	}catch(NullPointerException err){
		sql = "select * from tblSawon";
	}
	
	/*순서4. DB연결 부분 */
	
	try{
		//1단계(JDBC 드라이버 로딩)
		//Mysql측 회사에서 제공해주는 DB연결 드라이버를 JDBC프로그램에 로딩 시킨다.
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		//2단계 DB연결 시도 (DB접속)
		con = DriverManager.getConnection(url,id,pw);
		//3단계 DB에 sql쿼리 전달 및 sql쿼리를 실행할 Statement객체 반환
		stmt = con.prepareStatement(sql);
		//Statement객체를 이용하여 DB에 sql쿼리 전달 및 sql쿼리를 실행하고 그결과값을 ResultSet객체에 담아 리턴함
		rs = stmt.executeQuery(sql);
		
		//4단계 
		//쿼리 실행 후 테이블 형식으로 감싼 레코드들이 ResultSet객체에 존재하는 동안 반복해서..
		//하나의 레코드씩 정보를 꺼내온다.
		while(rs.next()){//참고 : 맨 처음에는 테이블의 필드명을 포인터로 가리키므로 반드시 한 번은 next()해줘야함.
		/*하나의 직원정보 꺼내오기*/
		//DB로부터 select한 결과 값 중...
		//ResultSet객체에 저장된 하나의 DB레코드 정보중 no값 꺼내와서 저장
		String s_no = String.valueOf(rs.getInt("no"));
		//ResultSet객체에 저장된 하나의 DB레코드 정보 중 id값 꺼내와서 저장
		String s_id = rs.getString(2); //필드명 대신 인덱스 2를 써줘도 된다.
		//ResultSet객체에 저장된 하나의 DB레코드 정보중 name값 꺼내와서 저장
		String s_name = rs.getString("name");
		//ResultSet객체에 저장된 하나의 DB레코드 정보중 pass값 꺼내와서 저장
		String s_pw = rs.getString("pass");
		//ResultSet객체에 저장된 하나의 DB레코드 정보중 age값 꺼내와서 저장
		int s_age = rs.getInt("age");
		//ResultSet객체에 저장된 하나의 DB레코드 정보중 addr값 꺼내와서 저장
		String s_addr = rs.getString("addr");
		//ResultSet객체에 저장된 하나의 DB레코드 정보중 dept값 꺼내와서 저장
		String s_dept = rs.getString("dept");
		//ResultSet객체에 저장된 하나의 DB레코드정보중 extension값 꺼내와서 저장
		String s_extension = rs.getString("extension");
	%>
	
		<%--한 사람씩 직원 정보 뿌려주기 --%>
		<tr>
			<td><%=s_id %></td><%--select한 결과값 중 직원 id뿌려주기 --%>
			<td><%=s_name %></td><%--select한 결과값 중 직원 id뿌려주기 --%>
			<td><%=s_age %></td><%--select한 결과값 중 직원 id뿌려주기 --%>
			<td><%=s_addr %>
			<td><%=s_dept %></td><%--select한 결과값 중 직원 id뿌려주기 --%>
			<td><%=s_extension %></td><%--select한 결과값 중 직원 id뿌려주기 --%>
			<%--직원수정페이지로 이동시 수정할 직원 번호를 넘겨준다. --%>
			<td><a href="modifySawon.jsp?no=<%=s_no%>">직원 정보 수정</a></td>
			<%--직원삭제페이지로 이동시 삭제할 직원 번호를 넘겨준다. --%>			
			<td><a href="javascript:fnDel(<%=s_no%>)">직원 정보 삭제</a></td>
		</tr>		

<% 
		}
	}catch(Exception err){
		System.out.println("index.jsp에서 오류: " + err);
	}finally{
		//Result객체가 아직 사용되고 있으면 자원 해제
		if(rs != null){
			rs.close();
		}
		//Statement객체가 아직 사용되고 있으면 자원 해제
		
		
		if(stmt != null){
			stmt.close();
		}
		//Connectino객체가 아직 사용되고 있으면 자원 해제
		if(con != null){
			con.close();
		}
	}
%>
</table>
</body>
</html>