<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
	<link rel="stylesheet" href="../css/product-style.css">
	<title>첫번째 페이지</title>
</head>
<style> 
	/* 기본 설정 */



/* 로그인 폼 컨테이너 (중앙 정렬) */
#app {
    width: 350px;
    padding: 20px;
    background: white;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    text-align: center;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

/* 입력 필드 스타일 */
input {
    width: 100%;
    padding: 10px;
    margin: 10px 0;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 1em;
}

/* 버튼 스타일 */
button {
    width: 100%;
    padding: 12px;
    margin-top: 10px;
    background-color: #466789;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 1.1em;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: #6e757b;
}
	
</style>
<body>
	<div>
		<jsp:include page="../common/header.jsp"/>
	</div>

	<div id="app"> 
		<div>
			아이디 : <input v-model="userId">  
		</div>
		<div>
			비밀번호 : <input v-model="pwd">
		</div>
		<button @click="fnLogin">로그인</button>
		<button @click="fnAdd">회원가입</button>
		<div>
			<button @click="fnSearchPwd">비밀번호 찾기</button>
		</div>

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
							alert(data.member.userName + "님 환영합니다!");
							location.href="/product/list.do";						
						} else {
							alert("아이디/패스워드 확인하세요.");
						}
					}
				});
            },
			fnAdd (){
				location.href="/member/add.do";
			},
			fnSearchPwd (){
				location.href="/member/pwd.do";
			}
        },
        mounted() {
            var self = this;
        }
    });
    app.mount('#app');
</script>