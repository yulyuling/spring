<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
	<title>첫번째 페이지</title>
    <link rel="stylesheet" href="../css/product-style.css">
</head>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f8f8;
        }
    
        /* 헤더 스타일 */
        #header {
        width: 100%;
        min-height: 80px;
        background: white;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        padding: 10px 20px;
        }
    
        /* 로고 */
        .logo-text {
        font-size: 1.8em;
        font-weight: bold;
        color: #333;
        }
    
        /* 제목 중앙 정렬 */
        .header-title {
            flex-grow: 1;
            text-align: center;
            font-size: 1.5em;
            font-weight: bold;
            color: #333;
        }
        .header-right {
            display: flex;
            align-items: center;
            gap: 10px; /* 검색창과 로그인 버튼 사이 간격 */
        }
    
        .search-container {
            position: relative;
            width: 280px; /* 검색창 크기 */
            display: flex;
            align-items: center;
            border: 2px solid #0056b3;
            border-radius: 50px;
            padding: 5px 10px;
            background-color: white;
        }

        .search-input {
            flex-grow: 1;
            border: none;
            outline: none;
            font-size: 16px;
            padding: 8px;
            background: transparent;
        }

        .search-btn {
            border: none;
            background-color: #0056b3;
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 14px;
            cursor: pointer;
            transition: 0.3s;
        }
        .login-btn button {
            background-color: #0056b3;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 20px;
            font-size: 14px;
            cursor: pointer;
            transition: 0.3s;
        }

        .login-btn button:hover {
            background-color: #466789;
        }

        .search-btn img {
            width: 20px;
            height: 20px;
            filter: invert(20%) sepia(100%) saturate(700%) hue-rotate(200deg); 
            /* 아이콘 색상을 블루 계열로 조정 */
        }
        
        
        /* 버튼 스타일 */
        .search-box button, .login-btn button {
            padding: 6px 12px;
            background-color: #003d80;
            color: white;
            border: none;
            border-radius: 25px;
            cursor: pointer;
        }
    
        .search-box button:hover, .login-btn button:hover {
            background-color: #466789;
        }
        .header {
            background-color: #ffffff;
            padding: 10px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
        }
        .logo-text {
            font-size: 28px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 10px;
        }
        /* 네비게이션 스타일 */
        .nav {
            display: flex;
            justify-content: center;
            background-color: #ffffff;
            padding: 10px 0;
            text-decoration: none;
            color: #333;
        }

        .nav > li {
            list-style: none;
            position: relative;
            margin: 0 20px;
            cursor: pointer;
        }

        .nav > li > a {
            display: block;
            padding: 10px 15px;
            color: rgb(157, 157, 157);
            text-decoration: none;
            font-weight: bold;
        }

        /* 드롭다운 메뉴 스타일 */
        .nav li ul {
            position: absolute;
            top: 40px;
            left: 0;
            background-color: white;
            padding: 0;
            min-width: 120px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            border-radius: 5px;
            z-index: 1000;
            display: none; /* 🔹 기본적으로 숨김 */
        }

        .nav li:hover ul,
        .nav li ul.show {
            display: block; /* 🔹 Vue에서 클래스 제어 */
        }

        .nav li ul li {
            list-style: none;
            padding: 10px;
            border-bottom: 1px solid #ddd;
            cursor: pointer;
            text-align: center;
        }

        .nav li ul li:last-child {
            border-bottom: none;
        }

        .nav li ul li:hover {
            background-color: #f0f0f0;
        }
        .ulText{
            font-size: 15px;
        }
        a {
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }
    </style>
    <body>
        <div class="header">
            <div class="logo">
            <div class="logo-text">양파쿵야</div>
            </div>
            <!-- <div class="header-title">양파쿵야의 레스토랑</div> -->
            <ul class="nav">
                <li v-for="main in mainList"
                    @mouseover="openMenu = main.menuId"
                    @mouseleave="openMenu = null">
                    <a href="#">{{ main.menuName }}</a>
                    <ul v-if="main.subCnt > 0" :class="{'show': openMenu === main.menuId}" class="ulText">
                        <template v-for="sub in subList">
                            <li v-if="sub.parentId == main.menuId">
                                <a :href="sub.menuUrl">{{ sub.menuName }}</a>
                            </li>                    
                        </template>
                    </ul>
                </li>
            </ul>
            <div class="header-right">
                <div class="search-container">
                    <input v-model="keyword" type="text" placeholder="검색어를 입력하세요" class="search-input" >
                    <button class="search-btn" @click="fnSearch">검색</button>
                </div>
                <div class="login-btn">
                    <button @click="fnLogin">로그인</button>
                </div>
            </div>
        </div>
    
    </body>
    </html>
    
    <script>
        const header = Vue.createApp({
            data() {
                return {
                    mainList : [],
                    subList : [],
                    keyword : "",
                };
            },
            methods: {
                fnMenu() {
                    let self = this;
                    $.ajax({
                        url: "/menu.dox",
                        dataType: "json",
                        type: "POST",
                        data: {},
                        success: function(data) {
                            console.log(data);
                            self.mainList = data.mainList;
                            self.subList = data.subList;
                        }
                    });
                },
                fnLogin : function(){

                },
                fnSearch : function(){
                    let self = this;
                    app._component.methods.fnProductList(self.keyword);
                },
            },
            mounted() {
                var self = this;
                self.fnMenu();
            }
        });
        header.mount('.header');
    </script>