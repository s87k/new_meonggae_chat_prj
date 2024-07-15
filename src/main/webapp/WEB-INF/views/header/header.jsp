<%-- <%@page import="com.store.meonggae.product.dao.CategoryDAO"%> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="top-bar">
	<div class="container">
		<div class="action pull-right">
			<ul>
				<li class="login"><a
					href="http://stu8.sist.co.kr/meonggae_prj/logout.do"
					class="login-btn"> <i class="fa fa-sign-out"></i>로그아웃
				</a> / <a
					href="http://stu8.sist.co.kr/meonggae_prj/My/mypage/main/myPageMain_frm.do"
					class="login-btn"> <i class="fa fa-user"></i>마이페이지
				</a></li>
			</ul>
		</div>
	</div>
</div>

<div class="header">
	<div class="container">
		<div class="row">
			<div class="col-md-3 col-sm-3">
				<div class="logo">
					<a href="http://stu8.sist.co.kr/meonggae_prj/index.do"> <img
						src="/images/meonggaelogo.png">
					</a>
				</div>
			</div>
			<div class="col-md-6 col-sm-5">
				<div class="search-form">
					<form class="navbar-form" id="searchFrm" role="search">
                        <div class="form-group">
                            <input type="text" id="searchKey" onkeydown="enterkey(event)" value="${requestScope.keyword}" class="form-control" placeholder="상품명, @상점명 입력">
                        </div>
                        <button type="button" id="search-btn" class="btn"><i class="fa fa-search"></i></button>
                    </form>
				</div>
			</div>
			<div class="col-md-3 col-sm-4">
				<div class="col-md-4 col-sm-4">
					<a href="http://stu8.sist.co.kr/meonggae_prj/product_page/product_add.do"
						class="icons"> <img
						src="/images/meonggaesale.png"
						alt="판매하기 이미지"> <span class="icons-text">판매하기</span>
					</a>
				</div>
				<div class="col-md-4 col-sm-4">
					<a href="http://stu8.sist.co.kr/meonggae_prj/My/store/store_frm.do?nick=${nick}"
						class="icons"> <img
						src="/images/meonggaeStore.png"
						alt="내상점 이미지"> <span class="icons-text">내 상점</span>
					</a>
				</div>
				<div class="col-md-4 col-sm-4">
					<a href="javascript:location.reload()"
						class="icons"> <img
						src="/images/meonggaeTalk.png"
						alt="멍게톡 이미지"> <span class="icons-text">멍게톡</span>
					</a>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-2 col-sm-3">
				<button type="button" class="category-btn">
					<i class="fa fa-bars"></i> 전체보기
				</button>
				<div class="categories">
					<div class="category-list">
						<ul class="category-ul">
							<!-- 카테고리 항목이 동적으로 추가 -->
						</ul>
					</div>
				</div>
				<div class="category-detail">
					<div class="detail-list">
						<ul class="detail-ul">
							<!-- 카테고리 항목이 동적으로 추가 -->
						</ul>
					</div>
				</div>
			</div>
			<div class="col-md-2 col-sm-3">
				<button type="button" class="event-btn" name="event-btn" value="이벤트">
					<i class="fa fa-star" aria-hidden="true"></i> 이벤트
				</button>
			</div>
		</div>
	</div>
</div>
<!-- Header 끝 -->
<!-- Modal -->
<div class="modal fade" id="popupModal" tabindex="-1" role="dialog"
	aria-labelledby="popupModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="popupModalLabel">로그인</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<!-- AJAX로 가져온 로그인 페이지가 여기 표시됨 -->
			</div>
			<div class="modal-footer">
				<p style="text-align: center">
					도움이 필요하면 이메일 또는 고객센터1670-2910로 문의 부탁드립니다.<br> 고객센터 운영시간:
					09~18시 (점심시간 12~13시, 주말/공휴일 제외)
				</p>
			</div>
		</div>
	</div>
</div>
<!-- Modal 끝 -->