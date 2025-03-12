<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
	<title>첫번째 페이지</title>
</head>
<style>
</style>
<body>
	<div id="app">
        <div>아이디 입력 <input v-model="userId"></div>
            <button @click="fnIdCheck">확인</button>
            <button @click="requestCert()">비밀번호 찾기</button>
        <div>
            새비밀번호 입력<input v-model="password">
            <button @click="fnSave">저장</button>
        </div>
	</div>
</body>
</html>
<script>
    IMP.init("imp29272276");
    const app = Vue.createApp({
        data() {
            return {
                userId : "",
                info : {},
                userName : "",
                password : "",
            };
        },
        methods: {
            requestCert(){
                IMP.certification({
                  channelKey: "channel-key-5130c33b-27ed-4b00-b62a-47c0045ceb94",
                  merchant_uid: "test_m83romjl",
                  userName: "",
                  m_redirect_url: "member/add/pwd.do",
                  popup: false,
                });
            },
            fnIdCheck (){
                let self = this;
                var nparmap = {
                    userId : self.userId,
                };
                $.ajax({
					url:"/member/check.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        if(data.result == "success"){
							alert("존재하지 않는 아이디입니다.");					
						} else {
							alert("인증되었습니다.");
						}
					}
				});
            },
            fnSave(){
				var self = this;
				var nparmap = {
                    password : self.password
                };
				$.ajax({
					url:"member/addPwd.dox",
					dataType:"json",
					type : "POST",
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        alert("저장함!");
                        location.href="/member/list.do";
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