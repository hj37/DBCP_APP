<%@page import="mybean.SawonDto"%>
<%@page import="mybean.SawonDao"%>
<%@page import="dbcp.DBConnectionMgr" %>
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
//수정할 직원 한사람 DB작업을 위한 dao객체 생성
SawonDao dao = new SawonDao();
//index.jsp에서 받아온 수정할 직원번호 받아오기
int no = Integer.parseInt(request.getParameter("no"));
//수정할 메소드 호출후..
//수정할 사원 레코드 가져오기
SawonDto dto = dao.getSawon(no);
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
			<td><input type="text" name="id" value="<%=dto.getId() %>"/><td>
		</tr>
		<tr>
			<th>이름</th>
			<td><input type="text" name="name" value="<%=dto.getName()%>"/></td>
		</tr>
		<tr>
			<th>패스워드</th>
			<td><input type="text" name="pass" value="<%=dto.getPass()%>"/></td>
		</tr>
		<tr>
			<th>나이</th>
			<td><input type="text" name="age" value="<%=dto.getAge() %>"/></td>
		</tr>
		<tr>
			<th>근무지</th>
			<td>
				<select name="s_addr">
					<option value="서울" <%if(dto.getAddr().equals("서울")){%> selected <%}%>>서울</option>
					<option value="경기" <%if(dto.getAddr().equals("경기")){%> selected <%}%>>경기</option>
					<option value="인천" <%if(dto.getAddr().equals("인천")){%> selected <%}%>>인천</option>
					<option value="수원" <%if(dto.getAddr().equals("수원")){%> selected <%}%>>수원</option>				
				</select>
			</td>
		</tr>
		<tr>
			<th>내선번호</th>
			<td><input type="text" name="s_extension" value="<%=dto.getExtension() %>"/></td>
		</tr>	
		<tr>
			<th>부서명</th>
			<td>
				<select name="s_dept">
					<option value="영업" <%if(dto.getDept().equals("영업")) {%> selected <%}%>>영업 </option>
					<option value="기술" <%if(dto.getDept().equals("기술")) {%> selected <%}%>>기술</option>
					<option value="기획" <%if(dto.getDept().equals("기획")) {%> selected <%}%>>기획 </option>
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