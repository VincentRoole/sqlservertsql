select studentno,studentname,studentresult,examdate,�Ƿ�ȱ��=case
when studentresult IS null then '��'
else '��'
end,�Ƿ�ͨ������=case
when studentresult >= 60 then '��'
else '��'
end
from tempres tr 

declare @ydnum int
declare @hege int

select @hege = COUNT(*)
from tempres
where studentresult >= 60

select @ydnum = COUNT(*)
from tempres

select @ydnum as Ӧ������,@hege as ͨ������,(convert(varchar(20),(@hege / convert(float,@ydnum))*100)+'%') as �ϸ���

while(
exists
(
select * from tempres where studentresult < 60
))
update tempres set studentresult = studentresult + 2 where studentresult <= 98

select @hege = COUNT(*)
from tempres 
where studentresult >= 60

select @ydnum as Ӧ������,@hege as ͨ������,(convert(varchar(20),(@hege / convert(float,@ydnum))*100)+'%') as �ϸ���

