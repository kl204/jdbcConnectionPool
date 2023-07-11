<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 등록</title>
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

        button {
            font-size: 15px;
            margin: 5px;
        }
        
        
        #sending {
        	text-align: center;
        }
        
        
        #form {
        	font-size: 30px;
        }

    </style>
    <script type="text/javascript" src="https://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		  $('#go_book_regist').on('click', function(event) {
		    event.preventDefault(); // submit 이벤트 중단

		    var isbn = $('#isbn').val();
		    var title = $('#book_title').val();
		    var author = $('#author').val();
		    var publishDate = $('#publish_date').val();

		    if (!isbn || !title || !author || !publishDate) {
		      alert('입력되지 않은 필드가 있습니다!');
		      return;
		    }

		    var timestampRegex = /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/;
		    if (!timestampRegex.test(publishDate)) {
		      alert('출판일 형식이 올바르지 않습니다! (예: 2023-07-11 14:30:00)');
		      return;
		    }

		    $('#frm').attr('action', 'regist.do');
		    $('#frm').unbind('submit').submit(); // submit 이벤트 다시 트리거
		  });
		});

	
	$(document).ready(function(){
		$('#go_book_list').on('click',function(){
			alert('go');
			$('#frm').attr('action','list.do');
			$('#frm').attr('method','get');
			$('#frm').submit();
		});
	});
	</script>
</head>
<body>
<%-- <% String cmd = request.getParameter("cmd"); %>
<%=cmd.equals("success")?"<script>alert('hello');</script>":""%> --%>
<form action="" method="post" id="frm">
    <table>
        <tr><th colspan="4" id="form">도서등록</th></tr>
        <tr><th>구분</th><th class="data_ui" colspan="2">데이터입력</th><th>비고</th></tr>
        <tr>
            <td>도서번호</td>
            <td colspan="2">
            	<input type="text" id="book_seq" name="bookSeq" disabled="disabled">
            </td>
            <td id="message">자동생성</td></tr>
            
        <tr>
        	<td>ISBN</td>
        	<td colspan="2">
        		<input type="text" id="isbn" name="isbn">
        	</td>
        	<td>
        		<input type="hidden" id="flag" value="false">
        	</td>
        </tr>
        <tr>
        	<td>도서명</td>
        	<td colspan="2">
        		<input type="text" id="book_title" name="title">
        	</td><td></td>
        </tr>
        <tr>
        	<td>저자/역자</td>
        	<td colspan="2">
        		<input type="text" id="author" name="author">
        	</td><td></td>
        </tr>

        <tr>
        	<td>출판일</td>
        	<td colspan="2">
        		<input type="text" id="publish_date" size="35" name="publishDate">
        	</td>
        	<td></td>
        <tr>
        <tr>
        	<td>도서위치</td>
        	<td colspan="2">
        		<select name="bookPosition" disabled="disabled">
        			<option value='BS'>--도서 위치--
        			<option value='BS-001' selected>일반서가
        			<option value='BS-002'>예약서가
        			<option value='BS-'>회원
        		</select>
        	</td>
        	<td>기본값삽입</td>
        <tr>
        <tr>
        	<td>도서상태</td>
        	<td colspan="2">
        		<select name="bookStaus" disabled="disabled">
        			<option value='BM'>--도서 상태--
        			<option value='BM-001' selected>도서대출서비스
        			<option value='BM-002'>도서수선
        			<option value='BM-003'>도서저장고
        		</select>
        	</td>
        	<td>기본값삽입</td>
        <tr>
        <tr>
        	<td colspan="4" id="sending">
        		<input type="submit" value="도서등록" id="go_book_regist"> 
        		<input type="submit" value="도서리스트" id="go_book_list">
        	</td>
        </tr>
    </table>
</form>
</body>
</html>