---ע��Ĵ洢����proc_sms_register

create proc proc_sms_register
@username varchar(50),
@password varchar(50),
@email varchar(100)
as
insert into TBL_User(username,password,email)values(@username,@password,@email)

--��½�Ĵ洢����proc_sms_findByUserName

create proc proc_sms_findByUserName
@username varchar(50),
@password varchar(50) = '' output
as

select @password = password from TBL_User where username = @username

--declare @pwd varchar(20)

--exec proc_sms_findByUserName 'wkx',@pwd output

--print @pwd

-----�鿴��ǰ�û��Ķ���Ϣ�б� proc_sms_findSmsListByUserName

create proc proc_sms_findSmsListBySento
@sento varchar(50)
as
select * from TBL_MESSAGE where sento = @sento

exec proc_sms_findSmsListBySento 'wk'

----�鿴ĳ������Ϣproc_sms_findByMsgid
create proc proc_sms_findByMsgidOrDel
@msgid int,
@oper int = 0
as
if(@oper=0)
begin
select * from TBL_MESSAGE where msgid = @msgid
update TBL_MESSAGE set state = 1 where msgid = @msgid
end
else
begin
delete from TBL_MESSAGE where msgid = @msgid
end

--exec proc_sms_findByMsgidOrDel 2,1

--������Ϣproc_sms_sendsms

create proc proc_sms_sendsms
@username varchar(50),
@title varchar(200),
@msgcontent text,
@sento varchar(50)
as
insert into TBL_MESSAGE(username,title,msgcontent,sento)values(@username,@title,@msgcontent,@sento)

--exec proc_sms_sendsms 'wk','����һ����Ϣ��Ĳ��','�������Ϣ��Ĳ��','mx'

--�ظ�proc_sms_msgreply

create proc proc_sms_msgreply
@msgid int,
@msgcontent text
as
declare @username varchar(50)
declare @sento varchar(50)
declare @title varchar(200)
declare @replytitle varchar(200)

select @username=sento,@sento=username,@title=title from TBL_MESSAGE where msgid = @msgid

set @replytitle = '�ظ���' + @title

insert into TBL_MESSAGE(username,title,msgcontent,sento)values(@username,@replytitle,@msgcontent,@sento)


--exec proc_sms_msgreply 1,'�����ô洢���̻ظ���һ������Ϣ'

select * from TBL_MESSAGE