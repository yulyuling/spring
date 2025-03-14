<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-Change.js"></script>
	<title>첫번째 페이지</title>
    <link rel="stylesheet" href="../css/product-style.css">
</head>

    <style>
     
  
        
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
                <div class="search-container">
                    <input v-model="keyword" type="text" placeholder="검색어를 입력하세요" class="search-input" >
                    <button class="search-btn" @click="fnSearch">검색</button>
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
                fnLogin(){
                    location.href="/member/login.do";
                    
                },                
                fnSearch : function(){
                    let self = this;
                    app._component.methods.fnProductList(self.keyword);
                }
            },
            mounted() {
                var self = this;
                self.fnMenu();
            }
        });
        header.mount('.header');
    </script>