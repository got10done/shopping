<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<link rel="stylesheet"  href="../style2.css">	


	<h2>[업체목록]</h2>
	<div id="divCondition"style="display:none;">
		<div style="float:left;display:none;">
			<select id="key">
				<option value="mall_id">업체코드</option>
				<option value="mall_name">업체이름</option>
				<option value="address">업체주소</option>
				<option value="tel">전화번호</option>
			</select>
			<input type="text" id="word" value="P"/>
			<select id="perpage">
				<option value="3">3개씩출력</option>
				<option value="6">6개씩출력</option>
				<option value="10" selected>10개씩출력</option>
			</select>
			<span id="count"></span>
		</div>
		<div style="float:right;">
			<select id="order">
				<option value="mall_id">업체코드</option>
				<option value="mall_name">업체이름</option>
				<option value="address">업체주소</option>
				<option value="tel">전화번호</option>
			</select>
			<select id="desc">
				<option value="desc">내림차순</option>
				<option value="asc" selected>오름차순</option>
			</select>
		</div>
	</div>
	<table id="tbl"></table>
	<script id="temp" type="text/x-handlebars-template">
	<tr class="title" style="background-color:white;">
		<td width=100>업체코드</td>
		<td width=100>업체명</td>
		<td width=100>업체전화</td>

	</tr>
	{{#each array}}
	<tr class="row" style="cursor:pointer;">
		<td class="mall_id">{{mall_id}}</td>
		<td class="mall_name">{{mall_name}}</td>
		<td>{{tel}}</td>

	</tr>
	{{/each}}
	</script>
	<div id="pagination">
		<button id="btnPre">◀</button>
		<span id="pageInfo"></span>
		<button id="btnNext">▶</button>
	<br/>
	<br/>
	<button id="btnClose" style="border:none;padding:0px;"> ✖ </button>
	</div>


<script>
	var url="/mall/list.json";
	//클릭 시 값 부여하기
	$("#tbl").on("click",".row",function(){
		var mall_id=$(this).find(".mall_id").html();	//pcode 클래스를 찾아서 그 html 값을 
		var mall_name=$(this).find(".mall_name").html();
		$(opener.frm.mall_id).val(mall_id);		//pcode값을 넣는다. frm의 advisor에 넣는다(parameter도 advisor로 호출)
		$(opener.frm.mall_name).val(mall_name); //opener가 다른 창하고 연결해주는 역할
		window.close();
	});
	$("#btnClose").on("click",function(){
		window.close();
	});
</script>
<script src="/script.js"></script>
