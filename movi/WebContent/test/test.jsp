<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<body>
    <!-- body 부분 -->
    <input id="searchInput">
</body>

<script>
    $(function() {    //화면 다 뜨면 시작
        var searchSource = ["김치 볶음밥", "신라면", "진라면", "라볶이", "팥빙수","너구리","삼양라면","안성탕면","불닭볶음면","짜왕","라면사리" ]; // 배열 형태로 
        $("#searchInput").autocomplete({  //오토 컴플릿트 시작
            source : searchSource,    // source 는 자동 완성 대상
            focus : function(event, ui) { 
                return false;//한글 에러 잡기용도로 사용됨
            },
            minLength: 1,// 최소 글자수
            autoFocus: true,
            classes: { 
                "ui-autocomplete": "highlight"//선택된거에 하이라이트
            },
            delay: 0    //검색창에 글자 써지고 나서 autocomplete 창 뜰 때 까지 딜레이 시간(ms)
           // position: { my : "right top", at: "right bottom" }
        });
        
    });
</script>