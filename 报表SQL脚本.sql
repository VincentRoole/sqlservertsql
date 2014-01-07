select DATEPART(QQ,hh.HTIME) as ����,hd.DNAME as ����,hs.SNAME as �ֵ�,ht.HTNAME as ����,COUNT(*) as ��������
from hos_house hh
inner join hos_street hs on hs.SID = hh.SID
inner join hos_district hd on hd.DID = hs.SDID
inner join hos_type ht on ht.HTID = hh.HTID
group by DATEPART(QQ,hh.HTIME),hd.DNAME,hs.SNAME,ht.HTNAME

union

select DATEPART(QQ,hh.HTIME) as ����,hd.DNAME as ����,' С�� ','',COUNT(*)
from hos_house hh
inner join hos_street hs on hs.SID = hh.SID
inner join hos_district hd on hd.DID = hs.SDID
group by DATEPART(QQ,hh.HTIME),hd.DNAME

union

select DATEPART(QQ,hh.HTIME) as ����,' �ϼ�','','',COUNT(*)
from hos_house hh
group by DATEPART(QQ,hh.HTIME) 