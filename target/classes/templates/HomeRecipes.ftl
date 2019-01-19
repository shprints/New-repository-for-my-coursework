<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.css">
    <script src="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.js"></script>
    <meta charset="utf-8">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<@c.page>
    <#if known>
        <#if theme=="Fruit">
        <body background="../static/fruit.jpg" style="background-size: 100%;">
        <#else>
            <#if theme=="Vegetables">
            <body background="../static/vegetables.jpg" style="background-size: 100%;">
            <#else>
                <body class="bg-light">
            </#if>
        </#if>
    <#else>
<body class="bg-light">
    </#if>

<form action="/home" method="post">
    <p class="container">


    <#if known>
        <#if theme=="Fruit">
        <div class="col-9 rounded"  style="display: inline-block; background: url(../static/fruitBackground.jpg);">
        <#else>
            <#if theme=="Vegetables">
            <div class="col-9 rounded"  style="display: inline-block; background: url(../static/vegetablesBackground.jpg);">
            <#else>
                <div class="col-9"  style="display: inline-block;">
            </#if>
        </#if>
    <#else>
     <div class="col-9"  style="display: inline-block;">
    </#if>
        <div class="text-center"> <h3><em><u>${summ.title}</u></em></h3></div>
        <div>
            <img class="img-fluid rounded float-left text-center" style="width: 300px; height: 200px; border: solid 4px #FFCC00" src="${summ.imageURL?if_exists}" alt="No image available">
        </div>
    <#if known>
        <#if language=="Russian">
        <div style="margin-left: 350px;">
            Описание: ${summ.descript}
            <br>Основные ингредиенты: ${summ.number}
        </div>
        <#else>
     <div style="margin-left: 350px;">
         Description: ${summ.descript}
         <br>Main ingredients: ${summ.number}
     </div>
        </#if>
    <#else>
        <div style="margin-left: 350px;">
            Description: ${summ.descript}
            <br>Main ingredients: ${summ.number}
        </div>
    </#if>
    </div>


    <p></p>
    <br>
    <style>
        p{
            text-align: justify;
        }
    </style>
<p>
    <script>
        $(document).ready(function () {
            createMarkdown(document.getElementById("area"));
            function createMarkdown(textarea) {
                simplemde = new SimpleMDE({
                    element: textarea
                })}
        });
    </script>
    <#if known>
        <#if theme=="Fruit">
        <br> <div class="form-group text-left " style="background: url(../static/fruitBackground.jpg);">
        <#else>
            <#if theme=="Vegetables">
            <div class="form-group text-left " style="background: url(../static/vegetablesBackground.jpg);">
            <#else>
                <div class="form-group text-left ">
            </#if>
        </#if>
    <#else>
     <div class="form-group text-left ">
    </#if>
    <textarea class="form-control" id="area" rows="3" name="text">${summ.text}</textarea>
</div>
    </p>
    <br>
    <br>

    <aside class="col-md-4 blog-sidebar">
    </aside>
    <p></p>
    <br>
    <div class="text-center">
    <#if known>
        <#if language=="Russian">
        <a href="/home"><u>Назад</u></a>
        <#else>
        <a href="/home"><u>Return</u></a>
        </#if>
        <#else>
        <a href="/home"><u>Return</u></a>
    </#if>
    </div>
    </div>
</form>
</body>
</@c.page>