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

--1. 광주은행 가상계좌 입금
select TOP(10) ref_num, acc_num, field1, * from tran_master 
where ref_num='2834993'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='2834993'


--2. 가상계좌를 이용한 국내송금(Primary A/C)
select TOP(10) ref_num, acc_num, field1,tran_amt, * from tran_master 
where ref_num='1259418'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='1259418'

--2. 가상계좌를 이용한 국내송금(Not Primary A/C)
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='1259527'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='1259527'

--3. 광주은행 계좌를 이용한 달러를 구입
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='31894'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='31894'

--4. 오픈뱅킹을 이용한 해외송금(입금)
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10923756'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10923756'

--5. 오픈뱅킹을 이용한 해외송금(출금)
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='6355072'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='6355072'

--6. 가상계좌를 이용한 해외송금(출금)
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='6251491'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='6251491'

--７. 오픈뱅킹을 이용한 국내송금（입금）
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10928870'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10928870'

--8. 오픈뱅킹을 이용한 국내송금（출금）
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10928871'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10928871'

--9. KJ을 이용한 국내송금（출금）
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10930432'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10930432'

--10. 오픈뱅킹을 이용한 Local-Topup(입금)
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10928747'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10928747'

--11. 오픈뱅킹을 이용한 Local-Topup
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10928748'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10928748'

--11. 가상계좌를 이용한 Local-Topup
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10919950'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10919950'

--12. 오픈뱅킹을 이용한 International-Topup(입금)
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10928848'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10928848'

--13. 오픈뱅킹을 이용한 International-Topup
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10928850'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10928850'

--14. 가상계좌를 이용한 International-Topup
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10928967'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10928967'

--15. 오픈뱅킹을 이용한 GME Pay 충전(입금)
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10928751'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10928751'

--16. 가상계좌를 이용한 GME Pay 충전(입금)
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num='10928734'

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num='10928734'

--17. 오픈뱅킹을 이용한 Sim-card 구매
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num=''

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num=''

--10. 오픈뱅킹을 이용한 
select TOP(10) ref_num, acc_num, field1, field2, tran_amt, * from tran_master 
where ref_num=''

select TOP(10) ref_num, * from tran_masterDetail 
where ref_num=''

