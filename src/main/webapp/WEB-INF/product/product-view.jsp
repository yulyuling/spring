<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
	<title>첫번째 페이지</title>
    <script src="/js/page-Change.js"></script>
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
        gap: 5px;
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
    <jsp:include page="../common/header.jsp"/>
    <div id="app">
    
        <div class="container">
            <div class="product-detail">
                <img :src="info.filePath" :alt="info.itemName">
                <div class="detail-info">
                    <h2>{{ info.itemName }}</h2>
                    <p class="price">{{ info.price }} 원</p>
                    <p class="description">{{ info.itemInfo }}</p>
                    <button class="buy-button" @click="fnPayment()">구매하기</button>
                    <button class="buy-button" @click="goBack">뒤로 가기</button>
                </div>
            </div>
        </div>
    </div>

</body>
</html>

<script>
    const userCode = "imp70038285"; 
    IMP.init(userCode);
    const app = Vue.createApp({
        data() {
            return {
                itemNo : "${map.itemNo}",
                info: {},
                uid : {merchant_uid: "test1" + new Date().getDate()},
            };
        },
        methods: {
            fnGetProduct() {
                var self = this;
                var params = {
                    itemNo : self.itemNo
                };

                $.ajax({
                    url: "/product/view.dox",
                    dataType: "json",
                    type: "POST",
                    data: params,
                    success: function(data) {
                        self.info = data.info;
                        console.log(data);
                    }
                });
            },
            goBack() {
                window.history.back();
            },
            fnPayment(){
                let self = this;
                IMP.request_pay({
                    pg: "html5_inicis",
                    pay_method: "card",
                    merchant_uid: "test1" + new Date().getDate(),
                    name: "테스트 결제",
                    amount: 1,
                    buyer_tel: "010-0000-0000",
                  } , function (rsp) { // callback
                      if (rsp.success) {
                        // 결제 성공 시
                        alert("성공");
                        console.log(rsp);
                      } else {
                        // 결제 실패 시
                        alert("실패");
                      }
                });
            }
        },
        mounted() {
            this.fnGetProduct();
        }
    });

    app.mount('#app');
</script>
