--update cardInfo set IsReportLoss = 1 where customerID = (select customerID from userInfo where customerName = '����')

select ci.cardID,ci.curID,dt.savingName,ci.openDate,ci.openMoney,ci.balance,ci.pass,�Ƿ��ʧ=case
when IsReportLoss = 0 then 'δ��ʧ'
else '��ʧ'
end,ui.customerName
from cardInfo ci
inner join Deposit dt on dt.savingID = ci.savingID
inner join userInfo ui on ui.customerID = ci.customerID 


---------------
declare @cunru numeric(10,2)
declare @quchu numeric(10,2)
declare @zjltye numeric(10,2)   ----�ʽ���ͨ���
declare @yyjs numeric(10,2)     ----ӯ�����
declare @ckll numeric(10,3)     ----�������
declare @dkll numeric(10,3)     ----��������

set @ckll = 0.003
set @dkll = 0.008

select @cunru = SUM(tradeMoney)
from tradeInfo
where tradeType = '����'

select @quchu = SUM(tradeMoney)
from tradeInfo
where tradeType = '֧ȡ'


set @zjltye = @cunru - @quchu

set @yyjs = @quchu * @dkll - @cunru * @ckll

print '������ͨ���' + convert(varchar(20),@zjltye) + 'RMB'

print 'ӯ������' + convert(varchar(20),@yyjs) + 'RMB'


--------------------------------

select *
from cardInfo
where DATEPART(WW,openDate) = DATEPART(ww,GETDATE())

------------------------
select *
from userInfo ui 
inner join cardInfo ci on ci.customerID = ui.customerID 
where ci.cardID = (
select top 1 cardID
from tradeInfo
group by cardID
order by SUM(tradeMoney) desc)

---------------------------
select *
from userInfo
where customerID in (
select customerID
from cardInfo
where balance < 200)


----------------

create proc bankdb_login
@cname varchar(20),
@cpass varchar(20)
as

if(EXISTS(select *
from cardInfo
where customerID = (
select customerID
from userInfo
where customerName = @cname) and pass = @cpass))
begin
select *
from cardInfo
where customerID = (
select customerID
from userInfo
where customerName = @cname) and pass = @cpass
end
else
begin
raiserror('�Բ�������û��������벻����',16,1)
end

exec bankdb_login 'liss','sdfsdf'


create view vi_userinfo
as
select customerID as �ͻ����,customerName as ������,PID as ���֤,telephone as ��ϵ�绰,address as ��ס��ַ
from userInfo

select * from vi_userinfo


-----------------------------------------
alter proc usp_takemoney
@cname varchar(20),
@cpass varchar(20) = null,
@jymoney numeric(15,2),
@jytype int -------0,�棻1��ȡ
as
----��ȡ������Ӧ�Ŀ���
declare @cardid varchar(50)
declare @cipass varchar(20)
declare @errors int -----------�����־����
declare @blances numeric(15,2) ----�����
declare @cardstate bit  
set @errors = 0

select @cardid=ci.cardID,@cipass=ci.pass,@blances = ci.balance,@cardstate = ci.IsReportLoss
from cardInfo ci
inner join userInfo ui on ui.customerID = ci.customerID
where ui.customerName = @cname 

if(@jytype = 0)
begin
--������֤����,���ڼ���ʱ��������
begin transaction
update cardInfo set balance = balance + @jymoney where cardID = @cardid
set @errors = @errors + @@ERROR
insert into tradeInfo(tradeType,cardID,tradeMoney,remark)values('����',@cardid,@jymoney,'sdfsd')
set @errors = @errors + @@ERROR
if(@errors <> 0)
rollback transaction
else
commit transaction
end
else
begin
if(@cpass = @cipass)
begin
if(@cardstate = 1)
begin
raiserror('���˺��Ѿ�����',16,1)
return
end
if(@jymoney < @blances + 1)
begin
begin transaction
update cardInfo set balance = balance - @jymoney where cardID = @cardid
set @errors = @errors + @@ERROR
insert into tradeInfo(tradeType,cardID,tradeMoney,remark)values('֧ȡ',@cardid,@jymoney,'sd')
set @errors = @errors + @@ERROR
if(@errors <> 0)
rollback transaction
else
commit transaction
end
else
begin
raiserror('�Բ�������',16,1)
print '���ţ�' + @cardid + '   ��' + convert(varchar(20),@blances)
end
end
else
begin
raiserror('�Բ����������',16,1)
end
end

exec usp_takemoney '����','888888',200,1

select * from cardInfo

select * from tradeInfo


select * from userInfo



