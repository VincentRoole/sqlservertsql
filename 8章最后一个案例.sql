alter proc proc_hotel_addguest
@upid varchar(20)=null,----���֤
@uname varchar(20),----�Ǽ����֤����
@rtypename varchar(20),----��������
@rznum int=1,----��ס����
@yjmoney numeric(15,2)=1000.00 -----Ѻ��
as
declare @roomprice numeric(15,2)
declare @roomid int
declare @errors int 
----�ж����֤�Ƿ�Ϊ��
if(@upid is null)
begin
raiserror('�Բ��𣬱��������֤',16,1)
return
end
----�ж����֤�Ƿ���18λ
if(LEN(@upid) <> 18)
begin
raiserror('�Բ������֤��������',16,1)
return
end
----�ж�Ѻ���Ƿ����0
if(@yjmoney <= 0)
begin
raiserror('�Բ��𣬱�����Ѻ��',16,1)
return
end
---�ж�Ѻ���Ƿ������ס����۸��2��
---1.ͨ���������ͻ�ø÷���ļ۸�
select @roomprice=TypePrice
from RoomType
where TypeName = @rtypename
---2.�ж�Ѻ���Ƿ���ڷ���2��
if(@yjmoney < (@roomprice * 2))
begin
raiserror('�Բ���Ѻ����Ҫ������Ҫ���ѵ�2��',16,1)
return
end
--------���¿�ʼ������---------
--1.ͨ���û�����ķ������ͣ����һ�����з����

print 'fffffffffffffff'

select @roomid = r.RoomID
from Room r
inner join RoomType rt on rt.TypeID = r.RoomTypeID
where rt.TypeName = @rtypename and r.RoomStateID = 2

print @roomid

print 'dsfsddddddd'


--2.������
begin transaction
---����room���е������ֶΣ���ס�����ͷ���״̬
update Room set GuestNum = @rznum,RoomStateID = 1 where RoomID = @roomid
set @errors = @errors + @@ERROR
--���û�д˷��䣬����������Ϊ0������Ϊ����
if(@@ROWCOUNT <= 0)
begin
set @errors = 1
end
---����һ����¼���ͻ���¼���У�guestrecord��
insert into GuestRecord(IdentityID,GuestName,RoomID,ResideID,ResideDate,Deposit)values(@upid,@uname,@roomid,1,GETDATE(),@yjmoney)
set @errors = @errors + @@ERROR
if(@errors <> 0)
begin
raiserror('ʧ����',16,1)
rollback transaction
end
else
begin
print '�ɹ���ס,��ס�ķ�����ǣ�' + convert(varchar(20),@roomid)
commit transaction
end


--exec proc_hotel_addguest '234243423423431231','��֣','��׼��',2,2000