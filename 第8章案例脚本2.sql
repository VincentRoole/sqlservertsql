create proc proc_guestnum
@roomtypename varchar(20),
@guestnum int output

as

select @guestnum = SUM(r.GuestNum)
from Room r
inner join RoomType rt on r.RoomTypeID = rt.TypeID
where rt.TypeName = @roomtypename

--print @roomtypename + '������:' + convert(varchar(20),@guestnum)

declare @num int
exec proc_guestnum '��׼��',@num output

print @num
