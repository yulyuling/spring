<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
	<title>첫번째 페이지</title>
    <link rel="stylesheet"href="../css/product-style.css">
</head>
<style>
     body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f8f8;
            text-align: center;
        }
		h1{
			text-align: center;
		}
    .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
            padding: 10px 20px;
			height: 100px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            position: relative;
        }
        .logo img {
            height: 80px;
        }
        .header-title {
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            font-size: 1.5em;
            font-weight: bold;
            color: #333;
        }
</style>
<body>
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
</body>
</html>
<script>
   
</script>