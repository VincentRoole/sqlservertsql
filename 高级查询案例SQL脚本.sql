if
(
exists(select *
from student where gradeid = (select gradeid from Grade where GradeName = 's1'))
)
begin
--����Щѧ�����뵽�±�
select *
INTO student3
from Student
where GradeId = (select GradeId from Grade where GradeName = 'S1')
--ͬʱ�������꼶
update student3 set gradeid = (select gradeid from Grade where GradeName = 'S2')
end

