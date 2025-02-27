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
		<div>
            <table v-model="">
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>아이디</th>
                    <th>조회수</th>
                    <th>작성일</th>
                </tr>
                <tr v-for="item in list">
                    <td>{{item.boardNo}}</td>
                    <td><a href="javascript:;" @click="fnView(item.boardNo)">{{item.title}}</a></td>
                    <td>{{item.userId}}</td>
                    <td>{{item.cnt}}</td>
                    <td>{{item.cDateTime}}</td>
                </tr>
            </table>
        </div>
            <button @click="fnAdd"> 글쓰기</button>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                list : [],
                userId:"",
            
            };
        },
        methods: {
            fnBoardList(){
				var self = this;
				var nparmap = {
                    userId : self.userId
                };
				$.ajax({
					url:"/board/list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        self.list = data.list;
					}
				});
            },
            fnAdd : function (){
                // /board/add.do로 이동 --컨트롤러
                // board-add.jsp 페이지 화면을 띄움 --보드폴더
                location.href="/board/add.do";
            },
            fnView : function (boardNo){
                //주소를 숨겨서 보내고싶을때
                pageChange("/board/view.do", {boardNo : boardNo});
            }
        },
        mounted() {
            var self = this;
            self.fnBoardList();
        }
    });
    app.mount('#app');
</script>