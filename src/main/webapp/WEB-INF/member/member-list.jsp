<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
	<title>첫번째 페이지</title>
	<script src="../js/page-Change.js"></script>
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
			<tr>
				<th><input type="checkbox" @click="fnAllCheck"></th>
				<th>ID</th>
				<th>이름</th>
				<th>주소</th>	
				<th>삭제</th>		
			</tr>
			<tr v-for="item in list">
				<td><input type="checkbox" :value="item.userId" v-model="selectList"></td>
				<td>{{item.userId}}</td>
				<td> 
					<a @click="fnUserView" v-if="sessionIdStatus == 'A'">{{item.userName}}</a>
				</td>
				<td>{{item.address}}</td>
				<td>
					<button @click="fnRemove(item.userId)">삭제</button>
				</td>
			</tr>
		</table>
		<div>
			<button @click="fnRemoveList">삭제</button>
		</div>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                list: [],
				userId : "",
				sessionId : "${sessionId}",
                sessionIdStatus : "${sessionStatus}",
				selectList : [],
				checked : false,
            };
        },
        methods: {
            fnMemberList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/member/list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data); //테이블 만들기
						self.list = data.list;
					}
				});
            },
			fnRemove : function(userId){
				var self = this;
				var nparmap = {
					userId : userId
				};
				$.ajax({
					url:"/member/remove.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data); //테이블 만들기
						if(data.result == "success"){
							alert("삭제되었습니다!");
							self.fnMemberList();
						}
					}
				});
        	},
			fnUserView (sessionIdStatus){
				let self = this;
				var nparmap = {};
				$.ajax({
					url:"/member/list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data); //테이블 만들기
						self.list = data.list;
						
					}
				});
            },
			fnRemoveList : function (){
                let self = this;
                var nparmap = {
                    selectList : JSON.stringify(self.selectList)
                };
                $.ajax({
					url:"/member/remove-list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						alert("삭제되었습니다!");
					}
				});
            },
			fnAllCheck : function (){
                let self = this;
                self.checked = !self.checked;
                if(self.checked){
                    for(let i=0; i<self.list.length; i++){
                        self.selectList.push(self.list[i].userId);
                    }
                } else {
                    self.selectList = [];
                }
                
            }
			
		},
        mounted() {
            var self = this;
			self.fnMemberList();
        }
    });
    app.mount('#app');
</script>