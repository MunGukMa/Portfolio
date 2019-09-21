<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src='/secondpj/js/jquery-3.4.1.js'></script>
<script>
	$(function()
	{
		$('#cancelbtn').on('click',cancelregit);
		$('#prdtfile').on('change',filechk);
		$('#loginbtn').on('click',login);
		$('#signupbtn').on('click',signup);
		$('#editprofile').on('click',editprofile);
		$('#callmypage').on('click',callmypage);
	})
	
	
		function login()
	{
		$.ajax
		({
			url:'/secondpj/member/login',
			type:'post',
			data:{'userid':$('#userid').val(),'userpwd':$('#userpwd').val()},
			success:function(){location.href="/secondpj/"},
			error:function(){alert("error")}	
		});
	}
	function callmypage()
	{
		location.href="/secondpj/callmypage";
	}
	var signinfo;
	function signup()
	{
		signinfo = window.open("/secondpj/member/signupform","_blank","width=400,height=400,left=100");
	}
	
	function editprofile()
	{
		signinfo = window.open("/secondpj/member/editprofile","_blank","width=400,height=400,left=100");
	}
	
	
	function cancelregit()
	{
		location.href="/secondpj/";
	}
	
	function chkval()
	{
		if($('#prdttype').val()==""||$('#prdttype').val()==null||$('#prdtname').val()==""||$('#prdtname').val()==null
				||$('#prdtweight').val()==""||$('#prdtweight').val()==null||$('#prdtprice').val()==""||$('#prdtprice').val()==null
				||$('#prdtfile').val()==""||$('#prdtfile').val()==null||$('#prdtmemo').val()==""||$('#prdtmemo').val()==null)
		{
			alert("빈칸없이 입력해주세요");
			return false;
		} else return true;
	}
	
	function filechk()
	{
		$.ajax
		({
			url:'/secondpj/seller/filechk',
			type:'get',
			data:{'originalfilename':$('#prdtfile').val()},
			success:function(result)
			{
				if(result=="good")
				{
					alert("사용가능한 양식입니다");
				} else 
				{
					alert("사용불가능한 파일양식입니다");
					$('#prdtfile').val("");
				}
			},
			error:function(){alert("error")}
		})
	}
	
</script>
<style>
	body
	{
		text-align:center;
	}
	
	.product img
	{
		position:relative;
		left:25%;		
		width:50%;
		height:20%;
		display:block;
	}
	.maintitle
	{
		position:relative;
		text-align:center;
		padding-bottom: 1%;
	}

	#maintext
	{
		position:relative;
		left:40%;
		width:50%;
	}
	ul 
	{
		list-style-type: none;
		margin: 0;
		padding: 0;
		overflow: hidden;
		background-color: #333;
		position: -webkit-sticky; /* Safari */
		position: fixed;
		top: 0;
		width:10%;
		height:100%;
		left:0;
	}

	/* li input
	{
  		text-align: center;
		top:2%;  		
  		
	} */
	
	li 
	{
	}

	li a
	{
  		display: block;
  		color: white;
  		text-align: center;
  		padding: 14px 16px;
  		text-decoration: none;
	}

	li a:hover 
	{
  		background-color: gray;
	}
	li.drop-down
	{
		background-color: #333;
	}
	.drop-content{
		display: none;
		position: relative;
		background-color: #f9f9f9;
		/* min-width: 160px; */
		/* box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); */
		z-index: 1;
	}
	
	
	.drop-content a
	{
		color: black;
		/* padding: 12px 16px; */
		text-decoration: none;
		display: block;
		text-align: left;
	}
	
	.drop-down:hover .drop-content
	{
		display:block;
	}
	.rightcontent
	{
		position:absolute;
		left:11%;
		width:40%;
		height:fit-content;
	}
	.leftcontent
	{
		position:absolute;
		left:51%;
		width:40%;
		height:fit-content;
	}
	.adcontent
	{
		position:fixed;
		left:91%;
		width:9%;
		height:fit-content;
	}
	#registform
	{
		position:relative;
		left:25%;
		width:65%;
	}
</style>
</head>
<body>
	<div class="wrapper">
		<div id="navibar">
			<ul>
				<li><a href="/secondpj/"><img width="90%;"src="/secondpj/resources/img/main.png"/></a></li>
				<c:choose>
					<c:when test="${sessionScope.user!=null}">
 						<li>Welcome, ${sessionScope.user.username}</li>
 						<li><a href="/secondpj/member/logout">Logout</a></li>
 						<li><a id="editprofile">Edit Profile</a></li>
 						<li><a id="callmypage">mypage</a></li>
 						<c:if test="${sessionScope.user.usertype=='seller'}">
 						<li><a href="/secondpj/seller/mylist">ShippingList</a></li>
 						<li><a href="/secondpj/seller/registform">RegistProduct</a></li>
 						</c:if>
					</c:when>
					<c:otherwise>
						<li><input type="text" id="userid" name="userid" placeholder="아이디를 입력하세요"></li>
						<li><input type="password" id="userpwd" name="userpwd" placeholder="비밀번호를 입력하세요"></li>
						<li><input type="button" id="loginbtn" value="로그인">  <input type="button" id="signupbtn" value="회원가입"></li>	
					</c:otherwise>
				</c:choose>
 				<li class="drop-down">
 					<a class="drop-downbtn" id="drop-downbtn">Product List</a>
	 				<div class="drop-content" id="drop-content">
	 					<a href="#">전체</a>
	 					<a href="/secondpj/productboard?prdttype=rice">쌀/잡곡</a>
	 					<a href="/secondpj/productboard?prdttype=fruit">과일/견과</a>
	 					<a href="/secondpj/productboard?prdttype=mush">채소/버섯</a>
	 				</div>
 					</li>
 				<li><a href="#about">About</a></li>
 				<li><input type="text"><input type="button" id="searchbtn" value="검색"></li>
			</ul>
		</div>
		<div id="maintitle" class="maintitle">
			<img width="30%;" height="10%;" src="/secondpj/resources/img/main.png"/>
		</div>
		<div id="adcontent" class="adcontent">
				최근본 상품
		</div>
		<!-- 여기까지 navi -->
		
		<form id="registform" action="/secondpj/seller/registproduct" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<th>
						카테고리
					</th>
					<td>
						<select id="prdttype" name="prdttype">
							<option value="rice">쌀/잡곡</option>
							<option value="fruit">과일/견과</option>
							<option value="mush">채소/버섯</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>
						상품 제목
					</th>
					<td>
						<input style="width:300px;"type="text" id="prdtname" name="prdtname" placeholder="상품명을 포함하여 적어주세요">
					</td>
				</tr>
				<tr>
					<th>
						상품 가격
					</th>
					<td>
						<select id="prdtweight" name="prdtweight">
							<option>100G</option>
							<option>500G</option>
							<option>1KG</option>
							<option>5KG</option>
							<option>20KG</option>
							<option>50KG</option>
						</select>
						<input type="number" id="prdtprice" name="prdtprice" placeholder="무게당 가격을 입력하세요">
					</td>
				</tr>
				<tr>
					<th>
						메인 사진
					</th>
					<td>
						<input type="file" id="prdtfile" name="prdtfile">
					</td>
				</tr>
				<tr>
					<th>
						상품 설명
					</th>
					<td>
						<textarea id="prdtmemo" name="prdtmemo" style="resize:none;width:550px;height:350px;" ></textarea>
					</td>
				</tr>
				<tr>
					<th colspan="3">
						<input type="submit" id="submitbtn" onclick="return chkval()" value="상품등록">
						<input type="button" id="cancelbtn" value="취소">
					</th>
				</tr>
			</table>
		</form>
		
		
		
		
	</div>
</body>
</html>