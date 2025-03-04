<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
	<title>첫번째 페이지</title>
</head>
<style>
</style>
<body>
	<div id="app"> 
        <div>아이디: <input v-model="user.userId">
            <button @click="fnIdCheck()">중복체크</button>
        </div>
		<div>비밀번호: <input v-model="user.password"></div>
		<div>이름: <input v-model="user.userName"></div>
		<div>주소: <input v-model="user.address">
            <button @click="fnSearchAddr">주소 검색</button>
        </div>
		<input type="radio" name="user.status" value="C" v-model="user.status">일반
        <input type="radio" name="user.status" value="A" v-model="user.status">관리자
        <button @click="fnAdd()">저장</button>
	</div>
</body>
</html>
<script>
    function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
        // window.vueObj.(함수명) 이렇게 쓰면 뷰 문법을 그냥 스크립트에서 쓸 수 있다.
        window.vueObj.fnResult(roadFullAddr, roadAddrPart1, addrDetail, engAddr);
    }

    const app = Vue.createApp({
        data() {
            return {
                user : {
                    userId : "",
                    password : "",
                    userName : "",
                    address : "",
                    status : "",
                }
                
            };
        },
        methods: {
            fnAdd(){
				var self = this;
				var nparmap = {
                    userId : self.userId,
                    password : self.password,
                    userName : self.userName,
                    address : self.address,
                    status : self.status
                };
				$.ajax({
					url:"/member/add.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        alert("저장함!");
                        location.href="/member/list.do";
					}
				});
            },
            fnIdCheck : function () {
                let self = this;
                if(self.user.userId == ""){
                    alert("아이디를 입력하세요")
                    return;
                }
                var nparmap = {
                    userId : self.user.userId,
                };
                $.ajax({
					url:"/member/check.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        if(data.count == 0){
                            alert("사용 가능");
                        } else {
                            alert("사용불가");
                        }
                        location.href="/member/list.do";
					}
				});
            },
            fnSearchAddr : function (){
                //팝업으로 addr.do 호출
                window.open("/addr.do", "addr", "width=500, height=500")
            },
            fnResult :function (roadFullAddr, roadAddrPart1, addrDetail, engAddr){
                let self = this;
                self.user.address = roadFullAddr;

                console.log(roadFullAddr);
                console.log(roadAddrPart1);
                console.log(addrDetail);
                console.log(engAddr);
            }
        },
        mounted() {
            var self = this;
            window.vueObj = this; //this는 뷰 자체라서 윈도우에 뷰를 넣었음
        }
    });
    app.mount('#app');
</script>