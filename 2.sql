--select subjectid from Subject where SubjectName = 'C#���Ժ����ݿ⼼��'

--select MAX(ExamDate) from Result where SubjectId = (select subjectid from Subject where SubjectName = 'C#���Ժ����ݿ⼼��')

if(
not exists(
select *
from Result
where SubjectId = (select subjectid from Subject where SubjectName = 'C#���Ժ����ݿ⼼��')
  and 
ExamDate = (select MAX(ExamDate) from Result where SubjectId = (select subjectid from Subject where SubjectName = 'C#���Ժ����ݿ⼼��'))
 and StudentResult >= 60))
begin
	print 'ÿ�˼�����'
	update Result set StudentResult = StudentResult + 3 where SubjectId = (select SubjectId from Subject where SubjectName='C#���Ժ����ݿ⼼��') and ExamDate = (select MAX(ExamDate) from Result where SubjectId = (select subjectid from Subject where SubjectName = 'C#���Ժ����ݿ⼼��'))
end
else
begin
	print 'ÿ�˼�1��'
	update Result set StudentResult = StudentResult + 1 where SubjectId = (select SubjectId from Subject where SubjectName='C#���Ժ����ݿ⼼��') and ExamDate = (select MAX(ExamDate) from Result where SubjectId = (select subjectid from Subject where SubjectName = 'C#���Ժ����ݿ⼼��')) and StudentResult <= 99
end


select GradeId from Grade where GradeName = 's1'

if(
exists(
select * from Student where GradeId = (select GradeId from Grade where GradeName = 's1')
)
)
begin
 update Student set GradeId = (select GradeId from Grade where GradeName = 's2') where GradeId = (select GradeId from Grade where GradeName = 's1')
end


