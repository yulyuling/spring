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
        max-width: 900px;
        margin: 20px auto;
        background: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        display: flex;
        flex-direction: row;
        align-items: flex-start;
    }
    .product-images {
        width: 50%;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .product-images img {
        width: 400px;
        height: 400px;
        border-radius: 10px;
        object-fit: cover;
    }
    .thumbnails {
        display: flex;
        gap: 10px;
        margin-top: 10px;
    }
    .thumbnails img {
        width: 80px;
        height: 80px;
        cursor: pointer;
        border-radius: 5px;
        object-fit: cover;
        border: 2px solid transparent;
        transition: border 0.3s ease;
    }
    .thumbnails img:hover, .thumbnails img.active {
        border: 2px solid #8000ff;
    }
    .product-info {
        width: 50%;
        text-align: left;
        padding: 0 20px;
    }
    .product-name {
        font-size: 1.8em;
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
        padding: 12px 25px;
        background-color: #8000ff;
        color: white;
        border: none;
        border-radius: 5px;
        font-size: 1.2em;
        cursor: pointer;
        transition: background-color 0.3s ease;
        margin-right: 10px;
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
            <!-- 왼쪽: 이미지 -->
            <div class="product-images">
                <img :src="selectedImage" :alt="info.itemName">
                <div class="thumbnails">
                    <img v-for="(img, index) in imgList" :src="img.filePath" :alt="info.itemName"
                    :class="{'active': selectedImage === img.filePath}" 
                     @click="selectedImage = img.filePath">
                </div>
            </div>

            <!-- 오른쪽: 상세 정보 -->
            <div class="product-info">
                <h2 class="product-name">{{ info.itemName }}</h2>
                <p class="product-price">{{ info.price }} 원</p>
                <p class="description">{{ info.itemInfo }}</p>
                <button class="buy-button" @click="fnPayment()">구매하기</button>
                <button class="buy-button" @click="goBack()">뒤로 가기</button>
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
                imgList : [],
                selectedImage: "",
                sessionId : "${sessionId}"
            };
        },
        methods: {
            fnGetProduct() {
                var self = this;
                var params = {
                    itemNo : self.itemNo,
                };

                $.ajax({
                    url: "/product/view.dox",
                    dataType: "json",
                    type: "POST",
                    data: params,
                    success: function(data) {
                        self.info = data.info;
                        self.selectedImage = data.info.filePath;
                        self.imgList = data.imgList;
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
                    merchant_uid: "test1" + new Date().getTime(),
                    name: "테스트 결제",
                    amount: self.info.price,
                    buyer_tel: "010-0000-0000",
                  } , function (rsp) { // callback
                      if (rsp.success) {
                        // 결제 성공 시
                        alert("성공");
                        console.log(rsp);
                        // self.fnSave(rsp.merchant_uid);
                    } else {
                        // 결제 실패 시
                        alert("실패");
                        self.fnSave(rsp.merchant_uid);
                      }
                });
            },
            fnSave : function (merchant_uid) {
                var self = this;

				var nparmap = {
                    //결제 아이디, 세션아이디, 가격, 제품 번호,
                    orderId : merchant_uid,
                    userId : self.sessionId,
                    price : self.info.price,
                    itemNo : self.info.itemNo,
				};
                $.ajax({
					url:"/payment.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						self.list = data.list;
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
