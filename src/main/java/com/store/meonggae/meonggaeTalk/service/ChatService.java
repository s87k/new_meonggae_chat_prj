package com.store.meonggae.meonggaeTalk.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.ibatis.exceptions.PersistenceException;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.store.meonggae.dao.ChatDAO;
import com.store.meonggae.meonggaeTalk.domain.ChatDomain;
import com.store.meonggae.meonggaeTalk.domain.ChatRoomDomain;
import com.store.meonggae.meonggaeTalk.vo.ChatRoomParticipantVO;
import com.store.meonggae.meonggaeTalk.vo.ChatSendVO;

@Service
@SuppressWarnings("unchecked")
public class ChatService {
	@Autowired(required = false)
	private ChatDAO cDAO;
	
	// 나의 닉네임 조회
	public String searchOneMyNick(int memNum) {
		String nick = "";
		try {
			nick = cDAO.selectOneMyNick(memNum);
		} catch (PersistenceException pe) {
			pe.printStackTrace();
		} // end catch
		return nick;
	} // searchOneMyNick
	
	// 채팅방 목록 조회
	public List<ChatRoomDomain> searchListChatRoom(int memNum) {
		List<ChatRoomDomain> list = null;
		
		try {
			list = cDAO.selectListChatRoom(memNum);
		} catch(PersistenceException pe) {
			pe.printStackTrace();
		} // end catch
		
		return list;
	} // searchListChatRoom
	
	// 채팅방의 채팅 목록 조회
	public List<ChatDomain> searchListChat(ChatRoomParticipantVO chatRoomParticipantVO) {
		List<ChatDomain> list = null;
		
		try {
			list = cDAO.selectListChat(chatRoomParticipantVO);
		} catch(PersistenceException pe) {
			pe.printStackTrace();
		} // end catch
		
		return list;
	} // searchListChat
	
	// 채팅방의 채팅 목록 조회
	public String searchListChatJson(ChatRoomParticipantVO chatRoomParticipantVO) {
		
		LocalDateTime now = LocalDateTime.now();
				
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("result", false);
		jsonObj.put("dataSize", 0);
		jsonObj.put("date", now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
		jsonObj.put("data", "");
		
		List<ChatDomain> list = null;
		
		try {
			list = cDAO.selectListChat(chatRoomParticipantVO);
			
			ObjectMapper objMapper = new ObjectMapper();
			jsonObj.put("data", objMapper.writeValueAsString(list));
			jsonObj.put("dataSize", list.size());
			jsonObj.put("result", true);
		} catch(PersistenceException pe) {
			pe.printStackTrace();
		}  catch (JsonProcessingException jpe) {
			jpe.printStackTrace();
		} // end catch
		
		return jsonObj.toJSONString();
	} // searchListChat
	
	// 채팅 보내기
	public String addChat(ChatSendVO chatSendVO) {
		int cnt = 0;
		LocalDateTime now = LocalDateTime.now();
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("result", false);
		jsonObj.put("dataSize", 0);
		jsonObj.put("date", now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
		jsonObj.put("data", "");
		
		try {
			cnt = cDAO.insertChat(chatSendVO);
			if(cnt == 1) {
				jsonObj.put("dataSize", 1);
				jsonObj.put("data", new JSONObject().put("cnt", cnt));
				jsonObj.put("result", true);
			} // end if
		} catch(PersistenceException pe) {
			pe.printStackTrace();
		} // end catch
		return jsonObj.toJSONString();
	} // addChat
} // class
