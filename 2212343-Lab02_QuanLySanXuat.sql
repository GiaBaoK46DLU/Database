/*	Học phần: Cơ sở dữ liệu
	Bài thực hành: Lab02_QLSX
	SV thực hiện: Đinh Lâm Gia Bảo
	Mã SV: 2212343
	Thời gian: 
*/
----------------------------------------------------
-------TẠO CƠ SỞ DỮ LIỆU-------------
create database Lab02_QuanLySanXuat
go 
use Lab02_QuanLySanXuat

------Tạo bảng tổ sản xuất-------
Create table ToSanXuat
(MaTSX char(4) primary key,
TenTSX nvarchar(30) not null unique
)
go

------Tạo bảng công nhân-------
Create table CongNhan
(MACN char(5) primary key,
Ho nvarchar(30) not null ,
Ten nvarchar(7) not null ,
Phai nvarchar(4) not null ,
NgaySinh datetime ,
MaTSX char(4) references ToSanXuat(MaTSX)
)
go

------Tạo bảng sản phẩm-------
Create table SanPham
(MaSP char(5) primary key,
TenSP nvarchar(30) not null,
DVT nvarchar(4) not null ,
TienCong int 
)
go

------Tạo bảng thành phẩm-------
Create table ThanhPham
(MACN char(5) references CongNhan(MACN),
MaSP char(5) references SanPham(MaSP),
Ngay datetime not null,
SoLuong int,
Primary key (MACN, MaSP, Ngay)
)
go

--drop table ThanhPham
------Xem các quan hệ-------
Select * from ToSanXuat
Select * from CongNhan
Select * from SanPham
Select * from ThanhPham

------Ràng buộc toàn vẹn------
--a) Tên tổ sản xuất phải được phân biệt
alter table ToSanXuat
add CONSTRAINT UC_TenTSX unique (TenTSX);
--b) Tên sản phẩm phải khác nhau
alter table SanPham
add constraint UC_TenSP unique (TenSP);
--c) Tiền công >0
alter table SanPham
add constraint UC_TienCong check (TienCong > 0);
--d) Số lượng phải nguyên dương
alter table ThanhPham
add constraint UC_SoLuong check (SoLuong >0);

------NHẬP DỮ LIỆU VÀO CÁC QUAN HỆ-------
--Nhập bảng Tổ sản xuất
insert into ToSanXuat values ('TS01', N'Tổ 1')
insert into ToSanXuat values ('TS02', N'Tổ 2')
--Xem bảng Tổ sản xuất
Select * from ToSanXuat

--Nhập bảng công nhân
set dateformat dmy --báo với SQL Server nhập ngày tháng theo kiểu ngày/tháng/năm
go
insert into CongNhan values ('CN001', N'Nguyễn Trường', N'An', 'Nam', '12/05/1981','TS01')
insert into CongNhan values ('CN002', N'Lê Thị Hồng', N'Gấm', N'Nữ', '04/06/1980','TS01')
insert into CongNhan values ('CN003', N'Nguyễn Công', N'Thành', 'Nam', '04/05/1981','TS02')
insert into CongNhan values ('CN004', N'Võ Hữu', N'Hạnh', 'Nam', '15/02/1980','TS02')
insert into CongNhan values ('CN005', N'Lý Thanh', N'Hân', 'Nam', '03/12/1981','TS01')
--Xem bảng công nhân
Select * from CongNhan

--Nhập bảng sản phẩm
insert into SanPham values ('SP001',N'Nồi đất',N'cái','10000')
insert into SanPham values ('SP002',N'Chén',N'cái','2000')
insert into SanPham values ('SP003',N'Bình gốm nhỏ',N'cái','20000')
insert into SanPham values ('SP004',N'Bình gốm lớn',N'cái','25000')
--Xem bảng sản phẩm
Select * from SanPham

--Nhập bảng thành phẩm
set dateformat dmy
go
insert into ThanhPham values ('CN001','SP001','01/02/2007',10)
insert into ThanhPham values ('CN002','SP001','01/02/2007',5)
insert into ThanhPham values ('CN003','SP002','10/01/2007',50)
insert into ThanhPham values ('CN004','SP003','12/01/2007',10)
insert into ThanhPham values ('CN005','SP002','12/01/2007',100)
insert into ThanhPham values ('CN002','SP004','13/02/2007',10)
insert into ThanhPham values ('CN001','SP003','14/02/2007',15)
insert into ThanhPham values ('CN003','SP001','15/01/2007',20)
insert into ThanhPham values ('CN003','SP004','14/02/2007',15)
insert into ThanhPham values ('CN004','SP002','30/01/2007',100)
insert into ThanhPham values ('CN005','SP003','01/02/2007',50)
insert into ThanhPham values ('CN001','SP001','20/02/2007',30)
--Xem bảng thành phẩm
Select * from ThanhPham

----------------TRUY VẤN DỮ LIỆU-------------
--q1) Liệt kê các công nhân theo tổ sản xuất gồm các thông tin: TenTSX, HoTen(xếp thứ tự tăng dần của tên tổ sản xuất, tên công nhân)
Select A.TenTSX, B.Ho + ' ' + B.Ten, B.NgaySinh, B.Phai
From ToSanXuat A, CongNhan B
Where A.MaTSX = B.MaTSX
Order By TenTSX, Ten, Ho

--q2) Liệt kê các thành phẩm mà công nhân "Nguyễn Trường An" đã làm gồm các thông tin: TenSP, Ngay, SoLuong, ThanhTien(xếp theo thứ tự tăng dần của ngày.)
Select A.TenSP, B.Ngay, B.SoLuong, B.SoLuong * A.TienCong as ThanhTien
From SanPham A, ThanhPham B, CongNhan C
Where A.MaSP = B.MaSP and B.MACN = C.MACN and Ho = N'Nguyễn Trường' and Ten = N'An'
Order By Ngay

--q3) Liệt kê các nhân viên không sản xuất sản phẩm 'Bình gốm lớn'
Select *
From CongNhan
Where MACN Not In ( Select A.MACN
					From ThanhPham A, SanPham B
					Where A.MaSP = B.MaSP and TenSP = N'Bình gốm lớn')

--q4) Liệt kê thông tin các công nhân có sản xuất cả 'Nồi đất' và 'Bình gốm nhỏ'
Select distinct A.MACN, Ho, Ten, MaTSX
From CongNhan A, ThanhPham B, SanPham C
Where A.MACN = B.MACN and B.MaSP = C.MaSP and TenSP = N'Nồi đất' 
	  and A.MACN in ( Select D.MACN
					  From ThanhPham D, SanPham E
					  Where D.MaSP = E.MaSP and TenSP = N'Bình gốm nhỏ')

--q5) Thống kê số lượng công nhân theo từng tổ sản xuất ( truy vấn gom nhóm )
Select A.TenTSX, count(MaCN) as SoCN
From ToSanXuat A, CongNhan B
Where A.MaTSX = B.MaTSX
Group By TenTSX

--q6) Tổng số lượng thành phẩm theo từng loại mà mỗi nhân viên làm được 
Select A.Ho, A.Ten, C.TenSP, sum(B.SoLuong) as TongSLSanPham, sum(B.SoLuong * C.TienCong) as TongThanhTien
From CongNhan A, ThanhPham B, SanPham C
Where A.MACN = B.MACN and B.MaSP = C.MaSP
Group By Ho, Ten, TenSP

--q7) Tổng số tiền công đã trả cho công nhân trong tháng 1 năm 2007\
Select A.MACN, A.Ho, A.Ten, sum(B.SoLuong * C.TienCong) as ThanhTien
From CongNhan A, ThanhPham B, SanPham C
Where A.MACN = B.MACN and B.MaSP = C.MaSP and month(Ngay) = 1 and year(Ngay) = 2007
Group By A.MACN, A.Ho, A.Ten

--q8) Cho biết sản phẩm được sản xuất nhiều nhất trong tháng 2/2007 (bài toán max)
Select B.TenSP, B.DVT, sum(A.SoLuong) as SoLuongSXThang2_2007
From ThanhPham A, SanPham B
Where A.MaSP = B.MaSP and month(Ngay) = 2 and year(Ngay) = 2007
Group By B.TenSP, B.DVT
Having sum(A.SoLuong) >=all (Select sum(C.SoLuong)
							 From ThanhPham C
							 Where month(C.Ngay) = 2 and year(C.Ngay) = 2007
							 Group By C.MaSP)

--q9) Cho biết công nhân sản xuất được nhiều Chén nhất
Select A.MACN, A.Ho, A.Ten, A.MaTSX , sum(B.SoLuong) as SoLuong_Chen
From CongNhan A, ThanhPham B, SanPham C
Where A.MACN = B.MACN and B.MaSP = C.MaSP and TenSP = N'Chén'
Group By A.MACN, Ho, Ten, MaTSX
Having sum(B.SoLuong) >=all (Select sum(D.SoLuong)
							 From ThanhPham D, SanPham E
							 Where D.MaSP = E.MaSP and TenSP = N'Chén'
							 Group By D.MACN)

--q10) Tiền công tháng 2/2007 của công nhân có mã số "CN002"
Select sum(A.SoLuong * B.TienCong) as TienCongCuaCN
From ThanhPham A, SanPham B
Where A.MaSP = B.MaSP and A.MACN = 'CN002' and month(Ngay) = 2 and year(Ngay) = 2007

--q11) Liệt kê các công nhân có sản xuất từ 3 loại sản phẩm trở lên
Select A.MACN, Ho, Ten, MaTSX, count(distinct MaSP) as SoLoaiSPLamDuoc
From CongNhan A, ThanhPham B
Where A.MACN = B.MACN
Group By A.MACN, Ho, Ten, MaTSX
Having count(distinct MaSP)>=3

--q12) Cập nhật giá tiền công của các loại bình gốm thêm 1000.
Update SanPham
Set TienCong = TienCong + 1000
Where TenSP in (N'Bình gốm nhỏ' , N'Bình gốm lớn')
Select * from SanPham

--q13) Thêm bộ<'CN006','Lê Thị','Lan','Nữ','TS02'> vào bảng CongNhan
insert into CongNhan values ('CN006', N'Lê Thị', N'Lan', 'Nữ', null,'TS02')
Select * from CongNhan

--------------THỦ TỤC & HÀM-------------
------------HÀM-------------
--a) Tính tổng số công nhân của một tổ sản xuất cho trước
alter function TongCN1To (@MaTSX char(4)) returns int
As
Begin
	declare @TongCN int
	if exists (select * from ToSanXuat where MaTSX = @MaTSX)
		if exists (select * from CongNhan where MaTSX = @MaTSX)
			begin
				select	@TongCN = COUNT(MaTSX)
				from	CongNhan a
				where	a.MaTSX = @MaTSX
			end
		else set @TongCN = 0
	else set @TongCN = -1
	return @TongCN
End
--Chạy thử hàm
--insert into ToSanXuat values ('TS03','To 3')
--delete from ToSanXuat where MaTSX = 'TS03'
print dbo.TongCN1To ('TS03')

--b) Tính tổng sản lượng sản xuất trong một tháng của một loại sản phẩm cho trước
alter function TongSanLuong1Thang (@MaSP char(5), @Thang int, @Nam int) returns int
As
Begin
	declare @SoLuong int
	if exists (select * from ThanhPham where MaSP = @MaSP and MONTH(Ngay) = @Thang and YEAR(Ngay) = @Nam)
		begin
			select @SoLuong = sum(a.SoLuong)
			from	ThanhPham a
			where	a.MaSP = @MaSP and MONTH(a.Ngay) = @Thang and YEAR(a.Ngay) = @Nam
		end
	else set @SoLuong = 0
	return @SoLuong
End
--Chạy thử hàm
print dbo.TongSanLuong1Thang ('SP001', 2, 2007)

--c) Tính tổng tiền công tháng của một công nhân cho trước
alter function TongTienCong (@MaCN char(5), @Thang int, @Nam int) returns int
As
Begin
	declare @TongTienCong int
	if exists (select * from ThanhPham where MACN = @MaCN and MONTH(Ngay) = @Thang and YEAR(Ngay) = @Nam)
		begin
			select @TongTienCong = sum(SoLuong * TienCong)
			from	SanPham a, ThanhPham b
			where	a.MaSP = b.MaSP and MONTH(b.Ngay) = @Thang and YEAR(b.Ngay) = @Nam and MACN = @MaCN
		end
	return @TongTienCong
End
--Chạy thử hàm
print dbo.TongTienCong ('CN001', 2, 2007)

--d) Tính tổng thu nhập trong năm của một tổ sản xuất cho trước
alter function TongThuNhap_TSX (@MaTSX char(4), @Nam int) returns int
As
Begin
	declare @TongThuNhap int
	if exists (select * from ToSanXuat where MaTSX = @MaTSX)
		begin
			select @TongThuNhap = sum(SoLuong * TienCong)
			from	CongNhan a, SanPham b, ThanhPham c
			where	a.MACN = c.MACN and b.MaSP = c.MaSP and a.MaTSX = @MaTSX and YEAR(Ngay) = @Nam
		end
	else set @TongThuNhap = 0
	return @TongThuNhap
End
--Chạy thử hàm
print dbo.TongThuNhap_TSX('TS01', 2007)

--e) Tính tổng sản lượng xuất của một loại sản phẩm trong một khoảng thời gian cho trước
alter function TongSanLuong_Xuat_1LoaiSP (@MaSP char(5), @bd datetime, @kt datetime) returns int
As
Begin
	declare @TongSanLuong int
	if exists (select * from ThanhPham where MaSP = @MaSP)
		begin
			select	@TongSanLuong = sum(SoLuong)
			from	ThanhPham
			where	MaSP = @MaSP and Ngay between @bd and @kt
		end
	else set @TongSanLuong = 0
	return	@TongSanLuong
End
--Chạy thử hàm
Set dateformat dmy
print dbo.TongSanLuong_Xuat_1LoaiSP('SP001', '03/01/2007', '15/02/2007')

------------THỦ TỤC-------------
--a) In danh sách các công nhân của một tổ sản xuất cho trước
create proc InDanhSachCongNhanCuaTSX @matsx char(4)
as
	if exists (Select * From ToSanXuat Where MaTSX = @matsx)
		Select * From CongNhan Where MaTSX = @matsx
	else
		print N'Không có tổ ' + @matsx + 'trong cơ sở dữ liệu.'
go
--Gọi thực hiện thủ tục
exec InDanhSachCongNhanCuaTSX 'TS01'

--b) In bảng chấm công sản xuất trong tháng của một công nhân cho trước(bao gồm Tên sản phẩm, đơn vị tính, số lượng sản xuất trong tháng, đơn giá, thành tiền)
--drop proc InBangChamCong_Thang 
create proc InBangChamCong_Thang @macn char(5), @thang int
As
	if exists (Select * From CongNhan Where MACN = @macn)
		begin
			select	TenSP as N'Tên sản phẩm', DVT, SUM(SoLuong) as SoLuongSX, TienCong, (SoLuong * TienCong) as Thanhtien
			from	SanPham sp, ThanhPham tp
			where	sp.MaSP = tp.MaSP and MONTH(Ngay) = @thang
			group by	TenSP, DVT, SoLuong, TienCong
		end
	else
		print N'Không có công nhân ' + @macn + N'trong cơ sở dữ liệu'
go
--Gọi thực hiện thủ tục 
exec InBangChamCong_Thang 'CN001', 1