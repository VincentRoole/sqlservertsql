--insert into Customer(cname,cpwd,yuer)values('����','123456',1000)
--declare @cid int
--select @cid = cid from Customer where cname = '����'
--insert into TradeLog(tradeinfo,trademoney,cid)values('���',1000,@cid)

--insert into Customer(cname,cpwd,yuer)values('��֣','qaz123',100)
--select @cid = cid from Customer where cname = '��֣'
--insert into TradeLog(tradeinfo,trademoney,cid)values('���',100,@cid)

----delete Customer

--delete TradeLog where tid > 4


declare @cid int
declare @errors int -----�������ۼ�
declare @nexti int

set @errors = 0
set @nexti = 0

--��������

begin transaction

while(@nexti < 5)
begin

update  Customer set yuer = yuer - 100 where cname = '����'

set @errors = @errors + @@ERROR

select @cid = cid from Customer where cname = '����'

insert into TradeLog(tradeinfo,trademoney,cid)values('ȡ��',100,@cid)

set @errors = @errors + @@ERROR

update Customer set yuer = yuer + 100 where cname = '��֣'

set @errors = @errors + @@ERROR

select @cid = cid from Customer where cname = '��֣'

insert into TradeLog(tradeinfo,trademoney,cid)values('���',100,@cid)

set @errors = @errors + @@ERROR

set @nexti = @nexti + 1

end

if(@errors != 0)
begin
	print 'ת��ʧ�ܣ�'
	rollback transaction
end
else
begin
	print 'ת�˳ɹ���'
	commit transaction
end