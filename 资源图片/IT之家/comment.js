function GetObj(objName)
{
    if (document.getElementById)
    {
        return eval('document.getElementById("' + objName + '")');
    }
    else if (document.layers)
    {
        return eval("document.layers['" + objName + "']");
    }
    else
    {
        return eval('document.all.' + objName);
    }
}

function getTop(e)
{
    var offset=e.offsetTop;
    if(e.offsetParent!=null) offset+=getTop(e.offsetParent);
    return offset;
}

function getLeft(e)
{
    var offset=e.offsetLeft;
    if(e.offsetParent!=null) offset+=getLeft(e.offsetParent);
    return offset; 
}

function appPageMoreStartLoad()
{
    $("#pagecomment").text('加载中 ...');
}

function appPageMoreEndLoad()
{
    $("#pagecomment").text('查看更多 ...');
}

function appAllCommentStartLoad(commentid)
{
    $("#zheDie" + commentid).text('评论加载中 ...');
}

function appAllCommentEndLoad(commentid)
{
    $("#zheDie" + commentid).text('展开所有评论');
}

/******************************************************************************************/
/*旗鱼跳转*/
function showqiyubrowser()
{
    window.location.href = 'qiyubrowser:'+'0';
    event.cancelBubble = true;
}

/*回复评论*/
function ShowReplay(parentid,newsid,floorid,commentid)
{
    window.location.href = 'comment:'+parentid+':'+newsid+':'+floorid+':'+commentid;
    event.cancelBubble = true;
}

/*举报*/
function commentComplain(commentid)
{
    window.location.href = 'commentcomplain:'+commentid;
    event.cancelBubble = true;
}

/*热评展开*/
function showallsinglecomment(commentid)
{
    var taga=document.getElementById('comm_showallsinglecomment' + commentid);
    
    if(taga!=null)
    {
        var toltop = parseFloat($(window).scrollTop());
        var tolleft = parseFloat($(window).scrollLeft());
        var tagaleft = getLeft(taga);
        var tagatop = getTop(taga);
        var tagawidth = taga.offsetWidth;
        var tagaheight = taga.offsetHeight;
        var resultleft = tagaleft + tagawidth/2.0 - tolleft;
        var resulttop = tagatop + tagaheight/2.0 - toltop;
        window.location.href = 'showallsinglecomment:'+commentid+':'+resultleft+':'+resulttop;
    }
    else
    {
        window.location.href = 'showallsinglecomment:'+commentid;
    }
    /*两种阻止方法都可以，选一种即可*/
    event.cancelBubble = true;/*停止冒泡*/
    /*event.stopPropagation(); // 阻止事件的传播*/
}

/*评论排序*/
function commentorderclick()
{
    var object = event.srcElement;
    var newobject=document.getElementById('commentnew');
    var lastobject=document.getElementById('commentlatest');
    
    var newParentNode = newobject.parentNode;
    var lastParentNode = lastobject.parentNode;
    
    if(object==newobject)
    {
        newParentNode.className = 'pay_list_c1 on';
        lastParentNode.className = 'pay_list_c1';
        window.location.href = 'commentorder:'+1;
    }
    else if(object==lastobject)
    {
        newParentNode.className = 'pay_list_c1';
        lastParentNode.className = 'pay_list_c1 on';
        window.location.href = 'commentorder:'+2;
    }
    
    event.cancelBubble = true;
}

/*获取展开按钮位置*/
function getallsinglecommentposition(commentid)
{
    var taga=document.getElementById('comm_showallsinglecomment' + commentid);
    
    if(taga!=null)
    {
        var toltop = parseFloat($(window).scrollTop());
        var tolleft = parseFloat($(window).scrollLeft());
        var tagaleft = getLeft(taga);
        var tagatop = getTop(taga);
        var tagawidth = taga.offsetWidth;
        var tagaheight = taga.offsetHeight;
        var resultleft = tagaleft + tagawidth/2.0 - tolleft;
        var resulttop = tagatop + tagaheight/2.0 - toltop;
        return resultleft+':'+resulttop;
    }
    else
    {
        return '';
    }
}

/*支持反对*/
function commentVote(commentid, typeid)
{
    window.location.href = 'commentvote:'+commentid+':'+typeid;
    event.cancelBubble = true;
}

/*取消支持*/
function cancleCommentVote(commentid, typeid)
{
    window.location.href = 'canclecommentvote:'+commentid+':'+typeid;
    event.cancelBubble = true;
}

/*最热评论支持反对*/
function hotCommentVote(commentid, typeid)
{
    window.location.href = 'hotcommentvote:'+commentid+':'+typeid;
    event.cancelBubble = true;
}

/*最热评论取消支持*/
function cancleHotCommentVote(commentid, typeid)
{
    window.location.href = 'canclehotcommentvote:'+commentid+':'+typeid;
    event.cancelBubble = true;
}

/*显示更多评论*/
function displayCommentLouMore(commentid,commentcount)
{
    //window.location.href = 'displaycommentloumore:'+commentid;
    
    var div1 = document.getElementById("showmorecommentdiv"+commentid);
    if(div1.style.display=='block')
    {
        div1.style.display='none';
        document.getElementById("liGetMore"+commentid).innerHTML = "还有"+commentcount+"条回复，<a onclick=\"displayCommentLouMore("+commentid+","+commentcount+");\">点击查看</a>";
        
        var taga=document.getElementById("lou"+commentid);
        if(taga!=null)
        {
            var toltop = parseFloat($(window).scrollTop());
            var tagatop = getTop(taga);
            var tagaheight = taga.offsetHeight;
            var resulttop = tagatop - toltop;
            if(resulttop < 0)
            {
                var leftleft = $(document).height() - tagatop - tagaheight + 100;
                if(leftleft > document.body.clientHeight)
                {
                    $(window).scrollTop(tagatop + tagaheight - 100);
                }
            }
        }
    }
    else
    {
        div1.style.display='block';
        document.getElementById("liGetMore"+commentid).innerHTML = "<a style=\"display:inline-block;width:100%;\" onclick=\"displayCommentLouMore("+commentid+","+commentcount+");\">收起</a>";
    }
    
    event.cancelBubble = true;
}

/*显示所有*/
function displayCommentLouAll(commentid)
{
    if($("#zheDie" + commentid).text() == '评论加载中 ...')  /*正在加载不加载*/
    {
        return;
    }
    
    appAllCommentStartLoad(commentid);
    
    window.location.href = 'displayCommentLouAll:'+commentid;
}

/*收起*/
function shouQiCommentLouAll(commentid)
{
    window.location.href = 'shouQiCommentLouAll:'+commentid;
}

/*加载下一页*/
function pagecomment(commentid, newsid)
{
    if($("#pagecomment").text() == '加载中 ...')  /*正在加载不加载*/
    {
        return;
    }
    
    if($("#pagecomment").text() == '已无更多数据')  /*已无更多数据不加载*/
    {
        return;
    }
    
    appPageMoreStartLoad();
    window.location.href = 'pagecomment:'+commentid+':'+newsid;
    event.cancelBubble = true;
}

//模拟alert
function sAlert(str)
{
    window.location.href = 'salert:'+str;
}

//打开文章
function opennewsbyid(newsid)
{
    window.location.href = 'opennewsbyid:'+newsid;
}

/*获取评论内容*/
function getcommentcontent(commentid,hot)
{
    var idStr = '';
    if (hot == 1)  //热评
    {
        idStr = 'hotcommentcontent' + commentid;
    }
    else
    {
        idStr = 'commentcontent' + commentid;
    }
    
    var taga=document.getElementById(idStr);
    if(taga!=null)
    {
        return taga.innerText;
    }
    else
    {
        return '';
    }
}

/*获取用户昵称*/
function getcommentusername(commentid,hot)
{
    var idStr = '';
    if (hot == 1)  //热评
    {
        idStr = 'hotcommentusername' + commentid;
    }
    else
    {
        idStr = 'commentusername' + commentid;
    }
    
    var taga=document.getElementById(idStr);
    if(taga!=null)
    {
        return taga.innerText;
    }
    else
    {
        return '';
    }
}

//获取位置
function getshowmoreposition(commentid,hot)
{
    var idStr = '';
    if (hot == 1)  //热评
    {
        idStr = 'hotshowmorebtnli' + commentid;
    }
    else
    {
        idStr = 'showmorebtnli' + commentid;
    }
    
    var li=document.getElementById(idStr);
    if(li!=null)
    {
        var toltop = parseFloat($(window).scrollTop());
        var tolleft = parseFloat($(window).scrollLeft());
        var tagaleft = getLeft(li);
        var tagatop = getTop(li);
        var tagawidth = li.offsetWidth;
        var tagaheight = li.offsetHeight;
        var resultleft = tagaleft + tagawidth/2.0 - tolleft;
        var resulttop = tagatop + 20 - toltop;
        return resultleft+':'+resulttop;
    }
    else
    {
        return '';
    }
}

//打开更多按钮 commentid 评论id hot = 1为最热评论
function showmorebtn(commentid,hot,userid,username)
{
    //获取位置
    window.location.href = 'showmorebtn:'+commentid+':'+hot+':'+userid+':'+username;
    event.cancelBubble = true;
}

function showcommentlink(link)
{
    //获取位置
    window.location.href = 'ruanmeicommentlink'+link;
    event.cancelBubble = true;
}

/******************************************************************************************/

/*支持反对回调函数*/
function appcommentVote(commentid, jmcommentid, typeid, userid)
{
    $.ajax({
           type: "POST",
           url: "http://api.ithome.com/api/comment.asmx/CommentVote",
           data: "commentID=" + commentid + "&typeID=" + typeid + "&userHash=" + userid,
           success: function (msg)
           {
               if ($(msg).text().indexOf("登录软媒通行证") >= 0)
               {
                   window.location.href = 'commentvoteout:'+'1';
               }
               else if ($(msg).text().indexOf("验证手机后") >= 0)
               {
                   window.location.href = 'commentvoteout:'+'2';
               }
               else if ($(msg).text().indexOf("您") >= 0)
               {
                   sAlert($(msg).text());
               }
               else
               {
                   if (typeid == 1)
                   {
                       $("#agree" + commentid).text('取消支持(' + $(msg).text() + ')');
                       if($("#agree" + commentid).attr('href') && ($("#agree" + commentid).attr('href')) != '')
                       {
                           $("#agree" + commentid).attr('href', 'javascript:cancleCommentVote('+commentid+', 1)');
                       }
                       else
                       {
                           $("#agree" + commentid).attr('onclick', 'cancleCommentVote('+commentid+', 1)');
                       }
           
                       $("#agree" + commentid).css({ "position": "relative" });
                       $("#agree" + commentid).append("<span class='flower'></span>");
                       $("#agree" + commentid).find(".flower").css({ "position": "absolute", "text-align": "center", "left": "6px", "top": "-10px", "display": "block", "width": "30px", "height": "30px", "background": "url(comment_agree.gif) left center no-repeat", "opacity": "0" }).animate({ top: '-30px', opacity: '1' }, 300, function () { $(this).delay(300).animate({ top: '-35px', opacity: '0' }, 300) });
                       $("#agree" + commentid).find(".flower").removeClass();
           
                   }
                   else
                   {
                       $("#against" + commentid).text('取消反对(' + $(msg).text() + ')');
                       if($("#against" + commentid).attr('href') && ($("#against" + commentid).attr('href')) != '')
                       {
                           $("#against" + commentid).attr('href', 'javascript:cancleCommentVote(' + commentid + ', 2)');
                       }
                       else
                       {
                           $("#against" + commentid).attr('onclick', 'cancleCommentVote(' + commentid + ', 2)');
                       }
           
                       $("#against" + commentid).css({ "position": "relative" });
                       $("#against" + commentid).append("<span class='shit'></span>");
                       $("#against" + commentid).find(".shit").css({ "position": "absolute", "text-align": "center", "left": "6px", "top": "-60px", "display": "block", "width": "30px", "height": "30px", "background": "url(comment_against.gif) left center no-repeat", "opacity": "0" }).animate({ top: '-30px', opacity: '1' }, 300, function () { $(this).delay(300).animate({ top: '-5px', opacity: '0' }, 300) });
                       $("#against" + commentid).find(".shit").removeClass();
           
                   }
               }
           }
           });
}

/*取消支持回调函数*/
function appcancleCommentVote(commentid, jmcommentid, typeid, userid)
{
    $.ajax({
           type: "POST",
           url: "http://api.ithome.com/api/comment.asmx/CancelCommentVote",
           data: "commentID=" + commentid + "&typeID=" + typeid + "&userHash=" + userid,
           success: function (msg)
           {
               if ($(msg).text().indexOf("登录软媒通行证") >= 0)
               {
                   window.location.href = 'cancelcommentvoteout:'+'1';
               }
               else if ($(msg).text().indexOf("验证手机后") >= 0)
               {
                   window.location.href = 'cancelcommentvoteout:'+'2';
               }
               else if ($(msg).text().indexOf("您") >= 0)
               {
                   sAlert($(msg).text());
               }
               else
               {
                   if (typeid == 1)
                   {
                       $("#agree" + commentid).text('支持(' + $(msg).text() + ')');
                       if($("#agree" + commentid).attr('href') && ($("#agree" + commentid).attr('href')) != '')
                       {
                           $("#agree" + commentid).attr('href', 'javascript:commentVote(' + commentid + ', 1)');
                       }
                       else
                       {
                           $("#agree" + commentid).attr('onclick', 'commentVote(' + commentid + ', 1)');
                       }
                   }
                   else
                   {
                       $("#against" + commentid).text('反对(' + $(msg).text() + ')');
                       if($("#against" + commentid).attr('href') && ($("#against" + commentid).attr('href')) != '')
                       {
                            $("#against" + commentid).attr('href', 'javascript:commentVote(' + commentid + ', 2)');
                       }
                       else
                       {
                           $("#against" + commentid).attr('onclick', 'commentVote(' + commentid + ', 2)');
                       }
                   }
               }
           }
           });
}

/*最热评论支持反对回调函数*/
function apphotCommentVote(commentid, jmcommentid, typeid, userid)
{
    $.ajax({
           type: "POST",
           url: "http://api.ithome.com/api/comment.asmx/CommentVote",
           data: "commentID=" + commentid + "&typeID=" + typeid + "&userHash=" + userid,
           success: function (msg)
           {
               if ($(msg).text().indexOf("登录软媒通行证") >= 0)
               {
                   window.location.href = 'commentvoteout:'+'1';
               }
               else if ($(msg).text().indexOf("验证手机后") >= 0)
               {
                   window.location.href = 'commentvoteout:'+'2';
               }
               else if ($(msg).text().indexOf("您") >= 0)
               {
                   sAlert($(msg).text());
               }
               else
               {
                   if (typeid == 1)
                   {
                       $("#hotagree" + commentid).text('取消支持(' + $(msg).text() + ')');
                       if($("#hotagree" + commentid).attr('href') && ($("#hotagree" + commentid).attr('href')) != '')
                       {
                           $("#hotagree" + commentid).attr('href', 'javascript:cancleHotCommentVote(' + commentid + ', 1)');
                       }
                       else
                       {
                           $("#hotagree" + commentid).attr('onclick', 'cancleHotCommentVote(' + commentid + ', 1)');
                       }
           
                       $("#hotagree" + commentid).css({ "position": "relative" });
                       $("#hotagree" + commentid).append("<span class='flower'></span>");
                       $("#hotagree" + commentid).find(".flower").css({ "position": "absolute", "text-align": "center", "left": "6px", "top": "-10px", "display": "block", "width": "30px", "height": "30px", "background": "url(comment_agree.gif) left center no-repeat", "opacity": "0" }).animate({ top: '-30px', opacity: '1' }, 300, function() { $(this).delay(300).animate({ top: '-35px', opacity: '0' }, 300) });
                       $("#hotagree" + commentid).find(".flower").removeClass();
           
                   }
                   else
                   {
                       $("#hotagainst" + commentid).text('取消反对(' + $(msg).text() + ')');
                       if($("#hotagainst" + commentid).attr('href') && ($("#hotagainst" + commentid).attr('href')) != '')
                       {
                           $("#hotagainst" + commentid).attr('href', 'javascript:cancleHotCommentVote(' + commentid + ', 2)');
                       }
                       else
                       {
                           $("#hotagainst" + commentid).attr('onclick', 'cancleHotCommentVote(' + commentid + ', 2)');
                       }
           
                       $("#hotagainst" + commentid).css({ "position": "relative" });
                       $("#hotagainst" + commentid).append("<span class='shit'></span>");
                       $("#hotagainst" + commentid).find(".shit").css({ "position": "absolute", "text-align": "center", "left": "6px", "top": "-60px", "display": "block", "width": "30px", "height": "30px", "background": "url(comment_against.gif) left center no-repeat", "opacity": "0" }).animate({ top: '-30px', opacity: '1' }, 300, function() { $(this).delay(300).animate({ top: '-5px', opacity: '0' }, 300) });
                       $("#hotagainst" + commentid).find(".shit").removeClass();
           
                   }
               }
           }
           });
}

/*最热评论取消支持回调函数*/
function appcancleHotCommentVote(commentid, jmcommentid, typeid, userid)
{
    $.ajax({
           type: "POST",
           url: "http://api.ithome.com/api/comment.asmx/CancelCommentVote",
           data: "commentID=" + commentid + "&typeID=" + typeid + "&userHash=" + userid,
           success: function (msg)
           {
               if ($(msg).text().indexOf("登录软媒通行证") >= 0)
               {
                   window.location.href = 'cancelcommentvoteout:'+'1';
               }
               else if ($(msg).text().indexOf("验证手机后") >= 0)
               {
                   window.location.href = 'cancelcommentvoteout:'+'2';
               }
               else if ($(msg).text().indexOf("您") >= 0)
               {
                   sAlert($(msg).text());
               }
               else
               {
                   if (typeid == 1)
                   {
                       $("#hotagree" + commentid).text('支持(' + $(msg).text() + ')');
                       if($("#hotagree" + commentid).attr('href') && ($("#hotagree" + commentid).attr('href')) != '')
                       {
                           $("#hotagree" + commentid).attr('href', 'javascript:hotCommentVote(' + commentid + ', 1)');
                       }
                       else
                       {
                           $("#hotagree" + commentid).attr('onclick', 'hotCommentVote(' + commentid + ', 1)');
                       }
                   }
                   else
                   {
                       $("#hotagainst" + commentid).text('反对(' + $(msg).text() + ')');
                       if($("#hotagainst" + commentid).attr('href') && ($("#hotagainst" + commentid).attr('href')) != '')
                       {
                           $("#hotagainst" + commentid).attr('href', 'javascript:hotCommentVote(' + commentid + ', 2)');
                       }
                       else
                       {
                           $("#hotagainst" + commentid).attr('onclick', 'hotCommentVote(' + commentid + ', 2)');
                       }
                   }
               }
           }
           });
}

/*评论管理页举报回调函数*/
function appCommentComplain(commentid,u,p,orgcommentid)
{
    $.ajax({
           type: "POST",
           url: "http://www.ithome.com/ithome/ithome.asmx/ComplainComment",
           data: "strCommentID=" + commentid + "&username=" + u + "&pwd=" + p,
           success: function (message)
           {
           $("#complainmessage" + orgcommentid).html("<span style=\"color:red;\" class=\"jubao\">" + $(message).text() + "&nbsp;&nbsp;</span>");
           $(".jubao").delay(1500).fadeOut("slow");
           }
           });
}

/*评论页举报回调函数*/
function appCommentComplainOut(commentid,u,p,orgcommentid)
{
    $.ajax({
           type: "POST",
           url: "http://www.ithome.com/ithome/ithome.asmx/ComplainComment",
           data: "strCommentID=" + commentid + "&username=" + u + "&pwd=" + p,
           success: function (message)
           {
           window.location.href = 'commentcomplainout:'+$(message).text();
           }
           });
}

/*帖子管理页举报回调函数*/
function appForumComplain(commentid,u,orgcommentid)
{
    $.ajax({
           type: "POST",
           url: "http://apiquan.ithome.com/s/reply.asmx/ReplyComplain",
           data: "strReplyID=" + commentid + "&userHash=" + u,
           success: function (message)
           {
           $("#complainmessage" + orgcommentid).html("<span style=\"color:red;\" class=\"jubao\">" + $(message).text() + "&nbsp;&nbsp;</span>");
           $(".jubao").delay(1500).fadeOut("slow");
           }
           });
}

/*加载下一页回调函数*/
function appinsertpagemorecomment(insertstr, newsid, lastcommentid, lastlou)
{
    $("<div/>").html(unescape(insertstr)).appendTo($("#ulcommentlist")).fadeIn('slow');
    if (lastlou < 2)
    {
        appPageMoreEndLoad();
        $(".more_comm").hide();
    }
    else
    {
        appPageMoreEndLoad();
        
        if($("#pagecomment").attr('href') && ($("#pagecomment").attr('href')) != '')
        {
            $("#pagecomment").attr('href', 'javascript:pagecomment(' + lastcommentid + ',' +  newsid +')');
        }
        else
        {
            $("#pagecomment").attr('onclick', 'pagecomment(' + lastcommentid + ',' +  newsid +')');
        }
    }
}

/*隐藏加载更多按钮*/
function cancelpagemorecomment()
{
    $("#pagecomment").text('已无更多数据');
    /*$(".more_comm").hide();*/
}

/*显示更多评论回调函数*/
function appinsertdisplaycommentloumore(insertstr, commentid)
{
    $("<div/>").html(unescape(insertstr)).appendTo($("#lou" + commentid));
    $("#liGetMore" + commentid).hide();
}

/*显示全部评论回调函数*/
function appinsertdisplaycommentlouall(insertstr, commentid, bzhan)
{
    document.getElementById("entry"+commentid).innerHTML = unescape(insertstr);
    
    if(bzhan != 1)
    {
        var taga=document.getElementById("entry"+commentid);
        
        if(taga!=null)
        {
            var toltop = parseFloat($(window).scrollTop());
            var tagatop = getTop(taga);
            var tagaheight = taga.offsetHeight;
            var resulttop = tagatop - toltop;
            if(resulttop < 0)
            {
                var leftleft = $(document).height() - tagatop - tagaheight + 150;
                if(leftleft > document.body.clientHeight)
                {
                    $(window).scrollTop(tagatop + tagaheight - 150);
                }
            }
        }
    }
}

/*回复评论回调函数*/
function appQuickCommentLoadData(insertstr,commentid)
{
    $("#lou" + commentid).show();
    $("<div/>").html(unescape(insertstr)).appendTo($("#lou" + commentid));
    
    /*var ReplyDiv = GetObj('Reply' + commentid);
    ReplyDiv.style.display = 'none';
    ReplyDiv.innerHTML = "";*/
}

//判断图片是否加载完成
function LoadDefaultHeaderImage()
{
    var img=event.srcElement;
    
    img.src = img.attributes['defaultImagesrc'].nodeValue;
}

/*评论回调函数*/
function appLoadData(insertstr)
{
    $("<div/>").html(unescape(insertstr)).appendTo($("#LoadArticleReply"));
}

/*取消最新标记*/
function cancelZuiXinTag()
{
    var children = document.getElementsByTagName('span');
    //获取元素的class为className的所有元素
    for (var i = 0; i < children.length; i++)
    {
        var child = children[i];
        var classNames = child.className.split(' ');
        if (classNames.length == 1)
        {
            if (classNames[0] == 'p_floor')
            {
                var tmpTest = child.innerText;
                tmpTest = tmpTest.replace(' 新','');
                tmpTest = tmpTest.replace('新','');
                child.innerText = tmpTest;
                child.className = 'p_normalfloor';
            }
        }
    }
}

/******************************************************************************************/

$(window).scroll(function()
                 {
                     totalheight = parseFloat(document.body.clientHeight) + parseFloat($(window).scrollTop());
                     if($(document).height() <= totalheight + 80)
                     {
                         if($("#pagecomment").text() == '查看更多 ...')
                         {
                             if($(".more_comm").is(":visible"))
                             {
                                 document.getElementById("pagecomment").click();
                             }
                         }
                     }
                 });

