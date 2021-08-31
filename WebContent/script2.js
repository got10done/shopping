   var page=1;
	getList3();
	$("#query1").keydown(function(e){
	      if(e.keyCode==13) 
	      	page=1;
	    	  getList3();
	   });
	   
	   $("#size1").change(function(){
	      page=1;
		   getList3();
	   });
	   $("#btnNext1").click(function(){
		      page++;
			   getList3();
		   });
	   $("#btnPre1").click(function(){
		      page--;
			   getList3();
		   });
		
		
	function getList3(){
      var query=$("#query1").val();
      var size=$("#size1").val();

      $.ajax({
      type:"get",
      url:url,
      dataType:"json",
      data:{"query":query,"size":size,"page":page},
         headers:{"Authorization" : "KakaoAK 87b6d3ba1453e7fad641622a3362f4c3"},
         success:function(result){
        	 var lastPage=Math.ceil(result.meta.pageable_count/size);
     			var temp=Handlebars.compile($("#temp").html());
                $("#tbl").html(temp(result));
				if(page==1){
					$("#btnPre1").attr("disabled",true);
				}else $("#btnPre1").attr("disabled",false);
				if(result.meta.is_end){
					$("#btnNext1").attr("disabled",true);
				}else $("#btnNext1").attr("disabled",false);
				$("#pageInfo1").html(page+" / "+lastPage);
            }         
         });
      }
