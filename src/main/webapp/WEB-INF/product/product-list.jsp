<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품 목록</title>
	<link rel="stylesheet"href="../css/product-style.css">
</head>
<body>
	<div id="app">
	    <div class="header">
	        <div class="logo">
	            <img src="../img/re3.webp">
	        </div>
	        <div class="header-title">양파쿵야의 레스토랑</div>
	        <div class="search-box">
	            <input type="text" placeholder="검색어를 입력하세요">
	            <button>검색</button>
	        </div>
	    </div>
	    <h1>🛒 제품 목록</h1>
	    <div class="product-list">
			
	        	<div v-for="item in list" class="product">
	        	    <img :src="item.filePath" alt="제품1" @click="fnView">
	        	    <div class="product-name"> {{item.itemName}} </div>
					<p>{{item.itemInfo}}</p>
	        	    <div class="product-price">\{{item.price}}원</div>

	        	</div>
			
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
            fnProductList(){
				var self = this;
				var nparmap = {};
				$.ajax({
					url:"/product/list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.list = data.list;
					}
				});
            },
			fnView(){
				location.href="/product/view.do"

			}
        },
        mounted() {
            var self = this;
			self.fnProductList();
        }
    });
    app.mount('#app');
</script>