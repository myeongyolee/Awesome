<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
	.dragcomponent{width: 280px; height:450px;border-radius:21px}
	#chat_head{height:43px; padding-top:10px; padding-left:10px; border-bottom: 1px solid #e1e1e1; width:100%}
	#chat_log{width:279px;  height: 358px; overflow-y: auto; padding: 10px 9px; border-bottom:1px solid #e1e1e1}
	#chat_com{text-align:center; padding-top: 11px;}
</style>
		</div>
	  </main>
	</div>

	<div id="draggable" class="ui-widget-content dragcomponent">
	  <div id="chat_head">
	  	&nbsp;&nbsp;&nbsp;ss님과의 채팅
	  </div>
	  <div id="chat_body">
	  	<div id="chat_log">
	  		div#
	  	</div>
	  	<div id="chat_com">
	  		<input type="text" name="message" id="msg" /> <button>전송</button>
	  	</div>
	  </div>

	</div>

</body>
</html>