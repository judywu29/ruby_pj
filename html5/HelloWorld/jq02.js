/**
 * Created by mac on 16/07/15.
 */
//var myjq = $.noConflict();//use jQuery

var timeoutid;
$(document).ready(function(){
    $("li").each(function(index){
        var node = $(this);
        $(this).mouseover(function(){
            timeoutid = setTimeout(function(){
                $("div.content").removeClass("content");
                $("#first li.tablein").removeClass("tablein");
                $("div").eq(index).addClass("content");
                node.addClass("tablein");
            }, 300);

        }).mouseout(function(){
            clearTimeout(timeoutid);
        });
    })

    $("#realcontent").load("newpage.html");
    $("#table2 li").each(function(index){
        $(this).click(function(){
            $("#table2 li.tablein").removeClass("tablein");
            $(this).addClass("tablein");
            if(index==0){
                $("#realcontent").load("newpage.html");
            }else if(index==1){
                $("#realcontent").load("newpage.html");//加载部分文件,加载jsp文件中部分元素
            }else if(index==2){
                $("#realcontent").load("newpage.html");//upload all file.
            }
        })
    })
//$(window).on("load", function(){
//    imgLocation();
//    var dataImg = {"data":[{"src":"images/1.jpg"},{"src":"images/2.jpg"}, {"src":"images/3.jpg"}, {"src":"images/4.jpg"}]};
//    window.onscroll = function(){
//        if(scrollside()){
//            $.each(dataImg.data, function(index, value){
//                var box = $("<div>").addClass("box").appendTo("container");
//                var content = $("<div>").addClass("content").appendTo("box");
//                var imge = $("<img>").attr("href", $(value).attr("src")).appendTo("content");
//            });
//            imgLocation();
//        }
//    };
//});


    //first last eq filter not
    //$("div p").first().css({border: "3px solid red"});
    //$("div p").last().css({border: "3px solid red"});
    //$("div p").eq(1).css({border: "3px solid red"});//start from 0
    //$("div p").filter("p").css({border: "3px solid red"});//all equal p, change
    //$("div p").not("a").css({border: "3px solid red"});

    //siblings, next, nextAll, nextUntil, prev, prevAll, preUntil
    //$("h4").siblings().css({border: "3px solid red"});//all his siblings changed. except h4
    //$("h4").next().css({border: "3px solid red"});//h5
    //$("h4").nextAll().css({border: "3px solid red"});//h5, h6
    //$("h4").nextUntil("h6").css({border: "3px solid red"});//range: only h5
    //$("h4").prev().css({border: "3px solid red"});//only h3
    //$("h4").prevAll().css({border: "3px solid red"});//all above h4
    //$("h4").prevUntil("p").css({border: "3px solid red"});//not include p


    //parent, parents, parentUntil()
    //$("a").parent().css({border: "3px solid red"});//p changed. direct parent
    //$("a").parents("#div1").css({border: "3px solid red"});//all parents/ if define div1, only div1 change
    //$("a").parentsUntil("#div1").css({border: "3px solid red"});//range, not include a and div1

    //children, find
    //$("#div1").children("#div2").css({border: "3px solid red"});//only valid for his direct son, argument is optional(#div2)
    //$("#div1").find("a").css({border: "3px solid red"});//can be applied to all his inheritence.
   //$("#btn").click(function(){
   //    $("#resultid").text("geting the data, pls wait. ");
   //
   //    $.get("ajax.php", {name: $("#namevalue").val()}, function(data){//data is return value or post
   //        alert("hello");
   //         $("#resultid").text(data);
   //    }).error(function(){
   //        $("#resultid").text("something wrong with communication. ");
   //    });
   //});
   // $("body").text("loading data");
   // //alert("hello");
   // $("body").load("box.htm", function(a, status, c){
   //     console.log(status);
   //
   //     if(status=="error"){
   //         $("body").text("load faild.");
   //     }
   // });
   // //say hello after finishing load:
   // $.getScript("HelloJs.js").complete(function(){
   //     sayHello();
   // });

    //alert($("#divid").innerHeight() );//width()

    //$.myjq();
    //$("div").myjq();
    //myjq("#btn").click(function(){
    //    myjq("div").text("world");
    //});
    //$("div").css("width", "100px");
    //$("div").css("height", "100px");
    //$("div").css("background", "red");

    //$("div").addClass("style1"); //use css class from css file
    //$("div").click(function(){
    //    //$(this).addClass("style2");
    //    $(this).toggleClass("style2");//removeClass
    //});
    //$("div").css({
    //    width: "100px", height:"100px", backgroundColor:"blue"
    //});
});

function scrollside(){
    var box = $(".box");
    var lastboxHeight = box.last().get(0).offsetTop+Math.floor(box.last().height()/2);
    var docHeight = $(document).width();
    var scrollHeight = $(window).scrollTop();
    return (lastboxHeight<scrollHeight+docHeight)?true:false;
}
function imgLocation(){
    var box = $(".box");
    var width = box.eq(0).width();
    var num = Math.floor($(window).width()/width);

    var heightArray = [];
    box.each(function(index, value){
       console.log(index + "--" + value);
        var height = box.eq(index).height();
        if(index<num){
            heightArray[index] = height;
        }
        else{
            var minHeight = Math.min.apply(null, heightArray);
            var minboxindex = $.inArray(minHeight, heightArray);
            $(value).css({
                "position": "absolute",
                "top":minHeight,
                "left": box.eq(minboxindex).position().left
            });
            heightArray[minboxindex] += box.eq(index).height();
        }
    });
}
