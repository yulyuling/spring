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
		<div>
			<input>
			<button @click="fnRemove()">삭제</button>

		</div>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				list : [],

			};
        },
        methods: {
            fnItemList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"test.dox",
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
					userId : itemNo
				};
				$.ajax({
					url:"/test/remove.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data); //테이블 만들기
						if(data.result == "success"){
							alert("삭제되었습니다!");
							self.fnItemList();
						}
					}
				});
        	},
			
        },
        mounted() {
            var self = this;
        }
    });
    app.mount('#app');
</script>