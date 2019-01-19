<#import "login.ftl" as l>
<#include "security.ftl">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #FFCC00">
    <h2 class="navbar-new mb-0" style="color:#505050">RecipeBook</h2>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <meta charset="utf-8">

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <div class="col-lg-10">
        <ul class="navbar-nav mr-auto">
            <form class="form-inline my-2">
            <#if known>
                <#if language=="Russian">
                    <#if isAdmin>
                    <li class="nav-item">
                        <a class="nav-link mb-0 text-white h4" href="/user" >Список пользователей </a>
                    </li>
                    </#if>
                    <li class="nav-item">
                        <a class="nav-link mb-0 text-white h4" href="/home">Главная </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link  mb-0 text-white h4" href="/Recipes">Рецепты </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link mb-0 text-white h4" href="/cabinet">Кабинет </a>
                    </li>
                <#else>
                    <#if isAdmin>
                    <li class="nav-item">
                        <a class="nav-link mb-0 text-white h4" href="/user" >User list </a>
                    </li>
                    </#if>
                    <li class="nav-item">
                        <a class="nav-link mb-0 text-white h4" href="/home">Home </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link  mb-0 text-white h4" href="/Recipes">Recipes </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link mb-0 text-white h4" href="/cabinet">My cabinet </a>
                    </li>
                </#if>

            <#else>
                <#if isAdmin>
                <li class="nav-item">
                    <a class="nav-link mb-0 text-white h4" href="/user" >User list </a>
                </li>
                </#if>
                <li class="nav-item">
                    <a class="nav-link mb-0 text-white h4" href="/home">Home </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link  mb-0 text-white h4" href="/Recipes">Recipes </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link mb-0 text-white h4" href="/cabinet">My cabinet </a>
                </li>
            </#if>


            </form>
        </ul>
        </div>
        <#if known>
            <#if language=="Russian">
            <body class="bg-light">
            <div style="padding-bottom: 0">
                <form class="form-inline my-2 my-lg-0" action="/logout" method="post" >
                    <button class="btn btn-outline-dark btn-lg" type="submit">Выйти</button>
                </form>
            </div>
            </body>
            <#else>
            <body class="bg-light">
            <div style="padding-bottom: 0">
                <form class="form-inline my-2 my-lg-0" action="/logout" method="post" >
                    <button class="btn btn-outline-dark btn-lg" type="submit">Sign Out</button>
                </form>
            </div>
            </body>
            </#if>
        <#else>
            <div class="form-inline my-2 my-lg-0 mr-2">
                <a class="btn btn-outline-dark btn-lg" href="/login">Log in</a>
            </div>
        </#if>
    </div>
    </nav>
