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
		$('#signupbtn').on('click',signup);
		$('#callmypage').on('click',callmypage);
	})
	function callmypage()
	{
		location.href="/secondpj/callmypage";
	}
	function clearlist()
	{
		$('#rightcontent').remove();
		$('#leftcontent').remove();
	}
	
	function savelist()
	{
		rightcontent = $('#rightcontent'); 
		leftcontent = $('#leftcontent');
	}
	
	function returnlist()
	{
		$('#contentarea').append(rightcontent);
		$('#contentarea').append(leftcontent);
		alert("잠시후 다시 시도해 주세요");
	}
	
	function makediv()
	{
		$('#contentarea').append('<div id="leftcontent" class="leftcontent"></div>');
		$('#contentarea').append('<div id="rightcontent" class="rightcontent"></div>');
	}
	
	function setlist(result)
	{
		clearlist();
		makediv();
		$(result).each(function(index,item)
		{
			if(index%2!=1)
			{
				$('#leftcontent').append('<div class="product" id="product'+item.prdtnum+'">'+
				'<a href="/secondpj/productread?prdtnum='+item.prdtnum+'">'+
				'<img src="/secondpj/resources/img/product/'+item.savefilename+'"/>'+
				'<div id="beable'+item.prdtnum+'"><p>'+item.prdtname+'</p>'+
				'<p>'+item.prdtweight+' / '+item.prdtprice+'</p></div></a></div>');
			}else
			{
				$('#rightcontent').append('<div class="product" id="product'+item.prdtnum+'">'+
				'<a href="/secondpj/productread?prdtnum='+item.prdtnum+'">'+
				'<img src="/secondpj/resources/img/product/'+item.savefilename+'"/>'+
				'<div id="beable'+item.prdtnum+'"><p>'+item.prdtname+'</p>'+
				'<p>'+item.prdtweight+' / '+item.prdtprice+'</p></a></div>');
			}
		})
	}
	
	function setmedal(result)
	{
		$(result).each(function(index,item)
		{
			if(index>5) return;
			$('#beable'+item.prdtnum).prepend('<img style="position:absolute; width:15%;height:10%;" src="/secondpj/resources/img/main/medal'+index+'.png"/>');
		});
	}
	
	
 	function setmainlist()
	{
		$.ajax
		({
			url:"/secondpj/setmainlist",
			type:"get",
			data:{'prdttype':$('#sortkey').val()},
			dataType:"json",
			success:function(result)
			{
				setlist(result);
				setmedal(result);
			},
			error:function()
			{
				returnlist();
			}
		});
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
//////////////////////////////////////////////////////////////////////////////////////////////////	
	
	
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
		
		
		
	</div>
</body>
</html>
