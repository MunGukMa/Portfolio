<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src='/secondpj/js/jquery-3.4.1.js'></script>
<script>
	$(function()
	{
			$('#idchk').on('click',idchk);
			$('#checkpwd').on('keyup',chkpwd);
			$('#signupbtn').on('click',signup);
			$('#hiddenmenu').hide();
	})
	var flag=false;
	function idchk()
	{
		$.ajax({
			url:'/secondpj/member/idchk',
			type:'post',
			data:{'userid':$('#userid').val()},
			success:function(result)
			{
				if(result==null)
				{
					alert("이미 사용중인 ID입니다");
					return;
				}
				alert("사용가능한 ID입니다");
				$('#hiddenmenu').show();
				document.getElementById('userid').readOnly="true"
			},
			error:function()
			{
				alert("이미 사용중인 ID입니다");
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
	
	function signup()
	{
		if(flag==false||$('#usertel').val()==""||$('#usertel').val()==null||$('#address').val()==""||$('#address').val()==null)
		{
			alert("빈칸없이 입력해주세요");
			return;
		}
		if($('#registnumber').val()==null)
		{
			if(!confirm("구매자로 회원가입하시겠습니까?"))
			{
				return;
			};
		} else 
		{
			if(!confirm("판매자로 회원가입하시겠습니까?"))
			{
				$('#registnumber').val('');
				return;
			};
		}
		
		$.ajax
		({
			url:'/secondpj/member/signup',
			type:'post',
			data:$('#userinfo').serialize(),
			success:function()
			{
				alert("회원가입에 성공하였습니다.");
				close();
			},
			error:function()
			{
				alert("error");
			}
		})
		
		
	}
	
	
</script>
</head>
<body>
<form id="userinfo" action="/secondpj/member/signup" method="post">
		<table id="signform">
			<tr>
				<h1>[회원가입]</h1>
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
					<input type="button" id="idchk" value="중복체크">
				</td>
			</tr>
			<tr id="idcell">
			
			</tr>
			<tr>
				<th>
					비밀번호
				</th>
				<td>
					<input type="password" id="userpwd" name="userpwd">
				</td>
			</tr>
			<tr>
				<th>
					비밀번호 확인
				</th>
				<td>
					<input type="password" id="checkpwd">
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
			<tr>
				<th>
					사업자등록번호
				</th>	
				<td>
					<input type="text" id="registnumber" name="registnumber" placeholder="판매자로 가입시에만 입력">
				</td>
			</tr>
			<tr id="hiddenmenu">
				<th colspan="3">
					<input type="button" id="signupbtn" value="회원가입">
				</th>
			</tr>
		</table>
	</form>
</body>
</html>