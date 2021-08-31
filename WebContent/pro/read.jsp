<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<br>
<h2>[ 상품정보 ]</h2>
<br>
<form name="frm" enctype="multipart/form-data">
     <table>
        <tr>
           <td width=100 class="title">상품코드</td>
           <td width=100><input type="text" name="prod_id"  size=6  value="${vo.prod_id}" style="text-align:center;font-weight:bold;" readonly/></td>
           <td width=100 class="title">제조/수입원</td>
           <td width=100><input type="text" name="company"  size=10 value="${vo.company}"  style="text-align:center;"/></td>
           <td width=100 class="title">판매가격</td>
           <td width=100><input type="text" name="price1"  size=5 value="${vo.price1}"  style="text-align:center;"/></td>
        </tr>
        <tr>
           <td width=100 class="title">업체정보</td>
           <td width=600 colspan=3>
           		<input type="text" name="mall_id" value="${vo.mall_id}" size=6 style="text-align:center;" readonly/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           		<input type="text" name="mall_name" value="${vo.mall_name}" size=32 style="text-align:center;" readonly/>
           </td>
           <td width=100 class="title">일반가격</td>
           <td width=100><input type="text" name="price2" size=5 value="${vo.price2}" style="text-align:center;"/></td>
        </tr>
        <tr>
           <td width=100 class="title">상품이름</td>
           <td width=700 colspan=3><input type="text" name="prod_name" size=50 value="${vo.prod_name}" style="text-align:center;"/></td>
           <td width=100 class="title">판매상태</td>
           <td width=100>
           		<input type="checkbox" name="prod_del" style="width:10px;zoom:2;" value="${vo.prod_del}" <c:out value="${vo.prod_del=='1'? 'checked':''}"/> />
           		<span id="status" style="padding:5px;"></span>
           </td>
        </tr>
        <tr>
           <td width=100 class="title">상품이미지</td>
           <td colspan=3>
           		<c:if test="${vo.image==null}">
           			<img src="http://placehold.it/200x150" width=200 height=150 id="image" style="cursor:pointer;display:block; margin: 0px auto;margin-top:40px;">
           		</c:if>
           		<c:if test="${vo.image!=null}">
           			<img src="/product/img/${vo.image}" width=200 height=150 id="image" style="cursor:pointer;display:block; margin: 0px auto;margin-top:40px;"/>
           		</c:if>
              
              <input type="file" name="image" size=3 accept="image/*" style="visibility:hidden;float:right;"/>
              
           </td>
           <td width=100 class="title">상품평점</td>
           <td width=100>
           		<span id="scoreAvg" style="color:red;font-weight:bold;font-size:20px;"></span>
           </td>
        </tr>
        <tr>
           <td width=100 class="title">상품설명</td>
           <td width=700 colspan=5>
             <textarea rows="10" cols="91" name="detail" style="padding:10px;" >${vo.detail}</textarea>
           </td>
        </tr>                           
     </table>

     <br>
     <div id="pagination">
        <input type="submit" value="상품수정" id="btnEdit"/> 
        <input type="reset" value="초기화" id="btnReset"/> 
        <input type="button" value="상품삭제" id="btnDelete"/> 
        <input type="button" value="이전목록" onClick="location.href='list'"/>
        <div class="dropdown">
		  <input type="button" value="장바구니에 담기" id="btnCartIn" style="background:lemonchiffon;color:darkslategrey;border:2px solid lightgrey;"/>
		  <div class="dropdown-content">
		    	<span style="width:200px;">
		    	<input type="number" id="quantities" placeholder=" 수량 입력" size=3/>
		    	</span>
		   
		  </div>
		</div>
      
        <input type="button" value="상품후기" id="btnReview"/> 
        <input type="button" value="상품문의" id="btnQuestion"/>  
     </div>
     
 </form> 
<br>
<br>

<hr id="proBlog"/>
<br>
<jsp:include page="${blogPage}"></jsp:include>
<br>
<br>

<hr id="proReview"/>

<br>
<h2>[ 상품 후기 ]</h2>
	<div id="sk">
	
		<div class="star-box">
				<span class="star star_left"></span>
				<span class="star star_right"></span>

				<span class="star star_left"></span>
				<span class="star star_right"></span>

				<span class="star star_left"></span>
				<span class="star star_right"></span>

				<span class="star star_left"></span>
				<span class="star star_right"></span>

				<span class="star star_left"></span>
				<span class="star star_right"></span>
				별점 : <span id="score"></span> 점
		</div>
		<input type="text" id="contents" placeholder=" 댓글 입력"/>
		<button id="btnInsert"> 입 력 </button>
		
	</div>
	<br>
	<b>총 댓글 수 : <span id="count"></span> 개</b>

		<br>
		<br>
		<div id="replyList"></div>
	
		<script id="replyTemp" type="text/x-handlebars-template">

		{{#each array}}
			<div class="replyBox" style="font-size:15px;" writer={{writer}} rn={{rn}} editChk={{editchk}}>
				 	<div class="replyMenu" score={{score}} style="font-size:15px;text-align:left;overflow:hidden;padding:10px;width:700px;margin:0px auto;border:1px solid lightgrey; box-shadow:0px 0px 10px lightgrey;">
						<span style="padding:5px;"><b>{{rn}}</b> &nbsp;&nbsp;&nbsp;{{hide rid}} &nbsp;&nbsp;&nbsp;{{rdate}}</span> 
						<span class="editChk" style="{{chk ec}}" editChk={{editchk}}>(수정됨)</span>
						&nbsp;&nbsp;&nbsp; <b>평점 : </b>
						<span class="replyScore" style="color:green;font-weight:bold;font-size:20px;"><b>{{score}} 점</b></span>
						<button class="btnDelete" rn={{rn}} rid={{rid}} writer={{writer}} style="{{hiddener writer}}float:right;padding:5px;">후기 삭제 </button>
						<button class="btnEdit" rn={{rn}} rid={{rid}} score={{score}} writer={{writer}} content={{content}} style="{{hidden writer}}float:right;padding:5px; border-radius:20px;">후기 수정</button>
						

					</div>
					{{writer}} : 
					<input type="text" class="replyContent" writer={{writer}} value="{{content}}" style="font-size:15px;text-align:center;background:none; border:2px solid black; border-radius:0px; margin:10px;" disabled/>
					<div class="star2-box" style="display:none">
						별점 수정: <span class="star2 star_left"></span>
						<span class="star2 star_right"></span>

						<span class="star2 star_left"></span>
						<span class="star2 star_right"></span>

						<span class="star2 star_left"></span>
						<span class="star2 star_right"></span>

						<span class="star2 star_left"></span>
						<span class="star2 star_right"></span>

						<span class="star2 star_left"></span>
						<span class="star2 star_right"></span>
						<span class="score2"></span> 점
					</div>					
					<br>
					<button class="btnEditor" score={{score}} rid={{rid}} writer={{writer}} content={{content}} style="display:none;padding:5px;border-radius:20px;">수정하기</button>
					<button class="editClose" rid={{rid}} writer={{writer}} content={{content}} style="display:none;padding:5px;border-radius:20px;">수정취소</button>
					<br/>
			</div>
		{{/each}}
		</script>
<div id="pagination3">
	<button id="btnPre"> 이 전 </button>
	<span id="infoPage"></span>
	<button id="btnNext"> 다 음 </button>
	<button id="btnUp" style="float:right;margin:10px;"> 맨 위로 </button>
</div>

<script>
	var id="${user.id}";
	Handlebars.registerHelper("hidden", function(writer){		//수정버튼은 자기것만 보이도록(핸들바의 특정 메서드를 씀. hidden이라는 이름으로 writer를 매개변수로	
		if(id=="admin" || id!=writer){
			return "display:none;";
		}else if(id==writer){	
			return ;	
		}
	});
	Handlebars.registerHelper("hiddener", function(writer){		//삭제버튼은 관리자와 자기것만 보이도록	
		if(id=="admin" || id==writer){
			return ;
		}else if(id!=writer){	
			return "display:none;";	
		}
	});
	Handlebars.registerHelper("chk", function(ec){			
		var editChk=$(this).attr("editChk");
		if(editChk==1){
			return;
		}else return "display:none;";	
		
	});
	Handlebars.registerHelper("hide", function(rid){
		var id="${user.id}";
		if(id!="admin"){
			return;
		}else{
			return "(rid : "+rid+")";
		}
	});

</script>
<br>
<br>
<hr id="proQuestion"/>
<br>
<jsp:include page="${qnaPage}"/>
<script>
	var pid="${vo.prod_id}";		//현재상품 id
	var rpage=1;
	var replyEditChk=0;
	getList();
	var id="${user.id}";

	if(id==""){
		$("#sk").css("display","none");
	}
	
	if(id!="admin"){
		
		$(frm.prod_id).prop("disabled",true);
		$(frm.company).prop("disabled",true);
		$(frm.price1).prop("disabled",true);
		$(frm.mall_id).prop("disabled",true);
		$(frm.mall_name).prop("disabled",true);
		$(frm.price2).prop("disabled",true);
		$(frm.prod_name).prop("disabled",true);
		$(frm.prod_del).prop("disabled",true);
		$(frm.image).prop("disabled",true);
		$(frm.detail).prop("disabled",true);

		$("#btnEdit").css("display","none");
		$("#btnDelete").css("display","none");
		$("#btnReset").css("display","none");
	
	}
	
	
	//상품후기, 상품 문의 버튼 누르면 스크롤 이동 - 인터넷참고
	$(document).ready(function(){
		$('#btnReview').click(function(){
			var offset = $('#proReview').offset(); //선택한 태그의 위치를 반환
			$('html').animate({scrollTop : offset.top}, 400);
		});
		$('#btnQuestion').click(function(){
			var offset = $('#proQuestion').offset(); //선택한 태그의 위치를 반환
			$('html').animate({scrollTop : offset.top}, 400);
		});
		$('#btnUp').click(function(){
			var offset = $('#homeTop').offset(); //선택한 태그의 위치를 반환
			$('html').animate({scrollTop : offset.top}, 400);
		});
		$('#btnUp2').click(function(){
			var offset = $('#homeTop').offset(); //선택한 태그의 위치를 반환
			$('html').animate({scrollTop : offset.top}, 400);
		});
	});
	
	
	//상품정보 이미지 클릭 시 동작
	$("#image").on("click",function(){
		$(frm.image).click();
	});
	//판매상태 내용바꿔주기
	if($(frm.prod_del).is(":checked")){
		$("#status").html("일시품절");
		$("#status").css("color","red");
		$("#status").css("font-weight","bold");
	}else{
		$("#status").html("판매중");
		$("#status").css("color","green");
// 		$("#status").css("font-weight","bold");
	}
	//판매중지 체크박스를 체크한 경우
	$(frm.prod_del).on("click",function(){
		if($(frm.prod_del).is(":checked")){
			$(frm.prod_del).val("1");
			alert("판매가 중지되었습니다.");
			$("#status").html("일시품절");
			$("#status").css("color","red");
		}else{
			$(frm.prod_del).val("0");
			alert("판매가 시작되었습니다.");
			$("#status").html("판매중");
			$("#status").css("color","green");
		}
		
	});
	//상품수정하기
	$(frm).on("submit",function(e){
		e.preventDefault();
		if(!confirm("상품을 수정하시겠습니까?")) return;
			frm.action="/pro/update";
			frm.method="post";
			frm.submit();
			alert("상품이 수정되었습니다.");
	});
	//장바구니에 담기 버튼
	$("#btnCartIn").on("click",function(){
		var idC="${user.id}";
		if(idC==""){
			alert("로그인을 하신 후 이용해 주시기 바랍니다.");
			$("#quantities").val("");
			return;
		}
		
		getCart();
	});
	function getCart(){
		var prod_idC="${vo.prod_id}";
		var prod_nameC="${vo.prod_name}";
		var priceC="${vo.price1}"
			var quantityC=$("#quantities").val();
		$.ajax({
			type:"get",
			url:"/cart/insert",
			data:{"prod_id":prod_idC,"prod_name":prod_nameC,"price":priceC,"quantity":quantityC},
			success:function(){
				
				if(!confirm(prod_nameC +" 상품이 장바구니에 담겼습니다.")) return;
				if(!confirm("장바구니로 이동하시겠습니까?")) return;
				location.href="../cart/list";
				
			}
		});
	}
	//상품삭제
	$("#btnDelete").on("click",function(){
		var prod_id="${vo.prod_id}";
		if(!confirm("상품을 삭제합니다.")) return;
		location.href="/pro/delete?prod_id="+prod_id;
	});
	
	//이미지 미리보기
	$(frm.image).on("change",function(){
		var reader=new FileReader();
		reader.onload=function(e){
			$("#image").attr("src", e.target.result);
		}
		reader.readAsDataURL(this.files[0]);
	});
	//업체정보 불러오기
	$(frm.mall_id).on("click",function(){
		window.open("/mall/listAll.jsp","mall_id","width=850,height=360,top=100,left=600");
	});
	$(frm.mall_name).on("click",function(){
		window.open("/mall/listAll.jsp","mall_id","width=850,height=360,top=100,left=600");
	});

	//엔터키
	$("#contents").keydown(function(e){
		if(e.keyCode==13) $("#btnInsert").click();
	});		//외우기!
	
	
	
	
	//댓글삭제
	$("#replyList").on("click",".replyBox .btnDelete",function(){
		var rn=$(this).attr("rn");
		var rid=$(this).attr("rid");
		var writer=$(this).attr("writer");
		if(id==writer || id=="admin"){
			if(!confirm(rn+"번 후기를 삭제하시겠습니까?")) return;
			$.ajax({
				type:"post",
				url:"../reply/delete",
				data:{"rid":rid},
				success:function(){
					alert("상품 후기가 삭제되었습니다.");
					getList();
				}
			});
		}else{
			alert("해당 상품후기를 삭제할 수 없습니다.");
		}
	});
	//댓글수정작업1-댓글수정버튼을 눌렀을 때
	$("#replyList").on("click",".replyBox .btnEdit",function(){
		var row=$(this).parent().parent();
		var rn=$(this).attr("rn");
		var replyContent=row.find(".replyContent");
		var btnEditor=row.find(".btnEditor");
		var btnEdit=row.find(".btnEdit");
		var editClose=row.find(".editClose");
		var writer=row.attr("writer");
		var star2_box=row.find(".star2-box");
		var score=$(this).attr("score");
		
		
		if(replyEditChk==1){
			alert("수정하기 버튼을 클릭하세요."); return;
		}
		if(!confirm("상품 후기를 수정하시겠습니까?")) return;
		
		if(id==writer ||id=="admin"){
			btnEditor.show();
			editClose.show();
			star2_box.show();
			replyContent.attr("disabled",false);
			replyContent.focus();
			replyEditChk=1;
		}else{
			alert("해당 상품후기를 수정할 수 없습니다.");
		}
		$(".score2").html(score); //기존 점수 반영
		//$("#star"+rn).attr("disabled",false);
		$(".star2").on('click',function(){ //클래스명을 구분해도 화면에 잘 안나오는 경우는 캐시때문인듯하다. 
		   	var idx = $(this).index();
		   	var score=0;
		   	$(".star2").removeClass("on");
		   	for(var i=0; i<=idx; i++){
		   		$(".star2").eq(i).addClass("on");
		       score+=0.5;
		   	}
		   	//alert(score);
		   	$(".score2").html(score); //변경점수 반영
		   	
		 });
		
	});
	//댓글수정작업2-수정취소버튼
	$("#replyList").on("click",".replyBox .editClose",function(){
		var row=$(this).parent();
		var replyContent=row.find(".replyContent");
		
		var btnEditor=row.find(".btnEditor");
		var editClose=row.find(".editClose");
			btnEditor.hide();
			editClose.hide();
			replyContent.attr("disabled",false);
			replyEditChk=0;
			getList();
		
	});
	//댓글수정작업3-수정하기 버튼(최종)을 눌렀을 때
	$("#replyList").on("click",".replyBox .btnEditor",function(){
		var row=$(this).parent();
		var rid=$(this).attr("rid");
		var writer=$(this).attr("writer");
		var content=row.find(".replyContent").val(); //이부분이 제일 안됨. 다른 영역은 다 가져오는데, 이것만 위 댓글 데이터 가져옴..
		var score=row.find(".score2").html();
		
		
		if(id==writer){
			$.ajax({
				type:"post",
				url:"../reply/update",
				data:{"rid":rid, "content":content,"score":score},
				success:function(){
					alert("수정이 완료되었습니다.");
					//alert(content); 문제해결 실패!
					replyEditChk=0;
					getList();
				}
			});
		}
	});
	
	
	//댓글입력
	$("#btnInsert").on("click",function(){	//button으로 submit을 강제로 만듬.
		var contents=$("#contents").val();
		var writer="${user.id}"; 		//세션에 저장된 id를 가져옴
		var score=$("#score").html();
		var insertChk=0;
		if(writer==""){
			alert("상품후기를 쓰시려면 로그인을 하세요.")
			$("#contents").val("");
			return;
		}else if(score==0){
			alert("별점을 체크해주세요!"); return;
			
		}else{
			if(!confirm("상품후기를 등록하시겠습니까?")) return;
		}
		
		
		$("#replyList .replyBox .replyContent").each(function(){
			var writer2=$(this).attr("writer");
			if(writer2==writer){
				insertChk=1;
				return;
			}
		});
			
		if(insertChk==1){
			alert("이미 상품후기를 등록하셨습니다.");
			window.location.reload(); //댓글입력값 초기화
		}else{	
			$.ajax({
				type:"post",
				url:"../reply/insert",	//현재 bbs의 servlet을 기반으로 하니까 한칸 빠져 올라가서 reply servlet의 특정 주소로 간다.
				data:{"prod_id":pid, "content":contents,"writer":writer,"score":score},
				success:function(){
					alert("상품 후기가 등록되었습니다.");
					//alert(id+"\n"+content+"\n"+writer);
					$("#contents").val("");
					$("#contents").focus();
					window.location.reload()
				}
			});
		}
	});

	//버튼
	$("#btnNext").on("click",function(){
		rpage++;
		getList();
	});
	$("#btnPre").on("click",function(){
		rpage--;
		getList();
	});
	
	function getList(){
		$.ajax({
			type:"get",
			url:"../reply/list.json", //현재 위치는 bbs servlet을 기점이므로 한칸 올라가서 reply.java(reply의 servlet)으로 가서 그 list.json을 연결해주는것!!
			dataType:"json",
			data:{"prod_id":pid, "page":rpage},
			success:function(data){
				//alert(pid+rpage);
				var lastPage=Math.ceil(data.count/5);
				var temp=Handlebars.compile($("#replyTemp").html());
				
				$("#replyList").html(temp(data)); //temp라는 변수는 주소다.(data)를 적용한 결과값과 temp 변수 자체는 값이 다르다. append는 결과누적
				$("#count").html(data.count);
				$("#infoPage").html("현재 페이지 : "+rpage+" / "+lastPage);
				if(rpage==lastPage){
					$("#btnNext").attr("disabled",true);
				}else $("#btnNext").attr("disabled",false);
				if(rpage==1){
					$("#btnPre").attr("disabled",true);
				}else $("#btnPre").attr("disabled",false);
				//평점평균 구하기
				var scoreTot=0;
				var rnCnt=0;
				$("#replyList .replyBox .replyMenu").each(function(){
					var scores=$(this).attr("score");
					scoreTot=Number(scoreTot)+Number(scores); //수식화하는 방법 ㅎㅎ;
					//alert(scores);
					rnCnt+=1;
					
				});
				//alert(scoreTot);
				var scoreAvg=(scoreTot/rnCnt);
				//alert(scoreAvg);
				if(data.count==0){ scoreAvg="-";}
				$("#scoreAvg").html(scoreAvg+"점");
				
				//댓글 수정 후 '(수정됨)'표시
				$("#replyList .replyBox").each(function(){
					var editCheck=$(this).attr("editChk");
					var editChk=$(this).find(".editChk");
					if(editCheck==1){
						editChk.show();
					}
				});
			}
		});
	}
	 $(".star").on('click',function(){
	   	var idx = $(this).index();
	   	var score=0;
	   	$(".star").removeClass("on");
	   	for(var i=0; i<=idx; i++){
	       $(".star").eq(i).addClass("on");
	       score+=0.5;
	   	}
	   	$("#score").html(score);
	 });	
	 
</script>


