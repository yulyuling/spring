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
    .textStyle{
            font-weight: bold;
            color : red;
        }
</style>
<body>
	<div id="app">
		<div>
            <div>
                <select v-model="searchOption">
                    <option value="all"> ::전체:: </option>
                    <option value="title"> 제목 </option>
                    <option value="name"> 작성자 </option>
                </select>
                <input v-model="keyword" @keyup.enter="fnBoardList" placeholder="검색어">
                <button @click="fnBoardList">검색</button>
            </div>
            <div>
                <select @change="fnBoardList" v-model="pageSize">
                    <option value="5">5개씩</option>
                    <option value="10">10개씩</option>
                    <option value="15">15개씩</option>
                    <option value="20">20개씩</option>
                </select>
            </div>
            <table>
                <tr>
                    <th><input type="checkbox" @click="fnAllCheck"></th>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일</th>
                </tr>
                <tr v-for="item in list">
                    <td><input type="checkbox" :value="item.boardNo" v-model="selectList"></td>
                    <td>{{item.boardNo}}</td>
                    <td>
                        <a href="javascript:;" @click="fnView(item.boardNo)">{{item.title}}</a>
                        <span class="textStyle" v-if="item.commentCnt != null">({{item.commentCnt}})</span>
                    </td>
                    <td>
                        <a v-if="sessionStatus == 'A'" href="javascript:;" @click="fnGetUser(item.userId)">{{item.userName}}</a>
                        <a v-else>{{item.userName}}</a>
                    </td>
                    <td>{{item.cnt}}</td>
                    <td>{{item.cDateTime}}</td>
                </tr>
            </table>
        </div>
        <div>
            <a href="javacript:;" @click="fnPageMove('prev')" v-if="page != 1"> < </a>
            <a id="index" href="javacript:;" v-for="num in index" @click="fnPage(num)">
                <span v-if="page == num" id="pageText">{{num}}</span>
                <span v-else class="color-black">{{num}}</span>
            </a>
            <a href="javacript:;" @click="fnPageMove('next')"  v-if="page != index">> </a> 
            <!-- 파라미터로 다음,이전을 구분해놨음 next / prev -->
        </div>
        <div>
            <button @click="fnAdd"> 글쓰기</button>
            <button @click="fnRemove">삭제</button>
        </div>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                list : [],
                keyword: "",
                searchOption: "all",
                sessionStatus : "${sessionStatus}",
                selectList : [],
                checked : false,
                orderKey: "",
                orderType: "",
                index : 0,
                pageSize : 5,
                page : 1,
            };
        },
        methods: {
            fnBoardList(){
				var self = this;
				var nparmap = {
                    userId : self.userId,
                    keyword : self.keyword,
                    kind: self.kind,
                    orderKey : self.orderKey,
                    orderType : self.orderType,
                    searchOption : self.searchOption,
                    pageSize : self.pageSize,
                    page : (self.page - 1) *self.pageSize,
                };
				$.ajax({
					url:"/board/list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        self.list = data.list;
                        self.index = Math.ceil(data.count / 5);
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
            },
            fnGetUser : function(userId){
                var self = this;
				var nparmap = {
                    userId : userId
                };
				$.ajax({
					url:"/member/get.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
					}
				});
            },
            fnRemove : function (){
                let self = this;
                var nparmap = {
                    selectList : JSON.stringify(self.selectList)
                };
                $.ajax({
					url:"/board/remove-list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
 
					}
				});
            },
            fnAllCheck : function (){
                let self = this;
                self.checked = !self.checked;
                if(self.checked){
                    for(let i=0; i<self.list.length; i++){
                        self.selectList.push(self.list[i].boardNo);
                    }
                } else {
                    self.selectList = [];
                }
                
            },
            fnOrder : function(orderKey){
                let self = this;
                if(self.orderKey != orderKey){
                    self.orderType = "";
                }
                self.orderKey = orderKey;
                self.orderType = self.orderType == "ASC" ? "DESC" : "ASC";
                self.fnList();
            },
            fnPage : function(num){
                let self = this;
                self.page = num;
                self.fnBoardList();
            },
            fnPageMove : function(direction){
                let self = this;
                if(direction == "next"){
                    self.page++;
                } else {
                    self.page--;
                }
                self.fnBoardList();
            },
        },
        mounted() {
            var self = this;
            self.fnBoardList();
        }
    });
    app.mount('#app');
</script>