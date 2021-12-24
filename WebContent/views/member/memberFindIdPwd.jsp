<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<!-- bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<!-- jQuery Cookie -->
	<script src="https://cdn.jsdelivr.net/npm/js-cookie@3.0.1/dist/js.cookie.min.js"></script>
  <style>
        *{
            box-sizing: border-box;
        }
        #innerContentWrapper {
            margin: 0px auto;
            width: 600px;
            height: 950px;
            padding: 20px;
            text-align: center;
        }
        #title{
            margin: auto;
            text-align: center;
            font-size: 23px;
            font-weight: 700;
            border-left: 1px solid black;
            border-right: 1px solid black;
            width: 230px;
            height: 20px;
            line-height: 20px;
        }
        .th {
            float: left;
            width: 100px;
            height : 48px;
            text-align: left;
            line-height: 48px;
            font-size: 16px;
        }
        .td{
            width: 350px;
            margin: 0 auto;
        }
        input{
            height : 50px;
            width : 350px;
            border : 1px solid #707070;
            padding-left: 10px;
        }
        .greenBtn{
            background-color: #7FB292;
            color: white;
            border: 0px;
        }
        .float{
            float: left;
            margin-left: 10px;
            line-height: 12px;
            margin: 5px;
        }
        #join:hover{
            color: black;
        }
		ul.tabs{
			margin: 0px;
			padding: 0px;
			list-style: none;
		}
		ul.tabs li{
			display: inline-block;
			padding: 10px 15px;
			cursor : pointer;
			border-bottom: 1px solid #707070;
            width : 150px;
		}
		ul.tabs li.current{
			color: #7FB292;
			border-bottom: 1px solid #7FB292;
		}
		.tab-content{
			display: none;
		}
		.tab-content.current{
			display: inherit;
		}
		a{
			text-decoration:none;
		}
    </style>

<title>아이디 찾기</title>
</head>
<body>
    <div id="innerContentWrapper">
    <div><div id="title" >아이디/비밀번호 찾기</div></div><br>
    <ul class="tabs">
		<li class="tab-link current" data-tab="tab-1">아이디 찾기</li><li class="tab-link" data-tab="tab-2" id="pwdTab">비밀번호 찾기</li>
	</ul>
	<br /><br />
        <div class="tab-content current" id="tab-1">
            <div class="th">이름 </div>
            <div class="td">
                <input type="text" class="input" name="userName" placeholder=" 이름을 입력해주세요">
            </div><br /><br />
            <div class="th">이메일 </div>
            <div class="td">
	            <input type="email" name="userEmail" placeholder=" 이메일을 입력해주세요" data-name="이메일">
            </div>
            <br><br>
            <div class="td"><input type="button" value="아이디 찾기" id="findId" class="btn greenBtn input"></div>
        </div>
        
        <div class="tab-content" id="tab-2">
            <div class="th">아이디 </div>
            <div class="td">
                <input type="text" class="input" name="userId" placeholder=" 아이디를 입력해주세요">
            </div><br /><br />
            <div class="th">이메일 </div>
            <div class="td">
                <input type="email" class="input" name="pwdUserEmail" placeholder=" 이메일을 입력해주세요">
            </div>
            <br><br>
            <div class="td"><input type="button" value="비밀번호 찾기" id="findPwd" class="btn greenBtn input"></div>
        </div>        
    </div>
    
	<!-- 알림 Modal -->
    <div class="modal fade Modal" id="alertModal" tabindex="-1" aria-labelledby="alertModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="alertModalLabel">알림메세지</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body" id="alertModalMSG">
          </div>
          <div class="modal-footer">
           <button type="button" class="btn greenBtn" data-bs-dismiss="modal" id="movePwdBtn">비밀번호 찾기</button>
            <a href="/views/member/memberLogin.jsp"><button type="button" class="btn greenBtn" data-bs-dismiss="modal" id="loginBtn">로그인 하기</button></a>
            <button type="button" class="btn greenBtn" data-bs-dismiss="modal" id="btn">확인</button>
          </div>
        </div>
      </div>
    </div>
    
    <script>
    	// 초기 탭 설정
    $(function(){
    	$("ul.tabs li").click(function(){
    		var tabId = $(this).attr("data-tab");
    		
    		$("ul.tabs li").removeClass("current");
    		$(".tab-content").removeClass("current");
    		
    		$(this).addClass("current");
    		$("#"+tabId).addClass("current");
    	})
    })
	
    	// 아이디 찾기
	$("#findId").click(function(){
	var name = $("input[name=userName]").val();
	var email = $("input[name=userEmail]").val();
	
		$.ajax({
			url : "/member/AjaxFindId.do",
			type : "post",
			data : {"userName":name, "userEmail":email},
			success : function(id){
				var findId = $.trim(id);
				if(findId!=""){
					$("#alertModalMSG").html(name+"님 아이디는 " + id + "입니다.");
					$("#btn").css("display", "none");
					$("#pwdBtn").css("display", "block");
					$("#loginBtn").css("display", "block");
				}else{
					$("#alertModalMSG").html("입력하신 정보로 아이디를 찾을 수 없습니다."+"<br>"+"이름과 이메일을 확인해주세요.");
					$("#btn").css("display", "show");
					$("#loginBtn").css("display", "none");
					$("#movePwdBtn").css("display", "none");
				}
			}
		})
    	$("#alertModal").modal("show");
	})
	
    	// 비밀번호 찾기
	$("#findPwd").click(function(){
	var userId = $("input[name=userId]").val();
	var email = $("input[name=pwdUserEmail]").val();
	
		$.ajax({
			url : "/member/AjaxFindPwd.do",
			type : "post",
			data : {"userId":userId, "userEmail":email},
			success : function(result){
				var findPwd = $.trim(result);
				if(findPwd!=""){
					$("#alertModalMSG").html(email+" 주소로 임시비밀번호가 발급되었습니다.");
					$("#btn").css("display", "block");
					$("#movePwdBtn").css("display", "none");
					$("#loginBtn").css("display", "block");
				}else{
					$("#alertModalMSG").html("입력하신 정보로 비밀번호를 찾을 수 없습니다."+"<br>"+"아이디와 이메일을 확인해주세요.");
					$("#movePwdBtn").css("display", "none");
					$("#loginBtn").css("display", "none");
					$("#btn").css("display", "show");
				}
		    	$("#alertModal").modal("show");
			}
		})
	})
    	
		// 아이디 찾기 알림메시지에서 비밀번호 찾기 탭으로 이동
	$("#movePwdBtn").click(function(){
		$("input[name=userId]").val(id);
		
		$("ul.tabs li").removeClass("current");
		$(".tab-content").removeClass("current");
		
		$("#pwdTab").addClass("current");
		$("#tab-2").addClass("current");
	})
    </script>
    
</body>
</html>