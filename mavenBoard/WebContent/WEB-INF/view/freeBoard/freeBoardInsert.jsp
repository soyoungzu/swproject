<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<script type="text/javascript">
	$(document).ready(function() {
		$("#btnWrite").click(function() {
			var codeType = $("#codeType").val();
			var name = $("#name").val();
			var title = $("#title").val();
			var content = $("#content").val();
			
			var param = {
					"codeType" : codeType,
					"name" : name,
					"title" : title,
					"content" :content
			}
			
			if (name == "") {
				confirm("이름을 입력해주세요.");
				$("#name").focus();
				return false;
			}
			if (title == "") {
				confirm("제목을 입력해주세요.");
				$("#title").focus();
				return false;
			}
			if (content == "") {
				confirm("내용을 입력해주세요.");
				$("#content").focus();
				return false;
			}
			
			var result = confirm("글을 작성하시겠습니까?");
			
			if(result) {
				$.ajax({
					type : "POST",
					url : "./freeBoardInsertPro.ino",
					data : param,
					success : function(resp) {
						if(!resp.msg) {
							var moveMain = confirm("main으로 돌아가시겠습니까?");
							if(moveMain) {
								window.location.href="./main.ino";
							} else {
								window.location.href="./freeBoardDetail.ino?num="+resp.num;
							}
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
	<div style="width:650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">

	<form action="./freeBoardInsertPro.ino">

		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select name="codeType" id="codeType">
							<option value="01">자유</option>
							<option value="02">익명</option>
							<option value="03">QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name" id="name" /></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title" id="title"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65" id="content" ></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="글쓰기" id="btnWrite">
					<input type="button" value="다시쓰기" onclick="reset()">
					<input type="button" value="취소" onclick="">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>



</body>
</html>