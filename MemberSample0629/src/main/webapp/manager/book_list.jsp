<%@page import="bitedu.bipa.member.vo.BookCopy"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 그냥 list 와 다른곳 -->
<%-- <%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>     --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book List</title>
<style>
        table, td, th {
            border : 1px solid black;
            border-collapse: collapse;
            margin: 20px auto;
        }
        td {
            width: 150px;
            height: 50px;
            padding: 5px;
            font-size: 20px;
            /* text-align: center; */
        }

        input , select {
            font-size: 20px;
        }
        .data_ui {
            /* width: 250px; */
            height: 50px;
        }

        button {
            font-size: 15px;
            margin: 5px;
        }
        
        
        #sending {
        	text-align: center;
        }
        
        input.poster :disabled {
        	background: gray;
        }
        
        #form {
        	font-size: 30px;
        }
        
        #title {
        	height: 80px;
        	font-size: 50px;
        }
    </style>
</head>
<body>
<!-- if 문 등 연산자가 사용 가능하다 -->
${param.flag=='true'?"<script>alert('삭제성공');</script>":"" }  

<%-- <%
	ArrayList<BookCopy> list = (ArrayList<BookCopy>)request.getAttribute("list");
%> --%>
<table>
	<tr><th colspan="5" id="title">도서리스트</th></tr>
	<tr><td>순번</td><td>타이틀</td><td>저자</td><td>출판일</td><td></td></tr>
	
<!-- 4개의 객체: 페이지객체, 리퀘스트객체, 세션객체, 어플리케이션객체 // 를 4번 검사함-->
<c:forEach var="copy" items="${list}"><!-- list는 setAttribute의 key 값이다, forEach는 메서드이고 var는 파라메터 items는 argument이다 -->
	<tr>
		<td>${copy.bookSeq}</td>
		<td><a href='book_detail.jsp'>${copy.title}</a></td>
		<td>${copy.author}</td>
		<td><fmt:formatDate value="${copy.publishDate}" pattern="yyy-MM-dd"/></td>
		<td><a href="./BlmController?cmd=remove&bookSeq=${copy.bookSeq}">삭제</a></td>	
	</tr>
</c:forEach>	

<!-- for을 쓰는대신 위의 코드를 사용한다. -->
<%-- <% for(BookCopy copy : list) { %>
	<tr><td><%=copy.getBookSeq()%></td><td><a href='book_detail.jsp'><%=copy.getTitle()%></a></td><td><%=copy.getAuthor() %></td><td><%=copy.getPublishDate()%></td><td><a href="javascript:alert('삭제완료');">삭제</a></td></tr>
<% } %>	 --%>

	<tr><td colspan="5"><a href="/MemberSample/BlmController?cmd=view_regist"><button>도서등록</button></a></td></tr>
</table>
</body>
</html>