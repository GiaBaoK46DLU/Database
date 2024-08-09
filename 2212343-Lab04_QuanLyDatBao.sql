/*
	Học phần: Cơ sở dữ liệu 
	Bài thực hành: Lab04_QuanLyDatBao
	SV thực hiện: Đinh Lâm Gia Bảo
	MaSV: 2212343
	Thời gian: 04/04/2024
*/
--------------------------------------------------------
--------- TẠO CƠ SỞ DỮ LIỆU
create database Lab04_QuanLyDatBao
go
use Lab04_QuanLyDatBao
------Tạo bảng báo, tạp chí------
Create Table BAO_TCHI
(
	MaBaoTC char(4) primary key,
	Ten nvarchar(30) not null,
	DinhKy nvarchar(30) not null,
	SoLuong int,
	GiaBan int
)
go

------Tạo bảng phát hành------
create table PHATHANH
(
	MaBaoTC char(4) references BAO_TCHI(MaBaoTC),
	SoBaoTC char(5),
	NgayPH datetime,
	primary key (MaBaoTC, SoBaoTC)
)
go

------Tạo bảng khách hàng------
create table KHACHHANG
(
	MaKH char(4) primary key,
	TenKH nvarchar(10),
	DiaChi nvarchar(20)
)
go

------Tạo bảng đặt báo------
create table DATBAO
(
	MaKH char(4) references KHACHHANG(MaKH),
	MaBaoTC char(4) references BAO_TCHI(MaBaoTC),
	SLMua int,
	NgayDM datetime,
	primary key (MaKH, MaBaoTC, NgayDM)
)
go

----------XÂY DỰNG CÁC THỦ TỤC NHẬP DỮ LIỆU-------------
--Thủ tục thêm dữ liệu vào bảng BAO_TCHI
create proc usp_ThemBAO_TCHI
	@Mabao_tchi varchar(4), @Ten nvarchar(30), @DinhKy nvarchar(30), @SoLuong int, @GiaBan int
As
	If exists(select * from BAO_TCHI where MaBaoTC = @Mabao_tchi)
		print N'Đã có mã báo chí ' + @Mabao_tchi + N' trong CSDL!'
	Else
		begin
			insert into BAO_TCHI values (@Mabao_tchi, @Ten, @DinhKy, @SoLuong, @GiaBan)
			print N'Thêm báo/tạp chí mới thành công.'
		end
go
--Gọi thực hiện thủ tục usp_ThemBAO_TCHI---
exec usp_ThemBAO_TCHI 'TT01',N'Tuổi trẻ',N'Nhật báo','1000','1500'
exec usp_ThemBAO_TCHI 'KT01',N'Kiến thức ngày nay',N'Bán nguyệt san','3000','6000'
exec usp_ThemBAO_TCHI 'TN01',N'Thanh niên',N'Nhật báo','1000','2000'
exec usp_ThemBAO_TCHI 'PN01',N'Phụ nữ',N'Tuần báo','2000','4000'
exec usp_ThemBAO_TCHI 'PN02',N'Phụ nữ',N'Nhật báo','1000','2000'

select * from BAO_TCHI
--drop proc usp_ThemBAO_TCHI

--Thủ tục thêm dữ liệu vào bảng PHATHANH
create proc usp_ThemPHATHANH
	@Mabao_tchi varchar(4), @SoBaoTC nvarchar(5), @NgayPH datetime
As
	If exists(select * from PHATHANH where MaBaoTC = @Mabao_tchi and SoBaoTC = @SoBaoTC)
			print N'Đã có báo/tạp chí ' + @Mabao_tchi + N' trong CSDL!'
	Else
		begin
			insert into PHATHANH values (@Mabao_tchi, @SoBaoTC, @NgayPH)
			print N'Thêm phát hành mới thành công.'
		end
go

--Gọi thực hiện thủ tục usp_ThemPHATHANH---
set dateformat dmy
exec usp_ThemPHATHANH 'TT01','123','15/12/2005'
exec usp_ThemPHATHANH 'KT01','70','15/12/2005'
exec usp_ThemPHATHANH 'TT01','124','16/12/2005'
exec usp_ThemPHATHANH 'TN01','256','17/12/2005'
exec usp_ThemPHATHANH 'PN01','45','23/12/2005'
exec usp_ThemPHATHANH 'PN02','111','18/12/2005'
exec usp_ThemPHATHANH 'PN02','112','19/12/2005'
exec usp_ThemPHATHANH 'TT01','125','17/12/2005'
exec usp_ThemPHATHANH 'PN01','46','30/12/2005'

select * from PHATHANH
--drop proc usp_ThemPHATHANH
--drop table PHATHANH

--Thủ tục thêm dữ liệu vào bảng KHACHHANG
create proc usp_ThemKHACHHANG
	@MaKH varchar(4), @TenKH nvarchar(10), @DiaChi nvarchar(20)
As
	If exists(select * from KHACHHANG where MaKH = @MaKH)
		print N'Đã có mã khách hàng ' + @MaKH + N' trong CSDL!'
	Else
		begin
			insert into KHACHHANG values (@MaKH, @TenKH, @DiaChi)
			print N'Thêm khách hàng mới thành công.'
		end
go
--Gọi thực hiện thủ tục usp_ThemKHACHHANG---
exec usp_ThemKHACHHANG 'KH01',N'LAN',N'2 NCT'
exec usp_ThemKHACHHANG 'KH02',N'NAM',N'32 THĐ'
exec usp_ThemKHACHHANG 'KH03',N'NGỌC',N'16 LHP'

select * from KHACHHANG

--Thủ tục thêm dữ liệu vào bảng DATBAO
create proc usp_ThemDATBAO
	@MaKH varchar(4), @MaBaoTC nvarchar(4), @SLMua int, @NgayDM datetime
As
	If exists(select * from DATBAO where MaKH = @MaKH and MaBaoTC = @MaBaoTC and NgayDM = @NgayDM)
		print N'Đã có khách đặt báo ' + @MaKH + N' trong CSDL!'
	Else
		begin
			insert into DATBAO values (@MaKH, @MaBaoTC, @SLMua, @NgayDM)
			print N'Thêm khách đặt báo mới thành công.'
		end
go

--Gọi thực hiện thủ tục usp_ThemDATBAO---
exec usp_ThemDATBAO 'KH01', 'TT01', 100, '12/01/2000'
exec usp_ThemDATBAO 'KH02', 'TN01', 150, '01/05/2001'
exec usp_ThemDATBAO 'KH01', 'PN01', 200, '25/06/2001'
exec usp_ThemDATBAO 'KH03', 'KT01', 50, '17/03/2002'
exec usp_ThemDATBAO 'KH03', 'PN02', 200, '26/08/2003'
exec usp_ThemDATBAO 'KH02', 'TT01', 250, '15/01/2004'
exec usp_ThemDATBAO 'KH01', 'KT01', 300, '14/10/2004'

select * from DATBAO
--drop proc usp_ThemDATBAO

--------NHẬP DỮ LIỆU VÀO CÁC QUAN HỆ---------
--Nhập bảng BAO_TCHI
insert into BAO_TCHI values ('TT01',N'Tuổi trẻ',N'Nhật báo',1000,1500)
insert into BAO_TCHI values ('KT01',N'Kiến thức ngày nay',N'Báo nguyệt san',3000,6000)
insert into BAO_TCHI values ('TN01',N'Thanh niên',N'Nhật báo',1000,2000)
insert into BAO_TCHI values ('PN01',N'Phụ nữ',N'Tuần báo',2000,4000)
insert into BAO_TCHI values ('PN02',N'Phụ nữ',N'Nhật báo',1000,2000)

Update BAO_TCHI set DinhKy = N'Bán nguyệt san'
Where MaBaoTC = 'KT01'
-- Nhập bảng PHATHANH
set dateformat dmy
go
insert into PHATHANH values ('TT01','123','15/12/2005')
insert into PHATHANH values ('KT01','70','15/12/2005')
insert into PHATHANH values ('TT01','124','16/12/2005')
insert into PHATHANH values ('TN01','256','17/12/2005')
insert into PHATHANH values ('PN01','45','23/12/2005')
insert into PHATHANH values ('PN02','111','18/12/2005')
insert into PHATHANH values ('PN02','112','19/12/2005')
insert into PHATHANH values ('TT01','125','17/12/2005')
insert into PHATHANH values ('PN01','46','30/12/2005')

--Nhập bảng KHACHHANG
insert into KHACHHANG values ('KH01',N'LAN',N'2 NCT')
insert into KHACHHANG values ('KH02',N'NAM',N'32 THĐ')
insert into KHACHHANG values ('KH03',N'NGỌC',N'16 LHP')

--Nhập bảng DATBAO
set dateformat dmy
go
insert into DATBAO values ('KH01', 'TT01', 100, '12/01/2000')
insert into DATBAO values ('KH02', 'TN01', 150, '01/05/2001')
insert into DATBAO values ('KH01', 'PN01', 200, '25/06/2001')
insert into DATBAO values ('KH03', 'KT01', 50, '17/03/2002')
insert into DATBAO values ('KH03', 'PN02', 200, '26/08/2003')
insert into DATBAO values ('KH02', 'TT01', 250, '15/01/2004')
insert into DATBAO values ('KH01', 'KT01', 300, '14/10/2004')
----------------------------------------

--Xem các bảng
select * from BAO_TCHI
select * from PHATHANH
select * from KHACHHANG
select * from DATBAO

----------------TRUY VẤN DỮ LIỆU-------------
--q1) Cho biết các tờ báo, tạp chí (MABAOTC, TEN, GIABAN) có định kỳ phát hành hàng tuần (Tuần báo).
Select	MaBaoTC, Ten, GiaBan
From	BAO_TCHI
Where	DinhKy = N'Tuần báo'

--q2) Cho biết thông tin về các tờ báo thuộc loại báo phụ nữ (mã báo tạp chí bắt đầu bằng PN).
Select	MaBaoTC, Ten, DinhKy, SoLuong, GiaBan
From	BAO_TCHI
Where	LEFT(MaBaoTC,2) = 'PN'

--q3) Cho biết tên các khách hàng có đặt mua báo phụ nữ (mã báo tạp chí bắt đầu bằng PN), không liệt kê khách hàng trùng.
Select	distinct TenKH
From	KHACHHANG kh, DATBAO db
Where	kh.MaKH = db.MaKH and LEFT(MaBaoTC,2) = 'PN'

--q4) Cho biết tên các khách hàng có đặt mua tất cả các báo phụ nữ (mã báo tạp chí bắt đầu bằng PN).
Select	TenKH
From	KHACHHANG kh, DATBAO db
Where	kh.MaKH = db.MaKH and MaBaoTC = 'PN01'
		and db.MaKH in (
							Select	db1.MaKH
							From	KHACHHANG kh1, DATBAO db1
							Where	kh1.MaKH = db1.MaKH and MaBaoTC = 'PN02'
					   )

--q5) Cho biết các khách hàng không đặt mua báo thanh niên.
Select	*
From	KhachHang kh
Where	kh.MaKH not in (
							Select	kh1.MaKH
							From	KHACHHANG kh1, DATBAO db
							Where	kh1.MaKH = db.MaKH and LEFT(MaBaoTC,2) = 'TN'
					   )

--q6) Cho biết số tờ báo mà mỗi khách hàng đã đặt mua.
Select		kh.MaKH, TenKH, SUM(SLMua) as SoToBaoDaDat
From		KHACHHANG kh, DATBAO db
Where		kh.MaKH = db.MaKH 
Group by	kh.MaKH, TenKH

--q7) Cho biết số khách hàng đặt mua báo trong năm 2004.
Select	COUNT(MaKH) as SoKHDatMua
From	DATBAO
Where	YEAR(NgayDM) = 2004

--q8) Cho biết thông tin đặt mua báo của các khách hàng (TenKH, Ten, DinhKy,SLMua, SoTien), trong đó SoTien = SLMua x DonGia.
Select	TenKH, Ten, SLMua, (SLMua * GiaBan) as SoTien
From	BAO_TCHI btc, KHACHHANG kh, DATBAO db
Where	btc.MaBaoTC = db.MaBaoTC and kh.MaKH = db.MaKH

--q9) Cho biết các tờ báo, tạp chí (Ten, DinhKy) và tổng lượng đặt mua của các khách hàng đối với tờ báo, tạp chí đó.
Select	Ten, DinhKy, SUM(SLMua) as LuongDM
From	BAO_TCHI btc, DATBAO db
Where	btc.MaBaoTC = db.MaBaoTC
Group by	btc.MaBaoTC, Ten, DinhKy

--q10) Cho biết tên các tờ báo dành cho học sinh, sinh viên (mã báo tạp chí bắt đầu bằng HS)
Select	Ten
From	BAO_TCHI
Where	MaBaoTC like N'%HS'

--q11) Cho biết những tờ báo không có người đặt mua.
Select	*
From	BAO_TCHI btc
Where	btc.MaBaoTC not in (
								Select	db.MaBaoTC
								From	DATBAO db
						   )

--q12) Cho biết tên, định kỳ của những tờ báo có nhiều người đặt mua nhất.
Select		Ten, DinhKy
From		BAO_TCHI btc, DATBAO db
Where		btc.MaBaoTC = db.MaBaoTC 
Group by	btc.MaBaoTC, Ten, DinhKy
Having		COUNT(MaKH) >= all (
									Select		COUNT(db1.MaKH)
									From		BAO_TCHI btc1, DATBAO db1
									Where		btc1.MaBaoTC = db1.MaBaoTC
									Group by	btc1.MaBaoTC
							   )

--q13) Cho biết khách hàng đặt mua nhiều báo, tạp chí nhất.
Select		kh.MaKH, TenKH, DiaChi, SUM(db.SLMua) AS SoBaoDM
From		KHACHHANG kh, DATBAO db
Where		kh.MaKH = db.MaKH 
Group by	kh.MaKH, TenKH, DiaChi
Having		SUM(db.SLMua) >= all (
									Select		SUM(db1.SLMua)
									From		KHACHHANG kh1, DATBAO db1
									Where		kh1.MaKH = db1.MaKH
									Group by	kh1.MaKH
							     )

--q14) Cho biết các tờ báo phát hành định kỳ một tháng 2 lần.
Select *
From BAO_TCHI 
Where  DinhKy = N'Bán nguyệt san'

--q15) Cho biết tờ báo, tạp chi có từ 3 khách hàng đặt mua trở lên.
Select Ten, DinhKy, COUNT(MaKH) AS TongKhachHang
From BAO_TCHI btc, DATBAO db
Where btc.MaBaoTC = db.MaBaoTC 
Group By Ten, DinhKy
Having COUNT(db.MaKH) >= 3;

----------Hàm & thủ tục----------
----------Hàm----------
--a) Tính tổng số tiền mua báo/tạp chí của một khách hàng cho trước
create function fn_TongSoTien (@MaKH char(4)) returns int
As
Begin
	declare @tong int
	if exists (select * from KhachHang where MaKH = @MaKH)
		begin
			select	@tong = SUM(GiaBan * SLMua)
			from	BAO_TCHI btc, DATBAO db
			where	btc.MaBaoTC = db.MaBaoTC and MaKH = @MaKH
		end
	else
		set @tong = 0
	return @tong
End
--Chạy thử hàm
print dbo.fn_TongSoTien ('KH03')

--b) Tính tổng số tiền thu được của một tờ báo/tạp chí cho trước
create function fn_TongTien_1ToBao_TapChi (@MaBaoTC char(4)) returns int
As
Begin
	declare @tong int
	if exists (select * from BAO_TCHI where MaBaoTC = @MaBaoTC)
		begin
			select	@tong = SUM(GiaBan * SLMua)
			from	BAO_TCHI btc, DatBao db
			where	btc.MaBaoTC = db.MaBaoTC and db.MaBaoTC = @MaBaoTC
		end
	else
		return 0
	return @tong
End
--Chạy thử hàm
print dbo.fn_TongTien_1ToBao_TapChi ('TT01')

----------Thủ tục----------
--a) In danh mục báo, tạp chí phải giao cho một khách hàng cho trước
create proc InDanhMucBaoTC @MaKH char(4)
as
	if exists (select * from KhachHang where MaKH = @MaKH)
		begin
			select	btc.MaBaoTC, Ten, DinhKy, SLMua, GiaBan
			from	BAO_TCHI btc, DatBao db
			where	btc.MaBaoTC = db.MaBaoTC and MaKH = @MaKH
		end
	else
		print N'Không có khách hàng ' + @MaKH + ' trong cơ sở dữ liệu'
go
--Chạy thử thủ tụcs
exec InDanhMucBaoTC 'KH03'

--b) In danh sách khách hàng đặt mua báo/tạp chí cho trước
create proc InDSKHMua @MaBaoTC char(4)
as
	if exists (select * from BAO_TCHI where MaBaoTC = @MaBaoTC)
		begin
			select	kh.MaKH, TenKH
			from	KhachHang kh, DatBao db
			where	kh.MaKH = db.MaKH and MaBaoTC = @MaBaoTC
		end
	else
		print N'Không có báo/tạp chí ' + @MaBaoTC + ' trong cơ sở dữu liệu'
go
--Chạy thử thủ tục
exec InDSKHMua 'PN01'