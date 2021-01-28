<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="com.spring.gogidang.domain.*"%>
<%@ page import="java.util.ArrayList"%>
<%
   MemberVO mvo = (MemberVO) session.getAttribute("memberVO");
   String u_id = "";
   int seller_key;
   if(mvo != null) {
      u_id = mvo.getU_id();
      seller_key = mvo.getSeller_key();
   } else {
      seller_key = 0;
   }
   
   ArrayList<EventVO> event_list =(ArrayList<EventVO>) request.getAttribute("eventList");
   ArrayList<StoreVO> store_list =(ArrayList<StoreVO>) request.getAttribute("storeList");
   ArrayList<ReviewVO> review_list =(ArrayList<ReviewVO>) request.getAttribute("reviewList");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="Ogani Template">
<meta name="keywords" content="Ogani, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>고기당</title>

<!-- Google Font -->
<link
   href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap"
   rel="stylesheet">

<!-- Css Styles -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/elegant-icons.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/nice-select.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery-ui.min.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/owl.carousel.min.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/slicknav.min.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" type="text/css">
</head>

<body>
   <!-- Page Preloder -->
   <div id="preloder">
      <div class="loader"></div>
   </div>

   <!-- Humberger Begin -->
    <header class="header">
        <div class="header__top">
         <div class="container">
            <div class="row">
               <div class="col-lg-6 col-md-6">
                  <div class="header__top__left">
                     <ul>
                     
                     </ul>
                  </div>
               </div>
                  <%
                    if (u_id == "" || u_id == null) {   
                  %>
               <div class="col-lg-6 col-md-6">
                  <div class="header__top__right">


                     <div class="header__top__right__auth">
                        <a href="./loginForm.me"><i class="fa fa-user"></i>LOGIN</a>
                     </div>
                     <div class="header__top__right__auth">
                        <a href="./joinForm.me"><i class="fa fa-user-o"></i> JOIN</a>
                     </div>
                     <div class="header__top__right__auth">
                        <a href="#"><i class="fa fa-shopping-cart"></i> CART</a>
                     </div>
                  </div>
               </div>
                     <%
                    } else if (seller_key == 1) {   
                  %>
               <div class="col-lg-6 col-md-6">
                  <div class="header__top__right">
                     <div class="header__top__right__auth">
                        <a href="./storeInsert.st"><i class="fa fa-user"></i><%=u_id %> 사장님 !</a>
                     </div>
                  </div>
               </div>
                  <%
                    } else if (seller_key == 2) {
                  %>
               <div class="col-lg-6 col-md-6">
                  <div class="header__top__right">
                     <div class="header__top__right__auth">
                        <a href="./adminmypage.me"><i class="fa fa-user"></i>관리자 입니다.</a>
                     </div>
                  </div>
               </div>
                  <%
                     } else {
                  %>
                  <div class="col-lg-6 col-md-6">
                  <div class="header__top__right">
                     <div class="header__top__right__auth">
                        <a href="./loginForm.me"><i class="fa fa-user"></i><%=u_id %>님!</a>
                     </div>
                  </div>
               </div>
                  <%
                     } 
                  %>   
            </div>
            <!-- row -->
         </div>
         <!-- container -->
      </div>
        <div class="container">
            <div class="row_main">
                <div class="col-lg-3">
                    <div class="header__logo">
                        <a href="./main.me"><img class="mainlogo_img" src="./resources/img/mainlogo_19.PNG" alt=""></a>
                    </div>
                </div>
                <div class="col-lg-8">
                    <nav class="header__menu">
                        <ul>
                            <li><a href="./main.me">Home</a></li>
                            <li><a href="./storeList.st">Shop</a></li>
                            <li><a href="./reviewList.re">Review</a></li>
                            <li><a href="./eventList.ev">Event</a></li>
                            <li><a href="./qnalist.qn">Q & A</a></li>
                        </ul>
                    </nav>
                </div>
                <!-- 
                <div class="col-lg-3">
                    <div class="header__cart">
                        <ul>
                            <li><a href="#"><i class="fa fa-heart"></i> <span>1</span></a></li>
                            <li><a href="#"><i class="fa fa-shopping-bag"></i> <span>3</span></a></li>
                        </ul>
                        <div class="header__cart__price">item: <span>$150.00</span></div>
                    </div>
                </div>
                 -->
            </div>
            <div class="humberger__open">
                <i class="fa fa-bars"></i>
            </div>
        </div>
    </header>
   <!-- Humberger End -->

   <!-- Header Section Begin -->
   <!-- Header Section Begin -->
   
   <!-- Header Section End -->