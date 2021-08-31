<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h2>[상품목록]</h2>
<div id="divCondition">
	<div style="float:left;">
		<select id="key">
			<option value="prod_id">상품코드</option>
			<option value="prod_name">상품이름</option>
		</select>
		<input type="text" id="word" placeholder="검색어"/>
		<select id="perpage">
			<option value="4">4개씩출력</option>
			<option value="8">8개씩출력</option>
			<option value="12">12개씩출력</option>
		</select>
		<span id="count"></span>
	</div>
	<div style="float:right;">
		<select id="order">
			<option value="prod_id">상품코드</option>
			<option value="prod_name">상품이름</option>
			<option value="price1">상품가격</option>
		</select>
		<select id="desc">
			<option value="desc">내림차순</option>
			<option value="asc">오름차순</option>
		</select>
	</div>
</div>
<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
	<tr class="title">
		<td width=100>상품코드</td>
		<td width=230>상품이름</td>
		<td width=150>업체이름</td>
		<td width=100>제조사</td>
		<td width=100>판매가</td>
		<td width=100>일반가</td>
		<td width=100>상품정보</td>
	</tr>
	{{#each array}}
	<tr class="row">
		<td>{{prod_id}}</td>
		<td>{{prod_name}}</td>
		<td>{{mall_name}}</td>
		<td>{{company}}</td>
		<td>{{price1}}</td>
		<td>{{price2}}</td>
		<td><button onClick="location.href='/pro/read?prod_id={{prod_id}}'">상품정보</button></td>
	</tr>
	{{/each}}
</script>
<div id="pagination">
	<button id="btnPre">◀</button>
	<span id="pageInfo"></span>
	<button id="btnNext">▶</button>
</div>
<script>
	var url="/pro/list.json";
</script>
<script src="/script.js"></script>


