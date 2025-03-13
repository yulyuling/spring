<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script src="/js/page-Change.js"></script>
<title>제품 목록</title>
<link rel="stylesheet"href="../css/product-style.css">
<style>
.product-list {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between; /* 요소 간격을 조정 */
	color: rgb(103, 103, 103);
}

.product {
    width: calc(33.33% - 10px); /* 3개씩 배치되도록 설정 (간격 고려) */
    box-sizing: border-box;
    margin-bottom: 20px; /* 아래 간격 조정 */
    text-align: center; /* 텍스트 정렬 */
	color: rgb(103, 103, 103);
}


</style>
</head>
<body>
	<jsp:include page="../common/header.jsp"/>
	<div id="app">

	    <h1 class="font" style="color: #003d80;"> ㅂㅂㅂ</h1>
	    <div class="product-list">
	        <div v-for="item in list" class="product">
	            <img :src="item.filePath" alt="제품1" @click="fnView(item.itemNo)">
	            <div class="product-name"> {{item.itemName}} </div>
				<p>{{item.itemInfo}}</p>
	            <div class="product-price">{{item.price}}원</div>
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
				keyword : "",
			};
        },
        methods: {
            fnProductList(keyword){
				var self = this;
				console.log(keyword);
				var nparmap = {
					keyword : keyword,
				};
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
			fnView : function(itemNo){
				pageChange("/product/view.do", {itemNo : itemNo});

			}
        },
        mounted() {
            var self = this;
			self.fnProductList("");
        }
    });
    app.mount('#app');
</script>