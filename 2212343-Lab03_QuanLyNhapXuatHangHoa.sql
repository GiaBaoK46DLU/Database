/*	Học phần: Cơ sở dữ liệu
	Bài thực hành: Lab03_QLNXHH
	SV thực hiện: Đinh Lâm Gia Bảo
	Mã SV: 2212343
	Thời gian: 
*/
----------------------------------------------------
-------TẠO CƠ SỞ DỮ LIỆU-------------
create database Lab03_QuanLyNhapXuatHangHoa
go 
use Lab03_QuanLyNhapXuatHangHoa
------Tạo bảng hàng hóa-------
Create table HANGHOA
(MAHH char(5) primary key,
TENHH nvarchar(30) not null unique,
DVT nvarchar(4) not null,
SOLUONGTON int
)
go
------Tạo bảng đối tác-------
Create table DOITAC
(MADT char(5) primary key,
TENDT nvarchar(30) not null ,
DIACHI nvarchar(32) not null ,
DIENTHOAI nvarchar(11) not null,
)
go
------Tạo bảng cung cấp-------
Create table KHANANGCC
(MADT char(5) references DOITAC(MADT),
MAHH char(5) references HANGHOA(MAHH),
Primary key (MADT, MAHH)
)
go
------Tạo bảng hóa đơn-------
Create table HOADON
(SOHD char(5) primary key,
NGAYLAPHD datetime not null ,
MADT char(5) references DOITAC(MADT) ,
TONGTG int
)
go
------Tạo bảng chi tiết hóa đơn------
Create table CT_HOADON
(SOHD char(5) references HOADON(SOHD) ,
MAHH char(5) references HANGHOA(MAHH) ,
DONGIA int ,
SOLUONG int,
Primary key (SOHD, MAHH)
)
------Xem các quan hệ-------
Select * from HANGHOA
Select * from DOITAC
Select * from HOADON
Select * from KHANANGCC
Select * from CT_HOADON
------NHẬP DỮ LIỆU VÀO CÁC QUAN HỆ-------
--Nhập bảng hàng hóa
insert into HANGHOA values ('CPU01', N'CPU INTEL,CELERON 600 BOX','CÁI','5')
insert into HANGHOA values ('CPU02', N'CPU INTEL,PIII 700','CÁI','10')
insert into HANGHOA values ('CPU03', N'CPU AMD K7 ATHL,ON 600','CÁI','8')
insert into HANGHOA values ('HDD01', N'HDD 10.2 GB QUANTUM','CÁI','10')
insert into HANGHOA values ('HDD02', N'HDD 13.6 GB SEAGATE','CÁI','15')
insert into HANGHOA values ('HDD03', N'HDD 20 GB QUANTUM','CÁI','6')
insert into HANGHOA values ('KB01', N'KB GENIUS','CÁI','12')
insert into HANGHOA values ('KB02', N'KB MITSUMIMI','CÁI','5')
insert into HANGHOA values ('MB01', N'GIGABYTE CHIPSET INTEL','CÁI','10')
insert into HANGHOA values ('MB02', N'ACOPR BX CHIPSET VIA','CÁI','10')
insert into HANGHOA values ('MB03', N'INTEL PHI CHIPSET INTEL','CÁI','10')
insert into HANGHOA values ('MB04', N'ECS CHIPSET SIS','CÁI','10')
insert into HANGHOA values ('MB05', N'ECS CHIPSET VIA','CÁI','10')
insert into HANGHOA values ('MNT01', N'SAMSUNG 14" SYNCMASTER','CÁI','5')
insert into HANGHOA values ('MNT02', N'LG 14"','CÁI','5')
insert into HANGHOA values ('MNT03', N'ACER 14"','CÁI','8')
insert into HANGHOA values ('MNT04', N'PHILIP 14"','CÁI','6')
insert into HANGHOA values ('MNT05', N'VIEWSONIC 14"','CÁI','7')
--Xem bảng hàng hóa
Select * from HANGHOA
--Nhập bảng công nhân
insert into DOITAC values ('CC001', N'Cty TNC', N'176 BTX Q1 - TPHCM', '08.8250259')
insert into DOITAC values ('CC002', N'Cty Hoàng Long', N'15A TTT Q1 - TPHCM', '08.8250898')
insert into DOITAC values ('CC003', N'Cty Hợp Nhất', N'152 BTX Q1 - TPHCM', '08.82523376')
insert into DOITAC values ('K0001', N'Nguyễn Minh Hải', N'91 Nguyễn Văn Trỗi Tp.Đà Lạt', '063.831129')
insert into DOITAC values ('K0002', N'Như Quỳnh', N'21 Điện Biên Phủ. N.Trang', '058590270')
insert into DOITAC values ('K0003', N'Trần Nhật Duật', N'Lê Lợi TP.Huế', '054.848376')
insert into DOITAC values ('K0004', N'Phan Nguyễn Hùng Anh', N'11 Nam Kỳ Khởi Nghĩa- TP.Đà Lạt', '063.823409')
--Xem bảng công nhân
Select * from DOITAC
--Nhập bảng khả năng cung cấp
insert into KHANANGCC values ('CC001', 'CPU01')
insert into KHANANGCC values ('CC001', 'HDD03')
insert into KHANANGCC values ('CC001', 'KB01')
insert into KHANANGCC values ('CC001', 'MB02')
insert into KHANANGCC values ('CC001', 'MB04')
insert into KHANANGCC values ('CC001', 'MNT01')
insert into KHANANGCC values ('CC002', 'CPU01')
insert into KHANANGCC values ('CC002', 'CPU02')
insert into KHANANGCC values ('CC002', 'CPU03')
insert into KHANANGCC values ('CC002', 'KB02')
insert into KHANANGCC values ('CC002', 'MB01')
insert into KHANANGCC values ('CC002', 'MB05')
insert into KHANANGCC values ('CC002', 'MNT03')
insert into KHANANGCC values ('CC003', 'HDD01')
insert into KHANANGCC values ('CC003', 'HDD02')
insert into KHANANGCC values ('CC003', 'HDD03')
insert into KHANANGCC values ('CC003', 'MB03')
--Xem bảng khả năng cung cấp
Select * from KHANANGCC
--Nhập bảng hóa đơn
set dateformat dmy
go
insert into HOADON values ('N0001', '25/01/2006', 'CC001', '')
insert into HOADON values ('N0002', '01/05/2006', 'CC002', '')
insert into HOADON values ('X0001', '12/05/2006', 'K0001', '')
insert into HOADON values ('X0002', '16/06/2006', 'K0002', '')
insert into HOADON values ('X0003', '20/04/2006', 'K0001', '')
--Xem bảng hóa đơn 
 
--Nhập bảng chi tiết hóa đơn
insert into CT_HOADON values ('N0001', 'CPU01', '63', '10')
insert into CT_HOADON values ('N0001', 'HDD03', '97', '7')
insert into CT_HOADON values ('N0001', 'KB01', '3', '5')
insert into CT_HOADON values ('N0001', 'MB02', '57', '5')
insert into CT_HOADON values ('N0001', 'MNT01', '112', '3')
insert into CT_HOADON values ('N0002', 'CPU02', '115', '3')
insert into CT_HOADON values ('N0002', 'KB02', '5', '7')
insert into CT_HOADON values ('N0002', 'MNT03', '111', '5')
insert into CT_HOADON values ('X0001', 'CPU01', '67', '2')
insert into CT_HOADON values ('X0001', 'HDD03', '100', '2')
insert into CT_HOADON values ('X0001', 'KB01', '5', '2')
insert into CT_HOADON values ('X0001', 'MB02', '62', '1')
insert into CT_HOADON values ('X0002', 'CPU01', '67', '1')
insert into CT_HOADON values ('X0002', 'KB02', '7', '3')
insert into CT_HOADON values ('X0002', 'MNT01', '115', '2')
insert into CT_HOADON values ('X0003', 'CPU01', '67', '1')
insert into CT_HOADON values ('X0003', 'MNT03', '115', '2')
--Xem bảng chi tiết hóa đơn
Select * from CT_HOADON
----------------TRUY VẤN DỮ LIỆU-------------
--q1) Liệt kê các mặt hàng thuộc loại đĩa cứng
Select*
From HANGHOA
Where LEFT(MAHH,3)=N'HDD'

--q2) Liệt kê các mặt hàng có số lượng tồn trên 10
Select *
From HANGHOA
Where SOLUONGTON> 10

--q3) Cho biết thông tin về các nhà cung cấp ở Thành phố Hồ Chí Minh
Select *
From DOITAC
Where DIACHI like N'%TPHCM' and MADT like N'CC%'

--q4) Liệt kê các hóa đơn nhập hàng trong tháng 5/2006, thông tin hiển thị gồm: sohd, ngaylaphd, tên, địa chỉ, và điện thoại của nhà cung cấp, số mặt hàng
Select  hd.SOHD , convert(char(10),hd.NGAYLAPHD, 105) as NGAYLAPHD, dt.TENDT, dt.DIACHI, dt.DIENTHOAI, sum(cthd.SOLUONG) as SOMATHANG
From HOADON hd, DOITAC dt, CT_HOADON cthd 
Where Left(hd.SOHD,1)= N'N' and hd.MADT = dt.MADT and hd.SOHD = cthd.SOHD and month(hd.NGAYLAPHD) = 5 and year(hd.NGAYLAPHD) = 2006
Group By hd.SOHD, hd.NGAYLAPHD, dt.TENDT, dt.DIACHI, dt.DIENTHOAI

--q5) Cho biết tên các nhà cung cấp có cung cấp đĩa cứng
Select kncc.MADT, kncc.MAHH, dt.TENDT, dt.DIACHI, dt.DIENTHOAI
From KHANANGCC kncc, DOITAC dt
Where Left(kncc.MAHH,3) = N'HDD' and kncc.MADT = dt.MADT

--q6) Cho biết tên các nhà cung cấp có thể cung cấp tất cả các loại đĩa cứng
Select kncc.MADT, dt.TENDT, dt.DIACHI, dt.DIENTHOAI
From KHANANGCC kncc, DOITAC dt
Where Left(kncc.MAHH,3) = N'HDD' and kncc.MADT = dt.MADT
Group By kncc.MADT, dt.TENDT, dt.DIACHI, dt.DIENTHOAI
Having count(MAHH) = (Select count(MAHH)
                      From HANGHOA
					  Where MAHH LIKE 'HDD%')

--q7) Cho biết tên nhà cung cấp không cung cấp đĩa cứng
Select dt.MADT, dt.TENDT, dt.DIACHI, dt.DIENTHOAI
From DOITAC dt
Where MADT like N'CC%' and dt.MADT not in (Select kncc.MADT
							              From KHANANGCC kncc
							              Where kncc.MAHH like 'HDD%')
Group By dt.MADT, dt.TENDT, dt.DIACHI, dt.DIENTHOAI

--q8) Cho biết thông tin của mặt hàng chưa bán được
Select *
From HANGHOA
Where MAHH not in (Select MAHH
				   From CT_HOADON
				   Where LEFT(SOHD,1) = N'X')

--q9) Cho biết tên và tổng số lượng bán của mặt hàng bán chạy nhiều nhất
Select hh.TENHH, sum(cthd.SOLUONG) as TongSoLuongBanNhieuNhat
From HANGHOA hh, CT_HOADON cthd
Where hh.MAHH = cthd.MAHH and cthd.SOHD like N'X%' 
Group By hh.TENHH
Having sum(cthd.SOLUONG) >=all (Select sum(cthd1.SOLUONG)
							 From CT_HOADON cthd1
							 Where cthd1.SOHD like N'X%'
							 Group By MAHH)

--q10) Cho biết tên và tổng số lượng của mặt hàng nhập về ít nhất
Select hh.TENHH, sum(cthd.SOLUONG) as NhapVeItNhat
From HANGHOA hh, CT_HOADON cthd
Where hh.MAHH = cthd.MAHH and cthd.SOHD like N'N%' 
Group By hh.TENHH
Having sum(cthd.SOLUONG) <=all (Select sum(cthd1.SOLUONG)
							 From CT_HOADON cthd1
							 Where cthd1.SOHD like N'N%'
							 Group By MAHH)

--q11) Cho biết hóa đơn nhập nhiều mặt hàng nhất
Select cthd.SOHD, count(MAHH) as SoMatHang
From HOADON hd, CT_HOADON cthd
Where hd.SOHD = cthd.SOHD and cthd.SOHD like N'N%' 
Group By cthd.SOHD
Having count(cthd.MAHH) >=all (Select count(cthd1.MAHH)
							From CT_HOADON cthd1
							Where cthd1.SOHD like N'N%'
							Group By SOHD)

--q12) Cho biết các mặt hàng không được nhập hàng trong tháng 1/2006
Select	hh.MAHH, TENHH
From	HangHoa hh
Where	hh.MAHH not in (Select hh1.MAHH
					   From	  HANGHOA hh1, CT_HOADON cthd, HOADON hd
					   Where  hh1.MAHH = cthd.MAHH and cthd.SOHD = hd.SOHD and hd.SOHD like N'N%' and month(NGAYLAPHD) = 1 and year(NGAYLAPHD) = 2006)

--q13) Cho biết tên các mặt hàng không bán được trong tháng 6/2006
Select	hh.MAHH, TENHH
From	HangHoa hh
Where	hh.MAHH not in (Select hh1.MAHH
					   From	  HANGHOA hh1, CT_HOADON cthd, HOADON hd
					   Where  hh1.MAHH = cthd.MAHH and cthd.SOHD = hd.SOHD and hd.SOHD like N'X%' and month(NGAYLAPHD) = 6 and year(NGAYLAPHD) = 2006)

--q14) Cho biết cửa hàng bán bao nhiêu mặt hàng
Select count(MAHH) as SoMatHang
From HANGHOA

--q15) Cho biết số mặt hàng mà từng nhà cung cấp có khả năng cung cấp
Select dt.MADT, dt.TENDT, count(kncc.MAHH) as SoMatHang
From DOITAC dt, KHANANGCC kncc
Where dt.MADT = kncc.MADT 
Group by dt.MADT, dt.TENDT

--q16) Cho biết thông tin của khách hàng có giao dịch với của hàng nhiều nhất
Select dt.MADT, dt.TENDT, dt.DIACHI, dt.DIENTHOAI, count(hd.SOHD) as SoLanGiaoDich 
From DOITAC dt, HOADON hd
Where dt.MADT = hd.MADT
Group by dt.MADT, dt.TENDT, dt.DIACHI, dt.DIENTHOAI
Having count(hd.SOHD) >=all (Select count(hd1.SOHD)
						    From HOADON hd1, DOITAC dt1
							Where hd1.MADT = dt1.MADT
							Group by hd1.MADT)

--q17) Tính tổng doanh thu năm 2006
Select sum(SOLUONG * DONGIA) as TongDoanhThu
From HOADON hd, CT_HOADON cthd
Where hd.SOHD = cthd.SOHD and year(NGAYLAPHD) = 2006 and cthd.SOHD like N'X%'

--q18) Cho biết loại mặt hàng bán chạy nhất
Select hh.MAHH, hh.TENHH
From HANGHOA hh, CT_HOADON cthd
Where hh.MAHH = cthd.MAHH and SOHD like N'X%'
Group by hh.MAHH, hh.TENHH
Having sum(SOLUONG) >=all (Select sum(SOLUONG)
                           From CT_HOADON
						   Where SOHD like N'X%'
						   Group by MAHH)

--q19) Liệt kê thông tin bán hàng của tháng 5/2006 bao gồm: mahh, tenhh, dvt, tổng số lượng, tổng thành tiền
Select		Distinct hh.MAHH, TenHH, SUM(SoLuong) as TongSoLuong, SUM(DonGia * SoLuong) as TongThanhTien
From		HANGHOA hh, CT_HOADON cthd, HOADON hd
Where		hh.MAHH = cthd.MaHH and hd.SOHD = cthd.SOHD and hd.SOHD like N'X%' and month(NGAYLAPHD) = 5 and year(NGAYLAPHD) = 2006
Group by	hh.MAHH, TenHH

--q20) Liệt kê thông tin của mặt hàng có nhiều người mua nhất
Select hh.MAHH, TENHH, DVT, SOLUONGTON
From HANGHOA hh, CT_HOADON cthd
Where hh.MAHH = cthd.MAHH and cthd.SOHD like N'X%'
Group by hh.MAHH, TENHH, DVT, SOLUONGTON
Having count(hh.MAHH) >= all(Select count(MAHH)
                            From CT_HOADON cthd1
                            Where cthd1.SOHD like N'X%'
                            Group by MaHH)

--q21) Tính và cập nhật tổng trị giá của các hóa đơn
Update HOADON
Set TONGTG = (Select SUM(SOLUONG * DONGIA)
              From CT_HOADON
              Where CT_HOADON.SoHD = HOADON.SoHD
              Group by SoHD)
From  HOADON

Select * from HOADON

----------Hàm & thủ tục----------
----------Hàm----------
--a) Tính tổng số lượng nhập trong một khoảng thời gian của một mặt hàng cho trước
create function fn_TongSoLuongNhap1MatHang (@mahh varchar(5), @bd datetime, @kt datetime) returns int	
As
Begin
	declare @TongSoLuong int
	if exists (Select * from CT_HOADON where MAHH = @mahh and LEFT(SOHD, 1) = 'N')
		begin
			Select @TongSoLuong = SUM(SOLUONG)
			From CT_HOADON ct, HOADON hd
			Where ct.SOHD = hd.SOHD and LEFT(ct.SOHD, 1) = 'N' and NGAYLAPHD between @bd and  @kt and MAHH = @mahh
		end
	else 
		set @TongSoLuong = 0
	return @TongSoLuong 
End 
--Chạy thử hàm
set dateformat dmy
print dbo.fn_TongSoLuongNhap1MatHang ('HDD03', '15/01/2006', '30/01/2006')

--b) Tính tổng số lượng xuất trong một khoảng thời gian của một mặt hàng cho trước
create function fn_TongSoLuongXuat1MatHang (@mahh varchar(5), @bd datetime, @kt datetime) returns int	
As
Begin
	declare @TongSoLuong int
	if exists (Select * from CT_HOADON where MAHH = @mahh and LEFT(SOHD, 1) = 'X')
		begin
			Select @TongSoLuong = SUM(SOLUONG)
			From CT_HOADON ct, HOADON hd
			Where ct.SOHD = hd.SOHD and LEFT(ct.SOHD, 1) = 'X' and NGAYLAPHD between @bd and  @kt and MAHH = @mahh
		end
	else 
		set @TongSoLuong = 0
	return @TongSoLuong 
End 
--Chạy thử hàm
set dateformat dmy
print dbo.fn_TongSoLuongXuat1MatHang ('KB02', '15/06/2006', '30/06/2006')
print dbo.fn_TongSoLuongXuat1MatHang ('NB01', '15/06/2006', '30/06/2006')

--c) Tính tổng doanh thu trong một tháng cho trước
alter function fn_TongDoanhThu1Thang (@thang int, @nam int) returns int
As
Begin
	declare @TongDoanhThu int
	declare @TongXuat int
	declare @TongNhap int
	if exists (select * from HOADON where MONTH(NGAYLAPHD) = @thang and YEAR(NGAYLAPHD) = @nam)
		begin
			-- Tính tổng tiền của hóa đơn nhập
			select	@TongNhap = SUM(DONGIA * SOLUONG)
			from	CT_HOADON ct, HOADON hd
			where	ct.SOHD = hd.SOHD and LEFT(ct.SOHD,1) = 'N' and MONTH(NGAYLAPHD) = @thang and YEAR(NGAYLAPHD) = @nam
			-- Tính tổng tiền của hóa đơn xuất
			select	@TongXuat = SUM(DONGIA * SOLUONG)
			from	CT_HOADON ct, HOADON hd
			where	ct.SOHD = hd.SOHD and LEFT(ct.SOHD,1) = 'X' and MONTH(NGAYLAPHD) = @thang and YEAR(NGAYLAPHD) = @nam
			-- Tính tổng doanh thu
			set @TongDoanhThu = @TongXuat - @TongNhap
		end
	else
		set @TongDoanhThu = 0
	return @TongDoanhThu
End
-- Chạy thử hàm
print dbo.fn_TongDoanhThu1Thang ('5', '2006')

--d) Tính tổng doanh thu của một mặt hàng trong một khoảng thời gian cho trước.
create function fn_TongDoanhThuCuaMotMatHang (@mahh varchar(5), @bd datetime, @kt datetime) returns int
As
Begin
	declare @TongDoanhThu int
	declare @TongXuat int
	declare @TongNhap int
	if exists (select * from HOADON hd, CT_HOADON ct where hd.SOHD = ct.SOHD and MaHH = @mahh and NGAYLAPHD between @bd and @kt)
		begin
			-- Tính tổng tiền của hóa đơn nhập
			select	@TongNhap = SUM(DONGIA * SOLUONG)
			from	CT_HOADON ct, HOADON hd
			where	ct.SOHD = hd.SOHD and LEFT(ct.SOHD,1) = 'N' and NGAYLAPHD between @bd and @kt and MAHH = @mahh
			-- Tính tổng tiền của hóa đơn xuất
			select	@TongXuat = SUM(DONGIA * SOLUONG)
			from	CT_HOADON ct, HOADON hd
			where	ct.SOHD = hd.SOHD and LEFT(ct.SOHD,1) = 'X' and NGAYLAPHD between @bd and @kt and MAHH = @mahh
			-- Tính tổng doanh thu
			set @TongDoanhThu = @TongXuat - @TongNhap
		end
	else
		set @TongDoanhThu = 0
	return @TongDoanhThu
End
-- Chạy thử hàm
set dateformat dmy
print dbo.fn_TongDoanhThuCuaMotMatHang ('HDD03', '13/01/2006', '30/01/2006')

--e) Tính tổng số tiền nhập hàng trong một khoảng thời gian cho trước.
create function fn_TongTienNhapHang (@mahh varchar(5), @bd datetime, @kt datetime) returns int
As
Begin
	declare @tongtiennhap int
	if exists (select * from HOADON hd, CT_HOADON ct where hd.SoHD = ct.SOHD and MaHH = @mahh and NgayLapHD between @bd and @kt and LEFT(ct.SOHD, 1) = 'N')
		begin
			select	@tongtiennhap = SUM(DONGIA * SOLUONG)
			from	CT_HOADON ct, HOADON hd
			where	ct.SOHD = hd.SOHD and LEFT(ct.SoHD,1) = 'N' and NgayLapHD between @bd and @kt and MaHH = @mahh
		end
	else
		set @tongtiennhap = 0
	return @tongtiennhap
End
-- Chạy thử hàm
set dateformat dmy
print dbo.fn_TongTienNhapHang ('MB02', '14/01/2006', '30/01/2006')

--f) Tính tổng số tiền của một hóa đơn cho trước.
create function fn_TongTienHoaDon (@SoHD char(5)) returns int
As
Begin
	declare @tongtien int
	if exists (select * from HoaDon where SOHD = @SoHD)
		begin
			select	@tongtien = SUM(DONGIA * SOLUONG)
			from	CT_HOADON
			where	SOHD = @SoHD
		end
	else
		set @tongtien = 0
	return @tongtien
End
-- Chạy thử hàm
print dbo.fn_TongTienHoaDon ('N0002')

----------Thủ tục----------
--a) Cập nhật số lượng tồn của một mặt hàng khi nhập hàng hoặc xuất hàng
create proc usp_CapNhatSoLuongTon @mahh varchar(5)
as
	if exists (select * from HANGHOA where MAHH = @mahh)
		begin
			if exists (select * from CT_HOADON where MAHH = @mahh and LEFT(SOHD, 1) = 'N')
				begin
					update	HANGHOA	
					set		SOLUONGTON = SOLUONGTON + SOLUONG
					from	HANGHOA hh, CT_HOADON ct
					where	hh.MaHH = ct.MAHH and  ct.MAHH = @mahh
				end
			if exists (select * from CT_HOADON where MAHH = @mahh and LEFT(SOHD, 1) = 'X')
				begin
					update	HANGHOA	
					set		SOLUONGTON = SOLUONGTON - SOLUONG
					from	HANGHOA hh, CT_HOADON ct
					where	hh.MAHH = ct.MAHH and  ct.MAHH = @mahh
				end
		end
	else
		print N'Không có mặt hàng '+ @mahh + ' trong cơ sở dữ liệu'
go

exec usp_CapNhatSoLuongTon 'MNT01'

--b) Cập nhật tổng giá trị của một hóa đơn
create proc usp_CapNhatTongGiaTri1HoaDon @SoHD char(5)
as
	if exists (select * from HOADON where SOHD = @SoHD)
		begin	
			update	HOADON
			set		TONGTG = (select SUM(DONGIA * SOLUONG)
							  from CT_HOADON
							  where SOHD = @SoHD )
			from	HOADON
			where	SOHD = @SoHD
		end
	else
		print N'Không có hóa đơn ' + @SoHD + ' trong cơ sở dữ liệu'
go
--drop proc usp_CapNhatTongGiaTri1HoaDon
exec usp_CapNhatTongGiaTri1HoaDon 'N0001'

--c) In đầy đủ thông tin của một hóa đơn
create proc usp_InThongTin1HoaDon @SoHD char(5)
as
	if exists (select * from HOADON where SOHD = @SoHD)
		begin
			select	*
			from	HOADON hd
		end
	else
		print N'Không có hóa đơn ' + @SoHD + ' trong cơ sở dữ liệu'
go

exec usp_InThongTin1HoaDon 'N0001' 