<%@page import="bitedu.bipa.member.vo.BookCopy"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<%
	ArrayList<BookCopy> list = (ArrayList<BookCopy>)request.getAttribute("list");
%>
<table>
	<tr><th colspan="5" id="title">도서리스트</th></tr>
	<tr><td>순번</td><td>타이틀</td><td>저자</td><td>출판일</td><td></td></tr>
<% for(BookCopy copy : list) { %>
	<tr><td><%=copy.getBookSeq()%></td><td><a href='book_detail.jsp'><%=copy.getTitle()%></a></td><td><%=copy.getAuthor() %></td><td><%=copy.getPublishDate()%></td><td><a href="javascript:alert('삭제완료');">삭제</a></td></tr>
<% } %>	
	<tr><td colspan="5"><a href="/MemberSample/BlmController?cmd=view_regist"><button>도서등록</button></a></td></tr>
</table>
</body>
</html>