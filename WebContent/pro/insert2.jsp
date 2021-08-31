<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<br>
<h2>[ 도서 상품 등록 ]</h2>
<br>
<form name="frm" enctype="multipart/form-data">
     <table>
        <tr>
           <td width=210 class="title">상품코드</td>
           <td width=100><input type="text" name="prod_id"  size=6  value="${prod_id}" readonly style="text-align:center;font-weight:bold;"/></td>
           <td width=100 class="title">작가</td>
           <td width=100><input type="text" name="company"  size=10 value=""  style="text-align:center;"/></td>
           <td width=100 class="title">판매가격</td>
           <td width=100><input type="text" name="price1"  size=5 value=""  style="text-align:center;"/></td>
        </tr>
        <tr>
           <td width=210 class="title">출판사</td>
           <td width=600 colspan=3>
           		<input type="text" name="mall_id" size=7 placeholder="업체코드" style="text-align:center;" readonly/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           		<input type="text" name="mall_name" size=32 placeholder="출판사명" style="text-align:center;" readonly/>
           </td>
           <td width=100 class="title">일반가격</td>
           <td width=100><input type="text" name="price2" size=5 value="" style="text-align:center;"/></td>
        </tr>
        <tr>
           <td width=210 class="title">상품이름</td>
           <td width=700 colspan=5><input type="text" name="prod_name" size=90 value="" style="text-align:center;"/></td>
        </tr>
        <tr>
           <td width=210 class="title">상품이미지</td>
           <td width=700 colspan=5  style="padding-left:300px;">
              <img src="http://placehold.it/200x150" width=200 id="image" style="float:left; margin-left:27px;cursor:pointer;"/>
              <input type="file" name="image" size=3 accept="image/*" style="visibility:hidden;float:right;"/>
              
           </td>
        </tr>
        <tr>
           <td width=210 class="title">상품설명</td>
           <td width=700 colspan=5>
             <textarea name="detail" style="width:600px;height:100px;margin:10px;"></textarea>
           </td>
        </tr>                           
     </table>
     <div id="pagination">
        <input type="submit" value="상품등록"> 
        <input type="reset" value="등록취소"> 
        <input type="button" value="목록이동" onClick="location.href='list'"> 
     </div>
</form>
<script>
	$("#image").on("click",function(){
		$(frm.image).click();
	});
	//상품등록하기
	$(frm).on("submit",function(e){
		e.preventDefault();
		if(!confirm("상품을 등록하시겠습니까?")) return;
			frm.action="/pro/insert";
			frm.method="post";
			frm.submit();
			alert("상품이 등록되었습니다.");
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
		window.open("/mall/listAll2.jsp","mall_id","width=850,height=400,top=200,right=600");
	});
	$(frm.mall_name).on("click",function(){
		window.open("/mall/listAll2.jsp","mall_name","width=850,height=400,top=200,right=600");
	});
</script>