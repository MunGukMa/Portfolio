<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>Home</title>
	<meta charset="UTF-8">
<script src='/secondpj/js/jquery-3.4.1.js'></script>
<script>
	var temp;
	var rightcontent;
	var leftcontent;
	
	$(function()
	{
		
		$('#loginbtn').on('click',login);
		$('#signupbtn').on('click',signup);
		$('#editprofile').on('click',editprofile);
		$('#searchbtn').on('click',searchitem);
		$('#orderqt').on('change',totalcalc);
		$('#orderbtn').on('click',goorder);
		$('#callmypage').on('click',callmypage);
		totalcalc();
	})
		////////////////////////////////////////////
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
	function signup()
	{
		signinfo = window.open("/secondpj/member/signupform","_blank","width=400,height=400,left=100");
	}
	function editprofile()
	{
		signinfo = window.open("/secondpj/member/editprofile","_blank","width=400,height=400,left=100");
	}
	function productboard(obj)
	{
		savelist();
		clearlist();
		$.ajax
		({
			url:'/secondpj/productboard',
			type:'get',
			data:{'prdttype':obj.innerText},
			dataType:"json",
			success:function(result)
			{
				makediv()
				setlist(result);
				
			},
			error:function()
			{
				returnlist();
			},
		})
		
	}
	function searchitem(obj)
	{
		$.ajax
		({
			url:'/secondpj/searchitem',
			type:'get',
			data:{"searchkey":$('#searchkey').val()},
			success:function(result)
			{
				savelist();
				clearlist();
				setlist(result);
			},
			error:function(){returnlist()}
		})	
	}
////////////////////////////////////////////////////////////////////////	
	function totalcalc()
	{
		var total = document.getElementById('totalvalue');
		var qt = document.getElementById('orderqt').value;
		total.innerText=qt*${prdt.prdtprice};
	}
	
	function goorder()
	{
		var qt = Number($('#orderqt').val());
		var prdtnum = Number(${prdt.prdtnum});
		var req = $('#odrequest').val();
		 $.ajax
		({
			url:'/secondpj/buyer/goorder',
			type:'post',
			data:{"orderqt":qt,"prdtnum":prdtnum,"request":req},
			success:function(){
				alert("주문완료되었습니다");
				location.href="/secondpj/callmypage";
			},
			error:function(){alert("bad")}
		});
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
	.leftcontent
	{
		position:absolute;
		left:11%;
		width:40%;
		height:fit-content;
	}
	.rightcontent
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
	#purchase
	{
		position:relative;
		left:11%;
		height:fit-content;
		width:50%;
		text-align:center;
	}
</style>
</head>
<body>
	<div class="wrapper" id="wrapper">
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
	 					<a href="#" onclick="productboard(this)">전체</a>
	 					<a href="#" onclick="productboard(this)">쌀/잡곡</a>
	 					<a href="#" onclick="productboard(this)">과일/견과</a>
	 					<a href="#" onclick="productboard(this)">채소/버섯</a>
	 				</div>
 					</li>
 				<li><a href="#about">About</a></li>
 				<li><input type="text" id="searchkey" ><input type="button" id="searchbtn" value="검색"></li>
			</ul>
		</div>
		<div id="maintitle" class="maintitle">
			<img width="30%;" height="10%;" src="/secondpj/resources/img/main.png"/>
		</div>
		<div id="adcontent" class="adcontent">
			최근본 상품
		</div>
		<!-- 여기까지 navi -->
		
		<div id="purchase">
			<table>
				<tr>
					<th colspan="5">
						<h1>[상품 구매]</h1>
					</th>
				</tr>
				<tr>
					<th colspan="2">
						구매상품
					</th>
					<th>
						가격
					</th>
					<th>
						구매수량
					</th>
					<th>
						총 구매가격
					</th>
					<th>
						요청사항
					</th>
					<th>
						주문하기
					</th>
				</tr>
				<tr>
					<td>
						${prdt.prdtname}
					</td>
					<td>
						<img style="width:100%;height:60%;" src="/secondpj/resources/img/product/${prdt.savefilename}"/>
					</td>
					
					<td>
						${prdt.prdtweight}  / ${prdt.prdtprice}
					</td>
					<td>
						<input style="width:50%;position:relative;left:25%;" type="number" name="orderqt" id="orderqt" value="${qt}" min="1">
					</td>
					<td id="totalvalue">
						
					</td>
					<td>
						<textarea id="odrequest" style="resize:none;"></textarea>
					</td>
					<td>
						<input type="button" id="orderbtn" value="주문">
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
