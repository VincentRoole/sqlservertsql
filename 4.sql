--��2010-01-22�ղμ��߽�JAVA��������Ӧ�μ�ѧ���γɳɼ���
--ѧ�ţ�ѧ���������Կ�ĿID�����Գɼ�


--select stu.StudentNo,stu.StudentName,res.SubjectId,res.StudentResult
--into restemp
--from Student stu
--left join (select StudentNo,SubjectId,StudentResult
--from Result 
--where SubjectId = (select SubjectId from Subject where SubjectName = '�߽�JAVA�������')
--and 
--ExamDate = '2010-01-22') res on res.StudentNo = stu.StudentNo
--where GradeId = (select GradeId from Subject where SubjectName = '�߽�JAVA�������')


select * from restemp

declare @yingdao int
declare @shidao int
declare @jige int
declare @jglv numeric(5,2)

select @yingdao = COUNT(*)
from restemp

select @jige = COUNT(*)
from restemp
where studentresult >= 60

set @jglv = @jige / convert(numeric(5,2),@yingdao) * 100

print '���μ�����Ϊ��' + convert(varchar(20),@jglv) + '%'