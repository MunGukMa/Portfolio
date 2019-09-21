<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src='/secondpj/js/jquery-3.4.1.js'></script>
<script>
	var flag = false;
	$(function()
	{
		setinfo();
		$('#checkpwd').on('keyup',chkpwd);
		$('#updatebtn').on('click',infoupdate);
	})
	
	
	function setinfo()
	{
		$.ajax({
			url:"/secondpj/member/setinfo",
			type:"post",
			dataType:"JSON",
			success:function(result)
			{
				$('#username').val(result.username);
				$('#userid').val(result.userid);
				$('#usertel').val(result.usertel);
				$('#address').val(result.address);
				document.getElementById('userid').style="background-color:lightgray;";
				document.getElementById('username').style="background-color:lightgray;";
				document.getElementById('username').readOnly="ture";
				document.getElementById('userid').readOnly="ture";
			},
			error:function()
			{
				alert("회원정보 불러오기를 실패하였습니다");
			}
		})
	}
	
	function chkpwd()
	{
		if($('#userpwd').val()!="" && $('#checkpwd').val()!="")
		{
			if($('#userpwd').val()!=$('#checkpwd').val())
			{
				$('#pwdmess').remove();
				$('#pwdcell').append('<th id="pwdmess" colspan="3" style="color:red;">비밀번호가일치하지않습니다</th>');
				flag=false;
			}
			if($('#userpwd').val()==$('#checkpwd').val())
			{
				$('#pwdmess').remove();
				flag=true;				
			}
		}
	};
	
	function infoupdate()
	{
		if(flag==false||$('#usertel').val()==""||$('#usertel').val()==null||$('#address').val()==""||$('#address').val()==null)
		{
			alert("빈칸없이 입력해주세요");
			return;
		}
		$.ajax({
			url:"/secondpj/member/infoupdate",
			type:"post",
			data:$('#userinfo').serialize(),
			success:function()
			{
				alert("회원정보를 수정하였습니다.");
				close();
			},
			error:function()
			{
				alert("정보수정에 실패하였습니다.");
				location.reload();
			}
		})
		
	}
	
</script>
</head>
<body>
	<form id="userinfo" action="/secondpj/member/signup" method="post">
		<table id="signform">
			<tr>
				<h1>[회원정보 수정]</h1>
			</tr>
			<tr>
				<th>
					이름
				</th>
				<td>
					<input type="text" id="username" name="username">
				</td>
			</tr>
			<tr>
				<th>
					아이디
				</th>
				<td>
					<input type="text" id="userid" name="userid">
				</td>
			</tr>
			<tr id="idcell">
			</tr>
			<tr>
				<th>
					비밀번호
				</th>
				<td>
					<input type="password" id="userpwd" name="userpwd" placeholder="본인확인을 위해 입력해주세요">
				</td>
			</tr>
			<tr>
				<th>
					비밀번호 확인
				</th>
				<td>
					<input type="password" id="checkpwd" placeholder="본인확인을 위해 입력해주세요">
				</td>
			</tr>
			<tr id="pwdcell">
			
			</tr>
			<tr>
				<th>
					주소
				</th>
				<td>
					<input type="text" id="address" name="address">
				</td>
			</tr>
			<tr>
				<th>
					핸드폰번호
				</th>
				<td>
					<input type="tel" id="usertel" name="usertel">
				</td>
			</tr>
			<tr id="hiddenmenu">
				<th colspan="3">
					<input type="button" id="updatebtn" value="회원정보수정">
				</th>
			</tr>
		</table>
	</form>
</body>
</html>