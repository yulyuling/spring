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
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f8f8f8;
        text-align: center;
    }
    .container {
        max-width: 800px;
        margin: 20px auto;
        background: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }
    .product {
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .product img {
        width: 400px;
        height: auto;
        border-radius: 10px;
    }
    .product-info {
        text-align: center;
        margin-top: 20px;
    }
    .product-name {
        font-size: 2em;
        font-weight: bold;
        margin-bottom: 10px;
    }
    .product-price {
        font-size: 1.5em;
        color: #ff5733;
        font-weight: bold;
        margin-bottom: 20px;
    }
    .buy-button {
        display: inline-block;
        padding: 15px 30px;
        background-color: #8000ff;
        color: white;
        border: none;
        border-radius: 5px;
        font-size: 1.2em;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .buy-button:hover {
        background-color: #5a00b3;
    }
    .description {
        margin-top: 20px;
        font-size: 1.1em;
        color: #555;
    }
</style>
</head>
<body>
<div id="app">
    <jsp:include page="../common/header.jsp"/>
        <div class="container" v-if="selectedItem">
            <div class="product">
                <img :src="selectedItem.filePath" alt="제품 이미지">
                <div class="product-info">
                    <div class="product-name">{{ selectedItem.itemName }}</div>
                    <div class="product-price">{{ selectedItem.price }}원</div>
                    <button class="buy-button" @click="fnBuy">구매하기</button>
                    <div class="description">{{ selectedItem.itemInfo }}</div>
                </div>
            </div>
        </div>
   
</div>
</body>
</html>
<script>
const app = Vue.createApp({
    data() {
        return {
            list: [
               
            ],
            selectedItem: null
        };
    },
    methods: {
        fnView(index) {
            this.selectedItem = this.list[index];
        },
        fnBuy() {
            alert(this.selectedItem.itemName + " 구매 완료!");
        }
    },
    mounted() {
        // 예시로 첫 번째 제품을 기본으로 선택
        this.selectedItem = this.list[0];
    }
});
app.mount('#app');
</script>