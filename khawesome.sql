insert into member values(
				MEMBER_SEQ.nextval, 
				'test', 
				'testpwd', 
				'용팔', 
				'1987/05/12',
                01089721172,
                'M',
                'abc',
                'asdq',
				'Y',
                'Y',
				'Y',
				'안녕하세요',
				'M',
				sysdate
				);
                commit;
rollback;                
select * from address;
select * from member;

SELECT SEQUENCE_NAME, MIN_VALUE, MAX_VALUE, INCREMENT_BY, CYCLE_FLAG 
FROM USER_SEQUENCES;

drop SEQUENCE MEMBER_SEQ;

CREATE SEQUENCE MEMBER_SEQ
  START WITH 1
  INCREMENT BY 1
  MAXVALUE 99999999999999
  MINVALUE 1
  NOCYCLE;


SELECT * FROM    ALL_CONSTRAINTS
WHERE    TABLE_NAME = 'member';

SELECT A.UNIQUENESS, B.*
FROM ALL_INDEXES A, ALL_IND_COLUMNS B
WHERE    A.INDEX_NAME = B.INDEX_NAME AND A.TABLE_NAME='member';

select *
from dba_constratins
where owner = :owner
and table_name =:tableName;

