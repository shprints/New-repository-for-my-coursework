<#import "parts/common.ftl" as c>
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
<h5>${username}</h5>
    ${message?if_exists}
<form method="post">

    <#if language=="Russian">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"> Пароль: </label>
            <div class="col-sm-6">
                <input type="password" name="password" class="form-control" placeholder="Пароль"/>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"> Электронная почта: </label>
            <div class="col-sm-6">
                <input type="email" name="email" class="form-control" placeholder="some@some.com" value="${email}">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"> Тема: </label>
            <div class="col-sm-6">
                Ваша тема: ${theme}, изменить:
                <select name="theme">
                    <option value="Fruit">Фруктовая</option>
                    <option value="Vegetables">Овощная</option>
                    <option value="WithoutTheme">Отсутствует</option>
                </select>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"> Язык: </label>
            <div class="col-sm-6">
                Ваш язык: ${language}, изменить:
                <select name="language">
                    <option value="Russian">Русский</option>
                    <option value="English">Английский</option>
                </select>
            </div>
        </div>
        <button class="btn btn-primary" type="submit">
            Сохранить
        </button>
    <#else>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label"> Password: </label>
        <div class="col-sm-6">
            <input type="password" name="password" class="form-control" placeholder="Password"/>
        </div>
    </div>
     <div class="form-group row">
         <label class="col-sm-2 col-form-label"> Email: </label>
         <div class="col-sm-6">
             <input type="email" name="email" class="form-control" placeholder="some@some.com" value="${email}">
         </div>
     </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"> Theme: </label>
            <div class="col-sm-6">
                Your theme: ${theme}, to change:
                <select name="theme">
                    <option value="Fruit">Fruit</option>
                    <option value="Vegetables">Vegetables</option>
                    <option value="WithoutTheme">WithoutTheme</option>
                </select>
            </div>
        </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label"> Language: </label>
        <div class="col-sm-6">
            Your language: ${language}, to change:
            <select name="language">
                <option value="Russian">Russian</option>
                <option value="English">English</option>
            </select>
        </div>
    </div>
    <button class="btn btn-primary" type="submit">
        Save
    </button>
    </#if>



</form>
</body>
</@c.page>