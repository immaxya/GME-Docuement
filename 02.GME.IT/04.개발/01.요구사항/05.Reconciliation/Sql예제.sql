select TOP(10) ref_num, * from VW_PostedAccountDetail order by tran_date desc


select TOP(10) ref_num, field1, * from tran_master 
where acc_num='100241011536'
order by tran_date desc

select TOP(100) ref_num, field1, * from tran_master 
where acc_num='100241011536'
order by tran_date desc


select TOP(10) ref_num, acc_num, field1, * from tran_master 
--where acc_num='100241011536'
where tran_date > '2023-05-07'
and tran_date < '2023-05-09'
and acc_num = '9424012189639'
order by tran_date desc

--1. �������� ������� �Ա�
select TOP(10) ref_num, acc_num, field1, * from tran_master 
where ref_num='2834993'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='2834993'


--2. ������¸� �̿��� �����۱�(Primary A/C)
select TOP(10) ref_num, acc_num, field1,tran_amt, * from tran_master 
where ref_num='1259418'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='1259418'

--2. ������¸� �̿��� �����۱�(Not Primary A/C)
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='1259527'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='1259527'

--3. �������� ���¸� �̿��� �޷��� ����
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='31894'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='31894'

--4. ���¹�ŷ�� �̿��� �ؿܼ۱�(�Ա�)
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10923756'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10923756'

--5. ���¹�ŷ�� �̿��� �ؿܼ۱�(���)
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='6355072'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='6355072'

--6. ������¸� �̿��� �ؿܼ۱�(���)
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='6251491'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='6251491'

--��. ���¹�ŷ�� �̿��� �����۱ݣ��Աݣ�
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10928870'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10928870'

--8. ���¹�ŷ�� �̿��� �����۱ݣ���ݣ�
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10928871'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10928871'

--9. KJ�� �̿��� �����۱ݣ���ݣ�
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10930432'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10930432'

--10. ���¹�ŷ�� �̿��� Local-Topup(�Ա�)
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10928747'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10928747'

--11. ���¹�ŷ�� �̿��� Local-Topup
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10928748'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10928748'

--11. ������¸� �̿��� Local-Topup
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10919950'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10919950'

--12. ���¹�ŷ�� �̿��� International-Topup(�Ա�)
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10928848'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10928848'

--13. ���¹�ŷ�� �̿��� International-Topup
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10928850'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10928850'

--14. ������¸� �̿��� International-Topup
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10928967'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10928967'

--15. ���¹�ŷ�� �̿��� GME Pay ����(�Ա�)
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10928751'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10928751'

--16. ������¸� �̿��� GME Pay ����(�Ա�)
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10928734'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10928734'

--17. ���¹�ŷ�� �̿��� Sim-card ����
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num=''

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num=''

--10. ���¹�ŷ�� �̿��� 
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num=''

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num=''

