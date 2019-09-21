<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세보기</title>
<script src='/secondpj/js/jquery-3.4.1.js'></script>
<script>
	$(function()
	{
		$('#loginbtn').on('click',login);
		$('#signupbtn').on('click',signup);
		$('#editprofile').on('click',editprofile);
		$('#qt').on('change',totalprice);
		$('#qt').val(1);
		$('#buybtn').on('click',requestbuyform);
		$('#callmypage').on('click',callmypage);
		$('#prarea').remove();
		var a = $('#qt').val();
		var b = $('#prdtprice').val();
		a= Number(a);
		b= Number(b);
		var temp = a*b;
		$('#pricearea').append('<span id="prarea">총 가격은'+temp+'원 입니다.</span>');
		
	})
	function callmypage()
	{
		location.href="/secondpj/callmypage";
	}
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
	
	var signinfo;
	function signup()
	{
		signinfo = window.open("/secondpj/member/signupform","_blank","width=400,height=400,left=100");
	}
	
	function editprofile()
	{
		signinfo = window.open("/secondpj/member/editprofile","_blank","width=400,height=400,left=100");
	}
/*         navi 관련 function          */
 	
 	
	function totalprice()
	{
		$('#prarea').remove();
		var a = $('#qt').val();
		var b = $('#prdtprice').val();
		a= Number(a);
		b= Number(b);
		var temp = a*b;
		$('#pricearea').append('<span id="prarea">총 가격은'+temp+'원 입니다.</span>');
	}
 	
 	function requestbuyform()
 	{
 		location.href="/secondpj/buyer/buyform?prdtnum="+$('#prdtnum').val()+"&orderqt="+$('#qt').val();
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
	#productarea
	{
		position:relative;
		left: 30%;
		width: 55%;
		text-align:center;
	}
</style>
</head>
<body>
	<div class="wrapper">
	
	<!-- Navi Start  -->
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
	 					<a href="/secondpj/productboard?prdttype=all">전체</a>
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
	<!-- Navi end -->
	<div id="productarea">
	<input type="hidden" value="${prdt.prdtprice}" id="prdtprice">
	<input type="hidden" value="${prdt.prdtnum}" id="prdtnum">
		<table>
			<tr>
				<th colspan="4">
					<h1>상품 상세보기</h1>
				</th>
			</tr>
			<tr>
				<th rowspan="5">
					<img src="/secondpj/resources/img/product/${prdt.savefilename}">
				</th>
				<th colspan="3">
					${prdt.prdtname}
				</th>
			</tr>
			<tr>
				<td colspan="3">
					${prdt.prdtweight} / ${prdt.prdtprice}원
				</td>
			</tr>
			<tr>
				<td colspan="3">
					구매수량 <input type="number" id="qt" min="1" max="999">
				</td>
			</tr>
			<tr >
				<th id="pricearea" rowspan="2">
					<span id="prarea"></span>
				</th>
				<td>
					<input type="button" id="buybtn" value="구매">
				</td>
			</tr>
			<tr>
				<td>
					<input type="button" id="cartbtn" value="장바구니에 추가">
				</td>
			</tr>
			<tr>
				<td rowspan="10" colspan="4">
					${prdt.prdtmemo}				
				</td>
			</tr>
		</table>
	</div>
		
		
	</div>
</body>
</html>