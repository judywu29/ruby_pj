/**
 * Created by mac on 13/07/15.
 */

window.onload = function(){
    imgLocation("container", "box");
    var imgDate = {"data":[{"src":"images/2.jpg"}, {"src":"images/4.jpg"}, {"src":"images/5.jpg"},
        {"src":"images/6.jpg"},{"src":"images/7.jpg"},{"src":"images/8.jpg"}]};
    window.onscroll = function(){
        if(checkFlag()){
            var cp = document.getElementById("container");
            for(var i = 0; i<imgDate.data.length; i++){
                var ccontent = document.createElement("div");
                ccontent.className = "box";
                cp.appendChild(ccontent);

                var boximage = document.createElement("div");
                boximage.className="image";
                ccontent.appendChild(boximage);

                var img = document.createElement("img");
                img.src=imgDate.data[i].src;
                boximage.appendChild(img);
            }
            imgLocation("container", "box");
        }
    }
}

function checkFlag(){
    var cp = document.getElementById("container");
    var ccontent = getChildElem(cp, "box");
    var lastImageHeight = ccontent[ccontent.length-1].offsetTop;
    var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
    var pageHeight = document.documentElement.clientHeight || document.body.clientHeight;
    if(lastImageHeight < scrollTop + pageHeight)
        return true;
    else return false;

}
function imgLocation(parent, content){
    var cp = document.getElementById(parent);
    var ccontent = getChildElem(cp, content);
    console.log(ccontent);
    var imagewidth = ccontent[0].offsetWidth;
    var cols = Math.floor(document.documentElement.clientWidth/imagewidth);
    cp.style.cssText = "width:" + imagewidth*cols+"px;margin:0 auto";

    var boxHeight = [];
    for(var i = 0; i<ccontent.length; i++){
        if(i<cols){
            boxHeight.push(ccontent[i].offsetHeight);
        }
        else{
            var minHeight = Math.min.apply(null, boxHeight);
            var minLocation = getminheightLocation(boxHeight, minHeight);
            console.log(minHeight);
            ccontent[i].style.position = "absolute";
            ccontent[i].style.top = minHeight+"px";
            ccontent[i].style.left = ccontent[minLocation].offsetLeft+"px";
            boxHeight[minLocation] = boxHeight[minLocation] + ccontent[i].offsetHeight;
        }

    }
}
function getminheightLocation(boxheight, minHeight){
    for(var i in boxheight){
        if(boxheight[i] == minHeight)
        return i;
    }
}
function getChildElem(parent, content){
    var contentArray = [];
    var allContent = parent.getElementsByTagName("*");
    for(var i = 0; i<allContent.length;i++){
        if(allContent[i].className == content){
            contentArray.push(allContent[i]);

        }
    }
    return contentArray;
}