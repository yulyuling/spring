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
    }

    /* 헤더 스타일 */
    #header {
        width: 100%;
    }

    .header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        background: white;
        padding: 10px 20px;
        height: 80px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    .logo img {
        height: 60px;
    }

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
        gap: 10px;
    }

    .search-box {
        display: flex;
        align-items: center;
        gap: 5px;
    }

    .search-box input {
        padding: 6px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 5px;
        width: 180px;
    }

    .search-box button, .login-btn button {
        padding: 6px 12px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .search-box button:hover, .login-btn button:hover {
        background-color: #0056b3;
    }

    /* 제품 등록 폼 */
    #app {
        width: 400px;
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        margin: 50px auto;
        text-align: center;
    }

    .form-container {
        display: flex;
        flex-direction: column;
        gap: 10px;
        margin-top: 20px;
        padding: 30px;
    }

    .form-container label {
        font-weight: bold;
        text-align: left;
        color: #333;
    }

    .form-container input {
        padding: 8px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 5px;
        width: 100%;
        
    }

    button {
        padding: 10px 15px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-top: 10px;
        width: 100%;
    }

    button:hover {
        background-color: #0056b3;
    }
</style>
<body>
    <div id="header">
        <jsp:include page="../common/header.jsp"/>
    </div>
    <div id="app">

        <h2>제품 등록</h2>
        <div class="form-container">
            <label>제품명</label>
            <input v-model="itemName" type="text" placeholder="제품명을 입력하세요">
            <div style="margin-bottom: 10px;">
                썸네일 <input type="file" id="thumbFile" name="thumbFile" accept=".jpg, .png" >
            </div>
            <div style="margin-bottom: 10px;">
                제품설명 <input type="file" id="file1" name="file1" accept=".jpg, .png" multiple>
            </div>
            <label>가격</label>
            <input v-model="price" type="number" placeholder="가격을 입력하세요">

            <label>설명</label>
            <input v-model="itemInfo" type="text" placeholder="설명을 입력하세요">
        </div>

        <button @click="fnAdd">저장</button>
    </div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                itemNo : "${map.itemNo}",
                itemName : "",
                price : "",
                itemInfo : "",
            };
        },
        methods: {
            fnAdd(){
				var self = this;
				var nparmap = {
                    itemName : self.itemName,
                    price : self.price,
                    itemInfo : self.itemInfo,
                };
				$.ajax({
					url:"/product/add.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log("상품 등록 성공", data);

                        if( $("#file1")[0].files.length > 0){
                            var form = new FormData();

                            form.delete("file1");
                            for(let i=0; i<$("#file1")[0].files.length; i++){
                                form.append( "file1",  $("#file1")[0].files[i]);
                            }
                            form.append( "itemNo", data.itemNo); // 임시 pk
                            self.upload(form); 
                    
                        }  else {
                            // location.href="/product/add.do"
                        }

					}
				});
            },
            //파일업로드
            upload : function(form){
            	var self = this;
            	 $.ajax({
            		 url : "/product/fileUpload.dox"
            	   , type : "POST"
            	   , processData : false
            	   , contentType : false
            	   , data : form
            	   , success:function(response) { 
                        alert("저장되었습니다");
                        location.href="/product/list.do"
            	   }	           
               });
            }
        }, 
        mounted() {
            var self = this;
            
        }
    });
    app.mount('#app');
</script>