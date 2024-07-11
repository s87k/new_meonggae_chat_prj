<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
	<title>멍게장터</title>
	<link rel="icon" href="/tamcatIcon.ico" />
	<!-- jQuery CDN -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
	<!-- Google Font -->
	<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700|Raleway:400,300,500,700,600' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.css" type="text/css">
	<!-- Theme Stylesheet -->
	<script src="/js/script.js"></script>
<!-- 	<script src="http://localhost/meonggae_prj/common/JS/eventJS.js"></script> -->
	<link rel="stylesheet" href="/css/style.css">
	<link rel="stylesheet" href="/css/event_style.css">
	<link rel="stylesheet" href="/css/responsive.css">
	<link rel="stylesheet" href="/css/meongae_talk.css">
<!-- 	<script src ="/js/chat.js"></script> -->
	<!-- sock js -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.2/sockjs.min.js"></script>
	<!-- STOMP -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>    
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>

<script type="text/javascript">

	$(function() {
		//const surscribe = [];
		
	}); // ready
	
    let scriptURL = "/js/chat.js?v="+Math.random();
    let scriptElement = document.createElement("script");
    scriptElement.src = scriptURL;
    document.head.appendChild(scriptElement);

</script>
<body>
<!-- header 시작 -->
<jsp:include page="../header/header.jsp" />

<div class="container" style="height: 1000px;">
	<h1>멍게톡</h1>
	<input type="hidden" id="memNum" value="${requestScope.memNum }"/>
	<input type="hidden" id="memNumOpponent" value=""/>
	<input type="hidden" id="imgOpponent" value=""/>
	<input type="hidden" id="goodsNum" value="${requestScope.goodsNum }"/>
	<div class="messaging">
		<div class="inbox_msg">
			<div class="inbox_people">
				<div class="headind_srch">
					<div class="recent_heading">
						<h4>전체 대화</h4>
					</div>
				</div>
				<div id="inbox_chat" class="inbox_chat">
					<c:choose>
						<c:when test="${requestScope.listChatRoom eq null}">
							<div class="chat_ib">
								<h5 style="margin-top:10px;">대화가 존재하지 않습니다</h5>
							</div>
						</c:when>
						<c:otherwise>
							<c:forEach var="chatRoomDomain" items="${requestScope.listChatRoom }" varStatus="i">
<%-- 								<div class="chat_list${i.index eq 0 ? ' active_chat' : '' }"> --%>
							<div class="chat_list">
								<input type="hidden" class="memNumOpponentClass" value="${chatRoomDomain.memNumOpponent}"/>
								<input type="hidden" class="imgOpponentClass" value="${chatRoomDomain.imgOpponent}"/>
								<div class="chat_people">
									<div class="chat_img">
										<c:choose>
											<c:when test="${chatRoomDomain.imgOpponent eq null or rchatRoomDomain.imgOpponent eq '' }">
												<img src="/profile-img/default.png" alt="" class="thumbnail">
											</c:when>
											<c:when test="${fn:startsWith(chatRoomDomain.imgOpponent, 'http')}">
												<img src="${chatRoomDomain.imgOpponent}" alt="" class="thumbnail" style="max-width:40px; max-height:40px;">
											</c:when>
											<c:otherwise>
												<img src="http://211.63.89.140/meonggae_prj/profile-img/${chatRoomDomain.imgOpponent}" alt="" class="thumbnail">
											</c:otherwise>
										</c:choose>
									</div>
									<div class="chat_ib">
										<h5 style="cursor:pointer;" class="memNick">${chatRoomDomain.nickOpponent} <span class="chat_date">
												<fmt:formatDate value="${date}" pattern="yyyy-MM-dd" />
											</span>
										</h5>
										<p class="chat_preview">${chatRoomDomain.content}</p>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div id="mesgs" class="mesgs" style="background-color: #F8F8F8;">
			<div class="msg_history" id="msg_history">
				<!-- 채팅 메시지가 들어오는 곳 -->
			</div>
			<div id="type_msg" class="type_msg">
				<div id="input_msg_write" class="input_msg_write">
					<input type="text" id="write_msg" class="write_msg" placeholder="채팅방을 선택해주세요!" readonly='readonly'/>
					<button id="msg_send_btn" class="msg_send_btn" type="button">
						<i class="fa fa-paper-plane-o" aria-hidden="true"></i>
					</button>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
<!-- footer 시작 -->
<jsp:include page="../footer/footer.jsp" />
<!-- footer 끝 -->