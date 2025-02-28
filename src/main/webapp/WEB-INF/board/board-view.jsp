<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-Change.js"></script>
	<title>첫번째 페이지</title>
</head>
<style>
    	table, tr, th, td {
	    text-align: center;
	    border : 2px solid #bbb;
	    border-collapse: collapse;
	    padding : 5px;
	}
</style>
<body>
	<div id="app">
        <table>
            <div>
                <tr>
                    <td>제목 : {{info.title}}</td>
                    <td>내용 : {{info.contents}}</td>
                    <td>조회수 : {{info.cnt}}</td>
                </tr>
            </div>
        </table>
        <div v-if="sessionId == info.userId || sessionIdStatus == 'A'">
            <button @click="fnEdit()">수정</button>
            <button @click="fnRemove()" >삭제</button>
        </div>
            <button @click="fnBack()">뒤로가기</button>
    </div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                boardNo : "${map.boardNo}",
                info : {}, //단일객체라 맵으로 넘어올거다. 그래서 맵 선언
                sessionId : "${sessionId}",
                sessionIdStatus : "${sessionStatus}",
            };
        },
        methods: {
            fnGetBoard(){
				var self = this;
				var nparmap = {
                    boardNo : self.boardNo,
                    option : "View",
                };
				$.ajax({
					url:"/board/info.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        self.info = data.info;
					}
				});
            },
            fnEdit : function(){
                pageChange("/board/edit.do", {boardNo : this.boardNo});
            },
            fnBack : function(){
                location.href="/board/list.do";
            },
            fnRemove : function(){
                var self = this;
				var nparmap = {
                    boardNo : self.boardNo,
                };
				$.ajax({
					url:"/board/remove.dox",
					dataType:"json",
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        self.info = data.info;
                        location.href="/board/list.do";
                        alert("삭제되었습니다!");
					}
				});
            }

        },
        mounted() {
            var self = this;
            self.fnGetBoard();
        }
    });
    app.mount('#app');
</script>