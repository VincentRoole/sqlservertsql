--select substring(convert(varchar(20),CONVERT(numeric(15,8),RAND(DATEPART(ms,getdate())*1000))),3,8)



declare @rand numeric(15,8)
declare @randStr varchar(20)
declare @dateStr varchar(30)
declare @jycode varchar(30)
declare @errors int

set @errors = 0

----ͨ��RAND()�������������0=1
set @rand = convert(numeric(15,8),RAND(DATEPART(ms,getdate())))

----��numeric����ת��Ϊ�ַ�������
set @randStr = convert(varchar(20),@rand)

----��ȡ8λС��
set @randStr = substring(@randStr,3,8)

----����ǰʱ��ת��Ϊ�ַ������ͣ�ע����ʽΪ20��
set @dateStr = convert(varchar(30),getdate(),20)

----��ȡʱ���е��꣬�£��գ�Сʱ���֣���
set @dateStr = SUBSTRING(@dateStr,1,4) + SUBSTRING(@dateStr,6,2) + SUBSTRING(@dateStr,9,2) + SUBSTRING(@dateStr,12,2) + SUBSTRING(@dateStr,15,2) + SUBSTRING(@dateStr,18,2)

----��ʱ�䴮�����������һ���ַ���
set @jycode = @dateStr + @randStr


-------------------------��ʼ������

begin transaction

---A�˻�-98Ԫ��B�˻�+98Ԫ

update CardInfo set cardyu = cardyu - 98 where cardid = '1234 4567 9876 2345'
set @errors = @errors + @@ERROR
update CardInfo set cardyu = cardyu + 98 where cardid = '9876 4567 1234 6543'
set @errors = @errors + @@ERROR

----���뽻����ˮ��A����֧ȡ��B�������

insert into YJLog(jycode,cardid,jytcode,jymoney)values(@jycode,'1234 4567 9876 2345',2,98)
set @errors = @errors + @@ERROR

----ͨ��RAND()�������������0=1
set @rand = convert(numeric(15,8),RAND(DATEPART(mm,getdate())))

----��numeric����ת��Ϊ�ַ�������
set @randStr = convert(varchar(20),@rand)

----��ȡ8λС��
set @randStr = substring(@randStr,3,8)

----����ǰʱ��ת��Ϊ�ַ������ͣ�ע����ʽΪ20��
set @dateStr = convert(varchar(30),getdate(),20)

----��ȡʱ���е��꣬�£��գ�Сʱ���֣���
set @dateStr = SUBSTRING(@dateStr,1,4) + SUBSTRING(@dateStr,6,2) + SUBSTRING(@dateStr,9,2) + SUBSTRING(@dateStr,12,2) + SUBSTRING(@dateStr,15,2) + SUBSTRING(@dateStr,18,2)

----��ʱ�䴮�����������һ���ַ���
set @jycode = @dateStr + @randStr


insert into YJLog(jycode,cardid,jytcode,jymoney)values(@jycode,'9876 4567 1234 6543',1,98)
set @errors = @errors + @@ERROR

if(@errors <> 0)
rollback transaction
else
commit transaction

