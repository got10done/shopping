<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h2>[ 상품 문의 ]</h2>
	<div id="sk2">
		<input type="text" id="contents2" placeholder=" 문의하기"/>
		<button id="btnInsert2"> 입 력 </button>
	</div>
	<br>
		<b>총 문의글 수 : <span id="count2"></span> 개</b>
		<br>
		<br>
		<div id="replyList2"></div>
	
		<script id="replyTemp2" type="text/x-handlebars-template">

		{{#each array}}
			<div class="replyBox2" style="overflow:hidden;font-size:15px;" writer={{writer}} rn={{rn}} qid={{qid}}>
				 	<div class="replyMenu2" style="overflow:hidden;text-align:left;padding:10px;width:700px;margin:0px auto;border:1px solid lightgrey; box-shadow:0px 0px 10px lightgrey;">
						<span style="padding:5px;">
							<b>{{rn}}</b> &nbsp;&nbsp;&nbsp;{{hide2 qid}} &nbsp;&nbsp;&nbsp;{{rdate}}
						</span> &nbsp;&nbsp;&nbsp;
						<button class="btnDelete2" rn={{rn}} qid={{qid}} writer={{writer}} style="{{hidden4 writer}}float:right;padding:5px;">문의글 삭제 </button>&nbsp;&nbsp;&nbsp;
						<button class="btnEdit2" qid={{qid}} answer={{answer}} writer={{writer}} content={{content}} style="{{hidden2 writer}}float:right;padding:5px; border-radius:20px;">문의글 수정</button>
						<button class="btnAnswer2" style="{{hidden3 ans}}float:right;padding:5px; border-radius:20px;">답변 달기</button>
					</div>
					<b>{{writer}} :</b> 
					<input type="text" class="replyContent2" writer={{writer}} value="{{content}}" style="text-align:center;background:none; border:2px solid lightgrey; border-radius:0px; margin:10px;" disabled/>
					<br>
					<button class="btnEditor2"  qid={{qid}}  writer={{writer}} style="display:none;padding:5px;border-radius:20px;">수정하기</button>
					<button class="editClose2" qid={{qid}} writer={{writer}} content={{content}} style="display:none;padding:5px;border-radius:20px;">수정취소</button>

					
					<div class="answerBox" style="float:left;padding-left:280px;" answer={{answer}} >
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						
						<b>ㄴ 담당자 : </b> 
						<input type="text" class="answerContent2" writer={{writer}} value="{{answer}}" style="text-align:center;background:none; border:2px solid lightgrey; border-radius:0px; margin:10px;" disabled/>
						<span class="answerTime" style="display:none;font-size:10px;">{{adate}}</span>
						&nbsp;
						<button class="answerEditor2" qid={{qid}} style="{{hidden6 read}}padding:5px;border-radius:20px;">답변하기</button>
						<button class="answerClose2" style="{{hidden6 read}}padding:5px;border-radius:20px;">답변취소</button>
						<button class="answerDelete2" style="{{hidden6 read}}padding:5px;border-radius:20px;">답변삭제</button>
						<br/>

					</div>					
			</div>
		{{/each}}
		</script>
	<br>
	<br>
	<div id="pagination2">
		<button id="btnPre2"> 이 전 </button> 
		<span id="infoPage2"></span>
		<button id="btnNext2"> 다 음 </button>
		<button id="btnUp2" style="float:right;margin:10px;"> 맨 위로 </button>
	</div>
	<br>
<script>
	var id="${user.id}";
	Handlebars.registerHelper("hidden2", function(writer){		//수정버튼은 자기것만 보이도록(핸들바의 특정 메서드를 씀. hidden이라는 이름으로 writer를 매개변수로	
		if(id=="admin" || id!=writer){
			return "display:none;";
		}else if(id==writer){	
			return ;	
		}
	});
	Handlebars.registerHelper("hidden3", function(ans){		//admin 만 답변달기 보이기	
		if(id=="admin"){
			return;
		}else{	
			return "display:none;";	
		}
	});
	Handlebars.registerHelper("hidden4", function(writer){		//삭제버튼은 관리자와 자기것만 보이도록	
		if(id=="admin" || id==writer){
			return ;
		}else if(id!=writer){	
			return "display:none;";	
		}
	});
	
	Handlebars.registerHelper("hidden6", function(read){	//admin 말고 다른사람은 답변하기,답변수정 버튼 보이지 않게 	
		
		if(id=="admin"){
			return;
		}else{	
			return "display:none;";	
		}
	});
	Handlebars.registerHelper("hide2", function(qid){

		if(id!="admin"){
			return;
		}else{
			return "(qid : "+qid+")";
		}
	});
</script>

<script>
	var pid="${vo.prod_id}";		//현재상품 id
	var rpage=1;
	var replyEditChk=0;
	var id="${user.id}";
	getList2();
	//alert("userid"+id);
	if(id==""){
		
		$("#sk2").css("display","none");
		
	}
	if(id!="admin"){
		
	}
	//답변달기버튼 문의 답변 다는곳
	$("#replyList2").on("click",".replyBox2 .btnAnswer2",function(){
		//alert("..")
		var row=$(this).parent().parent();
		var answerBox=row.find(".answerBox");
		var answerContent2=row.find(".answerContent2");
		
		answerBox.show();
		answerContent2.prop("disabled",false);
		answerContent2.val("");
		answerContent2.focus();
	});
	//답변하기 클릭 시
	$("#replyList2").on("click",".replyBox2 .answerEditor2",function(){
		var row=$(this).parent().parent();
		var qid=$(this).attr("qid");
		var answerBox=row.find(".answerBox");
		var btnAnswer2=row.find(".btnAnswer2");
		var answerContent2=row.find(".answerContent2").val();
		if(!confirm("답변을 등록하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"../qna/update2",
			data:{"answer":answerContent2,"qid":qid},
			success:function(){
				alert("답변이 등록되었습니다.");
				getList2();
				
				
			}
		});
	});
	
	//답변 취소를 눌렀을 때
	$("#replyList2").on("click",".replyBox2 .answerClose2",function(){
		var row=$(this).parent().parent();
		var answerBox=row.find(".answerBox");
		answerBox.hide();
	});
	
	//답변 삭제를 눌렀을 때
	$("#replyList2").on("click",".replyBox2 .answerDelete2",function(){
		var row=$(this).parent().parent();
		var qid=row.attr("qid");
		var answerBox=row.find(".answerBox");
		var answerContent2=row.find(".answerContent2").val();
		if(!confirm("해당 문의 답변을 삭제하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"../qna/update3",
			data:{"qid":qid},
			success:function(){
				alert("답변을 삭제하였습니다.");
				answerBox.hide();
				getList2();
				
			}
		});
		
	});
	//상품문의 적고 엔터로 입력
	$("#contents2").keydown(function(e){
		if(e.keyCode==13) $("#btnInsert2").click();
	});		//외우기!
	//문의글삭제
	$("#replyList2").on("click",".replyBox2 .btnDelete2",function(){
		var rn=$(this).attr("rn");
		var qid=$(this).attr("qid");
		var writer=$(this).attr("writer");
		
		if(id==writer || id=="admin"){
			if(!confirm(rn+"번 문의를 삭제하시겠습니까?")) return;
			$.ajax({
				type:"post",
				url:"../qna/delete",
				data:{"qid":qid},
				success:function(){
					alert("해당 문의글이 삭제되었습니다.");
					getList2();
				}
			});
		}else{
			alert("해당 문의글을 삭제할 수 없습니다.");
		}
	});
	//문의글수정작업1-문의글수정버튼을 눌렀을 때
	$("#replyList2").on("click",".replyBox2 .btnEdit2",function(){
		var row=$(this).parent().parent();
		var replyContent=row.find(".replyContent2");
		var btnEditor=row.find(".btnEditor2");
		var btnEdit=row.find(".btnEdit2");
		var editClose=row.find(".editClose2");
		var writer=row.attr("writer");
		var answer=$(this).attr("answer");
		if(answer!="-"){
			alert("답변이 달린 문의글은 수정할 수 없습니다."); return;
		}
		if(replyEditChk==1){
			alert("하단의 수정하기 버튼을 클릭하세요."); return;
		}
		if(!confirm("문의글을 수정하시겠습니까?")) return;
		
		if(id==writer ||id=="admin"){
			btnEditor.show();
			editClose.show();
			replyContent.attr("disabled",false);
			replyContent.focus();
			replyEditChk=1;
		}else{
			alert("해당 문의글을 수정할 수 없습니다.");
		}
					
	});
	
	//문의글수정작업2-수정취소버튼
	$("#replyList2").on("click",".replyBox2 .editClose2",function(){
		var row=$(this).parent().parent();
		var replyContent=row.find(".replyContent2");
		var btnEditor=row.find(".btnEditor2");
		var editClose=row.find(".editClose2");
			btnEditor.hide();
			editClose.hide();
			replyContent.attr("disabled",false);
			replyEditChk=0;
			getList2();		
	});
	
	//문의글수정작업3-수정하기 버튼(최종)을 눌렀을 때
	$("#replyList2").on("click",".replyBox2 .btnEditor2",function(){
		var row=$(this).parent().parent();
		var qid=$(this).attr("qid");
		var writer=$(this).attr("writer");
		var content=row.find(".replyContent2").val();
		//alert(qid);
		//alert(writer);
		//alert(content);
		if(id==writer){
			$.ajax({
				type:"post",
				url:"../qna/update",
				data:{"qid":qid, "content":content},
				success:function(){
					alert("수정이 완료되었습니다.");
					replyEditChk=0;
					getList2();
				}
			});
		}
	});
	
	
	//문의글입력
	$("#btnInsert2").on("click",function(){	//button으로 submit을 강제로 만듬.
		var contents=$("#contents2").val();
		var writer="${user.id}"; 		//세션에 저장된 id를 가져옴
		var insertChk=0;
		if(writer==""){
			alert("상품문의를 쓰시려면 로그인을 하세요.")
			$("#contents2").val("");
			return;
		}else{
			if(!confirm("상품문의를 등록하시겠습니까?")) return;
		}
			$.ajax({
				type:"post",
				url:"../qna/insert",	//현재 bbs의 servlet을 기반으로 하니까 한칸 빠져 올라가서 reply servlet의 특정 주소로 간다.
				data:{"prod_id":pid, "content":contents,"writer":writer},  //pid는 전역변수로 있음(그 상품 페이지라서 그렇게함)
				success:function(){
					alert("문의가 등록되었습니다.");
					//alert(id+"\n"+content+"\n"+writer);
					$("#contents2").val("");
					$("#contents2").focus();
					getList2();
				}
			});
		
	});
	
	
	
	//버튼
	$("#btnNext2").on("click",function(){
		rpage++;
		getList2();
	});
	$("#btnPre2").on("click",function(){
		rpage--;
		getList2();
	});
	
	function getList2(){
		$.ajax({
			type:"get",
			url:"../qna/list.json", 
			dataType:"json",
			data:{"prod_id":pid, "page":rpage},
			success:function(data){
				//alert(pid+rpage);
				var lastPage=Math.ceil(data.count/5);
				var temp=Handlebars.compile($("#replyTemp2").html());
				
				$("#replyList2").html(temp(data)); //temp라는 변수는 주소다.(data)를 적용한 결과값과 temp 변수 자체는 값이 다르다. append는 결과누적
				$("#count2").html(data.count);
				$("#infoPage2").html("현재 페이지 : "+rpage+" / "+lastPage);
				if(rpage==lastPage){
					$("#btnNext2").attr("disabled",true);
				}else $("#btnNext2").attr("disabled",false);
				if(rpage==1){
					$("#btnPre2").attr("disabled",true);
				}else $("#btnPre2").attr("disabled",false);
				//답변 달린것만 보이기
				$("#replyList2 .replyBox2 .answerBox").each(function(){
					var answer=$(this).attr("answer");
					var answerDelete2=$(this).find(".answerDelete2");
					if(answer=="-"){
						$(this).hide();
						answerDelete2.hide();
					}
				});
				//답변 등록한 후 버튼 두개 가리기
				$("#replyList2 .replyBox2 .answerBox").each(function(){
					var answer=$(this).attr("answer");
					var answerEditor2=$(this).find(".answerEditor2");
					var answerClose2=$(this).find(".answerClose2");
					var answerTime=$(this).find(".answerTime");
					var btnEdit2=$(this).parent().find(".btnEdit2");
					if(answer!="-"){
						answerEditor2.hide();
						answerClose2.hide();
						answerTime.show();
						
					}
				});
				
			}
		});
	}
	
</script>