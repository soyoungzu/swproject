<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<script type="text/javascript">
		
		//����
		$(document).ready(function() {
			$("#btnDelete").click(function() {
				var num = $("#num").val();
				var param = {
						"num" : num
				}
				var result = confirm("���� �����Ͻðڽ��ϱ�?");
				if(result) {
					$.ajax({
						type : "post",
						url : "./freeBoardDelete.ino",
						data : param,
						success : function(resp) {
							if(!resp.msg){
								alert("���� �����Ǿ����ϴ�.");
								window.location.href="./main.ino";
							} else {
								alert(resp.msg);
							}
						}, 
						error : function(xhr, status, error) {
							console.log(status, error);
						}
					}); //ajax
				}//if
			});
		});
		
		//����
		$(document).ready(function() {
			$("#btnModify").click(function() {
				var num = $("#num").val();
				var codeType = $("#codeType").val();
				var title = $("#title").val();
				var content = $("#content").val();
				
				var param = {
						"num" : num,
						"codeType" : codeType,
						"title" : title,
						"content" : content
				}
				var result = confirm("���� �����Ͻðڽ��ϱ�?");
				
				if(result) {
					$.ajax({
						type : "POST",
						url : "./freeBoardModify.ino",
						data : param,
						success : function(resp) {
							if(!resp.msg) {
								var result = confirm("mainȭ������ �̵��Ͻðڽ��ϱ�?");
								if(result) {
									window.location.href="./main.ino";
								}else {
									window.location.href="./freeBoardDetail.ino?num="+resp.num;
								}
							}else {
								alert(resp.msg);
							}
							
						},
						error : function(xhr, status, error) {
							console.log(status, error);
						}
					});//ajax
				}
			});
		});
	
	
	
	</script>

	<div>
		<h1>�����Խ���</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">����Ʈ��</a>
	</div>
	<hr style="width: 600px">

	<form name="insertForm">
		<input type="hidden" name="num" id="num" value="${dto.num }" />
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">Ÿ�� :</td>
					<td style="width: 400px;">
						<select id="codeType">
							<option value="01" <c:if test="${dto.codeType==01}">selected</c:if> >����</option>
							<option value="02" <c:if test="${dto.codeType==02}">selected</c:if> >�͸�</option>
							<option value="03" <c:if test="${dto.codeType==03}">selected</c:if> >QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">�̸� :</td>
					<td style="width: 400px;"><input type="text" name="name" id="name" value="${dto.name }" readonly/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><input type="text" name="title" id="title" value="${dto.title }"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">���� :</td>
					<td style="width: 400px;"><textarea name="content" id="content" rows="25" cols="65"  >${dto.content }</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="����" id="btnModify" >
					<input type="button" value="����" id="btnDelete" >
					<input type="button" value="���" onclick="location.href='./main.ino'">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>

</body>
</html>