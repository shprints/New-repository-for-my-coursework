<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
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
<h1 class="h3 mb-3 font-weight-normal" align="center">
    <#if language=="Russian">
        Изменение роли пользователя:</h1>
    <#else>
    Change user role:</h1>
    </#if>

<form action="/user" method="post">
    <#list roles as role>
     <div class="text-center">
         <label><input type="checkbox" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>${role}</label>
     </div>
    </#list>
    <input type="hidden" value="${user.id}" name="userId">
    <div class="text-center">
    <#if language=="Russian">
        <button type="submit" class="btn btn btn-outline-primary">Сохранить</button>
    <#else>
    <button type="submit" class="btn btn btn-outline-primary">Save</button>
    </#if>
    </div>
</form>
</body>
</@c.page>