declare @yingkao int ----Ӧ�μ�����
declare @hege int ----�ϸ�����
declare @subname varchar(20) ---�γ�����

set @subname = '�߽�JAVA�������'

select @yingkao = COUNT(*)
from Student
where GradeId = (select GradeId from Subject where SubjectName = @subname)

select @hege = COUNT(*)
from Result
where ExamDate = 
(
select MAX(ExamDate)
from Result
where SubjectId = (select SubjectId from Subject where SubjectName = @subname)
)
and StudentResult >=60 
and SubjectId = (select SubjectId from Subject where SubjectName = @subname)

print '�ϸ���Ϊ��' + convert(varchar(20),@hege / convert(float,@yingkao)*100)+'%' 

