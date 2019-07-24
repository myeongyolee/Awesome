--외래키는 기본적으로 제외 시켜 두겠습니다.

--멤버테이블
create table member(
    member_code number primary key,
    member_id varchar2(100) not null,
    nickname varchar2(100) not null,
    password varchar2(500) not null,
    member_name varchar2(50) not null,
    birthday date not null,
    phone varchar2(30) not null,
    gender char(1) check(gender in ('M','F')),
    profile varchar2(1000) not null,
    renamed_profile varchar2(1000) not null,
    blind_date_open char(1) default 'Y' check(blind_date_open in ('Y','N')),
    friend_open char(1) default 'Y' check(friend_open in ('Y','N')),
    search_open char(1) default 'Y' check(search_open in ('Y','N')),
    introduce varchar2(4000),
    verify char(1) default 'M' check(verify in ('A', 'M')),
    enroll_date date default sysdate,
    constraint unique_member_id unique(member_id),
    constraint unique_nickname unique(nickname)
);
drop table member;

select * from member;
delete from member where member_name='김용빈';
commit;

comment on table member is '회원테이블';
comment on column member.member_code is '회원코드';
comment on column member.member_id is '아이디';
comment on column member.password is '비밀번호';
comment on column member.member_name is '이름';
comment on column member.member_no is '주민번호';
comment on column member.phone is '전화번호';
comment on column member.gender is '성별';
comment on column member.profile is '프로필사진';
comment on column member.renamed_profile is 'DB프로필사진이름';
comment on column member.blind_date_open is '소개팅공개여부';
comment on column member.friend_open is '친구공개여부';
comment on column member.search_open is '검색공개여무';
comment on column member.introduce is '자기소개';
comment on column member.verify is '회원분류';
comment on column member.enroll_date is '가입일';

--주소테이블
create table address(
    member_code number,
    post_no varchar2(30) not null,
    address varchar2(100) not null,
    road_address varchar2(100) not null,
    detail_address varchar2(100) not null,
    place_lat number not null,
    place_lng number not null
);

drop table address;

comment on table address is '주소테이블';
comment on column address.member_code is '회원코드';
comment on column address.post_no is '우편번호';
comment on column address.address is '지번주소';
comment on column address.road_address is '도로명주소';
comment on column address.detail_address is '상세주소';
comment on column address.place_lat is '위도';
comment on column address.place_lng is '경도';

--출신학교테이블
create table school(
    member_code number,
    school_code varchar2(50) not null,
    school_name varchar2(50) not null,
    school_address varchar2(500) not null
);

comment on table school is '출신학교테이블';
comment on column school.member_code is '회원코드';
comment on column school.school_code is '학교코드';
comment on column school.school_name is '학교이름';
comment on column school.school_address is '학교주소';

--친구목록테이블
create table friend(
    member_code number,
    friend_member_code number,
    friend_check char(1) default 'N' check(friend_check in ('Y','N'))
);

comment on table friend is '친구목록테이블';
comment on column friend.member_code is '회원코드';
comment on column friend.friend_member_code is '신청받은회원';
comment on column friend.friend_check is '수락여부';

--소개팅호감기록테이블
create table blind_date_like(
    member_code number,
    receive_member_code number,
    like_check char(1) default 'N' check(like_check in ('Y','N'))
);

comment on table blind_date_like is '소개팅호감기록테이블';
comment on column blind_date_like.member_code is '회원코드';
comment on column blind_date_like.receive_member_code is '대상회원';
comment on column blind_date_like.like_check is '호감여부';

--회원정보확인여부
create table info_check(
    member_code number,
    checking_member_code number,
    check_date date default sysdate
);

comment on table info_check is '회원정보확인여부테이블';
comment on column info_check.member_code is '회원코드';
comment on column info_check.checking_member_code is '대상회원';
comment on column info_check.check_date is '확인날짜';

--채팅로그
create table chat_log(
    member_code number,
    receive_member_code number,
    chat_content varchar2(1000) not null,
    log_date date default sysdate
);

comment on table chat_log is '채팅로그테이블';
comment on column chat_log.member_code is '회원코드';
comment on column chat_log.receive_member_code is '받는회원코드';
comment on column chat_log.chat_content is '채팅내용';
comment on column chat_log.log_date is '채팅일자';

--알람로그
create table alarm_log(
    member_code number,
    receive_member_code number,
    alarm_type varchar2(50) not null,
    alarm_content varchar2(1000) not null,
    log_date date default sysdate
);

comment on table alarm_log is '알람로그테이블';
comment on column alarm_log.member_code is '회원코드';
comment on column alarm_log.receive_member_code is '받는회원코드';
comment on column alarm_log.alarm_type is '알람타입';
comment on column alarm_log.alarm_content is '알람내용';
comment on column alarm_log.log_date is '알람일자';

--관심분야목록테이블
create table interesting(
    interesting_code number primary key,
    interesting_name varchar2(100)
);

comment on table interesting is '관심분야목록테이블';
comment on column interesting.interesting_code is '관심분야코드';
comment on column interesting.interesting_name is '관심분야이름';

--회원관심분야테이블
create table member_interesting(
    member_code number,
    interesting_code number
);

comment on table member_interesting is '회원관심분야테이블';
comment on column member_interesting.member_code is '회원코드';
comment on column member_interesting.interesting_code is '관심분야코드';

--도시테이블
create table city(
    city_code number primary key,
    city_name varchar2(50) not null
);

comment on table city is '도시테이블';
comment on column city.city_code is '도시코드';
comment on column city.city_name is '도시이름';

--지역구테이블
create table local(
    local_code number primary key,
    city_code number,
    local_name varchar2(50)
);

comment on table local is '지역구테이블';
comment on column local.local_code is '지역코드';
comment on column local.city_code is '도시코드';
comment on column local.local_name is '지역이름';

--클럽테이블
create table club(
    club_code number primary key,
    interesting_code number,
    member_code number,
    local_code number,
    club_name varchar2(200) not null,
    club_simple_info varchar2(150) not null,
    club_info varchar2(4000) not null,
    main_original_filename varchar2(100),
    main_renamed_filename varchar2(100)
);

comment on table club is '클럽테이블';
comment on column club.club_code is '클럽코드';
comment on column club.interesting_code is '관심분야코드';
comment on column club.member_code is '회원코드';
comment on column club.local_code is '지역코드';
comment on column club.club_name is '클럽이름';
comment on column club.club_simple_info is '클럽간단소개';
comment on column club.club_info is '클럽소개';
comment on column club.main_original_filename is '클럽메인사진이름';
comment on column club.main_renamed_filename is '클럽메인사진db용이름';



--클럽회원테이블
create table club_member(
    club_code number,
    club_member_code number,
    club_mem_grade number,
    club_join_check char(1) default 'N' check(club_join_check in ('Y','N'))
);

comment on table club_member is '클럽회원테이블';
comment on column club_member.club_code is '클럽코드';
comment on column club_member.club_member_code is '회원코드';
comment on column club_member.club_join_check is '참여허가';
comment on column club_member.club_mem_grade is '회원등급';

CREATE SEQUENCE seq_club
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

--club_photo 테이블 생성
create table club_photo(
    club_content_code number primary key,
    club_original_filename varchar2(100) not null,
    club_renamed_filename varchar2(100) not null,
    pic_info varchar2(100)
)

comment on table club_photo is '클럽게시물사진';
comment on column club_photo.club_content_code is '클럽게시글코드';
comment on column club_photo.club_original_filename is '사진원본이름';
comment on column club_photo.club_renamed_filename is 'db용사진이름';
comment on column club_info.pic_info is '사진설명';



--클럽게시글테이블 수정
create table club_content(
    club_content_code number primary key,
    club_code number,
    member_code number,
    content_title varchar2(200),
    content varchar2(4000),
    write_level number default 1 check(write_level in ('0','1','2')),
    wrtie_date date default sysdate
);

comment on table club_content is '클럽게시글테이블';
comment on column club_content.club_content_code is '게시글코드';
comment on column club_content.club_code is '클럽코드';
comment on column club_content.member_code is '회원코드';
comment on column club_content.content_title is '게시글제목';
comment on column club_content.content is '내용';
comment on column club_content.write_level is '글레벨';
comment on column club_content.wrtie_date is '작성일자';



--게시글참여테이블
create table club_content_join_member(
    club_content_code number,
    member_code number
);

comment on table club_content_join_member is '게시글참여테이블';
comment on column club_content_join_member.club_content_code is '게시글코드';
comment on column club_content_join_member.member_code is '회원코드';


--매칭관리테이블
create table match_manager(
    match_no number primary key,
    match_title varchar2(1000) not null,
    member_code number,
    interesting_code number,
    local_code number,
    place_id varchar2(50),
    place_name varchar2(100),
    place_lat number,
    place_lng number,
    matching_type char(1) not null check(matching_type in('L','C')),
    match_content long not null,
    match_original_img varchar2(100),
    match_renamed_img varchar2(100),
    match_write_date date default sysdate,
    match_end_date date not null
);

comment on table match_manager is '매칭관리테이블';
comment on column match_manager.match_no is '매칭번호';
comment on column match_manager.match_title is '매칭제목';
comment on column match_manager.member_code is '회원코드';
comment on column match_manager.interesting_code is '관심코드';
comment on column match_manager.local_code is '지역코드';
comment on column match_manager.place_id is '장소아이디';
comment on column match_manager.place_name is '장소이름';
comment on column match_manager.place_lat is '위도';
comment on column match_manager.place_lng is '경도';
comment on column match_manager.matching_type is '매칭분류';
comment on column match_manager.match_content is '매칭내용';
comment on column match_manager.match_original_img is '이미지파일명';
comment on column match_manager.match_renamed_img is 'DB이미지파일명';
comment on column match_manager.match_write_date is '작성일';
comment on column match_manager.match_end_date is '매칭종료시각';

--매칭참여회원
create table matching_join_member(
    match_no number,
    member_code number,
    join_check char(1) default 'Y' check(join_check in ('Y','N')),
    permit_check char(1) default 'N' check(permit_check in ('Y','N'))
);

comment on table matching_join_member is '매칭참여회원테이블';
comment on column matching_join_member.match_no is '매칭번호';
comment on column matching_join_member.member_code is '회원코드';
comment on column matching_join_member.join_check is '참가여부';
comment on column matching_join_member.permit_check is '참여허가';

--신고테이블
create table report(
    member_code number,
    report_type varchar2(100) not null,
    reported_code number not null,
    reported_type varchar2(50) not null
);

comment on table report is '신고테이블';
comment on column report.member_code is '회원코드';
comment on column report.report_type is '신고타입';
comment on column report.reported_code is '신고대상코드';
comment on column report.reported_type is '신고대상분류';

--문의게시판
create table question_board(
    question_no number primary key,
    member_code number,
    question_title varchar2(200) not null,
    question_content long not null,
    question_original_filename varchar2(100),
    question_renamed_filename varchar2(100),
    question_date date default sysdate,
    question_open char(1) default 'Y' check (question_open in ('Y','N'))
);

comment on table question_board is '문의게시판테이블';
comment on column question_board.question_no is '문의번호';
comment on column question_board.member_code is '회원코드';
comment on column question_board.question_title is '문의제목';
comment on column question_board.question_content is '문의내용';
comment on column question_board.question_original_filename is '첨부파일명';
comment on column question_board.question_renamed_filename is 'DB첨부파일명';
comment on column question_board.question_date is '문의날짜';
comment on column question_board.question_open is '공개여부';

--문의답변
create table question_comment(
    question_comment_no number primary key,
    question_no number,
    question_comment_content long not null,
    question_comment_date date default sysdate
);

comment on table question_comment is '문의답변테이블';
comment on column question_comment.question_comment_no is '답변번호';
comment on column question_comment.question_no is '문의번호';
comment on column question_comment.question_comment_content is '답변내용';
comment on column question_comment.question_comment_date is '답변날짜';

--공지사항
create table notice(
    notice_no number primary key,
    notice_title varchar2(100) not null,
    notice_content long not null,
    notice_date date default sysdate
);

comment on table notice is '공지사항테이블';
comment on column notice.notice_no is '공지사항번호';
comment on column notice.notice_title is '공지사항제목';
comment on column notice.notice_content is '공지사항내용';
comment on column notice.notice_date is '작성날짜';

commit;

select * from smsauth;

create table smsauth(
    smsauth_no number primary key,
    smsauth_jsessionid varchar2(100) not null,
    smsauth_sms varchar2(4) not null
);

insert into smsauth values(5,'3B620F0F6EE330F3B5E020E4AD181B71','1234');
commit;

select * from member;
update member
comment on table smsauth is '문자인증테이블';
comment on column smsauth.smsauth_no is '문자번호';
comment on column smsauth.smsauth_jsessionid is '세션id';
comment on column smsauth.smsauth_sms is '문자인증번호';

CREATE SEQUENCE seq_smsauth
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

commit;

create table school(
    member_code number,
    school_code varchar2(50),
    school_name varchar2(50),
    school_address varchar2(500)
);

comment on table school is '학교테이블';
comment on column school.school_code is '학교코드';
comment on column school.school_name is '학교이름';
comment on column school.school_address is '학교주소';

CREATE SEQUENCE SEQ_CLUB_PHOTO
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;


create table userTable(
    sessionkey varchar(50) not null,
    member_id varchar(100) not null,
    sessionlimit timestamp,
    constraint pk_sessionkey primary key(sessionkey),
    constraint fk_userTable_member_id foreign key (member_id) references member(member_id)

);

comment on table userTable is '자동로그인테이블';
comment on column userTable.sessionkey is '세션키';
comment on column userTable.member_id is '회원 아이디';
comment on column userTable.sessionlimit is '세션제한시간';

        insert into userTable values(
        					'testSEssionID',
        					'yyongpall@gmail.com',
							SYSTIMESTAMP
							);

select * from member;

insert into smsauth values(23,'C85AE517EDE52452FC39D3797B0024AE',1111);
commit;

select * from member;
delete from member where member_code=211;
commit;

delete from member;
delete from address;

commit;

update address 
	  	 set post_No = '8813',
				 address = '서울특별시 관악구 신림동 1536-14',
				 road_Address = '서울특별시 관악구 호암로22길 55',
				 detail_Address = 'ㅂㅍㅈㄷㅂㅈㅍㄷㅂㄷㅍ',
				 place_Lat = 126.9358797,
				 place_Lng = 37.4687822 
		where member_code=211;
        
        select * from address;
        select * from member;
        delete from member where member_code=262;
        commit;
        insert into address values(241,'16875','경기도 용인시 수지구 죽전동 1165 새터마을죽전힐스테이트','경기도 용인시 수지구 현암로125번길 11','ㅂㅈㅍㄷㅂㅈㄷㅍㅂㅈㄷㅍ',127.1209373,37.3330944);
        commit;