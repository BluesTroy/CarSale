<%--
  Created by IntelliJ IDEA.
  User: Troy
  Date: 2016/6/26
  Time: 13:28
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>登录</title>
    <script type="text/javascript" src="/common/js/jQuery-2.1.4.min.js"></script>
</head>
<style>
body {
    background: #ebebeb;
    font-family: "Helvetica Neue", "Hiragino Sans GB", "Microsoft YaHei", "\9ED1\4F53", Arial, sans-serif;
    color: #222;
    font-size: 12px;
}

* {
    padding: 0px;
    margin: 0px;
}

.top_div {
    background: #008ead;
    width: 100%;
    height: 300px;
}

.ipt {
    border: 1px solid #d3d3d3;
    padding: 10px 10px;
    width: 333px;
    border-radius: 4px;
    padding-left: 35px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s
}

.ipt:focus {
    border-color: #66afe9;
    outline: 0;
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 8px rgba(102, 175, 233, .6);
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 8px rgba(102, 175, 233, .6)
}

.u_logo {
    background: url('${resource(dir: "images", file: "username.png")}') no-repeat;
    padding: 10px 10px;
    position: absolute;
    top: 43px;
    left: 40px;

}

.p_logo {
    background: url('${resource(dir: "images", file: "password.png")}') no-repeat;
    padding: 10px 10px;
    position: absolute;
    top: 12px;
    left: 40px;
}

a {
    text-decoration: none;
}

.tou {
    background: url('${resource(dir: "images", file: "tou.png")}') no-repeat;
    width: 97px;
    height: 92px;
    position: absolute;
    top: -87px;
    left: 140px;
}

.left_hand {
    background: url('${resource(dir: "images", file: "left_hand.png")}') no-repeat;
    width: 32px;
    height: 37px;
    position: absolute;
    top: -38px;
    left: 150px;
}

.right_hand {
    background: url('${resource(dir: "images", file: "right_hand.png")}') no-repeat;
    width: 32px;
    height: 37px;
    position: absolute;
    top: -38px;
    right: -64px;
}

.initial_left_hand {
    background: url('${resource(dir: "images", file: "hand.png")}') no-repeat;
    width: 30px;
    height: 20px;
    position: absolute;
    top: -12px;
    left: 100px;
}

.initial_right_hand {
    background: url('${resource(dir: "images", file: "hand.png")}') no-repeat;
    width: 30px;
    height: 20px;
    position: absolute;
    top: -12px;
    right: -112px;
}

.left_handing {
    background: url('${resource(dir: "images", file: "left-handing.png")}') no-repeat;
    width: 30px;
    height: 20px;
    position: absolute;
    top: -24px;
    left: 139px;
}

.right_handinging {
    background: url('${resource(dir: "images", file: "right_handing.png")}') no-repeat;
    width: 30px;
    height: 20px;
    position: absolute;
    top: -21px;
    left: 210px;
}

</style>

<body>
<div class="top_div"></div>

<div style="background: rgb(255, 255, 255); margin: -100px auto auto; border: 1px solid rgb(231, 231, 231); border-image: none; width: 400px; height: 200px; text-align: center;">
    <div style="width: 165px; height: 96px; position: absolute;">
        <div class="tou"></div>

        <div class="initial_left_hand" id="left_hand"></div>

        <div class="initial_right_hand" id="right_hand"></div></div>
    <g:form url="[controller: 'login', action: 'authenticate']" method="post">
        <p style="padding: 30px 0px 10px; position: relative;"><span
                class="u_logo"></span>
            <input class="ipt" type="text" name="userName" placeholder="请输入用户名(工号)" value="">
        </p>

        <p style="position: relative;"><span class="p_logo"></span>
            <input class="ipt" id="password" name="password" type="password" placeholder="请输入密码" value="">
        </p>
        <g:if test="${flash.loginMessage}"><p style="color: red;">${flash.loginMessage}</p></g:if>

        <div style="height: 50px; line-height: 50px; margin-top: 30px; border-top-color: rgb(231, 231, 231); border-top-width: 1px; border-top-style: solid;">
            <button type="submit"
                    style="background: rgb(0, 142, 173); width:100px;padding: 7px 10px; margin:8px 8px; border-radius: 4px; border: 1px solid rgb(26, 117, 152); border-image: none; color: rgb(255, 255, 255); font-weight: bold;">登录</button>

        </div></g:form>
</div>
</body>
</html>


<script type="text/javascript">
    $(function () {
        //得到焦点
        $("#password").focus(function () {
            $("#left_hand").animate({
                left: "150",
                top: " -38"
            }, {
                step: function () {
                    if (parseInt($("#left_hand").css("left")) > 140) {
                        $("#left_hand").attr("class", "left_hand");
                    }
                }
            }, 2000);
            $("#right_hand").animate({
                right: "-64",
                top: "-38px"
            }, {
                step: function () {
                    if (parseInt($("#right_hand").css("right")) > -70) {
                        $("#right_hand").attr("class", "right_hand");
                    }
                }
            }, 2000);
        });
        //失去焦点
        $("#password").blur(function () {
            $("#left_hand").attr("class", "initial_left_hand");
            $("#left_hand").attr("style", "left:100px;top:-12px;");
            $("#right_hand").attr("class", "initial_right_hand");
            $("#right_hand").attr("style", "right:-112px;top:-12px");
        });
    });
</script>