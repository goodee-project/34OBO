<!-- �ۼ���: �տ��� -->
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>������</title>
</head>
<body>
	<h1>������ ����</h1>
	
	<table>
		<tr>
			<th>���̵�</th>
			<td>${memberOne.memberId}</td>
		</tr>
		<tr>
			<th>�̸�</th>
			<td>${memberOne.memberName}</td>
		</tr>
		<tr>
			<th>�г���</th>
			<td>${memberOne.memberNickname}</td>
		</tr>
		<tr>
			<th>�̸���</th>
			<td>${memberOne.memberEmail}</td>
		</tr>
		<tr>
			<th>���Գ�¥</th>
			<td>${memberOne.createDate}</td>
		</tr>
		<tr>
			<th>�޴�����ȣ</th>
			<td>${memberOne.memberPhone}</td>
		</tr>
		<tr>
			<th>����</th>
			<td>${memberOne.memberBirth}</td>
		</tr>
		<tr>
			<th>����</th>
			<td>${memberOne.memberGender}</td>
		</tr>
		<tr>
			<th>�����ȣ</th>
			<td>${memberOne.postCode}</td>
		</tr>
		<tr>
			<th>�ּ�</th>
			<td>
				<div>
					${memberOne.doro}
				</div>
					${memberOne.detailAddress}
				
			</td>
		</tr>
	</table>
	
	<button id="modifyMemberOne" type="button" onclick="modifyMemberOne()">�� ���� ����</button>
<script>
	//�������� �������� �̵��ϱ� ���� ��й�ȣ �˻�
	function modifyMemberOne(){
		console.log('click!');
		
		let checkPw = prompt("��й�ȣ�� �Է��Ͻÿ�");
		
		$.ajax({
			type: 'post',
			url: '/',
			data: {memberId: ${memberOne.memberId}},
			success: function(jsonData){
				console.log('����')
			}
		})
		
		
	}
</script>	

</body>
</html>