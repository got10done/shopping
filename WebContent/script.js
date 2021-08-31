	var page=1;
	
	getList();
	
	
	$("#word").on("keydown",function(e){
		if(e.keyCode==13){
			page=1; getList();
		}	
	});
	
	$("#key, #perpage, #order, #desc").on("change", function(e){
		page=1; getList();	
	});
	
	$("#btnNext").on("click", function(){
		page++; getList();
	});
	
	$("#btnPre").on("click", function(){
		page--; getList();
	});
	
	function getList(){
		var key=$("#key").val();
		var word=$("#word").val();
		var perpage=$("#perpage").val();
		var order=$("#order").val();
		var desc=$("#desc").val();
		$.ajax({
			type:"get",
			url:url,
			dataType:"json",
			data:{"key":key,"word":word,"page":page,"perpage":perpage,"order":order,"desc":desc},
			success:function(result){
				//alert(result.count);
				var temp=Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(result));
				$("#count").html("검색수:<b>"+result.count+"</b>");
				var lastPage=Math.ceil(result.count/perpage);
				
				$("#pageInfo").html(page + "/" + lastPage);
				if(page==1){
					$("#btnPre").attr("disabled",true);
				}else{
					$("#btnPre").attr("disabled",false);
				}
				if(page==lastPage){
					$("#btnNext").attr("disabled",true);
				}else{
					$("#btnNext").attr("disabled",false);
				}
			}
		});
	}