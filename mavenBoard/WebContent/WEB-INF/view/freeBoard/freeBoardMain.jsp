<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<script type="text/javascript">
		$(document).ready(function () {
			$("#btnDeleteList").click(function() {
				
				var $checked = $('table input[id=chkBox]:checked');
				
				console.log( $checked.length );
				
				if($checked.length < 1) {
					alert("삭제할 데이터를 선택하세요.");
					return false;
				}
				var numList = [];
				
				$.each($checked, function(k, v) {
					numList.push( $(this).val() );
				});
				console.log(numList);
				
				var param = {
						"numList" : numList
				}
				
				var result = confirm("선택한 " + $checked.length + "건의 글을 삭제하시겠습니까?");
				
				if(result) {
					$.ajax({
						type : "get",
						dataType:'json',
						url : "./freeBoardDeleteList.ino",
						data : param,
						success : function(resp) {
							if(!resp.msg) {
								alert("선택하신 "+$checked.length+"건의 글 중 "+ resp.delCnt +"건의 글이 삭제되었습니다.");
								window.location.href="./main.ino";
							} else {
								alert(resp.msg);
							}
							
						},
						error : function(xhr, status, error) {
							console.log(status, error);
						}
					}); //ajax
				} //if
			});
		});
	
	</script>
	
	<div>
		<h1>자유게시판</h1>
	</div>
	
	<div>
		<select>
			<option value="0">전체</option>
			<option value="1">타입</option> <!-- selectbox -->
			<option value="2">번호</option> <!-- input type text 검색버튼 클릭시 숫자인지 체크하세요.-->
			<option value="3">내용</option> <!-- input type text -->
			<option value="4">제목</option> <!-- input type text -->
			<option value="5">이름</option> <!-- input type text -->
			<option value="6">기간</option> <!-- input type text - input type text 검색버튼 클릭시 숫자인지 체크하세요. 8자리수체크 ex)20221125 20221127 -->
		</select>
		<button>검색</button>
		<!-- ajax 만들것. -->
	</div>
	<div style="width:650px;" align="right">
		<a href="./freeBoardInsert.ino">글쓰기</a>
	</div>
	<hr style="width: 600px;">
	<div style="padding-bottom: 10px;">
		<table border="1">
			<thead>
				<tr>
					<td><input type="checkbox"></td>
					<td style="width: 55px; padding-left: 30px;" align="center">타입</td>
					<td style="width: 50px; padding-left: 10px;" align="center">글번호</td>
					<td style="width: 125px;" align="center">글제목</td>
					<td style="width: 48px; padding-left: 50px;" align="center">글쓴이</td>
					<td style="width: 100px; padding-left: 95px;" align="center">작성일시</td>
				</tr>
			</thead>
		</table>
	</div>
	<hr style="width: 600px;">

	<div>
		<table border="1">
			<tbody id="tb" name="tb">
					<c:forEach var="dto" items="${freeBoardList }">
						<tr>
							<td><input type="checkbox" value="${dto.num }" id="chkBox"></td>
							<td style="width: 55px; padding-left: 30px;" align="center">${dto.codeType }</td>
							<td style="width: 50px; padding-left: 10px;" align="center">${dto.num }</td>
							<td style="width: 125px; "" align="center"><a href="./freeBoardDetail.ino?num=${dto.num }">${dto.title }</a></td>
							<td style="width: 48px; padding-left: 50px;" align="center">${dto.name }</td>
							<td style="width: 100px; padding-left: 95px;" align="center">${dto.regdate }</td>
						<tr>
					</c:forEach>
			</tbody>
		</table>
		<input type="button" id="btnDeleteList" value="선택삭제" style=" margin-top : 10px; margin-right: 40px; float: right;">
	</div>

</body>
</html>