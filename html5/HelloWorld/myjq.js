/**
 * Created by mac on 16/07/15.
 */
$.myjq = function(){
    alert("hello myjq");
}

$.fn.myjq=function(){
    $(this).text("hello");
}