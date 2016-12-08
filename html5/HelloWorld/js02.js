///**
// * Created by mac on 13/07/15.
// */
///**
// * Created by mac on 13/07/15.
// */
//
////encapulation
//(function(){
//    var n = "hello";
//    function People(name){
//        this._name = name;
//    }
//    People.prototype.say = function(){
//        alert(n + this._name);
//    }
//    window.People = People;
//}()); //execute it.
//
//
//function Student(name){
//    this._name = name;
//}
//Student.prototype = new People();
//var superSay = Student.prototype.say;//People's say
//Student.prototype.say=function(){
//    superSay.call(this);
//    alert("student says hello." + this._name);
//}
//var s = new Student("judy");
//s.say();

function People(name){
    var _this ={}
    _this.say = function(){
        alert("hello");
    }
    _this._name = name;
    return _this;
}
//inheritance
function Student(name){
    var _this = People(name);
    var supSay = _this.say;
    _this.say = function(){
        supSay.call(_this);
        alert("student " + _this._name + " says hello");
    }
    return _this;
}
var s = Student("judy");
s.say();