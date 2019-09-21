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
		setlist();
		$('#loginbtn').on('click',login);
		$('#signupbtn').on('click',signup);
		$('#editprofile').on('click',editprofile);
		$('#searchkey').on('click',setlist);
		$('#callmypage').on('click',callmypage);
		
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
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	
	var tabbody;
	var tabtitle;
	function clearbody()
	{
		tabbody=$('.tabbody');
		$('.tabbody').remove();
	}
	function cleartitle()
	{
		tabtitle=$('#tabtitle');
		$('#tabtitle').remove();
	}
	function returnlist()
	{
		
	}
	
	function setptitle()
	{
		cleartitle();
		$('#mylisttap').append('<tr id="tabtitle"><th>상품번호</th><th id="ptype">'+
			'<a onclick="sortplist(this)">카테고리<b>▼</b></a></th><th id="pname">'+
			'<a onclick="sortplist(this)">상품이름<b>▼</b></a></th>'+
			'<th id="pprice"><a onclick="sortplist(this)">판매가격<b>▼</b></a></th>'+
			'<th id="regdate"><a onclick="sortplist(this)">등록일<b>▼</b></a></th>'+
			'<th id="porder"><a onclick="sortplist(this)">총 주문수<b>▼</b></a></th>'+
			'<th id="pview"><a onclick="sortplist(this)">조회수<b>▼</b></a></th>'+
			'<th id="ptotal"><a onclick="sortplist(this)">총 판매금액<b>▼</b></a></th></tr><span id="pdarea">');
	}
	
	function setpbody(result)
	{
		clearbody();
		$(result).each(function(index,item)
		{
			$('#mylisttap').append('<tr id="tabbody" class="tabbody"><td>'+
					(index+1)+'</td><td>'+item.prdttype+'</td><td>'+
					item.prdtname+'</td><td>'+
					item.prdtweight+'/'+item.prdtprice+'</td><td>'+
					item.regdate+'</td><td>'+
					'<input type="button" onclick="detailprdt(this)" id="'+item.prdtnum+'" value="'+item.prdtorder+'"></td><td>'+
					item.prdtview+'</td><td>'+
					item.prdtprice*item.prdtorder+'</td><input type="hidden" id="truenum" value="'+item.prdtnum+'"/></td></tr>');
			
		})
		$('#mylisttap').append('</span>');
	}
	function detailprdt(obj)
	{
		var num = obj.id;
		window.open("/secondpj/seller/detailform?prdtnum="+num,"_blank","width=1200,height=400,left=100");
	}
	
	function setplist()
	{
		$.ajax
		({
			url:'/secondpj/seller/setplist',
			type:'get',
			success:function(result)
			{
				setptitle();
				setpbody(result);
			},
			error:function()
			{
				alert("error");
			}
		})
	}
	function setstitle()
	{
		cleartitle();
		$('#mylisttap').append('<tr id="tabtitle"><th>선택</th><th id="ordernum">주문번호</th><th id="pname">'+
			'<a onclick="sortplist(this)">상품이름<b>▼</b></a></th>'+
			'<th id="pprice"><a onclick="sortplist(this)">주문일<b>▼</b></a></th>'+
			'<th id="regdate"><a onclick="sortplist(this)">주문수량<b>▼</b></a></th>'+
			'<th id="porder"><a onclick="sortplist(this)">총 주문금액<b>▼</b></a></th>'+
			'<th id="pview"><a onclick="sortplist(this)">주문진행사항<b>▼</b></a></th>'+
			'<th id="pview"><a onclick="sortplist(this)">구매자 요청사항<b>▼</b></a></th>'+
			'</tr>');
	}
	function setslist()
	{
		clearbody();	
		setstitle();
		$.ajax
		({
			url:'/secondpj/seller/setslist',
			type:'post',
			success:function(result)
			{
				$(result).each(function(index,item)
						{
							$('#mylisttap').append('<tr id="tabbody" class="tabbody">'+
							'<td><input type="checkbox" class="sbox" value="'+item.ordernum+'"></td><td>'+
							item.ordernum+'</td><td>'+
							item.prdtname+'</td><td>'+
							item.orderdate+'</td><td>'+
							item.orderqt+'</td><td>'+
							(item.orderqt*item.prdtprice)+'</td><td>'+
							item.shipstate+'</td><td>'+
							item.request+'<input type="hidden" id="truenum" value="'+item.prdtnum+'"/></td></tr>');
						});
			},
			error:function(result){alert('eee');}
		})
	}
		
	function setlist()
	{
		
		if($('#keyword').val()=="shippingstate")
		{
			setslist();
			return;
		} else setplist();
	}
	
	
	var temp;
	function sortplist(obj)
	{
		temp=obj;
		var value = obj.innerText;
		var searchkey;
		var sorttype;
		if(value.startsWith("카"))
		{
			searchkey="prdttype";
		} else if(value.startsWith("판"))
		{
			searchkey="prdtprice";
		} else if(value.startsWith("등"))
		{
			searchkey="regdate";
		} else if(value.startsWith("주"))
		{
			searchkey="prdtorder";
		} else if(value.startsWith("조"))
		{
			searchkey="prdtview";
		} else if(value.startsWith("상"))
		{
			searchkey="prdtname";
		} else if(value.startsWith("총"))
		{
			searchkey="prdtorder*prdtprice";
		}
		if(value.endsWith("▼"))
		{
			sorttype="desc";
			obj.firstElementChild.innerText="▲";

		} else 
		{
			sorttype="asc";
			obj.firstElementChild.innerText="▼";
		}
		
		
		
		$.ajax
		({
			url:'/secondpj/seller/sortlist',
			type:'post',
			contentType:'application/json; charset=utf-8',
			data:JSON.stringify({"searchkey":searchkey,"sorttype":sorttype}),
			success:function(result){setpbody(result)},
			error:function(){alert('fail');}
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
	#mylistdiv
	{
		position:relative;
		left:20%;
		width:60%;
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
		<!-- 여기까지 navi -->
		
		<div id="mylistdiv">
			<table id="mylisttap" border="1">
				<thead>
					<tr>
						<th colspan="10">
							<h1>주문내역 조회</h1>
							
						</th>
					</tr>
					<tr>
						<td style="width:15%;text-align:right;"colspan="10">
							<select id="keyword">
								<option value="all">판매상품전체조회</option>
								<option value="shippingstate">배송별 조회</option>
							</select>
							<input type="button" id="searchkey" value="조회">
						</td>
					</tr>
				</thead>
			</table>				
		
		</div>
	</div>
</body>
</html>