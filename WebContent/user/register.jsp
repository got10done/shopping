<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form name="frm2">
	<table id="regTbl" style="margin-top:50px;border:1px solid lightgrey;">
		<tr class="title" height=80>
			<td colspan=2>회원가입</td>
		</tr>
		<tr class="row">
			<th>아이디*</th>
			<td style="text-align:left;padding-left:240px;">
				<input type="text" name="regId" style="text-align:center;" maxlength=20 autofocus onSubmit=false/>
				&nbsp;&nbsp;&nbsp;
				<button type="button" id="idChk"> 중복확인 </button>
			</td>
			
		</tr>
		<tr class="row">
			<th>비밀번호*</th>
			<td>
				<input type="password" name="regPass" id="regPass" maxlength=20 size=20 style="text-align:center;" onSubmit=false/>

			</td>
		</tr>
		<tr class="row">
			<th>비밀번호 확인*</th>
			<td>
				<input type="password" name="regPass2"  id="regPass2" maxlength=20 size=20 style="text-align:center;"/>
				<br>
				<font id="chkNotice" size=2 style="font-weight:black;"></font>	
			</td>
		</tr>
		<tr class="row">
			<th>이름*</th>
			<td><input type="text" name="regName" id="regName" style="text-align:center;"></td>
		</tr>
		<tr class="row">
			<th>주소*</th>
			<td><input type="text" name="regAddress" style="text-align:center;"></td>
		</tr>
		<tr class="row">
			<th>메일</th>
			<td><input type="text" name="regEmail" style="text-align:center;"></td>
		</tr>
		<tr class="row">
			<th>휴대폰 번호</th>
			<td style="text-align:left;padding-left:200px;">
				<input type="text" name="tel1" size="3" style="text-align:center;"> - 
				<input type="text" name="tel2" size="4" style="text-align:center;"> - 
				<input type="text" name="tel3" size="4" style="text-align:center;">
				&nbsp;&nbsp;&nbsp;
				<button type="button">휴대폰 인증</button>
			</td>
		</tr>
		<tr>
			<td colspan="2"></td>
		</tr>
		<tr>
			<td align="center" colspan="2">
				<input type="submit" value=" 가입하기 " id="registerIn" style="width:300px; text-align:center; background:lemonchiffon;color:darkslategray;font-weight:bold;">
		</tr>
	</table>
</form>
<br>
<br>
<script>
var idChkNum=0;
//아이디 입력 엔터키
$(frm2.regId).keydown(function() {
  if (event.keyCode === 13) {
    event.preventDefault();
    alert("아이디 중복확인버튼을 눌러주세요."); return;
  };
});
//아이디 중복확인 버튼 클릭
$("#idChk").on("click",function(){
	//아이디 유효성체크 
	var regId=$(frm2.regId).val();
	//alert(regId.length);
	
	if(regId.length<4){
		alert("아이디를 4자리 이상으로 입력해주세요."); 
		$(frm2.regId).focus();
		return;
	}
	$.ajax({
		type:"get",
		url:"/user/read",
		dataType:"json",
		data:{"user_id":regId},
		success:function(data){
			//alert(data.user_id); //json데이터로 dao에서 받아야만 if(data)문 안에 인식이 된다..(ajax니까)
			if(data.user_id==""){
				alert("사용가능한 아이디입니다.");
				$(frm2.regPass).focus();
				idChkNum=1;
			}else if(data.user_id==regId){
				alert("이미 등록된 아이디입니다.");
				$(frm2.regId).val("");
				$(frm2.regId).focus();
			}
		}
	});	
});

var passChkNum=0;
//비밀번호 확인-인터넷 참고
$(function(){
	$('#regPass').keyup(function(){
	  $('#chkNotice').html('');
	});
	
	$('#regPass2').keyup(function(){
		if($('#regPass').val()==''){
			$('#chkNotice').html('상단의 비밀번호를 먼저 입력해주세요.');
			$('#chkNotice').attr('color', 'red');
		}else if($('#regPass').val() != $('#regPass2').val()){
	      $('#chkNotice').html('비밀번호가 일치하지 않습니다.<br>');
	      $('#chkNotice').attr('color', 'red');
	    } else{
	      $('#chkNotice').html('비밀번호가 일치합니다.<br>');
	      $('#chkNotice').attr('color', 'green');
	      passChkNum=1;
	      alert("비밀번호가 일치합니다.");
	      $("#regName").focus();
	    }

	 });
});


//frm2은 submit부터 막아줘야함! (refresh돼서 번거로움) - 개발자모드에 오류 내용 뜬다!
$(frm2).on("submit",function(e){ //이걸 해줘야 refresh가 안된다.
	e.preventDefault();
	var id=$(frm2.regId).val();
	if(id.length<4){
		alert("아이디를 4자리 이상으로 입력해주세요.");
		$(frm2.regId).focus();
		return;
	}else{
		if(idChkNum==0){
			alert("아이디 중복확인을 해주세요"); return;
		}else{
			var pass=$(frm2.regPass).val();	
			if(pass.length < 4){
			alert("비밀번호를 4자리 ~ 20자리 이내로 입력해주세요.");
			return false;
			}else {
				console.log("통과");
				$(frm2.regPass2).focus();
				
			
				var pass2=$(frm2.regPass2).val();
				
				if(passChkNum==0){
					alert("비밀번호 확인을 다시해주세요."); return;
				} else{
					var name=$(frm2.regName).val();
					if(name==""){
						alert("이름을 입력하세요!"); return;
						}else{
						var address=$(frm2.regAddress).val();
						if(address==""){
							alert("주소를 입력하세요!"); return;
						} else{
							var email=$(frm2.regEmail).val();
							var tel=$(frm2.tel1).val()+"-"+$(frm2.tel2).val()+"-"+$(frm2.tel3).val();
							//alert(tel);
							
							$.ajax({
								type:"post",
								url:"/user/register",
								data:{"id":id,"pass":pass,"name":name,"email":email,"tel":tel, "address":address},
								success:function(){
									
									if(!confirm("회원가입하시겠습니까?")) return;
									frm2.submit();
									alert(name+"님 회원가입을 축하합니다!");
									location.href="/home";
								}
							});
						
						}
					}
				}
			}
		}
	}
});


</script>