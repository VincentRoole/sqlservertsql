----Ӧ�μ��߽�JAVA��������ѧԱ����

select stu.StudentNo,StudentName,res.SubjectId,res.StudentResult,res.ExamDate 
into tempres
from Student stu
left join 
(
select *
from Result
where ExamDate = '2010-01-22' and SubjectId = (select SubjectId from Subject where SubjectName = '�߽�JAVA�������')
) res on res.StudentNo = stu.StudentNo
where GradeId = (select GradeId from Subject where SubjectName = '�߽�JAVA�������')


----��2010-01-22�μ��߽�JAVA��������ѧԱ�ɼ���

