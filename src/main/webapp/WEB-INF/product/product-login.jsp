<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
	<title>첫번째 페이지</title>
</head>
<style>
    /* 전체 페이지 스타일 */
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f8f8f8;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    /* 로그인 컨테이너 */
    .login-container {
        width: 350px;
        padding: 20px;
        background: white;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        text-align: center;
    }

    .login-container h2 {
        margin-bottom: 20px;
        font-size: 1.5em;
        color: #333;
    }

    /* 입력 필드 스타일 */
    .input-field {
        width: 100%;
        padding: 10px;
        margin: 10px 0;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 1em;
    }

    /* 로그인 버튼 스타일 */
    .login-button {
        width: 100%;
        padding: 12px;
        background-color: #8000ff;
        color: white;
        border: none;
        border-radius: 5px;
        font-size: 1.1em;
        cursor: pointer;
        transition: background-color 0.3s ease;
        margin-top: 10px;
    }

    .login-button:hover {
        background-color: #5a00b3;
    }
</style>
<body>
    <jsp:include page="../common/header.jsp"/>
	<div id="app">
		<div>
            <input class="input-field" type="text" placeholder="아이디" v-model="userId"> 
		</div>
		<div>
			<input class="input-field" type="password" placeholder="비밀번호" v-model="pwd">  
		</div>
		<button class="login-button" @click="fnLogin">로그인</button>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                userId : "",
				pwd : ""
            };
        },
        methods: {
            fnLogin(){
				var self = this;
				var nparmap = {
					userId : self.userId,
					pwd : self.pwd
				};
				$.ajax({
					url:"/member/login.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						if(data.result == "success"){
							alert(data.info.userName + "님 환영합니다!");						
						} else {
							alert("아이디/패스워드 확인하세요.");
						}
					}
				});
            }
        },
        mounted() {
            var self = this;
        }
    });
    app.mount('#app');
</script>