<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.css">
<script src="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.js"></script>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
<meta charset="utf-8">
<@c.page>
    <#if theme=="Fruit">
        <body background="../static/fruit.jpg" style="background-size: 100%;">
    <#else>
        <#if theme=="Vegetables">
            <body background="../static/vegetables.jpg" style="background-size: 100%;">
        <#else>
                <body class="bg-light">
        </#if>
    </#if>

<form action="/Recipes" method="post" enctype="multipart/form-data">
    <input type="hidden" name="summId" value="${summ.id}">
    <p></p>

    <style type="text/css">
        #rating_arr {
            width: 320px;
            text-align: right;
        }
        #rating_arr div { float: left; }
        #rating_arr p { margin: 0; padding: 0; }
        .param {
            width: 110px;
            margin: 0 20px 0 0;
            text-align: right;
        }
        .param, .rating, #summ { line-height: 28px; }
        .stars_progress, #sum_stars { background: url(../static/stars.png); }
        .stars_progress, #sum_stars, .progress_stars, #sum_progress {
            width: 130px;
            height: 28px;
            cursor: pointer;
        }
        .progress_stars { background: #FFEE00; }
        #sum_progress { background: #00EE00; }
        .rating, #summ {
            margin: 0 0 0 20px;
            font-weight: bold;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function() {
            if($('.stars_progress').attr('title') != 0){
                $('.stars_progress').toggleClass('fixed');
                $('.progress_stars').width(Math.round($('.stars_progress').width() * $('.stars_progress').attr('title') / 5));
            }
            $('#sum_progress').width(Math.round($('.stars_progress').width() * $('#sum_stars').attr('title') / 5));
            function move(e, obj) {
                var summ = 0;
                var id = obj.next().attr('id').substr(1);
                var progress = e.pageX - obj.offset().left;
                var rating = progress * 5 / $('.stars_progress').width();
                $('#param' + id).text(rating.toFixed(1));
                obj.next().width(progress);
                $('.rating').each(function () {
                    summ += parseFloat($(this).text());
                });
                summ = summ / $('.rating').length;
                return rating;
            }

            $('#rating_arr .stars_progress').click(function(e){
                if ($(this).attr("class")!="stars_progress fixed") {
                    $(this).toggleClass('fixed');
                    var rating = move(e, $(this));
                    var idS = document.getElementById("summId").value;
                    $.ajax({
                        url: '/save',
                        data: ({
                            "rating": rating,
                            "idSummaries": idS
                        }),
                        type: 'post',
                        success: function (settings) {
                            if (settings == "1") {
                                window.location.reload();
                            } else {
                                document.location.href = "http://localhost:8080/login?logout";
                            }
                        }
                    });
                }
            })

            $('#rating_arr .stars_progress').on('mousemove', function(e){
                if ($(this).hasClass('fixed')==false) move(e, $(this));
            });
            $('#rating_arr [type=submit]').click(function(){
                summ = parseFloat($('#summ').text());
                jQuery.post('change_rating.php', {
                    obj_id: $(this).attr('id').substr(3),
                    rating: summ
                }, notice);
            });

            function notice(text){
                $('#message').fadeOut(500, function(){ $(this).text(text); }).fadeIn(2000);
            }
        });
    </script>

    <div></div>

    <#if theme=="Fruit">
        <div class="col-9 rounded"  style="display: inline-block; background: url(../static/fruitBackground.jpg);">
    <#else>
        <#if theme=="Vegetables">
            <div class="col-9 rounded"  style="display: inline-block; background: url(../static/vegetablesBackground.jpg);">
        <#else>
                <div class="col-9"  style="display: inline-block;">
        </#if>
    </#if>

    <div>
             <#if summ.imageURL!="">
                 <img  class="img-fluid rounded float-left text-center" style="width: 300px; height: 200px; border: solid 4px #FFCC00" src="${summ.imageURL?if_exists}" >
             <#else>
             <img  class="img-fluid rounded float-left text-center" style="width: 300px; height: 200px; border: solid 4px #FFCC00" src="http://vollrath.com/ClientCss/images/VollrathImages/No_Image_Available.jpg" >
             </#if>
    </div>
    <div class="text-center"> <h2><u>${summ.title}</u></h2></div>
    <div style="margin-left: 350px;">
    <#if language=="Russian">
        Описание: ${summ.descript}
        <br>Основные ингредиенты: ${summ.number}
        <br>Ваш рейтинг:
        <div id="rating_arr">
            <div class="stars_progress"  title="${rating}"></div><p class="progress_stars" id="p3"></p>
        </div>
        <br>Общий рейтинг:
        <div id="rating_arr">
        <#--<div class="stars_progress"  title="${rating}"></div><p class="progress_stars" id="p3"></p>-->
            <div id="sum_stars" title="${summ.getRatings()}"></div><p id="sum_progress"></p>
        </div>
    <#else>
        Description: ${summ.descript}
        <br>Main ingredients: ${summ.number}
        <br>Your rating:
        <div id="rating_arr">
            <div class="stars_progress"  title="${rating}"></div><p class="progress_stars" id="p3"></p>
        </div>
        <br>General rating:
        <div id="rating_arr">
        <#--<div class="stars_progress"  title="${rating}"></div><p class="progress_stars" id="p3"></p>-->
            <div id="sum_stars" title="${summ.getRatings()}"></div><p id="sum_progress"></p>
        </div>
    </#if>
    </div>
</div>
    <div>
        <p></p>
        <style>
            p{
                text-align: justify;
            }
        </style>
    <p class="text-left">
        <script>
            $(document).ready(function () {
                createMarkdown(document.getElementById("area"));
                function createMarkdown(textarea) {
                    simplemde = new SimpleMDE({
                        element: textarea
                    })}
            });
        </script>
            <#if theme=="Fruit">
        <br> <div class="form-group text-left " style="background: url(../static/fruitBackground.jpg);">
            <#else>
                <#if theme=="Vegetables">
            <div class="form-group text-left " style="background: url(../static/vegetablesBackground.jpg);">
                <#else>
                <div class="form-group text-left ">
                </#if>
            </#if>

        <textarea class="form-control" id="area" rows="3" name="text">${summ.text}</textarea>
    </div>
        </p>

    </div>
    <p></p>
    <br>
    <footer class="pt-4 my-md5 pt-md-3 border-top"></footer>
    <#if language=="Russian">
    <b><em><h4> Коментарии:</h4></em></b>
    <div class="form-inline my-2 my-lg-2">
        <br>
        <input type="text" name="commentar" class="form-control  mr-sm-2" placeholder="Текст" size="90%"/>
        <button type="submit" class="btn btn-primary">Сохранить</button>
    </div>
    <#else>
    <b><em><h4> Comments:</h4></em></b>
    <div class="form-inline my-2 my-lg-2">
        <br>
        <input type="text" name="commentar" class="form-control  mr-sm-2" placeholder="Text" size="90%"/>
        <button type="submit" class="btn btn-primary">Save</button>
    </div>
    </#if>
    <p></p>

        <#list summ.comment as comment>
        <ul><footer class="  pt-md-3 border-top"></footer>
            <b><em>Comment by ${comment.getUser().username}:</b>
            </em>
            <br>
            ${comment.text}
            <br>
            <p></p>
        </ul>
        </#list>

    <input class="form-control" type="hidden" value="${summ.id}" id="summId" size="50%">

    <div class="text-center">
    <#if language=="Russian">
        <a href="/Recipes"><u>Назад</u></a>
    <#else>
        <a href="/Recipes"><u>Return</u></a>
    </#if>
    </div>
</form>
</body>
</@c.page>