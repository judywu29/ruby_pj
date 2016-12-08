/**
 * Created by mac on 15/07/15.
 */
//$(document).ready(function(){
//    //alert("its' done.");
//    $("p").click(function(){
//        $(this).hide();
//    })
//});
//var btn;
$(document).ready(function(){
    //$("button").click(function(){
    //    $("button").dblclick(function(){
    //        $("button").mouseenter(function(){
    //            $("button").mouseleave(function(){
    //   //$("#pid").text("has been changed.")
    //   // $(".pc").text("has been changed as well.")
    //    $(this).hide();
    //});
    //$("#btn").on("click", clickHandler1);
    //$("#btn").on("click", clickHandler2);
    //$("#btn").off("click");
    //$("body").bind("click", bodyHandler);
    //$("div").bind("click", divHandler);
    //$("div").bind("click", divHandler2);
    //self defined event:
    //btn=$("#click");
    //btn.click(function(){
    //    var e = jQuery.Event("MyEvent");
    //    btn.trigger(e);
    //});
    //
    //btn.bind("MyEvent", function(event){
    //    console.log(event);
    //})
    //$("#click").click(function(){
    //    //alert($("#pid").text());//text() //html()
    //    //alert($("#textid").val());
    //    alert($("#aid").attr("href"));
    //});
    //$("#click").click(function(){
    //    $("#pid").text("It has been changed. ");
    //});
    //$("#btn1").click(function(){
    //    $("#pid2").html("<a href='http://www.google.com'>This is good idea. </a>");
    //});
    //
    //$("#btn2").click(function(){
    //    $("#textid").val("Hello. ");
    //});
    //
    //$("#btn3").click(function(){
    //    $("#aid").attr({
    //        "href": "http://www.baidu.com",
    //        "title": "world"
    //    }); //"href", "http://www.baidu.com"
    //});
    //
    //$("#btn4").click(function(){
    //    $("#pid3").text(function(i, ot){
    //        return "old:" + ot + " new: This is new" + (i);
    //    });
    //});
    //
    //$("#click").click(function(){
    //    //$("#pid").append("It has been changed. ");
    //    //$("#pid").prepend("It has been changed. ");//add it the same line before the previous content.
    //    //$("#pid").before("Add before");//add it at new line
    //    //$("#pid").after("Add before");//
    //    //$("#pid").remove();
    //    //$("#pid").empty();
    //    //$("#divid").remove();
    //    $("#divid").empty();
    //});

    //$("#btn1").click(function(){
    //    $("p").hide(1000);//1s
    //});
    //
    //$("#btn2").click(function(){
    //    $("p").show(1000);//1s
    //});
    //
    //$("#btn3").click(function(){
    //    $("p").toggle(1000);//1s
    //});

   //$("#in").on("click", function(){
   // $("#div1").fadeIn(1000);
   //    $("#div2").fadeIn(1000);
   //    $("#div3").fadeIn(1000);
   //})
   // $("#out").on("click", function(){
   //     $("#div1").fadeOut(1000);
   //     $("#div2").fadeOut(1000);
   //     $("#div3").fadeOut(1000);
   // })
   //
   // $("#toggle").on("click", function(){
   //     $("#div1").fadeToggle(1000);
   //     $("#div2").fadeToggle(1000);
   //     $("#div3").fadeToggle(1000);
   // })
   // $("#to").on("click", function(){
   //     $("#div1").fadeTo(1000, 0.5);//淡化， 透明度0-1， 0： 看不到
   //     $("#div2").fadeTo(1000, 0.7);
   //     $("#div3").fadeTo(1000, 0.3);
   // })
   // $("#div1").click(function(){
   //    $("#div2").slideDown(1000);
   // });
   // $("#div3").click(function(){
   //     $("#div2").slideUp(1000);
   // });
   // $("#div4").click(function(){
   //     $("#div2").slideToggle(1000);
   // });

    //callback, complete
    $("#btn1").click(function(){
        //$("p").hide(1000, function(){
        //    alert("automation has finished. ");
        //});
        $("p").css("color", "red").slideUp(1000).slideDown(1000);

    });
});

//function appendText(){
//    //html, jquery, DOM
//    var text1 = "<p>judy</p>"
//    var text2 = $("<p></p>").text("min");
//    var text3 = document.createElement("p");
//    text3.innerHTML = "min wu";
//    $("body").append(text1, text2, text3);
//}

//function bodyHandler(event){
//    conlog(event);
//}
//function divHandler(event){
//    conlog(event);
//    //event.stopPropagation();// stop parent events
//    event.stopImmediatePropagation(); //stop all of events
//}
//
//function divHandler2(event){
//    conlog(event);
//
//}
//
//function conlog(event){
//    console.log(event);
//}

//function clickHandler1(e){
//    console.log("clickHanlder1");
//}
//
//function clickHandler2(e){
//    console.log("clickHanlder2");
//}