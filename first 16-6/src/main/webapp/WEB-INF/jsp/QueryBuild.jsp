<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
  
<h1 style="text-align:center">QUERY BUILDER</h1>  
<style>
#sortable1, #sortable2 {
    border: 1px solid #eee;
    width: 142px;
    min-height: 20px;
    list-style-type: none;
    margin: 0;
    padding: 5px 0 0 0;
    float: left;
    margin-right: 10px;
  }
  #sortable1 li, #sortable2 li {
    margin: 0 5px 5px 5px;
    padding: 5px;
    font-size: 1.2em;
    width: 120px;
    cursor: pointer;
    height: 1.5em;
      line-height: 1.2em;
      -moz-user-select: -moz-none;
   -khtml-user-select: none;
   -webkit-user-select: none;
   user-select: none;
  }
  
  #where1, #where2 {
    border: 1px solid #eee;
    width: 142px;
    min-height: 20px;
    list-style-type: none;
    margin: 0;
    padding: 5px 0 0 0;
    float: left;
    margin-right: 10px;
  }
  #where1 li, #where2 li {
    margin: 0 5px 5px 5px;
    padding: 5px;
    font-size: 1.2em;
    width: 120px;
    cursor: pointer;
    height: 1.5em;
      line-height: 1.2em;
      -moz-user-select: -moz-none;
   -khtml-user-select: none;
   -webkit-user-select: none;
   user-select: none;
  }
.ui-state-highlight { 
    height: 1.5em;
    line-height: 1.2em;
}

 ul {margin: 0; padding: 0; list-style-type: none; width: 50%;}
 ul li {padding: 0.4em; margin: 0.2em; cursor: pointer; font-size: 0.8em;}

</style>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>	
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jqueryui/1.9.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

<body>

<ul class="testo"> 
 <c:forEach var="class1" items="${classes}">
  
   <li>
               <div>+ ${class1}</div>
               <ul>
               </ul>
	</li>
</c:forEach>
</ul> 



 <table border="2" width="70%" cellpadding="2">  
<tr><th>Id</th><th>Name</th><th>Salary</th><th>Department</th></tr>  
   <c:forEach var="emp" items="${emplist}">  
   <tr>  
   <td>${emp.id}</td>  
   <td>${emp.name}</td>  
   <td>${emp.salary}</td>  
   <td>${emp.department}</td>  
   </tr>  
   </c:forEach>  
   </table> 
   
 <!--   
<h1>Player List</h1>
   
   
<table border="2" width="70%" cellpadding="2">  
<tr><th>jerseynum</th><th>Name</th><th>Salary</th><th>team</th></tr>  
   <c:forEach var="player" items="${playerlist}">  
   <tr>  
   <td>${player.jerseynum}</td>  
   <td>${player.name}</td>  
   <td>${player.salary}</td>  
   <td>${player.team}</td>  
   </tr>  
   </c:forEach>  
   </table> 
   
--> 
<br/>

<div class="row">

<div class="col-md-2" style = " ">

<p> <b>Choose command</b> </p>
   
 <select style="overflow-y: auto; margin-left : 10px" id = "command" multiple size = 4>


  <option>SELECT</option>
  <option>UPDATE</option>
  <option>DELETE</option>
  <option>INSERT INTO</option>
  
   
</select> 



<!-- <ul id="selezionabile" class="ui-widget">
    <li class="ui-widget-content ui-corner-all">SELECT</li>
    <li class="ui-widget-content ui-corner-all">UPDATE</li>
    <li class="ui-widget-content ui-corner-all">DELETE</li>
    <li class="ui-widget-content ui-corner-all">INSERT INTO</li>
</ul>    -->

</div>



<div class="col-md-2" style = "">

<p> <b>Select Table</b> </p>
   
<select style="overflow-y: auto;margin-left:10px; " id = "entityDrop" multiple size = "4">

 <c:forEach var="class1" items="${classes}">
  <option style= " text-transform: uppercase">${class1}</option>
  </c:forEach>  
</select>   

</div>

<div class="col-md-2" style = "">

<p><b> drag to select columns</b> </p>


<ul id = "sortable1" class="connectedSortable"> </ul>
</div>




<div class="col-md-2"  style = "">

<p> <b>selected columns</b> </p>
<ul id = "sortable2" class="connectedSortable"> </ul>
</div>


<div class="col-md-2" >
<p><b> drag to select conditions</b> </p>


<ul id = "where1" class="connectedWhere"> </ul>
</div>


<div class="col-md-2"  style = "">

<p> <b>selected conditions</b> </p>
<ul id = "where2" class="connectedWhere"> </ul>
</div>
</div>

 <div class="row" style=" margin-top : 80px ; margin-left:200px; margin-right:200px">
<div class="row">
<p id="p1" class="col-md-12" style = "font-weight : bold "></p>   
</div>
<div class="row">
 <p id="p2" class="col-md-12" style = " text-transform : uppercase ;"></p> 
 </div>
 <div class="row">
 <p class="col-md-12" style = " font-weight : bold">FROM </p></div>
 <div class="row">
  <p class="col-md-12" id="p3" style = "  text-transform : uppercase"></p> 
  </div>
  <div class="row">
 <p  class="col-md-12" style = "font-weight : bold; text-transform : uppercase ;">WHERE</p> 
 </div>
 <div class="row">
  <p class="col-md-12" id="p4" style = "  text-transform : uppercase"></p> 
  </div>
   
   </div>
   
 <button style="margin-left : 500px; margin-top:30px" type = "button">EXECUTE</button>
</body>
   
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>   
<script type="text/javascript">


$(document).ready(function(){
	
	
	$( "#selezionabile" ).selectable({
	    selected: function( e, ui ) {
	        if ($( ui.selected ).hasClass( "ui-state-highlight" )) {
	            $( ui.selected ).removeClass( "ui-state-highlight" );
	        } else {
	            $( ui.selected ).addClass( "ui-state-highlight" );
	        }
	    },    
	    unselected: function( e, ui ) {
	        $( ui.unselected ).removeClass( "ui-state-highlight" );    
	    }
	});
	
	
	
	
	
	$("#command").change(function(){
		
		$("#p1").html("");
		$("#p1").html($("#command option:selected" ).text());
		
	});
	
	$("#entityDrop").change(function(){
			
			$("#p3").html("");
			$("#p3").html($("#entityDrop option:selected" ).text());
			
		});

	$("#sortable2").click(function(){
		$("#p2").html("");
		$("#p2").html($("#sortable2 li").text());
		
	
	});


   
   $("#entityDrop").change(function(){
	   
	   var tmp = $("#entityDrop :selected").text();

       $.ajax({
url: 'http://10.1.55.100:9000/first/try1',
type: "POST",
data: {'entity' : tmp},
success: function(response) {
	

	$("#sortable1").html("");
	$("#sortable2").html("");
	$("#where1").html("");
	$("#where2").html("");
	$.each($.parseJSON(response), function() {
		$("#sortable1").append("<li  class='ui-state-default'>"+this + "</li>");
	});

	$.each($.parseJSON(response), function() {
		$("#where1").append("<div class='row'><div class='col-md-6'><li style='font-size:12px'class='ui-state-default'>"+this + "=</li></div><div class='col-md-6'><input style='width : 50px'  type='text'></div></div>");
	});


	
}
       });
	   
	   
	   
	   
	   
   });
   
   
   
   
   
   $("#sortable1").sortable({
	    connectWith: "#sortable2"
	})
	    .disableSelection();

	$("#sortable2").sortable({
	    connectWith: "#sortable1",
	     receive : function(event,ui)
	    {
	    	$("#p2").html("");
	    	var values = $('#sortable2 li').map(function(){ 
	    		  return $(this).text(); 
	    		}).get().join(',');
	    	$("#p2").html(values);
	    	
	    }, 
	    stop : function(event,ui)
	    {
	    	$("#p2").html("");
	    	var values = $('#sortable2 li').map(function(){ 
	    		  return $(this).text(); 
	    		}).get().join(',');
	    	$("#p2").html(values);
	    	
	    }
	    
	   /*  out : function(event,ui)
	    {
	    	$("#p2").html("");
	    	$("#p2").html($("#sortable2 li").text());
	    } */
	})
	    .disableSelection();

	$( "#sortable2" ).data( "ui-sortable" ).floating = true;
	

	
	  $("#where1").sortable({
		    connectWith: "#where2"
		})
		    .disableSelection();

		$("#where2").sortable({
		    connectWith: "#where1",
		     receive : function(event,ui)
		    {
		    	$("#p4").html("");
		    	var values = $('#where2 div[class="row"]').map(function(){ 
		    		  return ($(this).text()+" " +$(this).find("input[type='text']").val()); 
		    		}).get().join(',');
		    	$("#p4").html(values); 
		    	
		    }, 
		    stop : function(event,ui)
		    {
		    	 $("#p4").html("");
		    	 var values = $('#where2 div[class="row"]').map(function(){ 
		    		  return ($(this).text()+" " +$(this).find("input[type='text']").val()); 
		    		}).get().join(',');
		    	$("#p4").html(values); 
		    }
		    
		     /* out : function(event,ui)
		    {
		    	$("#p4").html("");
		    	$("#p4").html($("#where2 li").text());
		    }  */
		})
		    .disableSelection();

		$( "#where2" ).data( "ui-sortable" ).floating = true;
		
	
	
	
		 $(".testo").children('li').each(function(i, n) {
				
			var x = $(this); 
         	
         	
         	var tmp = $(this).find('div').html().substr(2);
         	
         	
            $.ajax({
            	url: 'http://10.1.55.100:9000/first/try1',
            	type: "POST",
            	data: {'entity' : tmp},
            	success: function(response) {
            		

            		$("#sortable1").html("");
            		$("#sortable2").html("");
            		$("#where1").html("");
            		$("#where2").html("");
            		$.each($.parseJSON(response), function() {
            			$("#sortable1").append("<li  class='ui-state-default'>"+this + "</li>");
            		});

            		$.each($.parseJSON(response), function() {
            			x.children('ul').append("<li>"+this+"</li>");
            			});
            		
            		

						
            		
            	}
            	       });
            		   

            console.log($(this).html());
         	
         });
	
	
	
   
});
   
   
   </script>
   
   
   
   
   
   
   
   
   
   