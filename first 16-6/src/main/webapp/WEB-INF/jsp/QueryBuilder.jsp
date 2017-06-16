<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
        <html>

        <head>
            <link rel="stylesheet" href="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
            <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
            <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/jquery-ui.min.js"></script>
            <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
            <script src="https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>

            <link href="https://netdna.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" rel="stylesheet">

            <link href="http://querybuilder.js.org/assets/css/docs.min.css" rel="stylesheet">
            <link href="http://querybuilder.js.org/assets/css/style.css" rel="stylesheet">
            <link href="<c:url value="/resources/css/query-builder.default.css" />" rel="stylesheet">
            <script src="<c:url value="/resources/js/query-builder.standalone.js" />"></script>



            <script src="https://netdna.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>



            <script>
                $(document).ready(function() {

                    var query;
                    var grcheck;
                    var mapc = {};
                    var map = {};
                    var mapcheck = {};
                    var arr = [];
                    var inn = [];
                    var grouplist = {},
                        orderlist = {};


                    $("#set").hide();

                    $("input[type='radio']").change(function() {

                        $("#comm").html("<strong>" + $(this).val() + "</strong>");
                        //$(".upright").html('<h4 style = " margin-top: 10px ; text-align : center">Canvas</h4> ');
                        alert("REMOVE ALL THE TABLES BEFORE CONTINUING");



                        if ($("#comm").text() == "SELECT") {
                            $("#col").show();
                            $("#groupby").show();
                            $("#gcond").show();
                            $("#orderby").show();
                            $("#ocond").show();
                            $("#comm").show();
                            $("#set").hide();
                            $("#scond").hide();
                            $("#from").html("<strong>FROM</strong");
                            $("#getTable").text("Fetch Table!");
                            $("#getTable").val("Fetch Table!");
                        }


                        if ($("#comm").text() == "UPDATE") {
                            $("#col").hide();
                            $("#set").html("<strong>SET</strong>");
                            $("#set").show();
                            $("#groupby").hide();
                            $("#gcond").hide();
                            $("#orderby").hide();
                            $("#ocond").hide();
                            $("#comm").hide();
                            $("#from").html("<strong>UPDATE</strong>");
                            $("#getTable").text("Update Table!");
                            $("#getTable").val("Update Table!");
                            $("#finalsql").val("");
                            $("#fetch").html("");
                            $('#toggle-text').text("-- select query to execute --");

                        }



                    });


                    $.ajax({
                        url: 'http://10.1.55.100:7000/first/sudQuery',
                        type: "POST",
                        data: {
                            'query': "select * from save_query",
                            'name': "yolo",
                            'type': "get",
                            'new_name': "yolo"
                        },
                        success: function(response) {
                            $(".dropdown-menu").html("");
                            $.each($.parseJSON(response), function(i, e) {

                                var th = this;

                                $(".dropdown-menu").append("<li style='padding-left :10px'><span class='ed'>" + th[0] + "</span><span style = 'float:right;margin-right:8px'class='glyphicon glyphicon-remove'></span><span style = 'float:right;margin-right:8px'class='glyphicon glyphicon-edit'></span><div class='description' style='display:none'>" + th[1] + "</div></li>");


                            });

                            $(".dropdown-menu").children("li").each(function() {

                                $(this).mouseover(function() {
                                    $(this).css("background-Color", "#7AA7C8");
                                    $("#finalsql").val($(this).children(".description").text());
                                    $('#toggle-text').text($(this).children("span").text());

                                    $(this).on('click', function() {
                                        $('#toggle-text').text($(this).children("span").text());
                                        $("#finalsql").val($(this).children(".description").text());


                                    });

                                });
                                $(this).mouseout(function() {
                                    $(this).css("background-Color", "#FFF");
                                    //$("#finalsql").val();
                                });
                            });



                            console.log(response + "dropdown list");

                        }
                    });

                    $body = $("body");

                    $(document).on({
                        ajaxStart: function() {
                            $body.addClass("loading");
                        },
                        ajaxStop: function() {
                            $body.removeClass("loading");
                        }
                    });


                    $(".collapsibleList").children('li').each(function(i, n) {

                        var x = $(this);


                        var tmp = $(this).find('div').html().substr(2);
                        x.children('ul').css("width", "130px");

                        $.ajax({
                            url: 'http://10.1.55.100:7000/first/try1',
                            type: "POST",
                            data: {
                                'entity': tmp
                            },
                            success: function(response) {

                                $.each($.parseJSON(response), function() {
                                    x.children('ul').append("<li style='word-break: break-word;white-space: normal;'>" + this + "</li>");
                                });


                            }
                        });


                        // console.log($(this).html());

                    });



                    $('.upleft >ul >li').attr('id', function(i) {
                        return 't' + (i + 1);
                    });

                    $('.upleft >ul >li >ul').attr('id', function(i) {
                        return 'st' + (i + 1);
                    });

                    $(function() {
                        $("#collapse li").children('ul').hide();
                        $("#collapse li").on('click', function(event) {
                            $(this).children('ul').stop().slideToggle(50);
                            $(this).toggleClass("open");
                            event.stopPropagation();
                        });
                    });

                    $("li[id^='t']").draggable({
                        revert: "invalid",
                        helper: "clone",



                    });




                    $(".upright").droppable({
                        activeClass: "ui-state-default",
                        hoverClass: "ui-state-hover",

                        over: function(event, ui) {
                            console.log("overrrrrr");


                        },

                        drop: function(event, ui) {

                            if (!($(ui.helper).hasClass("alreadyDropped"))) {


                                if (!($(".upright").find("#" + ui.draggable.attr("id").substring(0, 2) + "c").length)) {
                                    var tableidc = ui.draggable.attr("id").substring(0, 2) + "c";
                                    var subtableidc = "s" + ui.draggable.attr("id").substring(0, 2) + "c";
                                    var newClone = $(ui.helper).clone().prop("id", tableidc);
                                    newClone.addClass("alreadyDropped");
                                    //console.log(newClone.children('div').text().substr(2));


                                    newClone.css("list-style", "none");
                                    newClone.css("text-transform", "uppercase");

                                    newClone.children('ul').css("list-style", "none");
                                    newClone.children('ul').attr("id", subtableidc);
                                    var tmpi = newClone.find('div').attr("id") + "1";
                                    newClone.find('div').attr("id", tmpi);

                                    newClone.children('ul').children('li').attr('id', function(i) {
                                        return subtableidc + (i + 1);
                                    });
                                    mapc[newClone.children('div').text().substr(2)] = [];
                                    newClone.children('ul').children('li').each(function(i, n) {

                                        arr.push({
                                            id: newClone.children('div').text().substr(2) + '.' + $(this).text(),
                                            label: newClone.children("div").text().substr(2) + '.' + $(this).text(),
                                            type: 'string'
                                        });


                                        mapc[newClone.children('div').text().substr(2)].push(newClone.children('div').text().substr(2) + '.' + $(this).text());

                                        if ($("#comm").text() == "SELECT")
                                            $(this).html("<div class='ui-grid-b'><label style='font-size:small;'><input type='checkbox' class='colcheck' />" + $(this).text() + "</label></div>");

                                        if ($("#comm").text() == "UPDATE") {
                                            $(this).html("<div class='ui-grid-b'><label style='font-size:small;'>" + $(this).text() + "</label> <input type='text' style='color:black;height : 25px' class='coltext form-control'/></div>");
                                            $(this).parent().parent().css("width", "180px");
                                            $(this).parent().parent().css("height", "250px");
                                            $(this).parent().parent().css("overflow-y", "scroll");
                                        }


                                    });


                                    for (var i = 0; i < mapc[newClone.children('div').text().substr(2)].length; i++) {
                                        $('#group').append("<li style='word-break: break-word;white-space: normal;'><label><input type='checkbox' name='groupcheck' value='" + mapc[newClone.children('div').text().substr(2)][i] + "'/>" + mapc[newClone.children('div').text().substr(2)][i] + "</label></li>");
                                    }


                                    for (var i = 0; i < mapc[newClone.children('div').text().substr(2)].length; i++) {
                                        $('#order').append("<li style='word-break: break-word;white-space: normal;'><label><input type='checkbox' name='ordercheck' value='" + mapc[newClone.children('div').text().substr(2)][i] + "'/>" + mapc[newClone.children('div').text().substr(2)][i] + "</label>");
                                    }



                                    inn.push(newClone.find('div').html().substr(2));



                                    console.log(inn);


                                    // console.log(tableidc + "   " + subtableidc);
                                    newClone.children('ul').css("margin-top", "5px");
                                    newClone.children('ul').stop().slideToggle(50);
                                    newClone.toggleClass("open");
                                    $(this).append(newClone);

                                    $('#queryBuilderGoesHere').change(function() {

                                        $("select[name^='queryBuilderGoesHere_rule']").css({
                                            'width': '110px',
                                            'margin-left': '8px',
                                            'margin-right': '10px'
                                        });
                                        $("input[name^='queryBuilderGoesHere_rule']").css({
                                            'width': '110px',
                                            'margin-left': '8px',
                                            'margin-right': '10px'
                                        });

                                    });

                                    if (inn.length <= 1) {
                                        $('#tab').text(inn[0]);

                                    } else {


                                        $('#myModal').modal({
                                            show: false
                                        });
                                        $.ajax({
                                            url: 'http://10.1.55.100:7000/first/innerJoin',
                                            type: "POST",
                                            timeout: 0,
                                            data: {
                                                'innerArr': inn,
                                                'currTable': newClone.find('div').html().substr(2)
                                            },
                                            success: function(response) {
                                                //console.log(response.length + "  parseresponse" + $.parseJSON(response).length );
                                                var len = response.length;
                                                /* if (len == 0)
	                                    alert("parent or child tables not found");
 */

                                                var tmpthis = [];
                                                $.each($.parseJSON(response), function() {
                                                    tmpthis.push(this);
                                                });

                                                console.log(tmpthis[0] + "jssssssssss");

                                                if (tmpthis[0] == "common1" && tmpthis.length > 2) {
                                                    $('.modal-body').html("");
                                                    $('.modal-body').append("<p>No child or parent table found. Please remove <strong>" + newClone.find('div').html().substr(2) + "</strong> and add one of the following tables first : </p>")
                                                    $('.modal-body').append("<ul></ul>");
                                                    $.each(tmpthis, function(i) {
                                                        if (i == 0 || i == 1)
                                                            return;
                                                        $('.modal-body ul').append("<li>" + tmpthis[i] + "</li>");

                                                    });

                                                    $('#myModal').modal('show');

                                                } else if (tmpthis[0] == "common1" && tmpthis.length === 2) {
                                                    $('.modal-body').html("");
                                                    $('.modal-body').append("<p>No child or parent table found. Please remove <strong>" + newClone.find('div').html().substr(2) + "</strong></p>");
                                                    $('#myModal').modal('show');
                                                } else {
                                                    console.log(tmpthis[1] + " tmpppppppppp");
                                                    $('#inner').append("<div id ='" + tmpthis[0] + tmpthis[2] + "'><SELECT class='form-control' style='width : 150px; display : inline-block; color : white; background-color : #7AA7C8' ><OPTION style = 'background-color : #7AA7C8;border : 1px solid #7AA7C8' selected='selected'><strong>INNER JOIN</strong></OPTION><OPTION style = 'background-color : #7AA7C8;'><strong>LEFT JOIN</strong></OPTION><OPTION style = 'background-color : #7AA7C8;'><strong>RIGHT JOIN</strong></OPTION><OPTION style = 'background-color : #7AA7C8;'><strong>FULL OUTER JOIN</strong></OPTION></SELECT> <p style='display : inline-block'>" + tmpthis[4] + " ON " + tmpthis[0] + "." + tmpthis[1] + " = " + tmpthis[2] + "." + tmpthis[3] + " </p></div>");

                                                }
                                            }
                                        });

                                    }


                                    newClone.draggable({
                                        helper: "original",

                                        stop: function(event, ui) {
                                            if (!droppable) {

                                                ui.helper.remove();


                                            }

                                        },
                                        start: function(event, ui) {
                                            droppable = false;
                                        }
                                    });



                                    $('input[name="groupcheck"]').change(function() {


                                        if ($(this).is(':checked')) {

                                            grouplist[$(this).parent().find('input').val()] = $(this).parent().find('input').val();
                                            console.log(grouplist);
                                            $("#gcond").text("");
                                            for (var key in grouplist) {

                                                $("#gcond").append(" " + grouplist[key] + " ,");
                                            }

                                            $("#gcond").html($("#gcond").html().slice(0, -1));

                                        } else {
                                            delete grouplist[$(this).parent().find('input').val()];
                                            console.log(grouplist);
                                            $("#gcond").text("");
                                            for (var key in grouplist) {

                                                $("#gcond").append(" " + grouplist[key] + " ,");
                                            }

                                            $("#gcond").html($("#gcond").html().slice(0, -1));
                                        }
                                    });

                                    $('input[name="ordercheck"]').change(function() {


                                        if ($(this).is(':checked')) {
                                            orderlist[$(this).parent().find('input').val()] = $(this).parent().find('input').val();
                                            console.log(orderlist);
                                            $("#ocond").text("");
                                            for (var key in orderlist) {

                                                $("#ocond").append(" <p style='display:inline-block'>" + orderlist[key] + "</p>  <select class='form-control' style='width : 100px; display : inline; color : white; background-color : #7AA7C8'><option>ASC</option><option>DESC</option></select>" + " <span>,</span>");
                                            }

                                            $("#ocond").html($("#ocond").html().slice(0, -14));


                                        } else {
                                            delete orderlist[$(this).parent().find('input').val()];
                                            console.log(orderlist);
                                            $("#ocond").text("");
                                            for (var key in orderlist) {

                                                $("#ocond").append(" <p style='display:inline-block'>" + orderlist[key] + "</p>  <select class='form-control' style='width : 100px; display : inline; color : white; background-color : #7AA7C8'><option>ASC</option><option>DESC</option></select>" + " <span>,</span>");
                                            }

                                            $("#ocond").html($("#ocond").html().slice(0, -14));
                                        }
                                    });


                                    $(".colcheck").change(function() {

                                        if ($("#comm").text() == "SELECT") {
                                            if ($(this).is(':checked')) {
                                                //alert($(this).next("label").text());
                                                var tab = $(this).parent().parent().parent().parent().parent().find('div').html().substr(2);
                                                console.log($(this).parent().parent().find("label").text() + "sasasasasass");
                                                mapcheck[tab + '.' + $(this).parent().parent().find("label").text()] = tab + '.' + $(this).parent().parent().find("label").text();
                                                $("#col").text("");
                                                for (var key in mapcheck) {

                                                    $("#col").append(mapcheck[key] + " , ");
                                                }

                                                $("#col").text($("#col").text().slice(0, -2));
                                                console.log(mapcheck.length);
                                            } else {
                                                var tab = $(this).parent().parent().parent().parent().parent().find('div').html().substr(2);

                                                delete mapcheck[tab + '.' + $(this).parent().parent().find("label").text()];
                                                $("#col").text("");

                                                for (var key in mapcheck) {

                                                    $("#col").append(mapcheck[key] + " , ");
                                                }
                                                $("#col").text($("#col").text().slice(0, -2));
                                                console.log(mapcheck.length);
                                            }
                                            //console.log(mapcheck);
                                        }




                                    });

                                    $(".coltext").change(function() {
                                    	$("#scond").show();
                                        //alert($(this).prev("label").text() + '="' + $(this).val()+'"');    
                                        //console.log($(this).closest("div").find("input").is(":checked"));
                                        var ta = $(this).parent().parent().parent().parent().parent().find('div').html().substr(2);
                                        console.log(ta + "  tabbbbb")

                                        map[ta + '.' + $(this).parent().find("label").text()] = ta + "." + $(this).parent().find("label").text() + "='" + $(this).val() + "'";
										console.log(map);
                                        if ($(this).val() === "")
                                            delete map[ta + '.' + $(this).prev("label").text()];
                                        console.log(map + " ye bhi");
                                        $("#scond").text("");
                                        for (var key in map) {
                                            $("#scond").append(map[key] + " , ");
                                        }
                                        $("#scond").text($("#scond").text().slice(0, -2));


                                    });




                                    $("#getsql").addClass("ltblue");

                                    var myFilters = [{
                                        id: 'column1',
                                        label: 'Column 1',
                                        type: 'string'
                                    }, {
                                        id: 'column2',
                                        label: 'Column 2',
                                        type: 'double'
                                    }, {
                                        id: 'column3',
                                        label: 'Column 3',
                                        type: 'boolean'
                                    }];
                                    myFilters = arr;



                                    $("#queryBuilderGoesHere").queryBuilder({
                                        filters: myFilters
                                    });


                                    $



                                    $("#getsql").on('click', function() {
                                        var sqlob = $("#queryBuilderGoesHere").queryBuilder("getSQL", false);

                                        $("#sql").text(sqlob.sql);




                                    });



                                    $('#queryBuilderGoesHere').queryBuilder('setFilters', arr);




                                } else
                                    alert("Table already exists!");

                            } else {
                                var yolo = $(ui.helper).clone();

                                yolo.draggable({
                                    helper: "original",
                                    stop: function(event, ui) {
                                        if (!droppable) {

                                            ui.helper.remove();
                                        }

                                    },
                                    start: function(event, ui) {
                                        droppable = false;
                                    }
                                });
                                $(this).append(yolo);



                                $(".colcheck").change(function() {

                                    if ($(this).is(':checked')) {
                                        //alert($(this).next("label").text());
                                        var tab = $(this).parent().parent().parent().parent().parent().find('div').html().substr(2);
                                        console.log($(this).parent().parent().find("label").text() + " opopopopopo");
                                        mapcheck[tab + '.' + $(this).parent().parent().find("label").text()] = tab + '.' + $(this).parent().parent().find("label").text();
                                        $("#col").text("");
                                        for (var key in mapcheck) {

                                            $("#col").append(mapcheck[key] + " , ");
                                        }

                                        $("#col").text($("#col").text().slice(0, -2));
                                        console.log(mapcheck.length);
                                    } else {
                                        var tab = $(this).parent().parent().parent().parent().parent().find('div').html().substr(2);

                                        delete mapcheck[tab + '.' + $(this).parent().parent().find("label").text()];

                                        $("#col").text("");
                                        for (var key in mapcheck) {

                                            $("#col").append(mapcheck[key] + " , ");
                                        }
                                        $("#col").text($("#col").text().slice(0, -2));
                                        console.log(mapcheck.length);
                                    }
                                    //  console.log(mapcheck);


                                });

                                $(".coltext").change(function() {
                                	$("#scond").show();
                                    //alert($(this).prev("label").text() + '="' + $(this).val()+'"');    
                                    //console.log($(this).closest("div").find("input").is(":checked"));
                                    var ta = $(this).parent().parent().parent().parent().parent().find('div').html().substr(2);

                                    map[ta + '.' + $(this).parent().find("label").text()] = ta + "." + $(this).parent().find("label").text() + "='" + $(this).val() + "'";
									console.log(map);
                                    if ($(this).val() === "")
                                        delete map[ta + '.' + $(this).prev("label").text()];
                                    console.log(map + " ye bhi");
                                    $("#scond").text("");
                                    for (var key in map) {
                                        $("#scond").append(map[key] + " , ");
                                    }
                                    $("#scond").text($("#scond").text().slice(0, -2));


                                });

                            }

                        },
                        out: function(event, ui) {



                            $(ui.draggable).children('ul').children('li').each(function(i, n) {

                                var t = $(this).parent().parent().find('div').html().substr(2);
                                console.log(map);
                                delete mapcheck[t + '.' + $(this).text()];
                                var de = t + '.' + $(this).text()
                                delete map[de.trim()];
                                /* delete map["Address99.ADDRESS_ID"];
                                console.log("Address99.ADDRESS_ID".length +"        " + de.trim().length); */




                                //delete map["Student99.STUDENT_ID"];
                            });


                            delete mapc[$(ui.draggable).find('div').html().substr(2)];

                            inn.splice(inn.indexOf($(ui.draggable).find('div').html().substr(2)), 1);
                            //console.log(inn);
                            //console.log(grcheck);

                            $("#col").text("");
                            // console.log(mapcheck);
                            for (var key in mapcheck) {

                                $("#col").append(key + ",");
                            }

                            $("#col").text($("#col").text().slice(0, -1));

                            $("#cond").text("");
                            /*  for (var key in map) {
                                 $("#cond").append(map[key] + " AND ");
                             }
                             $("#cond").text($("#cond").text().slice(0, -4)); */



                            for (var e = 0; e < arr.length; e++) {
                                if (arr[e]['id'].startsWith($(ui.draggable).children('div').text().substr(2))) {
                                    arr.splice(e, 1);
                                    e = e - 1;
                                }
                            }


                            //console.log(map);
                            $("#scond").text("");
                            //console.log(map);
                            for (var key in map) {
                                $("#scond").append(map[key] + " , ");
                            }
                            $("#scond").text($("#scond").text().slice(0, -2));




                            var tmp = [{
                                id: '------',
                                label: '------',
                                type: 'string'
                            }];

                            if (arr.length > 0) {
                                $('#queryBuilderGoesHere').queryBuilder('reset');
                                $('#queryBuilderGoesHere').queryBuilder('setFilters', arr);
                            } else {
                                $('#queryBuilderGoesHere').queryBuilder('reset');
                                $('#queryBuilderGoesHere').queryBuilder('setFilters', tmp);
                            }

                            console.log(inn);
                            if (inn.length <= 1) {
                                if (inn.length == 0)
                                    $('#tab').html('');

                                $('#tab').text(inn[0]);
                                $('#inner').html('');
                            } else {
                                $('#tab').text(inn[0]);


                                $('#inner *').each(function() {

                                    if ($(this).is("div")) {
                                        console.log($(this).attr("id").toLowerCase().indexOf($(ui.draggable).find('div').html().substr(2).toLowerCase()));
                                        if ($(this).attr("id").toLowerCase().indexOf($(ui.draggable).find('div').html().substr(2).toLowerCase()) !== -1)
                                            $(this).remove();

                                    }


                                });

                                var tabagain = [];

                                for (var q = 0; q < inn.length; q++) {
                                    var fla = 0;
                                    console.log(inn[q] + " array wala" + $("#tab").text() + " from wala")
                                    if (inn[q] == $("#tab").text())
                                        fla = 1;

                                    $('#inner *').each(function() {

                                        if ($(this).is("div")) {
                                            console.log($(this).attr("id") + "   " + inn[q] + "   check");
                                            var s1 = $(this).attr("id").toLowerCase();
                                            var s2 = inn[q].toLowerCase();
                                            console.log(s1.includes(s2) + " inner wala");
                                            if (s1.includes(s2) === true)
                                                fla = 1;

                                        }


                                    });

                                    console.log(fla + " flaggg");
                                    //console.log($("#"+inn[q]).parent().parent().html());

                                    if (fla === 0) {
                                        console.log("inside");

                                        tabagain.push(inn[q]);




                                        $("#" + inn[q] + "1").parent().children('ul').children('li').each(function(i, n) {
                                            //console.log("_______")
                                            var t = $(this).parent().parent().find('div').html().substr(2);
                                            delete mapcheck[t + '.' + $(this).text()];

                                            // delete arrc[t+'.'+$(this).text()];
                                            delete map[$(this).text()];
                                        });


                                        delete mapc[inn[q]];


                                        //console.log(inn);
                                        //console.log(grcheck);

                                        $("#col").text("");
                                        for (var key in mapcheck) {

                                            $("#col").append(key + ",");
                                        }

                                        $("#col").text($("#col").text().slice(0, -1));

                                        $("#cond").text("");
                                        for (var key in map) {
                                            $("#cond").append(map[key] + " AND ");
                                        }
                                        $("#cond").text($("#cond").text().slice(0, -4));


                                        $("#" + inn[q] + "1").parent().remove();


                                        $('ul#group li').each(function(i, e) {
                                            var li = $(e);
                                            if (li.text().startsWith(inn[q]))
                                                $(this).remove();

                                        });

                                        $('ul#order li').each(function(i, e) {
                                            var li = $(e);
                                            if (li.text().startsWith(inn[q]))
                                                $(this).remove();

                                        });


                                        for (var t = 0; t < arr.length; t++) {
                                            if (arr[t]['id'].startsWith(inn[q])) {
                                                arr.splice(t, 1);
                                                t = t - 1;
                                            }
                                        }




                                        var tm = [{
                                            id: '------',
                                            label: '------',
                                            type: 'string'
                                        }];

                                        if (arr.length > 0) {
                                            $('#queryBuilderGoesHere').queryBuilder('reset');
                                            $('#queryBuilderGoesHere').queryBuilder('setFilters', arr);
                                        } else {
                                            $('#queryBuilderGoesHere').queryBuilder('reset');
                                            $('#queryBuilderGoesHere').queryBuilder('setFilters', tm);
                                        }


                                        inn.splice(inn.indexOf(inn[q]), 1);

                                    }

                                }



                            }


                            // console.log(arr + "__________________________")

                            $('ul#group li').each(function(i, e) {
                                var li = $(e);
                                if (li.text().startsWith($(ui.draggable).find('div').html().substr(2)))
                                    $(this).remove();

                            });

                            $('ul#order li').each(function(i, e) {
                                var li = $(e);
                                if (li.text().startsWith($(ui.draggable).find('div').html().substr(2)))
                                    $(this).remove();

                            });


                            for (var key in grouplist) {

                                if (key.startsWith($(ui.draggable).children('div').text().substr(2))) {
                                    delete grouplist[key];
                                }

                            }

                            for (var key in orderlist) {

                                if (key.startsWith($(ui.draggable).children('div').text().substr(2))) {
                                    delete orderlist[key];
                                }

                            }

                            $("#gcond").text("");
                            for (var key in grouplist) {

                                $("#gcond").append(" " + grouplist[key] + " ,");
                            }

                            $("#gcond").html($("#gcond").html().slice(0, -1));

                            $("#ocond").text("");
                            for (var key in orderlist) {

                                $("#ocond").append(" " + orderlist[key] + "  <select class='form-control' style='width : 100px; display : inline; color : white; background-color : #7AA7C8'><option>ASC</option><option>DESC</option></select>" + " ,");
                            }

                            $("#ocond").html($("#ocond").html().slice(0, -1));



                        }



                    });




                    $("#getsql").addClass("ltblue");

                    var myFilters = [{
                       id: '------',
                        /* label: '------',
                        type: 'string' */
                    }];
                    

                    $("#queryBuilderGoesHere").queryBuilder({

                        filters: myFilters,
                        allow_empty : true,
                        display_errors : false
                    });
                    
                    $('#queryBuilderGoesHere').on('validationError.queryBuilder', function(e) {
                    	console.log(e.error[0] + "errorrrrrrrrrrrrrrrrrrrrr");
                    	  if (e.error[0] == 'no_filter') {
                    	    e.preventDefault();
                    	  }
                    	});
                    
                    $("#getsql").on('click', function() {
                        var sqlob = $("#queryBuilderGoesHere").queryBuilder("getSQL", false);
                        $("#comm").css("visibility", "");
                        $("#from").css("visibility", "");
                        $("#where").css("visibility", "");
                        $("#sql").text(sqlob.sql);
                    });



                    $("#getsql").click(function() {
                    	if($("#sql").text() != "")
                        $("#cond").text($("#sql").text());
                    	else
                    		$("#cond").text("");
                    	
                    });

                    $('.notabtn').prop('disabled', true);

                    $('.form-control').change(function() {

                        $('.form-control').css({
                            'width': '110px',
                            'margin-left': '8px',
                            'margin-right': '10px'
                        });

                    });

                    //console.log($('#comm').text() + '  ' + $('#col').text());



                    $(".notabtn").on('click', function() {

                        if ($('#comm').text() == "SELECT") {


                            //var tmpquery = $('#comm').text() + ' ' + $('#col').text() + ' ' + $('#from').text() + ' ' + $('#tab').text() + ' ' + $('#inner').text() + ' ' + $('#where').text() + ' ' + $('#cond').text() + ' '+ $('#groupby').text() + ' '+$('#gcond').text() + ' '+$('#orderby').text() + ' '+$('#ocond').text() ;
                            query = '';
                            query = $('#comm').text() + ' ' + $('#col').text() + ' ' + $('#from').text() + ' ' + $('#tab').text() + ' ';
                            //alert($("#cond").text());

                            $('#inner *').each(function() {

                                if ($(this).is("select"))
                                    query = query + $("option:selected", this).text();

                                if ($(this).is("p"))
                                    query = query + " " + $(this).text();


                            });

                            query = query + ' ' + $('#where').text() + ' ' + $('#cond').text() + ' ' + $('#groupby').text() + ' ' + $('#gcond').text() + ' ' + $('#orderby').text() + ' ';



                            $('#ocond *').each(function() {

                                if ($(this).is("select"))
                                    query = query + " " + $("option:selected", this).text();

                                if ($(this).is("p"))
                                    query = query + " " + $(this).text();

                                if ($(this).is("span"))
                                    query = query + " " + $(this).text();


                            });




                            if ($.trim($("#cond").html()) == '') {
                                console.log("truec");
                                query = query.replace('WHERE', '');

                            }

                            if ($.trim($("#gcond").html()) == '') {
                                console.log("trueg");
                                query = query.replace('GROUP BY', '');

                            }
                            if ($.trim($("#ocond").html()) == '') {
                                console.log("trueo");
                                query = query.replace('ORDER BY', '');

                            }
                            console.log(query);
                            $("#finalsql").val(query);

                            $('#toggle-text').text("-- select query to execute --");

                        }

                        if ($('#comm').text() == "UPDATE") {
                            query = '';
                            query = $('#from').text() + ' ' + $('#tab').text() + ' ';

                            $('#inner *').each(function() {

                                if ($(this).is("select"))
                                    query = query + $("option:selected", this).text();

                                if ($(this).is("p"))
                                    query = query + " " + $(this).text();


                            });

                            query = query + ' ' + $('#set').text() + ' ' + $('#scond').text() + ' ' + $('#where').text() + ' ' + $('#cond').text();

                            if ($.trim($("#cond").html()) == '') {
                                console.log("truec");
                                query = query.replace('WHERE', '');

                            }

                            $("#finalsql").val(query);

                            $('#toggle-text').text("-- select query to execute --");



                        }



                    });




                    $("#getTable").on('click', function() {


                        if ($("#comm").text() == "UPDATE") {

                          //  alert("Executing query : " + $("#finalsql").val());
                          
                            var input = $("#finalsql").val();
                          var output = "<span>";
                          
                          for(var i = 0 ; i < input.length ; i++)
                        	  {
                        	  var ch = input.charAt(i);
                        	  
                        	  if( ch != "'")
                        		  output = output + ch;
                        	  else
                        		  {
                        		 
                        		  
                        		  i++;
                        		  var tp = input.charAt(i);
                        		  while(input.charAt(i) != "'")
                        			  {
                        			  i++;
                        			  var tp = tp + input.charAt(i);
                        			  }
                        		  output= output + "'</span><input style='width:150px;text-align:center' class='umm' type='text' value='"+tp+"'/>";
                        		  output = output+ "<span>'";
                        		  
                        		  
                        		  }
                        		  
                        	  
                        	  }
                          output = output + "</span>";
                          console.log(output + "outputtttttttttttttttttt");
                          
                          
                          
                          var fquery = $("#finalsql").val();
                          query = fquery;
                          
                          $(".modal-body").html(output);
                          
                        
                          
                          
                          
                         
                           // $(".modal-body").html("<p><strong>EXECUTING QUERY : </strong>"+$("#finalsql").val()+"</p>");
                            $(".modal-button").text("Ok");
                            $("#myModal").modal('show');


                            query = $("#finalsql").val();

                            /*  $("#save").on('click',function(){
                            	   
                            	   
                            	  // alert(query);
                            	   
                               }); */

							$(".modal-button").on('click',function(){
								
							
								
								
							
                            $.ajax({
                                url: 'http://10.1.55.100:7000/first/updateCustom',
                                type: "POST",
                                data: {
                                    'query': query
                                },
                                success: function(response) {

                                }
                            });
                            
							});

                        } else {
                            //alert("Executing query : " + $("#finalsql").val());
                            
                            var input = $("#finalsql").val();
                          var output = "<span>";
                          
                          for(var i = 0 ; i < input.length ; i++)
                        	  {
                        	  var ch = input.charAt(i);
                        	  
                        	  if( ch != "'")
                        		  output = output + ch;
                        	  else
                        		  {
                        		 
                        		  
                        		  i++;
                        		  var tp = input.charAt(i);
                        		  while(input.charAt(i) != "'")
                        			  {
                        			  i++;
                        			  var tp = tp + input.charAt(i);
                        			  }
                        		  output= output + "'</span><input style='width:150px;text-align:center' class='umm' type='text' value='"+tp+"'/>";
                        		  output = output+ "<span>'";
                        		  
                        		  
                        		  }
                        		  
                        	  
                        	  }
                          output = output + "</span>";
                          console.log(output + "outputtttttttttttttttttt");
                          
                          
                          
                          var fquery = $("#finalsql").val();
                          query = fquery;
                          
                          $(".modal-body").html(output);
                          
                        
                          
                          
                          
                         
                           // $(".modal-body").html("<p><strong>EXECUTING QUERY : </strong>"+$("#finalsql").val()+"</p>");
                            $(".modal-button").text("Ok");
                            $("#myModal").modal('show');
                            
                            $(".umm").change(function(){
                            	 
                            	fquery = "";
                            	$('.modal-body *').each(function() {

                                     if ($(this).is("span")) {
                                   	  
                                   	  fquery = fquery + $(this).text();
                                        
                                     }
                                     if($(this).is("input"))
                                   	  fquery = fquery + $(this).val();


                                 });
                                 
                            	 console.log(fquery + "fqueryyyyyyyyy");
                            	 query = fquery;
                            	
                            });
                           
                            
                            
                            
                           // query = $("#finalsql").val();

                            /*  $("#save").on('click',function(){
                            	   
                            	   
                            	  // alert(query);
                            	   
                               }); */

                               $(".modal-button").on('click',function(){
                            
                            	  
                            	   $.ajax({
                                url: 'http://10.1.55.100:7000/first/fetchTable',
                                type: "POST",
                                data: {
                                    'query': query
                                },
                                success: function(response) {
                                    //console.log(Object.keys(mapcheck).length);
                                    console.log($("#finalsql").val() + " whyyyyyyyyyyyyyyyy");
                                    var st = query.indexOf("SELECT") + 7;
                                    var end = query.indexOf("FROM");
                                    var tmps = query.substr(st, end - 8);
                                    var colList = tmps.split(',');
                                    console.log(colList);
                                    var count = 2;
                                    $("#fetch").html(' <tr> </tr>');
                                    for (var i = 0; i < colList.length; i++) {
                                        $("#fetch").find('tr').append(' <th>' + colList[i] + '</th>');

                                    }

                                    $.each($.parseJSON(response), function() {
                                        $("#fetch").append(' <tr> </tr>');
                                        var t = this;
                                        for (var i = 0; i < colList.length; i++) {
                                            $("#fetch").find('tr:nth-child(' + count + ')').append(' <td>' + t[i] + '</td>');
                                        }
                                        count++;

                                    });

                                }
                            });
                            
                               });

                        }




                    });




                    $('input[name="groupcheck"]').change(function() {


                        if ($(this).is(':checked')) {
                            var checkedValues = $('.groupcheck:checked').map(function() {
                                return this.value;
                            }).get();

                            console.log(checkedValues);
                        }
                    });




                    $('#save').on('click', function() {



                        var n = prompt("Name of the query to be saved?");
                        console.log("about to " + query + "  " + n + " save ");

                        $.ajax({
                            url: 'http://10.1.55.100:7000/first/sudQuery',
                            type: "POST",
                            data: {
                                'query': query,
                                'name': n,
                                'type': "save",
                                'new_name': "yolo"
                            },
                            success: function(response) {

                                $.ajax({
                                    url: 'http://10.1.55.100:7000/first/sudQuery',
                                    type: "POST",
                                    data: {
                                        'query': "select * from save_query",
                                        'name': n,
                                        'type': "get",
                                        'new_name': "yolo"
                                    },
                                    success: function(response) {
                                        $(".dropdown-menu").html("");
                                        $.each($.parseJSON(response), function(i, e) {

                                            var th = this;

                                            $(".dropdown-menu").append("<li style='padding-left :10px'><span class='ed'>" + th[0] + "</span><span style = 'float:right;margin-right:8px'class='glyphicon glyphicon-remove'></span><span style = 'float:right;margin-right:8px'class='glyphicon glyphicon-edit'></span><div class='description' style='display:none'>" + th[1] + "</div></li>");


                                        });

                                        $(".dropdown-menu").children("li").each(function() {
                                            $(this).mouseover(function() {
                                                $(this).css("background-Color", "#7AA7C8");
                                                $("#finalsql").val($(this).children(".description").text());
                                                $('#toggle-text').text($(this).children("span").text());

                                                $(this).on('click', function() {
                                                    $('#toggle-text').text($(this).children("span").text());
                                                    $("#finalsql").val($(this).children(".description").text());
                                                });
                                            });
                                            $(this).mouseout(function() {
                                                $(this).css("background-Color", "#FFF");
                                                // $("#finalsql").val("");
                                            });
                                        });


                                        console.log(response + "dropdown list");

                                    }
                                });



                            }
                        });



                    });

                    $(document).on('click', '.dropdown-menu li', function() {
                        $('#toggle-text').text($(this).children("span").text());
                    });




                    $(document).on('click', '.glyphicon-remove', function() {

                        var rem = $(this);

                        console.log($(this).parent().find(".ed").text());
                        $.ajax({
                            url: 'http://10.1.55.100:7000/first/sudQuery',
                            type: "POST",
                            data: {
                                'query': "yolo",
                                'name': $(this).parent().find(".ed").text(),
                                'type': "delete",
                                'new_name': "yolo"
                            },
                            success: function(response) {

                                rem.parent().remove();

                                $('#toggle-text').text("-- select query to execute --");
                                $("#finalsql").val("");


                            }
                        });


                    });


                    $(document).on('click', '.glyphicon-edit', function() {

                        var edit = $(this);
                        var old_name = $(this).parent().find(".ed").text();
                        var editName = prompt("Enter new name for the query " + $(this).parent().find(".ed").text());

                        console.log($(this).parent().find(".ed").text());
                        $.ajax({
                            url: 'http://10.1.55.100:7000/first/sudQuery',
                            type: "POST",
                            data: {
                                'query': "yolo",
                                'name': old_name,
                                'new_name': editName,
                                'type': "update"
                            },
                            success: function(response) {


                                /* 
                                $('#toggle-text').text("-- select query to execute --");
                                $("#finalsql").val(""); */

                                $.ajax({
                                    url: 'http://10.1.55.100:7000/first/sudQuery',
                                    type: "POST",
                                    data: {
                                        'query': "select * from save_query",
                                        'name': "yolo",
                                        'type': "get",
                                        'new_name': "yolo"
                                    },
                                    success: function(response) {
                                        $(".dropdown-menu").html("");
                                        $.each($.parseJSON(response), function(i, e) {

                                            var th = this;

                                            $(".dropdown-menu").append("<li style='padding-left :10px'><span class='ed'>" + th[0] + "</span><span style = 'float:right;margin-right:8px'class='glyphicon glyphicon-remove'></span><span style = 'float:right;margin-right:8px'class='glyphicon glyphicon-edit'></span><div class='description' style='display:none'>" + th[1] + "</div></li>");


                                        });

                                        $(".dropdown-menu").children("li").each(function() {
                                            $(this).mouseover(function() {
                                                $(this).css("background-Color", "#7AA7C8");
                                                $("#finalsql").val($(this).children(".description").text());
                                                $('#toggle-text').text($(this).children("span").text());

                                                $(this).on('click', function() {
                                                    $('#toggle-text').text($(this).children("span").text());
                                                    $("#finalsql").val($(this).children(".description").text());
                                                });
                                            });
                                            $(this).mouseout(function() {
                                                $(this).css("background-Color", "#FFF");
                                                // $("#finalsql").val("");
                                            });
                                        });

                                        $('#toggle-text').text(editName);

                                        console.log(response + "dropdown list");

                                    }
                                });




                            }
                        });


                    });




                });
            </script>
        </head>
        <style>
            /* .btn-group:hover .dropdown-menu {
    display: block;
    margin-top: 0;
 } */

            .description {
                margin-left: 170px;
                margin-bottom: 10px;
                display: none;
                position: absolute;
                background: #F9F9F9;
                border: 1px solid #000;
                font-weight: none;
                width: 400px;
                height: auto;
            }

            .dropdown-toggle {
                cursor: default;
            }


            .dropdown-menu li {
                cursor: pointer;
            }


            table #fetch {
                border-collapse: collapse;
                width: 100%;
            }

            #fetch th,
            td {
                text-align: center;
                padding: 8px;
            }

            #fetch tr:nth-child(even) {
                background-color: #F8F0D6;
                text-align: center;
            }



            .ui-overlay-a,
            .ui-page-theme-a,
            .ui-page-theme-a .ui-panel-wrapper {
                text-shadow: none;
            }


            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                top: 0;
                left: 0;
                height: 100%;
                width: 100%;
                background: rgba( 255, 255, 255, .8) url('http://i.stack.imgur.com/FhHRx.gif') 50% 50% no-repeat;
            }
            /* When the body has the loading class, we turn
   the scrollbar off with overflow:hidden */

            body.loading {
                overflow: hidden;
            }
            /* Anytime the body has the loading class, our
   modal element will be visible */

            body.loading .modal {
                display: block;
            }

            h5 {
                display: inline;
            }

            .btn-primary {
                height: 25px;
            }

            #myContainer {
                zoom: 0.8;
                -moz-transform: scale(0.8);
            }

            .collapsiblelist {
                zoom: 0.9;
                -moz-transform: scale(0.9);
            }
            /* li[id^="t"][id$="c"]
{
zoom: 0.8;
    -moz-transform: scale(0.8);
} */

            {
                zoom: 0.9;
                -moz-transform: scale(0.9);
            }

            .down {
                zoom: 0.9;
                -moz-transform: scale(0.9);
            }

            #getsql {
                border: 1px solid #555;
                margin-right: 10px;
                margin-top: 15px;
                padding: 6px 18px;
                float: right;
                background: #7AA7C8;
            }

            #queryBuilderGoesHere {

                width: 600px;
                float: right;
                width: 560px;
                margin-right: 10px;
            }

            .ltblue {
                background: lightblue;
                color: white;
                font-weight: bold;
                float: right;
            }

            #sql {
                border: 1px solid lightblue;
                padding: 15px;
                width: 600px;
                margin-left: 400px;
                float: right;
            }

            fieldset {
                overflow: hidden;
            }

            nav ul {
                height: 120px;
                width: 220px;
                overflow: hidden;
                overflow-y: scroll;
            }

            nav ul li {
                display: block;
                clear: both;
            }

            .some-class {
                zoom: 0.7;
                -moz-transform: scale(0.7);
            }






            label {
                float: left;
            }

            .colcheck {
                float: left;
            }

            #group-button {
                width: 140px;
                border: 1px solid #555;
                margin-right: 10px;
                padding: 6px 18px;
                float: left;
            }

            #order-button {
                width: 140px;
                border: 1px solid #555;
                margin-right: 10px;
                padding: 6px 18px;
            }


            .coltext {
                float: right;
                overflow: hidden;
            }


            html,
            body {
                height: 100%;
                margin: 0;
                padding: 0;
            }

            .container {
                width: 1285px;
                display: grid;
                grid-template-columns: 200px 600px 485px;
                grid-template-rows: 350px 45px 225px 300px;
                margin-left: 20px;
            }

            .upleft {
                grid-column: 1/2;
                grid-row: 1/2;
                background: #F8F0D6;
                border: 2px solid black;
                overflow-y: scroll;
                border-right: 0px
            }

            .middle {
                grid-column: 1/3;
                grid-row: 2/3;
                background: #7AA7C8;
                border-left: 2px solid black;
            }

            .upright {
                grid-column: 2/3;
                grid-row: 1/2;
                background: #F9F9F9;
                border: 2px solid black;
                border-right: 0px
            }

            .down {
                grid-column: 1/3;
                grid-row: 3/4;
                background: #7AA7C8;
                color: white;
                border-left: 2px solid black;
                border-bottom: 2px solid black;
                overflow-y: scroll
            }

            .right {
                grid-column: 3/4;
                grid-row: 1/4;
                background: #F8F0D6;
                border: 2px solid black;
                overflow-y: scroll
            }

            .below {
                grid-column: 1/4;
                grid-row: 4/5;
                margin-top: 20px;
            }

            #collapse * {
                display: block;
                list-style: none;
                cursor: pointer;
                text-transform: uppercase;
            }



            .ui-checkbox .ui-btn,
            .ui-radio .ui-btn {
                background: #5cb85c;
                color: white;
            }

            .collapsiblelist {
                list-style: none;
                padding-left: 0;
                margin-left: 10px;
            }

            ​​
        </style>

        <body>




            <h2 style="text-align:center; font-family : 'Times New Roman', Times, serif ; font-size : 30px">QUERY BUILDER</h2>
            <div class="container">
                <div class="upleft">

                    <h4 style="margin-top:10px; margin-left:10px;margin-bottom:5px ">Actions</h4>
                    <fieldset>
                        <div class="some-class" style="margin-left : 10px ">
                            <input type="radio" class="radio1" name="COMMAND" value="SELECT" id="SELECT" style="background:white !important" checked />
                            <label for="SELECT">SELECT</label>
                            <input type="radio" class="radio1" name="COMMAND" value="UPDATE" id="UPDATE" />
                            <label for="UPDATE">UPDATE</label>
                            <input type="radio" class="radio1" name="COMMAND" value="DELETE" id="DELETE" />
                           <!--  <label for="DELETE">DELETE</label>
                            <input type="radio" class="radio1" name="COMMAND" value="INSERT INTO" id="INSERT INTO" />
                            <label for="INSERT INTO" style="width : 122px ; text-align : center">INSERT</label>
                        --> </div>
                    </fieldset>

                    <h4 style="margin-top:10px; margin-left:10px ; margin-bottom: 10px">Tables</h4>
                    <ul class="collapsibleList " id="collapse">
                        <c:forEach var="class1" items="${classes}">

                            <li class="btn btn-info" style="background:#7AA7C8 ; width : 160px;margin-bottom : 5px; ">
                                <div style="text-align : left" id="${class1}">+ ${class1}</div>
                                <ul style='list-style:none; padding-left : 20px; text-align : left; '>
                                </ul>
                            </li>
                        </c:forEach>
                </div>
                <div class="upright">
                    <h4 style=" margin-top: 10px ; text-align : center">Canvas</h4>


                </div>
                <div class="middle">
                    <h4 style="margin-top:10px; margin-left :10px ; font-size : 110% ; background : #C9302C ; position : absolute" class="notabtn btn btn-xs btn-danger">SQL Query</h4>

                </div>
                <div class="down" style="width:920px">
                    <div style="margin-left : 10px;">
                        <!--          <h4 style="margin-top:10px; margin-left :10px ; font-size : 120% ; background : #C9302C ; position : absolute" class = "notabtn btn btn-xs btn-danger">SQL Query</h4>
 -->
                        <h4 id="comm" style="visibility :;position:relative;/* margin-top : 100px */"><strong>SELECT</strong></h4>
                        <p id="col"></p>
                        <h4 id="from" style="visibility :"><strong>FROM</strong></h4>
                        <p id="tab"></p>
                        <div id="inner"></div>
                        <h4 id="set"><strong>SET</strong></h4>
                        <div id="scond"></div>
                        <h4 id="where" style="visibility : "><strong>WHERE</strong></h4>
                        <p id="cond"></p>
                        <h4 id="groupby" style="visibility : "><strong>GROUP BY</strong></h4>
                        <div id="gcond"></div>
                        <h4 id="orderby" style="visibility : "><strong>ORDER BY</strong></h4>
                        <div id="ocond"></div>
                    </div>



                </div>

                <div class="right">
                    <h4 style=" margin-top: 10px ; text-align : center">Build Condition Below</h4>
                    <div id="myContainer">
                        <!-- <span style="width : 50px" ><label style ="float:center; margin-right : 10px;margin-left : 10px;font-size : 20px ; width : 120px"><strong>GROUP BY :  </strong></label> <select id="group" style="background: #7AA7C8; color : white"></select></span>
	          <span style="width : 50px" ><label style ="float:center; margin-right : 10px;margin-left : 10px;font-size : 20px ; width : 120px"><strong>ORDER BY :  </strong></label> <select id="order" style="background: #7AA7C8; color : white"></select></span>
	         -->
                        <div style="float:left;margin-left:50px;">
                            <h4><strong>GROUP BY</strong></h4>
                            <nav>
                                <ul style="list-style:none ;padding-left : 10px; text-align : left; background : rgb(249,249,249);border: 2px solid; border-radius: 5px; " id='group'>


                                </ul>
                            </nav>
                        </div>

                        <div style="float:right;margin-right:50px">
                            <h4><strong>ORDER BY</strong></h4>
                            <nav>
                                <ul style="list-style:none;padding-left : 10px; text-align : left; background : rgb(249,249,249);border: 2px solid; border-radius: 5px;" id='order'>


                                </ul>
                            </nav>
                        </div>


                        <br/><br/>
                        <br/><br/>
                        <br/><br/>
                        <br/><br/>

                        <span id="getsql" class="btn btn-info">Get SQL</span>


                        <br/>
                        <br/>
                        <div id="queryBuilderGoesHere"></div>
                        <br/><br/><br/><br/><br/>
                        <div id="sql" hidden></div>
                    </div>


                </div>

                <div class="below">
                    <h4 style="text-align : center ; margin-right:10px">CLICK ON FETCH TABLE TO EXECUTE THE BELOW QUERY</h4>
                    <div class="row">
                        <div class="col-md-4 col-md-offset-3" style="margin-left:430px">
                            <textarea class="form-control" data-role="none" wrap="hard" cols="50" rows="5" name="finalsql" id="finalsql" readonly> </textarea>


                            <div class="btn-group" style="margin-left : 95px;">
                                <button style="width:225px;" type="button" class="btn btn-default  dropdown-toggle" data-toggle="dropdown"><span id="toggle-text">-- select query to execute --</span> <span class="caret"></span>

    </button>
                                <ul class="dropdown-menu" role="menu" style="width:225px">

                                </ul>
                            </div>

                        </div>
                    </div>
                    <input class="btn" type="button" id="getTable" value="Fetch Table!" style="text-align:center;margin-left : 520px;margin-right:20px;display:inline ; margin-top : 20px" />

                    <input class="btn" type="button" id="save" value="Save Query!" style="text-align:center;margin:auto;display:inline ; margin-top : 20px" />


                </div>

            </div>
            <div class=".fintab" style="overflow:scroll">
                <table class="table table-striped" id="fetch" border="2" cellpadding="2" align="center" style='margin-top:30px;width :100px'>
                </table>
            </div>
            <div class="modal">
                <!-- Place at bottom of page -->
            </div>

            <div id="myModal" class="modal fade" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="modal-button btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>

                </div>
            </div>

            </div>




        </body>

        </html>