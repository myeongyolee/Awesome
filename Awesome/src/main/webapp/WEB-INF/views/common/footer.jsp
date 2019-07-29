<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
		</div>
	  </main>
<!-- 모임에 가입할 것인지 물어보는 모달 -->		
<div class="modal fade" id="enrollClub" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
                 해당 기능을 이용하기 위해서는 가입되어야 합니다. 가입 신청을 하시겠습니까?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취 소</button>
        <button type="button" class="btn btn-primary" onclick="enrollClub();">가입 신청</button>
      </div>
    </div>
  </div>
</div>

<!-- 모임 일정 등록 시, 지도검색모달 -->	
<div class="modal fade" id="searchMap" tabindex="-1" role="dialog" aria-labelledby="searchMap" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="searchMapTitle">지도 검색</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body" id="searchMapBody">
				<div id="search-container" class="mb-2">
					<input type="text" name="position" class="col-md-9" placeholder="검색하려는 장소를 입력하세요"/>
					<input type="button" value="검색" onclick="findPosition();" />
				</div>
				<div id="map" class="mb-2"></div>
				<div id="mapInfo" class="mapInfo"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary">완료</button>
			</div>
		</div>
	</div>
</div>	

</div>
</body>
</html>