package com.store.meonggae.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.store.meonggae.meonggaeTalk.domain.ChatDomain;
import com.store.meonggae.meonggaeTalk.domain.ChatRoomDomain;
import com.store.meonggae.meonggaeTalk.vo.ChatRoomParticipantVO;
import com.store.meonggae.meonggaeTalk.vo.ChatSendVO;

@Component
public class ChatDAO {
	@Autowired(required = false)
	private MyBatisDAO mbDAO;
	
	// 나의 닉네임 조회
	public String selectOneMyNick(int memNum) {
		String nick = "";
		SqlSession ss = mbDAO.getMyBatisHandler(false);
		nick = ss.selectOne("com.store.meonggae.chat.selectOneMyNick", memNum);
		mbDAO.closeHandler(ss);
		return nick;
	} // selectOneMyNick
	
	// 채팅방 목록 조회
	public List<ChatRoomDomain> selectListChatRoom(int memNum) {
		List<ChatRoomDomain> list = null;
		
		SqlSession ss = mbDAO.getMyBatisHandler(false);
		list = ss.selectList("com.store.meonggae.chat.selectListChatRoom", memNum);
		
		mbDAO.closeHandler(ss);
		
		return list;
	} // selectListChatRoom
	
	// 채팅방의 채팅 목록 조회
	public List<ChatDomain> selectListChat(ChatRoomParticipantVO chatRoomParticipantVO) {
		List<ChatDomain> list = null;
		
		SqlSession ss = mbDAO.getMyBatisHandler(false);
		list = ss.selectList("com.store.meonggae.chat.selectListChat", chatRoomParticipantVO);
		
		mbDAO.closeHandler(ss);
		
		return list;
	} // selectListChat
	
	// 채팅 보내기
	public int insertChat(ChatSendVO chatSendVO) {
		int cnt = 0;
		SqlSession ss = mbDAO.getMyBatisHandler(true);
		cnt = ss.insert("com.store.meonggae.chat.insertChat", chatSendVO);
		
		mbDAO.closeHandler(ss);
		
		return cnt;
	} // insertChat
	
	// 채팅방 입장시 메시지 읽음으로 처리
	public int updateChatRead(ChatRoomParticipantVO chatRoomParticipantVO) {
		int cnt = 0;
		SqlSession ss = mbDAO.getMyBatisHandler(true);
		cnt = ss.update("com.store.meonggae.chat.updateChatRead", chatRoomParticipantVO);
		
		mbDAO.closeHandler(ss);
		
		return cnt;
	} // updateChatRead
} // class
