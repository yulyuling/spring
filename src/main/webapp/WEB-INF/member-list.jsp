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
				<th>ID</th>
				<th>이름</th>
				<th>주소</th>	
				<th>삭제</th>		
			</tr>
			<tr v-for="item in list">
				<td>{{item.userId}}</td>
				<td>{{item.userName}}</td>
				<td>{{item.address}}</td>
				<td>
					<button @click="fnRemove(item.userId)">삭제</button>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                list: [],
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
					userId : self.userId
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
			
		},
        mounted() {
            var self = this;
			self.fnMemberList();
        }
    });
    app.mount('#app');
</script>