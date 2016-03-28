<script type="text/javascript">
var news_content = document.getElementById("content");
var video = news_content.getElementsByTagName("embed"); 
for(var i = 0; i<video.length; i++)
{
	//if (video[i].width >320)
	//{
	//	video[i].width = 320;
	//	video[i].height =240 ;
	//}
    video[i].parentNode.removeChild(video[i]);
}
</script>

<script type="text/javascript">
          //设置字体 by hk 2007-3-9
          function SetFont(size)
          {
              var divBody = document.getElementById("content");
              if(!divBody)
              {
                  return;
              }
              divBody.style.fontSize = size + "px";
              var divChildBody = divBody.childNodes;
              for(var i = 0; i < divChildBody.length; i++)
              {
                  if (divChildBody[i].nodeType==1)
                  {
                      divChildBody[i].style.fontSize = size + "px";
                  }
              }
          }
 </script>

<script type="text/javascript">
function setADImg(sizeWidth,sizeHeight)
{
    var divBody = document.getElementById("container");
    if(!divBody)
    {
        return;
    }
    divBody.style.width = sizeWidth + "px";
    divBody.style.height = sizeHeight + "px";
    
    var lis = divBody.getElementsByTagName('li');
    var imgs = divBody.getElementsByTagName('img');
    for(var i = 0; i < lis.length; i++)
    {
        lis[i].style.width = sizeWidth + "px";
        lis[i].style.height = sizeHeight + "px";
    }
    for(var i = 0; i < imgs.length; i++)
    {
        imgs[i].style.width = sizeWidth + "px";
        imgs[i].style.height = sizeHeight + "px";
    }
}
</script>
 
 <script type="text/javascript">
          //判断图片是否加载完成
          function IsImageLoaded()
          {
              var img=event.srcElement;

              if(img.src.indexOf("ruanmei_webview_defaultimage.png") > 0)
              {
                  img.src = img.attributes['loadingsrc'].nodeValue;
              }
              else if(img.src.indexOf("ruanmei_webview_loadingimage.gif") > 0)
              {
              }
              else
              {
                   if(img.complete)
                   {
                       var imagesrc = img.attributes['originsrc'].nodeValue;
                       document.location = imagesrc.replace("http://","ruanmeipic://");
                   }
                   else
                   {
                       //未加载完成时，咱不放大图片，以后可以修改
                       //img.src = img.attributes['originsrc'].nodeValue;
                   }
              }
          }
 </script>
 
  <script type="text/javascript">
          //判断图片是否加载完成
          function imageload()
          {
              var img=event.srcElement;

              if(img.src.indexOf("ruanmei_webview_loadingimage.gif") > 0)
              {
                  img.src = img.attributes['originsrc'].nodeValue;
              }
              else
              {
              }
          }
 </script>

<script type="text/javascript">
//判断图片是否加载完成
function LoadDefaultHeaderImage()
{
    var img=event.srcElement;
    
    img.src = img.attributes['defaultImagesrc'].nodeValue;
}
</script>

<script type="text/javascript">
          //处理#down
          function downfun()
          {
              location.href = "#down";
              //window.location.hash="down";  //此句只在第一次点击起作用，后面不起作用，所以不使用
          }
</script>

<script type="text/javascript">
//打开评论页
function showpagecomment()
{
    window.location.href = 'showpagecomment:';
}
</script>

<script type="text/javascript">
          //点击相关文章
          function clickRelateNews(newsid)
          {
              window.location.href = 'openxiangguannews:'+ newsid;
          }
</script>

<script type="text/javascript">
window.onload=function()//不能使用此函数判断页面是否加载完成，此函数只有图片加载完毕才会调用
{
}
</script>
 
<script src="jquery.min.js"></script>
<script src="jquery.lazyload.js"></script>
<script type="text/javascript" charset="utf-8">$(function () { $("img.lazy").lazyload(); });</script>

<script type="text/javascript">
function setADStyle () {
    var index = 0;
    var adtimer;
    var _wrap = $("#container ol");
    var len = $("#container ol li").length;
    if (len > 1) {
        $("#container").mousedown(function()
                                  {
                                  clearInterval(adtimer);
                                  }).mouseup(function()
                                             {
                                             adtimer = setInterval(function () {
                                                                   var _field = _wrap.find('li:first');
                                                                   var _h = _field.height();
                                                                   _field.animate({
                                                                                  marginTop: -_h + 'px'
                                                                                  },
                                                                                  500,
                                                                                  function () {
                                                                                  _field.css('marginTop', 0).appendTo(_wrap);
                                                                                  })
                                                                   
                                                                   },
                                                                   #admillisec#);
                                             }).trigger("mouseup");
        
        /*function showImg(index) {
         var Height = $("#container").height();
         $("#container ol").stop().animate({
         marginTop: -_h + 'px'
         },
         1000);
         }*/
        
        /*$("#container").mouseover(function () {
         $("#container .mouse_direction").css("display", "block");
         });
         $("#container").mouseout(function () {
         $("#container .mouse_direction").css("display", "none");
         });*/
    }
    
    $("#container").find(".mouse_top").click(function () {
                                             var _field = _wrap.find('li:first');
                                             var last = _wrap.find('li:last');
                                             var _h = last.height();
                                             $("#container ol").css('marginTop', -_h + "px");
                                             last.prependTo(_wrap);
                                             $("#container ol").animate({
                                                                        marginTop: 0
                                                                        },
                                                                        500,
                                                                        function () {
                                                                        })
                                             });
    $("#container").find(".mouse_bottom").click(function () {
                                                var _field = _wrap.find('li:first');
                                                var _h = _field.height();
                                                _field.animate({
                                                               marginTop: -_h + 'px'
                                                               },
                                                               500,
                                                               function () {
                                                               _field.css('marginTop', 0).appendTo(_wrap);
                                                               })
                                                });
}
</script>

<script type="text/javascript">
function appinserthotcomment(insertstr)
{
    document.getElementById("newshotcomment").innerHTML = unescape(insertstr);
    var div = document.getElementById("related");
    var liList = div.getElementsByTagName("li");
    if(liList.length > 0)
    {
        liList[liList.length-1].style.borderBottomStyle = "solid";
    }
}
</script>

<script type="text/javascript">
function padappinserthotcomment(insertstr)
{
    document.getElementById("newshotcomment").innerHTML = unescape(insertstr);
}
</script>

<script type="text/javascript">
function appinsertrelatednews(insertstr)
{
    document.getElementById("related").innerHTML = unescape(insertstr);
    
    var commentdiv = document.getElementById("newshotcomment");
    var commentliList = commentdiv.getElementsByTagName("li");
    var div = document.getElementById("related");
    var liList = div.getElementsByTagName("li");
    
    div.className = 'related_post';
    
    if(liList.length > 0)
    {
        if(commentliList.length > 0)
        {
            liList[liList.length-1].style.borderBottomStyle = "solid";
        }
    }
}
</script>

<script type="text/javascript">
function padappinsertrelatednews(insertstr)
{
    document.getElementById("related").innerHTML = unescape(insertstr);
    var div = document.getElementById("related");
    div.className = 'related_post';
}
</script>

<script type="text/javascript">
//处理乐视视频自动加载 不起作用此函数
function fix_letv_video()
{
    $("video").each(function () {
                    var src = $(this).attr('src');
                    var tag = "letv.";
                    if(src.indexOf(tag)!=-1)
                    {
                        $(this).removeAttr("preload");
                        $(this).attr("style", "width:100%;");
                        $(this).parent().attr("style", "width:100%;");
                        $(this).parent().parent().attr('style', "width:100%;");
                        $(this).parent().parent().parent().attr('style', "width:100%;");
                    }
                    });
}
</script>