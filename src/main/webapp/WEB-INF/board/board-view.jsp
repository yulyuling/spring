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
                <div>
                    제목 : {{info.title}}
                </div>
                <div>
                    내용 :<div v-html="info.contents"></div>
                </div>
                <div>
                    조회수 : {{info.cnt}}
                </div>
            </div>
        </table>
        <div v-if="sessionId == info.userId || sessionIdStatus == 'A'">
            <button @click="fnEdit()">수정</button>
            <button @click="fnRemove()" >삭제</button>
        </div>
        <table>
            <tr>
                <th>작성자</th>
                <td style="width: 400px">내용</td>
            </tr>
        </table>
            <tr>
                <div v-for="item in cmtList">
                    {{item.userId}} : {{item.contents}}
                </div>
            </tr>
            <template v-if="sessionId == info.userId || sessionIdStatus == 'A'">
                <button @click="fnCommentEdit()">🕳</button>
                <button @click="fnCommentRemove()" >❌</button>
            </template>
            <table>
                <tr>
                    <th> 댓글 입력 : </th>
                    <td>
                        <textarea 
                        style="width: 430px"
                        v-model="comment" cols="60" rows="5"></textarea>
                    </td>
                    <td style="width: 50px">
                        <button @click="fnCommentSave">저장</button>
                    </td>
                </tr>
            </table>
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
                cmtList : [],
                comment: "",
                userId: {},
            };
        },
        methods: {
            fnGetBoard(){
				var self = this;
				var nparmap = {
                    boardNo : self.boardNo,
                    option : "View",
                    cmtList : self.cmtList,
                };
				$.ajax({
					url:"/board/info.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        self.info = data.info;
                        self.cmtList = data.cmtList;
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
            },
            fnCommentEdit (){
                let self = this;
                var nparmap = {
                    boardNo : self.boardNo,
                };
				$.ajax({
					url:"/board/CommentEdit.dox",
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
            },
            fnCommentRemove (){
                let self = this;
                var nparmap = {
                    boardNo : self.boardNo,
                };
				$.ajax({
					url:"/board/CommentRemove.dox",
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
            },
            fnCommentSave (){
                let self = this;
                var nparmap = {
                    boardNo : self.boardNo,
                };
				$.ajax({
					url:"/board/CommentAdd.dox",
					dataType:"json",
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        self.info = data.info;
                        location.href="/board/list.do";
                        alert("등록되었습니다!");
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