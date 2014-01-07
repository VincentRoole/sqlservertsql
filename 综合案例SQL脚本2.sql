--create proc usp_openAccount
--@cname varchar(20),  -------�ͻ�����
--@cpid varchar(20),   -------�ͻ����֤����
--@ctel varchar(20),   -------�ͻ���ϵ�绰
--@openmoney numeric(8,2),----�ͻ��������
--@ctype varchar(20),     ----�������
--@caddress varchar(100)= null ---�ͻ���ϵ��ַ
--as
--declare @errors int  -------�����ύ��ع���־
--declare @cardid varchar(40) -----������ɿ���
--declare @savingid int  --------�������ID
--declare @customerID int -------�ͻ�ID

--set @errors = 0

--begin transaction
-----1.�����ͻ���Ϣ������userInfo��
--insert into userInfo(customerName,PID,telephone,address)values(@cname,@cpid,@ctel,@caddress)
--set @errors = @errors + @@ERROR
-----2.����������п���,����usp_cardid�洢����
--exec usp_cardid @cardid output
-----3.����������Ϣ������cardInfo��
-----3.1 ��ô������id,��savingID
--select @savingid = savingID from Deposit where savingName = @ctype
-----3.2 ����û�id,��customerID
--select @customerID = customerID from userInfo where PID = @cpid
-----3.3 �������п���Ϣ
--insert into cardInfo(cardID,curID,savingID,openMoney,balance,pass,IsReportLoss,customerID)values(@cardid,'RMB',@savingid,@openmoney,@openmoney,'888888',0,@customerID)
--set @errors = @errors + @@ERROR
-----4.���뽻����ˮ,����tradeInfo��
--insert into tradeInfo(tradeType,cardID,tradeMoney,remark)values('����',@cardid,@openmoney,'����')
--set @errors = @errors + @@ERROR
----5.��ʼ�����ж�
--if(@errors <> 0)
--begin
--raiserror('�Բ��𣬿���ʧ�ܣ�����ϵ�����У�',16,1)
--rollback transaction
--end
--else
--begin
--print '�����ɹ�������Ϊ��' + @cardid + '  ,��' + convert(varchar(20),@openmoney)
--commit transaction
--end


-----------------------------------------
create proc usp_CheckSheet
@cardid varchar(40),
@starttime varchar(20)=null,
@endtime varchar(20)=null
as
declare @cname varchar(20) ----�ͻ���
declare @curID varchar(10) ----��������
declare @savingname varchar(20) ---�������
declare @opendate datetime -----����ʱ��

----ͨ������ȡ���ͻ���Ϣ userInfo

select @cname = ui.customerName,@curID=ci.curID,@savingname=dep.savingName,@opendate = ci.openDate
from userInfo ui
inner join cardInfo ci on ci.customerID = ui.customerID
inner join Deposit dep on dep.savingID = ci.savingID
where ci.cardID = @cardid 

print '���ţ�' + @cardid
print '������' + @cname
print '�������ͣ�' + @curID
print '������ͣ�' + @savingname
print '�������ڣ�' + convert(varchar(10),datepart(yyyy,@opendate)) + '��' + convert(varchar(10),datepart(mm,@opendate)) + '��' + convert(varchar(10),datepart(dd,@opendate)) + '��' 

----ͨ������ȡ��������Ϣ tradeInfo

if(@starttime is null)
set @starttime = convert(varchar(5),DATEPART(YYYY,GETDATE())) + '-' + convert(varchar(5),DATEPART(mm,GETDATE())) + '-' + '01'
if(@endtime is null)
set @endtime = CONVERT(varchar(20),GETDATE(),20)

select * 
from tradeInfo
where cardID = @cardid and tradeDate >= @starttime and tradeDate <= @endtime

exec usp_checksheet '1010 3576 1212 1134'

------------------------------------

select *
from cardInfo
where cardID not in 
(
select cardID
from tradeInfo
where tradeDate >= '2013-03-01' and tradeDate <= '2013-03-16'
)


------------------------------

select COUNT(*)
from tradeInfo
where tradeType = '����'



