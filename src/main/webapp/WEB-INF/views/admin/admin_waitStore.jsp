<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.gogidang.domain.*"%>

<%
	ArrayList<StoreVO> storeList = (ArrayList<StoreVO>) request.getAttribute("storeList");
	StoreVO storeVO = (StoreVO) session.getAttribute("StoreVO");
%>

<%@include file="../includes/header_simple.jsp"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/modal.css"
	type="text/css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/storewait.css"
	type="text/css">

<!-- Product Section Begin -->
<section class="product spad">
	<div class="container">
		<div class="row">
		<div class="qnaListn">
			<div class="col-lg-3" id="nav-bar">
	            <div class="hero__categories">
	                  <div class="hero__categories__all">
	                  <span>마이페이지</span>
	              	 </div>
						<ul>
							<li><a href="storeWait.st">대기중인 가게 승인</a></li>
							<li><a href="noticeAdmin.no">공지사항 관리</a></li>
							<li><a href="qnaAdmin.qn">문의 관리</a></li>
							<li><a href="eventAdmin.ev">이벤트 관리</a></li>
						</ul>
					</div>
				</div>
			<!-- content Start -->
			<div class="col-lg-9">
				<div class="section-title product__discount__title">
					<h2>가게 승인 대기 리스트</h2>
				</div>
					<table class="table table-striped">
						<thead>
						<tr align=center>
							<td>가게 번호</td>
							<td>가게 이름</td>
							<td>상세보기</td>
						</tr>
						</thead>
						<tbody id="storewait_center">
						
						</tbody>
					</table>
			</div>
			<!-- content End -->
			</div>
		</div>
	</div>
</section>
<!-- Product Section End -->

<!-- The Modal -->
<div id="myModal" class="modal">
	<!-- Modal content -->
	<div class="modal-content">
		<span class="close">&times;</span>                                                               
		<form>
			<fieldset>
			<h3>대기 중인 판매자</h3>
			<ol>
			<!-- 
			  <div class="modal-textbox">
			  	<div class="modal-textbox-s">
			    	<ts for="s_num">사업자등록번호</ts>
			    	<td><input type="text" id="s_num" name="s_num"></td>
			  	</div>
			  	<div class="modal-textbox-s">
			    	<ts for="u_id">회원아이디</ts>
			    	<td><input type="text" id="u_id" name="u_id"></td>
			  	</div>
			  	<div class="modal-textbox-s">
			    	<ts for="thumbnail">가게메인사진</ts>
			    	<td><input type="text" id="thumbnail" name="thumbnail"></td>
			   </div>
			  </div>
			   -->
			  <div class="modal-textbox">
			  	<div class="modal-textbox-s">
			    	<ts for="s_name">가게이름</ts>
				    <td><input type="text" id="s_name" name="s_name"></td>
			  	</div>
			  	<div class="modal-textbox-s">
			    	<ts for="s_num">사업자등록번호</ts>
			    	<td><input type="text" id="s_num" name="s_num"></td>
			  	</div>
			  	<div class="modal-textbox-s">
			    	<ts for="s_phone">가게번호</ts>
			    	<td><input id="s_phone" name="s_phone" type="text"></td>
			   	</div>
			  </div>
			  
			  <div class="modal-textbox">
			  	<div class="modal-textbox-s">
			    	<ts for="u_id">회원아이디</ts>
			    	<td><input type="text" id="u_id" name="u_id"></td>
			  	</div>
			  	<div class="modal-textbox-ad">
			    	<ts for="s_addr">가게주소</ts>
				    <td><input id="s_addr" name="s_addr" type="text"></td>
			   	</div>
			  	<div class="modal-textbox-ti">
			    	<ts for="s_hour">운영시간</ts>
			    	<td><input id="s_hour" name="s_hour" type="text"></td>
			  	</div>
			  	
			  </div>
			 </ol>
			  
			   <div class="modal-imgbox">
			   	 <div class="modal-imgbox-ss">
			    	<ts>가게메인사진</ts>
		    		<div id="thumbnail_IMG"></div>
			     </div>
			     <div class="modal-imgbox-ss">
			    	<ts for="s_img">사업자등록사진</ts>
			    	<div id="s_img_IMG"></div>
			     </div>
			   </div>
				
			  	
			   	
			
			</fieldset>
		
			<div class="form-checkkkk">
                 <button type="button"  id="confirmBtn" class="btn btn-lg btn-block btn-success" >승인</button>
                 <button type="button" id="refuseBtn" class="btn-j btn-lg btn-block btn-success" >거절</button>
                   <br>
            </div>
             
            <!--      	
			<fieldset>
			  	<input type="button" id="confirmBtn" value="승인"/>
				<input type="button" id="refuseBtn" value="거절"/>
			</fieldset>
			 --> 
		</form>
	</div>
</div>
<!-- modal END -->

<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<script>
$(document).ready(function() {
	storeWaitList();
});
	
//Get the modal
var modal = document.getElementById('myModal');

// Get the button that opens the modal
var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];   

function storeWaitList(){
	  $.ajax({
	     url : 'storeWaitListAjax.re',
	     contentType : 'application/x-www-form-urlencoded; charset=utf-8',
	     success : function(data){ 
	        var a ='';
	        $.each(data, function(key,value){
	      		a += '<tr align=center><td>'+ value.s_num + '</td>';
	      		a += '<td>' + value.s_name + '</td>';
	      		a += '<td><button onclick="callModal(' + value.s_num + ');" id="myBtn" class="btn btn-primary btn-xs" style="background: #7fad39; color:white; border: 1px solid #7fad39; margin-top: 0px; padding-top: 0px;padding-bottom: 0px">상세보기</button></td></tr>';
	        });
	        
	        $("#storewait_center").html(a); //a내용을 html에 형식으로 .commentList로 넣음
	     },
	     error:function(){
	        alert("ajax통신 실패(list)!!!");
	     }
	  });
	}

// When the user clicks on the button, open the modal 
function callModal(event){
	$.ajax({
		url : 'storeWaitInfo.re',
		type : 'POST',
		data : {'s_num' : event},
		contentType : 'application/x-www-form-urlencoded;charset=utf-8',
		dataType : 'json',
		success : function(retVal) {
			if (retVal.res == "OK") {
				var s_num = retVal.s_num;
				var u_id = retVal.u_id;
				var thumbnail = retVal.thumbnail;
				var s_name = retVal.s_name;
				var s_addr = retVal.s_addr;
				var s_phone = retVal.s_phone;
				var s_img = retVal.s_img;
				var s_hour = retVal.s_hour;
				$('input#s_num').val(s_num);
				$('input#u_id').val(u_id);
				$('input#thumbnail').val(thumbnail);
				$('input#s_name').val(s_name);
				$('input#s_addr').val(s_addr);
				$('input#s_phone').val(s_phone);
				$('input#s_img').val(s_img);
				$('input#s_hour').val(s_hour);
				
				var dataURI1 = 'resources/img/store/'+retVal.thumbnail;		            
				var imgTag1 = "<img id='thumbnail_IMG' style='width: 550px; height:350px;' src='"+dataURI1+"'/>";
	            $("#thumbnail_IMG").append(imgTag1);
	            var dataURI2 = 'resources/img/store/'+retVal.s_img;	            
				var imgTag2 = "<img id='s_img_IMG' style='width: 550px; height:350px;' src='"+dataURI2+"'/>";
	            $("#s_img_IMG").append(imgTag2);
			} else {
				alert("confirm Fail!!!!");
			}
		}
	});
	
    modal.style.display = "block";
}

$('#confirmBtn').on('click', function(evt) {
    $.ajax({
       url: 'confirmStore.re',
       type : 'POST',
       data : {'s_num' : $('input#s_num').val()},
       contentType : 'application/x-www-form-urlencoded;charset=utf-8',
       dataType : 'json',
       success : function(retVal) {
          // webSocket에 보내기 (confirm, 댓글작성자(admin), 게시글작성자(u_id), 글번호(s_num))
          if (retVal.res == "confirm") {
             let socketMsg = ("confirm," + "admin," + u_id + "," + s_num);
             console.debug("ssssssmsg>> ", socketMsg);
             socket.send(socketMsg); 
             modal.style.display = "none";
             alert("승인하였습니다.")
             storeWaitList();
          } else {
             alert("confirm Fail!!!!");
          }
       }, 
       error:function() {
          alert("confirm ajax 통신 실패!!")
       }
    });
});
 
$('#refuseBtn').on('click', function(evt) {
    $.ajax({
       url: 'refuseStore.re',
       type : 'POST',
       data : {'s_num' : $('input#s_num').val()},
       contentType : 'application/x-www-form-urlencoded;charset=utf-8',
       dataType : 'json',
       success : function(retVal) {
          // webSocket에 보내기 (refuse, 댓글작성자(admin), 게시글작성자(u_id), 글번호(s_num))
          if (retVal.res == "refuse") {
             let socketMsg = ("refuse," + "admin," + u_id + "," + s_num);
             console.debug("ssssssmsg>> ", socketMsg);
             socket.send(socketMsg); 
             modal.style.display = "none";
             alert("거절하였습니다.");
             storeWaitList();
          } else {
             alert("refuse Fail!!!!");
          }
       }, 
       error:function() {
          alert("confirm ajax 통신 실패!!")
       }
    });
});


// When the user clicks on <span> (x), close the modal
span.onclick = function(event) {
    modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>

<%@include file="../includes/footer.jsp"%>