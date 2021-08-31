<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<br>
<h2>[ 전 상품 목록 ]</h2>
<br>
<input type="button" value="가전제품" id="go1"/>
<input type="button" value="도서/잡지" id="go2"/> 
<input type="button" value="생활가구" id="go3"/>  
<br id="stop1">
<h2>[ 가전제품목록 ]</h2>
<div id="divCondition33">
	<div style="float:left;">
		<select id="key33">
			<option value="prod_id">상품코드</option>
			<option value="prod_name">상품이름</option>
		</select>
		<input type="text" id="word33" placeholder="검색어"/>
		<select id="perpage33">
			<option value="4">4개씩출력</option>
			<option value="8">8개씩출력</option>
			<option value="12">12개씩출력</option>
		</select>
		<span id="count33"></span>
	</div>
	<div style="float:right;">
		<select id="order33">
			<option value="prod_id">상품코드</option>
			<option value="prod_name">상품이름</option>
			<option value="price1">상품가격</option>
		</select>
		<select id="desc33">
			<option value="desc">내림차순</option>
			<option value="asc">오름차순</option>
		</select>
	</div>
</div>
<div id="tbl33"></div>
<script id="temp33" type="text/x-handlebars-template">
	{{#each array}}
	<div class="box33" pid="{{prod_id}}" pname="{{prod_name}}" price={{price1}}>
		<img src="{{pntImage image}}" width=150 height=120 onClick="location.href='/pro/read?prod_id={{prod_id}}'"/>
		<div>{{prod_id}}</div>
		<div class="prod_name33">{{prod_name}}</div>
		<div>{{nf price1}}원</div>
		<div class="del{{prod_del}}33">{{status prod_del}}</div>
	</div>
	{{/each}}
</script>
<script>
	Handlebars.registerHelper("pntImage", function(image){
		if(!image){
			return "http://placehold.it/150x115";
		}else{
			return "/product/img/"+image;
		}
	});
	Handlebars.registerHelper("nf", function(price1){
		var regexp = /\B(?=(\d{3})+(?!\d))/g; 
		return price1.toString().replace(regexp, ",");
	});
	Handlebars.registerHelper("status", function(prod_del){
		if(prod_del==0){
			return "장바구니에 담기";
		}else{
			return "일시품절";
		}
	});
</script>
<div id="pagination33">
	<button id="btnPre33">◀</button>
	<span id="pageInfo33"></span>
	<button id="btnNext33">▶</button>
	
</div>
<script>
	var url="/pro/list.json";
	
	
	$("#tbl33").on("click", ".box33 .del033", function(){
		var box=$(this).parent();
		var prod_id=box.attr("pid");
		var prod_name=box.attr("pname");
		var price=box.attr("price");
		var quantity=1;
		var id="${user.id}";
		
		$.ajax({
			type:"get",
			url:"/cart/insert",
			data:{"prod_id":prod_id,"prod_name":prod_name,"price":price,"quantity":quantity},
			success:function(){
				
				if(id==""){
					alert("로그인을 하신 후 이용해 주시기 바랍니다.");
					return;
					
				}
				if(!confirm(prod_name +"을(를) 장바구니에 넣으실래요?")) return;
				if(!confirm("장바구니로 이동하실래요?")) return;
				location.href="/cart/list";
				
			}
		});
	});
	var apage=1;
	getList33();
	
	$("#word33").on("keydown",function(e){
		if(e.keyCode==13){
			apage=1; getList33();
		}	
	});
	
	$("#key33, #perpage33, #order33, #desc33").on("change", function(e){
		apage=1; getList33();	
	});
	
	$("#btnNext33").on("click", function(){
		apage++; getList33();
	});
	
	$("#btnPre33").on("click", function(){
		apage--; getList33();
	});
	
	function getList33(){
		var key=$("#key33").val();
		var word="E"// 가전제품 앞코드
		if($("#word33").val()!=""){ 	//product table에서 가전제품만 목록에 출력하도록
			word=$("#word33").val();
		}
		var perpage=$("#perpage33").val();
		var order=$("#order33").val();
		var desc=$("#desc33").val();
		$.ajax({
			type:"get",
			url:url,
			dataType:"json",
			data:{"key":key,"word":word,"page":apage,"perpage":perpage,"order":order,"desc":desc},
			success:function(result){
				//alert(result.count);
				var temp=Handlebars.compile($("#temp33").html());
				$("#tbl33").html(temp(result));
				$("#count33").html("검색수:<b>"+result.count+"</b>");
				var lastPage=Math.ceil(result.count/perpage);
				
				$("#pageInfo33").html(apage + "/" + lastPage);
				if(apage==1){
					$("#btnPre33").attr("disabled",true);
				}else{
					$("#btnPre33").attr("disabled",false);
				}
				if(apage==lastPage){
					$("#btnNext33").attr("disabled",true);
				}else{
					$("#btnNext33").attr("disabled",false);
				}
			}
		});
	}
		
</script>







<br>
<hr/>
<br id="stop2">
<!-- 홈의 도서/잡지목록 -->
<h2>[ 도서/잡지목록 ]</h2>
<br>
<div id="divCondition22">
	<div style="float:left;">
		<select id="key22">
			<option value="prod_id">상품코드</option>
			<option value="prod_name">상품이름</option>
		</select>
		<input type="text" id="word22" placeholder="검색어"/>
		<select id="perpage22">
			<option value="4">4개씩출력</option>
			<option value="8">8개씩출력</option>
			<option value="12">12개씩출력</option>
		</select>
		<span id="count22"></span>
	</div>
	<div style="float:right;">
		<select id="order22">
			<option value="prod_id">상품코드</option>
			<option value="prod_name">상품이름</option>
			<option value="price1">상품가격</option>
		</select>
		<select id="desc22">
			<option value="desc">내림차순</option>
			<option value="asc">오름차순</option>
		</select>
	</div>
</div>
<div id="tbl22"></div>
<script id="temp22" type="text/x-handlebars-template">
	{{#each array}}
	<div class="box22" pid="{{prod_id}}" pname="{{prod_name}}" price={{price1}}>
		<img src="{{pntImage image}}" width=150 height=120 onClick="location.href='/pro/read?prod_id={{prod_id}}'"/>
		<div>{{prod_id}}</div>
		<div class="prod_name22">{{prod_name}}</div>
		<div>{{nf price1}}원</div>
		<div class="del{{prod_del}}22">{{status prod_del}}</div>
	</div>
	{{/each}}
</script>
<script>
	Handlebars.registerHelper("pntImage", function(image){
		if(!image){
			return "http://placehold.it/150x115";
		}else{
			return "/product/img/"+image;
		}
	});
	Handlebars.registerHelper("nf", function(price1){
		var regexp = /\B(?=(\d{3})+(?!\d))/g; 
		return price1.toString().replace(regexp, ",");
	});
	Handlebars.registerHelper("status", function(prod_del){
		if(prod_del==0){
			return "장바구니에 담기";
		}else{
			return "일시품절";
		}
	});
</script>
<div id="pagination22">
	<button id="btnPre22">◀</button>
	<span id="pageInfo22"></span>
	<button id="btnNext22">▶</button>
	<button id="btnUp22" style="float:right;margin:10px;"> 맨 위로 </button>
</div>
<script>
	var url="/pro/list.json";
	
	
	$("#tbl22").on("click", ".box22 .del022", function(){
		var box=$(this).parent();
		var prod_id=box.attr("pid");
		var prod_name=box.attr("pname");
		var price=box.attr("price");
		var quantity=1;
		var id="${user.id}";
		
		$.ajax({
			type:"get",
			url:"/cart/insert",
			data:{"prod_id":prod_id,"prod_name":prod_name,"price":price,"quantity":quantity},
			success:function(){
				
				if(id==""){
					alert("로그인을 하신 후 이용해 주시기 바랍니다.");
					return;
					
				}
				if(!confirm(prod_name +"을(를) 장바구니에 넣으실래요?")) return;
				if(!confirm("장바구니로 이동하실래요?")) return;
				location.href="/cart/list";
				
			}
		});
	});
	var bpage=1;
	getList22();
	$('#btnUp22').click(function(){
		var offset = $('#homeTop').offset(); //선택한 태그의 위치를 반환
		$('html').animate({scrollTop : offset.top}, 400);
	});

	$("#word22").on("keydown",function(e){
		if(e.keyCode==13){
			bpage=1; getList22();
		}	
	});
	
	$("#key22, #perpage22, #order22, #desc22").on("change", function(e){
		bpage=1; getList22();	
	});
	
	$("#btnNext22").on("click", function(){
		bpage++; getList22();
	});
	
	$("#btnPre22").on("click", function(){
		bpage--; getList22();
	});
	
	function getList22(){
		var key=$("#key22").val();
		var word="B"// 책 앞코드
		if($("#word22").val()!=""){ 	//product table에서 책만 목록에 출력하도록
			word=$("#word22").val();
		}
		var perpage=$("#perpage22").val();
		var order=$("#order22").val();
		var desc=$("#desc22").val();
		$.ajax({
			type:"get",
			url:url,
			dataType:"json",
			data:{"key":key,"word":word,"page":bpage,"perpage":perpage,"order":order,"desc":desc},
			success:function(result){
				//alert(result.count);
				var temp=Handlebars.compile($("#temp22").html());
				$("#tbl22").html(temp(result));
				$("#count22").html("검색수:<b>"+result.count+"</b>");
				var lastPage=Math.ceil(result.count/perpage);
				
				$("#pageInfo22").html(bpage + "/" + lastPage);
				if(bpage==1){
					$("#btnPre22").attr("disabled",true);
				}else{
					$("#btnPre22").attr("disabled",false);
				}
				if(bpage==lastPage){
					$("#btnNext22").attr("disabled",true);
				}else{
					$("#btnNext22").attr("disabled",false);
				}
			}
		});
	}
		
</script>
<br>
<hr/>
<br id="stop3">
<!-- 홈의 생활가구목록 -->
<h2>[생활가구 목록]</h2>
<div id="divCondition11">
	<div style="float:left;">
		<select id="key11">
			<option value="prod_id">상품코드</option>
			<option value="prod_name">상품이름</option>
		</select>
		<input type="text" id="word11" placeholder="검색어"/>		
		<select id="perpage11">
			<option value="4">4개씩출력</option>
			<option value="8">8개씩출력</option>
			<option value="12">12개씩출력</option>
		</select>
		<span id="count11"></span>
	</div>
	<div style="float:right;">
		<select id="order11">
			<option value="prod_id">상품코드</option>
			<option value="prod_name">상품이름</option>
			<option value="price1">상품가격</option>
		</select>
		<select id="desc11">
			<option value="desc">내림차순</option>
			<option value="asc">오름차순</option>
		</select>
	</div>
</div>
<div id="tbl11"></div>
<script id="temp11" type="text/x-handlebars-template">
	{{#each array}}
	<div class="box11" pid="{{prod_id}}" pname="{{prod_name}}" price={{price1}}>
		<img src="{{pntImage image}}" width=150 height=120 onClick="location.href='/pro/read?prod_id={{prod_id}}'"/>
		<div>{{prod_id}}</div>
		<div class="prod_name11">{{prod_name}}</div>
		<div>{{nf price1}}원</div>
		<div class="del{{prod_del}}11">{{status prod_del}}</div>
	</div>
	{{/each}}
</script>
<script>
	Handlebars.registerHelper("pntImage", function(image){
		if(!image){
			return "http://placehold.it/150x115";
		}else{
			return "/product/img/"+image;
		}
	});
	Handlebars.registerHelper("nf", function(price1){
		var regexp = /\B(?=(\d{3})+(?!\d))/g; 
		return price1.toString().replace(regexp, ",");
	});
	Handlebars.registerHelper("status", function(prod_del){
		if(prod_del==0){
			return "장바구니에 담기";
		}else{
			return "일시품절";
		}
	});
</script>
<div id="pagination11">
	<button id="btnPre11">◀</button>
	<span id="pageInfo11"></span>
	<button id="btnNext11">▶</button>
	<button id="btnUp33" style="float:right;margin:10px;"> 맨 위로 </button>
</div>
<script>
	var url="/pro/list.json";
	
	//장바구니에 담기 버튼
	$("#tbl11").on("click", ".box11 .del011", function(){
		var box=$(this).parent();
		var prod_id=box.attr("pid");
		var prod_name=box.attr("pname");
		var price=box.attr("price");
		var quantity=1;
		var id="${user.id}";
		
		$.ajax({
			type:"get",
			url:"/cart/insert",
			data:{"prod_id":prod_id,"prod_name":prod_name,"price":price,"quantity":quantity},
			success:function(){
				
				if(id==""){
					alert("로그인을 하신 후 이용해 주시기 바랍니다.");
					return;
					
				}
				if(!confirm(prod_name +"을(를) 장바구니에 넣으실래요?")) return;
				if(!confirm("장바구니로 이동하실래요?")) return;
				location.href="/cart/list";
				
			}
		});
	});
	
	var page=1;
	getList11();
	$('#btnUp33').click(function(){
		var offset = $('#homeTop').offset(); //선택한 태그의 위치를 반환
		$('html').animate({scrollTop : offset.top}, 400);
	});
	$('#go1').click(function(){
		var offset = $('#stop1').offset(); //선택한 태그의 위치를 반환
		$('html').animate({scrollTop : offset.top}, 400);
	});
	$('#go2').click(function(){
		var offset = $('#stop2').offset(); //선택한 태그의 위치를 반환
		$('html').animate({scrollTop : offset.top}, 400);
	});
	$('#go3').click(function(){
		var offset = $('#stop3').offset(); //선택한 태그의 위치를 반환
		$('html').animate({scrollTop : offset.top}, 400);
	});
	$("#word11").on("keydown",function(e){
		if(e.keyCode==13){
			page=1; getList11();
		}	
	});
	
	$("#key11, #perpage11, #order11, #desc11").on("change", function(e){
		page=1; getList11();	
	});
	
	$("#btnNext11").on("click", function(){
		page++; getList11();
	});
	
	$("#btnPre11").on("click", function(){
		page--; getList11();
	});
	
	function getList11(){
		var key=$("#key11").val();
		var word="P"// 생활가구 앞코드
		if($("#word11").val()!=""){ 	//product table에서 생활가구만 목록에 출력하도록
			word=$("#word11").val();
		}
		//alert(word);
		var perpage=$("#perpage11").val();
		var order=$("#order11").val();
		var desc=$("#desc11").val();
		$.ajax({
			type:"get",
			url:url,
			dataType:"json",
			data:{"key":key,"word":word,"page":page,"perpage":perpage,"order":order,"desc":desc},
			success:function(result){
				//alert(result.count);
				
				var temp=Handlebars.compile($("#temp11").html());
				$("#tbl11").html(temp(result));
				$("#count11").html("검색수:<b>"+result.count+"</b>");
				var lastPage=Math.ceil(result.count/perpage);
				
				$("#pageInfo11").html(page + "/" + lastPage);
				if(page==1){
					$("#btnPre11").attr("disabled",true);
				}else{
					$("#btnPre11").attr("disabled",false);
				}
				if(page==lastPage){
					$("#btnNext11").attr("disabled",true);
				}else{
					$("#btnNext11").attr("disabled",false);
				}
			}
		});
	}
	
</script>

