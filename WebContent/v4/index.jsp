<%@page import="java.util.List"%>
<%@page import="mybean.SawonDto" %>
<%@page import="dbcp.DBConnectionMgr" %> <!-- [1]번 -->
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
	//<검색 기능 form>태그에서 요청받은 파라미터 한글처리
	request.setCharacterEncoding("UTF-8");
	//<검색기능 form>태그에서 요청받은 검색기준 값, 검색어 전달받아 저장 
	String search = request.getParameter("search");
	String searchText = request.getParameter("searchText");
%>

<%--DB작업을 위한 메소드 호출용 객체 생성 --%>
<jsp:useBean id="dao" class="mybean.SawonDao"/>


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
	<!-- 한사람씩 정보 뿌려주기 -->
<%
	List list = dao.getList(search,searchText);
	
	for(int i = 0; i < list.size(); i++){
		SawonDto dto = (SawonDto) list.get(i);
%>		
	<tr>
		<td><%=dto.getId() %></td><%--selelct한 결과값 중 직원 id 뿌려주기 --%>	
		<td><%=dto.getName() %></td><%--selelct한 결과값 중 직원 id 뿌려주기 --%>	
		<td><%=dto.getAge() %></td><%--selelct한 결과값 중 직원 id 뿌려주기 --%>	
		<td><%=dto.getAddr() %></td><%--selelct한 결과값 중 직원 id 뿌려주기 --%>	
		<td><%=dto.getDept() %></td><%--selelct한 결과값 중 직원 id 뿌려주기 --%>	
		<td><%=dto.getExtension() %></td><%--selelct한 결과값 중 직원 id 뿌려주기 --%>	
		<td><a href="modifySawon.jsp?no=<%=dto.getNo()%>">직원정보수정</a></td>
		<td><a href="javascript:fnDel(<%=dto.getNo()%>)">직원정보삭제</a></td>		
	</tr>	

<%		
	}
%>
	</table>
</body>
</html>