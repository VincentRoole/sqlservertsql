----ע��

--���Ĳ�Σ����Ļ�

insert into TBL_User(username,password,email)values('wk','123456','x@i.com')

insert into TBL_User(username,password,email)values('mx','qaz123','y@i.com')

insert into TBL_User(username,password,email)values('gwh','234567','z@i.com')

----��½(wk��½)

select * from TBL_User where username = 'wk'

----��ʾwk�Ķ���Ϣ�б�

select * from TBL_MESSAGE where sento = 'wk'

---�鿴wk�����б��е�ĳһ����ϸ����Ϣ

declare @msgid int

select * from TBL_MESSAGE where msgid = @msgid

--���µ�ǰ�������Ϣ��״̬

update TBL_MESSAGE set state = 1 where msgid = @msgid

---ɾ��WK����Ϣ�б��е�ĳ������

delete from TBL_MESSAGE where msgid = @msgid

---wk���Ͷ��Ÿ�mx


---��ʾ�����б��

select username from TBL_User where username <> 'wk'

---������Ϣ���������

insert into TBL_MESSAGE(username,title,msgcontent,sento)values('wk','�������һ����¼��Ĳ��','���������͸�Ĳ�Σ��㿴������','mx')

insert into TBL_MESSAGE(username,title,msgcontent,sento)values('wk','������Զ�����¼��Ĳ��','���������͸�Ĳ�Σ��㿴������2��','mx')

insert into TBL_MESSAGE(username,title,msgcontent,sento)values('wk','�������������¼��Ĳ��','���������͸�Ĳ�Σ��㿴������3��','mx')

insert into TBL_MESSAGE(username,title,msgcontent,sento)values('gwh','���ĻԲ���һ����¼������','���������͸�����㿴������','wk')

insert into TBL_MESSAGE(username,title,msgcontent,sento)values('gwh','���Ļ��Զ�����¼������','���������͸�����㿴������2��','wk')

insert into TBL_MESSAGE(username,title,msgcontent,sento)values('gwh','���Ļ���������¼������','���������͸�����㿴������3��','wk')


----�ظ�

select * from TBL_MESSAGE where msgid = @msgid

declare @sento varchar(20)
declare @title varchar(200)

set @title = '�ظ���' + @title

insert into TBL_MESSAGE(username,title,msgcontent,sento)values('wk',@title,'�ظ�����Ϣ',@sento)


