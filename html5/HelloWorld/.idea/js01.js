/**
 * Created by mac on 13/07/15.
 */
function People(){

}
People.prototype.say=function(){
    alert("hello");
}

function Student{

}
Student.prototype = new People();
Student.prototype.say=function(){
    alert("student says hello.");
}
var s = new Student();
s.say();