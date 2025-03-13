<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
    <!-- Quill CDN -->
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
    

	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
	<title>첫번째 페이지</title>
</head>
<style>
    div{
        margin-top : 5px;
    }

</style>
<body>
	<div id="app">
        <div> 제목 : <input v-model="title"> </div>
            <input type="file" id="file1" name="file1" accept=".jpg, .png" multiple>
            
            <div style="width: 500px;">
                <div id="editor" style="height: 300px;"></div>
            </div>
            <div>
                <button @click="fnSave()">저장</button>
                <!-- <button @click="fnAdd">파일저장</button> -->
        </div>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                title : "",
                contents : "",
                sessionId : "${sessionId}",
            };
        },
        methods: {
            fnSave(){
				var self = this;
				var nparmap = {
                    title : self.title,
                    contents : self.contents,
                    userId : self.sessionId,
                };
				$.ajax({
					url:"/board/add.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        alert("저장함!");  

                        //첨부파일이 있을때만 실행한다.
                        if( $("#file1")[0].files.length > 0){
                            var form = new FormData();
                            // form.append( "file1",  $("#file1")[0].files[0] );
                            for(let i=0; i<$("#file1")[0].files.length; i++){
                                form.append( "file1",  $("#file1")[0].files[i]);
                            }
                            form.append( "boardNo", data.boardNo); // 임시 pk
                            self.upload(form); 
                            location.href="/board/list.do"
                        } else {
                            location.href="/board/list.do"
                        }
                         //용량이 많으면 업로드 하는 동안 다음으로 넘어가버리니까, else로 해줘야함
                        //ajax통신은 비동기통신이라 순서대로 실행되지 않을 수도 있따.
					}
				});
            },
            
            //파일업로드
            upload : function(form){
            	var self = this;
            	 $.ajax({
            		 url : "/fileUpload.dox"
            	   , type : "POST"
            	   , processData : false
            	   , contentType : false
            	   , data : form
            	   , success:function(response) { 
                
            	   }	           
               });
            }
        },
        mounted() {
            var self = this;
                    // Quill 에디터 초기화
        var quill = new Quill('#editor', {
            theme: 'snow',
            modules: {
                toolbar: [
                    [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                    ['bold', 'italic', 'underline'],
                    [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                    ['link', 'image'],
                    ['clean'],
                    [{ 'color': [] }, { 'background': [] }],  
                ]
            }
        });

        // 에디터 내용이 변경될 때마다 Vue 데이터를 업데이트
        quill.on('text-change', function() {
            self.contents = quill.root.innerHTML;
        });
        }
    });
    app.mount('#app');
</script>