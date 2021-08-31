<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h2>[업체목록]</h2>
<div id="divCondition">
	<div style="float:left;">
		<select id="key">
			<option value="mall_id">업체코드</option>
			<option value="mall_name">업체이름</option>
			<option value="address">업체주소</option>
			<option value="tel">전화번호</option>
		</select>
		<input type="text" id="word" placeholder="검색어"/>
		<select id="perpage">
			<option value="3">3개씩출력</option>
			<option value="6">6개씩출력</option>
			<option value="9" selected>9개씩출력</option>
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
			<option value="asc">오름차순</option>
		</select>
	</div>
</div>
<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
	<tr class="title">
		<td width=100>업체코드</td>
		<td width=100>업체코드</td>
		<td width=300>업체주소</td>
		<td width=150>업체전화</td>
		<td width=200>업체이메일</td>
	</tr>
	{{#each array}}
	<tr class="row">
		<td>{{mall_id}}</td>
		<td>{{mall_name}}</td>
		<td>{{address}}</td>
		<td>{{tel}}</td>
		<td>{{email}}</td>
	</tr>
	{{/each}}
</script>
<div id="pagination">
	<button id="btnPre">◀</button>
	<span id="pageInfo"></span>
	<button id="btnNext">▶</button>
</div>

<script>
	var url="/mall/list.json";
</script>
<script src="/script.js"></script>
