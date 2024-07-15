/**
 * 
 */

//var socket = new SockJS('/websocket');
//var stomp  = Stomp.over(socket);
////stomp.debug = null; // stomp 콘솔출력 X
//
//// 구독을 취소하기위해 구독 시 아이디 저장
//var subscribe = [];

$(function (){
	const socket = new SockJS('/websocket');
	const stomp  = Stomp.over(socket);
	//stomp.debug = null; // stomp 콘솔출력 X

	// 구독을 취소하기위해 구독 시 아이디 저장
	var subscribe = null;
	
	const serverName = $("#serverName").val() != null ? $("#serverName").val() : '';
	
	// 채팅방 선택시 채팅 내역 불러오기
	$(".memNick").click(function() {
		if(subscribe != null) {
			// 기존 구독 취소
			subscribeCancle();
		}
		
		$("#mesgs").css("background-color", "#ffffff");
		$("#write_msg").prop("placeholder", "채팅을 입력해주세요");
		$("#write_msg").prop("readonly", "");

		$(".chat_list").removeClass("active_chat");
		$($(".chat_list")[$(".memNick").index(this)]).addClass("active_chat");
		
		let memNum = $("#memNum").val();
		let memNumOpponent = $($(".memNumOpponentClass")[$(".memNick").index(this)]).val();
		let imgOpponent = $($(".imgOpponentClass")[$(".memNick").index(this)]).val();
		
		$("#memNumOpponent").val(memNumOpponent);
		$("#imgOpponent").val(imgOpponent);
		
		callAjaxChatList(memNum, memNumOpponent);

		// 연결 시작
		stompConnect();
	}); // click
	
	// 엔터 치면 메시지 전송
	$("#write_msg").keydown(function (evt) {
		if(evt.which == 13) {
			chkNull();
		} // end if
	}); // keydown
	
	// 전송 버튼 누르면 메시지 전송
	$("#msg_send_btn").click(function () {
		chkNull();
	}); // click
	
	// 널 체크하여 메시지 전송
	function chkNull(){
		
		// 채팅방 미선택시 보내지 않음
		if($("#memNumOpponent").val() == null || $("#memNumOpponent").val() == '') {
			return;
		} // end if

		let content = $("#write_msg").val().trim()
		if(content != "") {
			callAjaxChatAdd(content);
	//		stomp.send("/socket/sendMessage/" + roomNumber, {}, JSON.stringify(data));
			const data = {
				memNumSend: $("#memNum").val(),
				memNumRecv: $("#memNumOpponent").val(),
				content: $("#write_msg").val()
			}
			stomp.send("/socket/sendMessage/" + getRoomnumber() , {}, JSON.stringify(data));
		} // end if
	} // chkNull
	
	// 채팅방 선택시 채팅 내역 불러오기
	function callAjaxChatList(memNum, memNumOpponent) {
		var param = {
				memNum: memNum,
				memNumOpponent:memNumOpponent
		}
		$.ajax({
			url: "http://" + serverName + ":8880/chat_list",
			type: "GET",
			data: param,
			dataType: "JSON",
			error: function(xhr) {
				console.log(xhr.status + " / " + xhr.statusText);
				alert("문제가 발생하였습니다. 잠시 후 다시 시도해주시기 바랍니다");
			}, 
			success: function(jsonObj) {
				if(jsonObj.result) {
					applyChatList(JSON.parse(jsonObj.data));
				} // end if
			} // success
		}); // ajax
	} // callAjaxChatList
	
	// 메시지 전송 (DB에 추가)
	function callAjaxChatAdd(content) {
		var param = {
				memNumSend: $("#memNum").val(),
				memNumRecv:$("#memNumOpponent").val(),
				content: content,
				goodsNum: $("#goodsNum").val()
		}
		$.ajax({
			url: "http://" + serverName + ":8880/chat_add",
			type: "POST",
			data: param,
			dataType: "JSON",
			error: function(xhr) {
				console.log(xhr.status + " / " + xhr.statusText);
				alert("문제가 발생하였습니다. 잠시 후 다시 시도해주시기 바랍니다");
			}, 
			success: function(jsonObj) {
				if(!jsonObj.result) {
					alert("문제가 발생하였습니다. 잠시 후 다시 시도해주시기 바랍니다");
				} else {
					let msgHistory = $("#msg_history");
					$(msgHistory).html(msgHistory.html() + '<div class="outgoing_msg"><div class="sent_msg"><p>' + content + '</p><span class="time_date">' + getFormatDate() + '</span></div></div>');
					scrollToBottom();
					$("#write_msg").val('');
				} // end if
			} // success
		}); // ajax
	} // callAjaxChatAdd
	
	function updateChatPreview(content) {
		let memNumOpponent = $("#memNumOpponent").val();
		let arrMemNumOpponent = $(".memNumOpponentClass");
		for(let i = 0; i < arrMemNumOpponent.length; i++) {
			if($(arrMemNumOpponent[i]).val() == memNumOpponent) {
				$($(".chat_preview")[i]).html(content);
				break;
			} // end if
		} // end for
	} // updateChatPreview
	
	// 채팅방 형식에 맞는 날짜 데이터 출력
	function getFormatDate() {
		let currentDate = new Date();
		return currentDate.getHours() + ":" + currentDate.getMinutes() + " | " + (currentDate.getMonth() + 1) + "-" + currentDate.getDate();
	} // getFormatDate
	
	// 유저 로그인 형태에 따른 프사 이미지 src 생성
	function getUserImg(img) {
		let imgSrc = ''
		if(img == null || img == '') {
			imgSrc = '/profile-img/default.png';
		} else if (img.startsWith('http')) {
			imgSrc = img;
		} else {
			imgSrc = 'http://stu8.sist.co.kr//meonggae_prj/profile-img/' + img;
		}
		return imgSrc
	} // getUserImg
	
	// 채팅방 선택시 불러온 채팅 내역을 <div>에 적용
	function applyChatList(jsonDataObj) {
		let msgHistory = $("#msg_history");
		let jsonObj = {};
		let output = '';
		let imgSrc = '';
		let memNum = $("#memNum").val();
		if(jsonDataObj.length == 0) {
			msgHistory.html('<div style="text-align:center;"><h5>대화를 시작해보세요!</h5></div>');				
		} else {
			for(let i = 0; i < jsonDataObj.length; i++) {
				jsonObj = jsonDataObj[i];
				if(jsonObj.memNumSend == memNum) {
					output += '<div class="outgoing_msg"><div class="sent_msg"><p>' + jsonObj.content + '</p><span class="time_date">' + jsonObj.strDate + '</span></div></div>';						
				} else {
					imgSrc = getUserImg(jsonObj.imgOpponent);
					output += '<div class="incoming_msg"><div class="incoming_msg_img"><img src="' + imgSrc + '" alt="prof"></div><div class="received_msg"><div class="received_withd_msg"><p>' + jsonObj.content + '</p><span class="time_date">' + jsonObj.strDate + '</span></div></div></div>'
				} // end else
			} // end for
			msgHistory.html(output);
			scrollToBottom();
		} // end else
	} // applyChatList
	
	// 채팅 리스트 스크롤을 맨 밑으로
	function scrollToBottom() {
		let msgHistory = $("#msg_history");
		msgHistory.scrollTop(msgHistory[0].scrollHeight);
	} // scrollToBottom
	
	
	// ------------------------------------------------------
	// ------------------------------------------------------
	// ------------------------------------------------------
	// ------------------------------------------------------
	// ------------------------------------------------------
	// ------------------------------------------------------
	// ------------------------------------------------------
	
	// 채팅방 식별자 구하기 
	function getRoomnumber() {
		let memNum = $("#memNum").val();
		let memNumOpponent = $("#memNumOpponent").val();
		let roomNumber = memNum < memNumOpponent ? memNum + '_' + memNumOpponent : memNumOpponent + '_' + memNum;
		return roomNumber;
	} // getRoomnumber	
	
	
	// 모든 구독 취소하기
	function subscribeCancle() {
		subscribe.unsubscribe();
//		const length = subscribe.length;
//		for(let i=0;i<length;i++) {
//			const sid = subscribe.pop();
//			stomp.unsubscribe(sid.id);
//		}
	}
	
	// 웹소켓 연결
	function stompConnect() {
		let memNum = $("#memNum").val();
		let memNumOpponent = $("#memNumOpponent").val();
		let roomNumber = getRoomnumber();
	
		const socket = new SockJS('/websocket');
		const stomp  = Stomp.over(socket);
		//stomp.debug = null; // stomp 콘솔출력 X
	
		//2. connection이 맺어지면 실행
		stomp.connect({}, function() {
			console.log("STOMP Connection")
		
			//4. subscribe(path, callback)으로 메세지를 받을 수 있음
			const subscribeId = stomp.subscribe("/topic/message/" + roomNumber, function(chat) {
				let jsonBody = JSON.parse(chat.body);
				console.log(chat.headers.destination);
				
				let memNumSend = jsonBody.memNumSend;
				let memNumRecv = jsonBody.memNumRecv;
				let content = jsonBody.content;
				let output = '';
				let memNum = $("#memNum").val();
				let imgSrc = '';
				let msgHistory = $("#msg_history")
				
				console.log("/topic/message/" + getRoomnumber());
				
				if ((memNumSend != memNum) && (chat.headers.destination == "/topic/message/" + getRoomnumber())) {
					imgSrc = getUserImg($("#imgOpponent").val());
					output = '<div class="incoming_msg"><div class="incoming_msg_img"><img src="' + imgSrc + '" alt="prof"></div><div class="received_msg"><div class="received_withd_msg"><p>' + content + '</p><span class="time_date">' + getFormatDate() + '</span></div></div></div>';
					msgHistory.append(output);
					scrollToBottom();
				} // end if
				updateChatPreview(content);
			}); // subscribe
			//subscribe.push(subscribeId);
			subscribe = subscribeId;
		
		}); // connection
	} // stompConnect

}); // $(document).ready(function() { })