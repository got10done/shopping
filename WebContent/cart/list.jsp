<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<h2>[장바구니]</h2>
<c:if test="${cartList.size()==0 || cartList==null}" >
	<table>
		<tr class="title"><td width=800>장바구니가 비어있습니다.</td></tr>
	</table>
</c:if>
<c:if test="${cartList.size()>0}" >

		<table id="tbl">
	<tr class="title">
		<td><input type="checkbox" id="chkAll"/></td>
		<td width=100>상품코드</td>
		<td width=300>상품이름</td>
		<td width=100>상품단가</td>
		<td width=100>상품수량</td>
		<td width=100>상품금액</td>
		<td width=100>삭제</td>
	</tr>
	<c:forEach items="${cartList}" var="vo">
	<tr class="row">
		<td><input type="checkbox" class="chk"/></td>
		<td class="prod_id">${vo.prod_id}</td>
		<td class="prod_name">${vo.prod_name}</td>
		<td class="price">${vo.price}</td>
		<td>
			<input type="text" value="${vo.quantity}" class="quantity" size=1 style="background:white; text-align:center;">
			<button class="btnUpdate">수정</button>
		</td>
		<td class="sum">${vo.price*vo.quantity}</td>
		<td><button class="btnDelete">삭제</button>
	</tr>
	</c:forEach>
</table>
<div id="pagination">
	<button id="btnAll">전체상품주문</button>
	<button id="btnSel">선택상품주문</button>
</div>
</c:if>
<div id="orderInfo">
<h2>[ 주문정보 ]</h2>
	<table id="tblOrder"></table>
	<script id="tempOrder" type="text/x-handlebars-template">
			<tr class="title">
				<td width=100>상품코드</td>
 				<td width=400>상품명</td>
 				<td width=100>상품가격</td>
 				<td width=100>상품수량</td>
 				<td width=100>합계</td>
			</tr>
		{{#each .}}
 			<tr class="row" sum={{sum}}>
 				<td class="prod_id">{{prod_id}}</td>
 				<td>{{prod_name}}</td>
 				<td class="price">{{price}}</td>
 				<td class="quantity">{{quantity}}</td>
 				<td>{{sum}}</td>
				
 			</tr>
		{{/each}}
			<tr>
				<td class="title" colspan=3>결제하실 금액</td>
				<td colspan=2 id="total"></td>
			</tr>
	</script>
<br>
<h2>[ 주문자 정보 ]</h2>
<br>
<form name="frm">
	<table>
		<tr>
			<td class="title" width=150>주문자성명</td>
			<td width=370><input type="text" name="name" value="${user.name}" size=30 autofocus/></td>
		</tr>
		<tr>
			<td class="title" width=150>배송지 주소</td>
			<td width=370><input type="text" name="address" value="${user.address}" size=30/></td>
		</tr>
		<tr>
			<td class="title" width=150>이메일</td>
			<td width=370><input type="text" name="email" value="${user.email}" size=30/></td>
		</tr>
		<tr>
			<td class="title" width=150>연락처</td>
			<td width=370><input type="text" name="tel" value="${user.tel}" size=30/></td>
		</tr>
		<tr>
			<td class="title" width=150>결제방법</td>
			<td width=370>
				<input type="radio" name="paytype" value="0" checked>무통장
				<input type="radio" name="paytype" value="1">카드
			</td>
		</tr>
	</table>
<br/>
<input type="submit" value="주문하기"/>	
</form>


<br/>
<br/>
</div>
<script>

</script>
<script>
	$("#orderInfo").hide();
	$(frm).on("submit",function(e){
		e.preventDefault();
		var name=$(frm.name).val();
		var address=$(frm.address).val();
		var email=$(frm.email).val();
		var tel=$(frm.tel).val();
		var paytype=$("input[name='paytype']:checked").val();
		//alert(name+"\n"+address+"\n"+tel+"\n"+email+"\n"+paytype);
		if(!confirm("상품을 주문하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"/pur/insert",
			data:{"name":name,"address":address,"email":email,"tel":tel,"paytype":paytype},
			success:function(order_id){
				
				$("#tblOrder .row").each(function(){
					var prod_id=$(this).find(".prod_id").html();
					var price=$(this).find(".price").html();
					var quantity=$(this).find(".quantity").html();
					alert(prod_id+price+quantity);
					$.ajax({
						type:"post",
						url:"/pur/i_product",
						data:{"order_id":order_id,"prod_id":prod_id,"price":price,"quantity":quantity},
						success:function(){}
					});
				});
			}
		});
		alert("상품 주문이 완료되었습니다.");
		frm.action="/pur/list";  //submit 하면 가는 주소창 이름 rest api 이름
		frm.method="get";
		frm.submit();		//따로 submit 실행해야한다.
	});
	
	//전체상품주문 버튼 클릭 시
	$("#btnAll").on("click",function(){
		$("#orderInfo").show();
		var array=[];
		$("#tbl .row .chk").each(function(){
			var row=$(this).parent().parent();
			var prod_id=row.find(".prod_id").html();
			var prod_name=row.find(".prod_name").html();
			var price=row.find(".price").html();
			var quantity=row.find(".quantity").val();
			var sum=(price*quantity);
			var data={"prod_id":prod_id, "prod_name":prod_name,"price":price,"quantity":quantity,"sum":sum};
			array.push(data);
			console.log(array);
			var temp=Handlebars.compile($("#tempOrder").html());
			$("#tblOrder").html(temp(array));
			//결제하실 금액 계산
			var total=0;
			$("#tblOrder .row").each(function(){
				var sum=$(this).attr("sum");
				total=Number(total)+Number(sum);
			});
			$("#total").html(total+"원");
		});
	});
	$("#btnSel").on("click",function(){
		if($("#tbl .row .chk:checked").length==0){
			alert("주문할 상품을 선택하세요.");
			return;
		}
		$("#orderInfo").show();
		var array=[];
		$("#tbl .row .chk:checked").each(function(){
			var row=$(this).parent().parent();
			var prod_id=row.find(".prod_id").html();
			var prod_name=row.find(".prod_name").html();
			var price=row.find(".price").html();
			var quantity=row.find(".quantity").val();
			var sum=(price*quantity);
			//var sum=row.find(".sum").html();
			var data={"prod_id":prod_id, "prod_name":prod_name,"price":price,"quantity":quantity,"sum":sum};
			array.push(data);
			//console.log(array);
			var temp=Handlebars.compile($("#tempOrder").html());
			$("#tblOrder").html(temp(array));
			//결제하실 금액 계산
			var total=0;
			$("#tblOrder .row").each(function(){
				var sum=$(this).attr("sum");
				total=Number(total)+Number(sum);
			});
			$("#total").html(total+"원");
		});
		//location.href="/cart/olist";
	});
	//전체선택
	
	$("#chkAll").on("click",function(){
		if($(this).is(":checked")){
			$("#tbl .row .chk").each(function(){
				$(this).prop("checked", true);
			});
		}else{
			$("#tbl .row .chk").each(function(){
				$(this).prop("checked", false);
			});
		}		
	});
	
		
	//각행 체크버튼
	$("#tbl").on("click",".row .chk", function(){
		var num1=$("#tbl .row .chk").length;
		var num2=$("#tbl .row .chk:checked").length;
		if(num1==num2){
			$("#chkAll").prop("checked",true);
		}else $("#chkAll").prop("checked",false);
	});
	//장바구니 수량 수정버튼
	$("#tbl").on("click",".row .btnUpdate",function(){
		var row=$("#tbl .row .btnUpdate").parent().parent();
		var prod_id=row.find(".prod_id").html();
		var quantity=row.find(".quantity").val();
		$.ajax({
			type:"get",
			url:"/cart/update",
			data:{"prod_id":prod_id,"quantity":quantity},
			success:function(){
				location.href="/cart/list";
			}
		});
	});
	
	
	$("#tbl").on("click",".row .btnDelete",function(){
		var prod_id=$(this).parent().parent().find(".prod_id").html();
		if(!confirm(prod_id+" 상품을 장바구니 목록에서 삭제합니다.")) return;
		$.ajax({
			type:"get",
			url:"/cart/delete",
			data:{"prod_id":prod_id},
			success:function(){
				alert("해당 상품이 삭제되었습니다.");
				location.href="/cart/list";
			}
		});
	});
</script>
