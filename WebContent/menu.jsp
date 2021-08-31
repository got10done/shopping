<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${user.id==null}">	
	<div class="menuItem">
		<div class="dropdown2">
			  <input type="button" value="상품목록" id="menuItem" style="padding:5px;display:inline;width:80px;" onClick="location.href='/home'"/>
			  <div class="dropdown2-content">
			    	<span style="width:160px;">
			    	<a href="/home1" style="text-align:center;margin:0px;padding:5px;display:inline-block;">생활가구</a>
			    	<a href="/home2" style="text-align:center;margin:0px;padding:5px;display:inline-block;">도서/잡지</a>
			    	<a href="/home3" style="text-align:center;margin:0px;padding:5px;display:inline-block;">가전제품</a>
			    	</span>
			  </div>
		</div>
	</div>
	<input type="button" value="고객센터" style="display:inline;padding:5px;width:80px;" onClick="location.href='/pro/client'"/>
</c:if>

<c:if test="${user.id=='admin'}">
	<input type="button" value="업체목록" style="display:inline;padding:5px;width:80px;" onClick="location.href='/mall/list'"/>
	<div class="menuItem">
		<div class="dropdown2">
			  <input type="button" value="상품목록" id="menuItem" style="padding:5px;display:inline;width:80px;" onClick="location.href='/home'"/>
			  <div class="dropdown2-content">
			    	<span style="width:160px;">
			    	<a href="/home1" style="text-align:center;margin:0px;padding:5px;display:inline-block;">생활가구</a>
			    	<a href="/home2" style="text-align:center;margin:0px;padding:5px;display:inline-block;">도서/잡지</a>
			    	<a href="/home3" style="text-align:center;margin:0px;padding:5px;display:inline-block;">가전제품</a>
			    	</span>
			  </div>
		</div>
	</div>
	<div class="menuItem">
		<div class="dropdown3">
			  <input type="button" value="상품등록" id="menuItem" style="padding:5px;display:inline;width:80px;" />
			  <div class="dropdown3-content">
			    	<span style="width:160px;">
			    	<a href="/pro/insert1" style="text-align:center;margin:0px;padding:5px;display:inline-block;">생활가구</a>
			    	<a href="/pro/insert2" style="text-align:center;margin:0px;padding:5px;display:inline-block;">도서/잡지</a>
			    	<a href="/pro/insert3" style="text-align:center;margin:0px;padding:5px;display:inline-block;">가전제품</a>
			    	</span>
			  </div>
		</div>
	</div>
	<input type="button" value="주문목록" style="display:inline;padding:5px;width:80px;" onClick="location.href='/pur/list'"/>
	<input type="button" value="장바구니" style="display:inline;padding:5px;width:80px;" onClick="location.href='/cart/list'"/>
	<input type="button" value="고객센터" style="display:inline;padding:5px;width:80px;" onClick="location.href='/pro/client'"/>
</c:if>
<c:if test="${user.id!='admin' && user.id!=null}">
	<div class="menuItem">
		<div class="dropdown2">
			  <input type="button" value="상품목록" id="menuItem" style="padding:5px;display:inline;width:80px;" onClick="location.href='/home'"/>
			  <div class="dropdown2-content">
			    	<span style="width:160px;">
			    	<a href="/home1" style="text-align:center;margin:0px;padding:5px;display:inline-block;">생활가구</a>
			    	<a href="/home2" style="text-align:center;margin:0px;padding:5px;display:inline-block;">도서/잡지</a>
			    	<a href="/home3" style="text-align:center;margin:0px;padding:5px;display:inline-block;">가전제품</a>
			    	</span>
			  </div>
		</div>
	</div>
	<input type="button" value="주문목록" style="display:inline;padding:5px;width:80px;" onClick="location.href='/pur/list'"/>
	<input type="button" value="장바구니" style="display:inline;padding:5px;width:80px;" onClick="location.href='/cart/list'"/>
	<input type="button" value="고객센터" style="display:inline;padding:5px;width:80px;" onClick="location.href='/pro/client'"/>
</c:if>


<div style="float:right;margin-top:10px;">
	<c:if test="${user.id==null}">
		<button id="register1" style="background:lemonchiffon;">Register</button>
		<button id="login">Login</button>
		
	</c:if>
	<c:if test="${user.id!=null}">
		안녕하세요, <b>${user.name}님</b>
		<button id="logout">Logout</button>
	</c:if>
</div>
<div id="darken-background">
	<div id="lightbox">
		<form name="frmLogin" class="box2" action="login" method="post">
		  <h1>Login</h1>
		  <input type="text" name="id" placeholder="Username" />
		  <input type="password" name="pass" placeholder="Password" />
		  <input type="submit" value="Login">
		</form>
		<button id="btnClose">close</button>
	</div>

</div>	
<script>
	$("#login").on("click",function(){

		$("#darken-background").show();
		$(document).keydown(function(event) {
		    if ( event.keyCode == 27 || event.which == 27 ) {
		    	$("#darken-background").hide();
		    }
		});
	});
	$("#register1").on("click",function(){
		location.href="/user/register";
	});
	$(frmLogin).on("submit",function(e){
		e.preventDefault();
		$("#darken-background").show();
		var id=$(frmLogin.id).val();
		var pass=$(frmLogin.pass).val();
		$.ajax({
			type:"post",
			url:"/user/login",
			data:{"id":id,"pass":pass},
			success:function(result){
				
				if(result==1){
					alert("로그인 성공");
					location.href="/home";
				}else if(result==0){
					alert("아이디가 존재하지 않습니다.");
				}else{
					alert("비밀번호가 일치하지 않습니다.");
				}
			}
		});
	});
	$("#logout").on("click",function(){
		if(!confirm("로그아웃 하시겠습니까?")) return;
		location.href="/user/logout";
	});
	$("#btnClose").on("click",function(){
		$("#darken-background").hide();
		$(frmLogin.id).val("");
		$(frmLogin.pass).val("");
	});
	
</script>