<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h2>[ 네티즌 후기 ]</h2>
		<input type="text" id="query1" value="${vo.prod_name}" style="display:none"/>
		<select id="size1" style="float:left;margin-left:100px;">
			<option value="5">5개씩 보기</option>	
			<option value="10">10개씩 보기</option>
			<option value="15">15개씩 보기</option>
		</select>
		<br>
		<br>
<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
	<tr class="title">
		<td colspan=2 width=700>후기 제목</td>
	</tr>
	{{#each documents}}
		<tr class="row">
			<td>
				<a href="{{url}}" target=_blank>
				<img src="{{change thumbnail}}" thumbnail={{thumbnail}} width=200 height=150 style="display:block; margin: 0px auto;"/>
				</a>
           	</td>
			<td>
				<div style="width:400px;margin:0px auto;padding:5px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
				<a href="{{url}}" style="font-size:15px;" target=_blank>{{{title}}}</a>
				</div>
			</td>
		</tr>
	{{/each}}
</script>

<div>
	<button id="btnPre1">이전</button>
	<span id="pageInfo1"></span>
	<button id="btnNext1">다음</button>
</div>

<script>
Handlebars.registerHelper("change", function(thumbnail){	
	if(thumbnail==""){
		return 'http://placehold.it/200x150';
	}else { 	
		return thumbnail;	
	}
});
</script>

<script>
var url="https://dapi.kakao.com/v2/search/blog";
</script>
<script>
$("#tbl").on("hover",".row img",function(){
	$(this).css("zoom","1.5");
});
</script>
<script src="/script2.js"></script>