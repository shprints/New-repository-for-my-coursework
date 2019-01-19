<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.css">
<script src="https://cdn.jsdelivr.net/simplemde/latest/simplemde.min.js"></script>

<meta charset="utf-8">
<@c.page>
<#if theme=="Fruit">
        <body background="../static/fruitfon.jpg" style="background-size: 100%;">
<#else>
    <#if theme=="Vegetables">
            <body background="../static/vegfon.jpg" style="background-size: 100%;">
    <#else>
            <body class="bg-light">
    </#if>
</#if>
<div class="text-center">
    <#if language=="Russian">
        <h1 class="display-6">Изменить запись</h1>
    <#else>
    <h1 class="display-6">Editing Notes</h1>
    </#if>
</div>
<p></p>
<form action="/Recipes/Page" method="post" enctype="multipart/form-data">
    <input class="form-control" type="text" name="title" value="${summ.title}" size="50%">
    <i><br><input class="form-control" type="text" name="descript" value="${summ.descript}" size="50%">

        <br><input class="form-control" type="text" name="number" value="${summ.number}" size="50%">

        <br> <input name="imageURL" type="url" class="form-control" value="${summ.imageURL}" size="50%">

        <script>
            $(document).ready(function () {
                createMarkdown(document.getElementById("area"));
                function createMarkdown(textarea) {
                    simplemde = new SimpleMDE({
                        element: textarea
                    })}
            });
        </script>
        <br> <div class="form-group">
            <textarea class="form-control" id="area" rows="3" name="text">${summ.text}</textarea>
        </div>
        <input class="form-control" type="hidden" value="${summ.id}" name="summId" size="50%">
    <#if language=="Russian">
        <p style="text-align: right"><button type="submit" class="btn btn-primary">Принять изменения</button></p>
    <#else>
        <p style="text-align: right"><button type="submit" class="btn btn-primary">Save</button></p>
    </#if>
        <p></p>

</form>
</body>

</@c.page>