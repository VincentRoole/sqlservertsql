alter proc proc_roomtype_del
@roomtypename varchar(20),
@res int output
as
--�жϴ˷��������Ƿ�����ס��Ϣ

if(exists(
select * 
from Room r
inner join RoomType rt on r.RoomTypeID = rt.TypeID 
where rt.TypeName = @roomtypename))
begin
set @res = -1
end
else
begin
delete from RoomType where TypeName = @roomtypename
set @res = @@ROWCOUNT
end


declare @res2 int
exec proc_roomtype_del '��׼��',@res2 output

if(@res2 = -1)
print 'ɾ��ʧ��'
else
print 'ɾ���ɹ�'+ convert(varchar(20),@res2)








