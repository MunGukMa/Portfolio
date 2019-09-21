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
	$(function(){
		
	})
	function chkall()
	{
		var temp = document.getElementsByClassName('saveinfo');
		var key= document.getElementById('chkall');
		if(key.innerText=="전체선택")
		{
			for(var i =0;i<temp.length;i++)
			{
				temp[i].checked=true;
			}
			key.innerText="선택해제"
		} else
		{
			for(var i =0;i<temp.length;i++)
			{
				temp[i].checked=false;
			}
			key.innerText="전체선택"
		}
	}
	
	function savefile()
	{
		var temp = document.getElementsByClassName('saveinfo');
		var result=[];
		for(var i =0;i<temp.length;i++)
		{
			if(temp[i].checked=true)
			{
				result.push(temp[i].id);
			}
		}
		
		$.ajax
		({
			url:'/secondpj/seller/excelDown.do',
			type:'post',
			contentType:"application/json; charset=utf-8",
			data:JSON.stringify(result),
			success:function(){alert("파일을 C:\\test폴더에 우체국.xls로 저장하였습니다")},
			error:function(){alert("C:\\test폴더가 존재하는지 확인해주세요")}
		}) 
		
	}
	
	
	function detailship(obj)
	{
		var temp = obj.id;
		var num = ${prdt.prdtnum};
		$.ajax
		({
			url:'/secondpj/seller/detailship',
			type:'post',
			data:{"shipstate":temp,"prdtnum":num},
			success:function(result)
			{
				$('#detailship').append('<tr><th colspan="10"><h1>[배송상태별 조회]</h1></th></tr><tr><th colspan="10"><a  href="<c:url value="excelDown.do"/>">낄낄낄</a></th></tr><tr><th colspan="10">'+
						'<input type="button" onclick="savefile()" value="파일저장"></th></tr><tr id="dstitle">'+
						'<th><a id="chkall" onclick="chkall()">전체선택</a></th><th>주문번호</th><th>주문일자</th><th>상품번호</th>'+
						'<th>상품이름</th><th>주문수량</th><th>구매자이름</th>'+
						'<th>구매자주소</th><th>구매자핸드폰번호</th><th>요청사항</th></tr>');
				$(result).each(function(index,item)
						{
							$('#detailship').append('<tr class="dsbody"><td>'+
									'<input type="checkbox" class="saveinfo" id="'+item.ordernum+'"></td><td>'+
									item.ordernum+'</td><td>'+item.orderdate+'</td><td>'+
									item.prdtnum+'</td><td>'+item.prdtname+'</td><td>'+
									item.orderqt+'</td><td>'+item.buyerid+'</td><td>'+
									item.buyeraddress+'</td><td>'+item.buyertel+'</td><td>'+
									item.request+'</td></tr>');
						});
				
			},
			error:function(){alert("ee")}
		})
	}
	
</script>
<style>
	table
	{
		width:100%;
		text-align:center;
	}
	th
	{
		text-align:center;
	}
	td
	{
		text-align:center;
	}
</style>
</head>
<body>
	<div class="wrapper">
		<table id="detailtab" border="1">
			<tr><th colspan="10"><h1>[상품 자세히보기]</h1></th></tr>
			<tr>
				<th>
					상품이름
				</th>
				<th>
					상품등록일
				</th>
				<th>
					상품판매가
				</th>
				<th>
					총 판매금액 (총판매량)
				</th>
				<th>
					총 주문건수
				</th>
				<th>
					배송완료 수
				</th>
				<th>
					배송중 수
				</th>
				<th>
					배송준비 수
				</th>
				<th>
					결제완료 수
				</th>
				<th>
					주문확인 수
				</th>
			</tr>
			<tr>
				<th>
					${prdt.prdtname}
				</th>
				<th>
					${prdt.regdate}
				</th>
				<th>
					${prdt.prdtprice}
				</th>
				<th>
					${totalqt*prdt.prdtprice} (${totalqt})
				</th>
				<th>
					<input type="button" class="shipbtn" onclick="detailship(this)" id="all" value="${prdt.prdtorder}">
				</th>
				<th>
					<input type="button" class="shipbtn" onclick="detailship(this)" id="배송완료" value="${totalend}">
				</th>
				<th>
					<input type="button" class="shipbtn" onclick="detailship(this)" id="배송중" value="${totalpro}">
				</th>
				<th>
					<input type="button" class="shipbtn" onclick="detailship(this)" id="배송준비" value="${totalready}">
				</th>
				<th>
					<input type="button" class="shipbtn" onclick="detailship(this)" id="결제완료" value="${totalpay}">
				</th>
				<th>
					<input type="button" class="shipbtn" onclick="detailship(this)" id="주문확인" value="${totalconf}">
				</th>
			</tr>
		</table>	
		
		<table id="detailship" border="1"></table>
	</div>
</body>
</html>