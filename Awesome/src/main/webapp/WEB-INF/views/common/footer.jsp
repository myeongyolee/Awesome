<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
		</div>
	  </main>
	</div>
	
	<div id="draggable" class="ui-widget-content dragcomponent">
	  <div id="chat_head">
	  	&nbsp;&nbsp;&nbsp;ss님과의 채팅 
	  	<img id="removeChat" src="${pageContext.request.contextPath }/resources/images/close.png" alt="" />
	  </div>
	  <div id="chat_body">
	  	<div id="chat_log">
	  		<ul>
	  			<li class="other"><span>a</span></li> 
	  			<li class="My"><span>s</span></li>
	  		</ul>
	  	</div>
	  	<div id="chat_com">
	  		<input type="text" name="message" id="msg" /> <button value="asd" class="sendMsg">전송</button>
	  	</div>
	  </div>
	</div>
</body>
</html>