/* 
	Học phần: Cơ sở dữ liệu 
	Bài thực hành: Lab07_QuanLySinhVien
	SV thực hiện: Đinh Lâm Gia Bảo
	MaSV: 2212343
	Thời gian: 04/04/2024
*/	
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
create database Lab07_QuanLySinhVien
go
use Lab07_QuanLySinhVien
go

-- Tạo bảng tỉnh
create table Tinh
(
	MSTinh	char(2) primary key,
	TenTinh	nvarchar(25) not null,
)
go

-- Tạo bảng khoa
create table Khoa
(
	MSKhoa	char(2) primary key,
	TenKhoa	nvarchar(30) not null,
	TenTat	varchar(5)
)
go

-- Tạo bảng lớp
create table Lop
(
	MSLop		char(4) primary key,
	TenLop		nvarchar(25) not null,
	MSKhoa		char(2) references Khoa(MSKhoa),
	NienKhoa	datetime
)
go

-- Tạo bảng sinh viên
create table SinhVien
(
	MSSV		char(7) primary key,
	Ho			nvarchar(30) not null,
	Ten			nvarchar(10) not null,
	NgaySinh	datetime,
	MSTinh		char(2) references Tinh(MSTinh),
	NgayNhapHoc	datetime not null,
	MSLop		char(4) references Lop(MSLop),
	Phai		varchar(3),
	DiaChi		nvarchar(50),
	DienThoai	varchar(10) 
)
go

-- Tạo bảng môn học
create table MonHoc
(
	MSMH	char(4) primary key,
	TenMH	nvarchar(30) not null,
	HeSo	real,
)
go

-- Tạo bảng bảng điểm
create table BangDiem
(
	MSSV	char(7) references SinhVien(MSSV),
	MSMH	char(4) references MonHoc(MSMH),
	LanThi	tinyint,
	Diem	real,
	primary key	(MSSV, MSMH, LanThi)
)
go

-- NHẬP BẢNG
-- Nhập bảng Tinh
insert into Tinh values ('01', N'An Giang')
insert into Tinh values ('02', N'TPHCM')
insert into Tinh values ('03', N'Dong Nai')
insert into Tinh values ('04', N'Long An')
insert into Tinh values ('05', N'Hue')
insert into Tinh values ('06', N'Cà Mau')

-- Nhập bảng Khoa
insert into Khoa values ('01', N'Công nghệ thông tin','CNTT')
insert into Khoa values ('02', N'Điện tử viễn thông','DTVT')
insert into Khoa values ('03', N'Quản trị kinh doanh','QTKD')
insert into Khoa values ('04', N'Công nghệ sinh học','CNSN')

-- Nhập bảng Lop
set dateformat ydm
go
insert into Lop values ('98TH', N'Tin hoc khoa 1998', '01', '1998')
insert into Lop values ('98VT', N'Vien thong khoa 1998', '02', '1998')
insert into Lop values ('99TH', N'Tin hoc khoa 1999', '01', '1999')
insert into Lop values ('99VT', N'Vien thong khoa 1999', '02', '1999')
insert into Lop values ('99QT', N'Quan tri khoa 1999', '03', '1999')

-- Nhập bảng SinhVien
set dateformat dmy
go
insert into SinhVien values ('98TH001',N'Nguyen Van',N'An','06/08/80','01','03/09/98','98TH','Yes',N'12 Tran Hung Dao,Q.1','8234512')
insert into SinhVien values ('98TH002',N'Le Thi',N'An','17/10/79','01','03/09/98','98TH','No',N'23 CMT8, Q. Tan Binh','0303234342')
insert into SinhVien values ('98VT001',N'Nguyen Duc',N'Binh','25/11/81','02','03/09/98','98VT','Yes',N'245 Lac Long Quan,Q.11','8654323')
insert into SinhVien values ('98VT002',N'Tran Ngoc',N'Anh','19/08/80','02','03/09/98','98VT','No',N'242 Tran Hung Dao,Q.1',' ')
insert into SinhVien values ('99TH001',N'Ly Van Hung',N'Dung','27/09/81','03','05/10/99','99TH','Yes',N'178 CMT8, Q. Tan Binh','7563213')
insert into SinhVien values ('99TH002',N'Van Minh',N'Hoang','01/01/81','04','05/10/99','99TH','Yes',N'272 Ly Thuong Kiet, Q.10','8341234')
insert into SinhVien values ('99TH003',N'Nguyen',N'Tuan','12/01/80','03','05/10/99','99TH','Yes',N'162 Tran Hung Dao, Q.5',' ')
insert into SinhVien values ('99TH004',N'Tran Van',N'Minh','25/06/81','04','05/10/99','99TH','Yes',N'147 Dien Bien Phu, Q.3','7236754')
insert into SinhVien values ('99TH005',N'Nguyen Thai',N'Minh','01/01/80','04','05/10/99','99TH','Yes',N'345 Le Dai Hanh, Q.11',' ')
insert into SinhVien values ('99VT001',N'Le Ngoc',N'Mai','21/06/82','01','05/10/99','99VT','No',N'129 Tran Hung Dao, Q.1','0903124534')
insert into SinhVien values ('99QT001',N'Nguyen Thi',N'Oanh','19/08/73','04','05/10/99','99QT','No',N'76 Hung Vuong, Q.5','0901656324')
insert into SinhVien values ('99QT002',N'Le My',N'Hanh','20/05/76','04','05/10/99','99QT','No',N'12 Pham Ngoc Thach, Q.3',' ')

-- Nhập bảng MonHoc
insert into MonHoc values ('TA01', N'Nhap mon tin hoc',2)
insert into MonHoc values ('TA02', N'Lap trinh cơ ban',3)
insert into MonHoc values ('TB01', N'Cau truc du lieu',2)
insert into MonHoc values ('TB02', N'Co so du lieu',2)
insert into MonHoc values ('QA01', N'Kinh te vi mo',2)
insert into MonHoc values ('QA02', N'Quan tri chat luong',3)
insert into MonHoc values ('VA01', N'Dien tu co ban',2)
insert into MonHoc values ('VA02', N'Mach so',3)
insert into MonHoc values ('VB01', N'Truyen so lieu',3)
insert into MonHoc values ('VB02', N'Vat ly dai cuong',2)

-- Nhập bảng BangDiem
insert into BangDiem values ('98TH001','TA01',1,8.5)
insert into BangDiem values ('98TH001','TA02',1,8)
insert into BangDiem values ('98TH002','TA01',1,4)
insert into BangDiem values ('98TH002','TA01',2,5.5)
insert into BangDiem values ('98TH001','TB01',1,7.5)
insert into BangDiem values ('98TH002','TB01',1,8)
insert into BangDiem values ('98VT001','VA01',1,4)
insert into BangDiem values ('98VT001','VA01',2,5)
insert into BangDiem values ('98VT002','VA02',1,7.5)
insert into BangDiem values ('99TH001','TA01',1,4)
insert into BangDiem values ('99TH001','TA01',2,6)
insert into BangDiem values ('99TH001','TB01',1,6.5)
insert into BangDiem values ('99TH002','TB01',1,10)
insert into BangDiem values ('99TH002','TB02',1,9)
insert into BangDiem values ('99TH003','TA02',1,7.5)
insert into BangDiem values ('99TH003','TB01',1,3)
insert into BangDiem values ('99TH003','TB01',2,6)
insert into BangDiem values ('99TH003','TB02',1,8)
insert into BangDiem values ('99TH004','TB02',1,2)
insert into BangDiem values ('99TH004','TB02',2,4)
insert into BangDiem values ('99TH004','TB02',3,3)
insert into BangDiem values ('99QT001','QA01',1,7)
insert into BangDiem values ('99QT001','QA02',1,6.5)
insert into BangDiem values ('99QT002','QA01',1,8.5)
insert into BangDiem values ('99QT002','QA02',1,9)

-- Xem bảng dữ liệu
select * from Tinh
select * from Khoa
select * from Lop
select * from SinhVien
select * from MonHoc
select * from BangDiem

----------------TRUY VẤN DỮ LIỆU-------------
--q1) Liệt kê MSSV, họ, tên, địa chỉ của tất cả các sinh viên
Select	MSSV, Ho, Ten, DiaChi
From	SinhVien

--q2) Liệt kê MSSV, Họ, Tên, MS Tỉnh của tất cả các sinh viên. Sắp xếp kết quả theo MStỉnh, trong cùng tinh sắp xếp theo họ tên của sinh viên.
Select		MSSV, Ho, Ten, MSTinh
From		SinhVien
Order by	MSTinh, Ho, ten asc

--q3) Liệt kê các sinh viên nữ của tỉnh Long An
Select	MSSV, Ho + ' ' + Ten as HoVaTen
From	SinhVien sv, Tinh t
Where	sv.MSTinh = t. MSTinh and Phai = 'No' and TenTinh = N'Long An'

--4) Liệt kê các sinh viên có sinh nhật trong tháng giêng.
Select	MSSV, Ho + ' ' + Ten as HoVaTen, NgaySinh
From	SinhVien
Where	MONTH(NgaySinh) = 1

--5) Liệt kê các sinh viên có sinh nhật nhằm ngày 1/1.
Select	MSSV, Ho + ' ' + Ten as HoVaTen, NgaySinh
From	SinhVien
Where	DAY(NgaySinh) = 1 and MONTH(NgaySinh) = 1

--6) Liệt kê các sinh viên có số điện thoại.
Select	MSSV, Ho + ' ' + Ten as HoVaTen, DienThoai
From	SinhVien
Where	DienThoai != ' '

--7) Liệt kê các sinh viên có số điện thoại di động.
Select	MSSV, Ho + ' ' + Ten as HoVaTen, DienThoai
From	SinhVien
Where	LEN(DienThoai) = 10

--8) Liệt kê các sinh viên tên 'Minh’ học lớp ’99TH’_
Select	MSSV, Ho + ' ' + Ten as HoVaTen, MSLop
From	SinhVien
Where	Ten = N'Minh' and MSLop = N'99TH'

--9) Liệt kê các sinh viên có địa chỉ ở đường 'Tran Hung Dao'
Select	MSSV, Ho + ' ' + Ten as HoVaTen, DiaChi
From	SinhVien
Where	SUBSTRING(DiaChi, 5, 13) = N'Tran Hung Dao' or SUBSTRING(DiaChi, 4, 13) = N'Tran Hung Dao'

--10) Liệt kê các sinh viên có tên lót chữ 'Van' (không liệt kê người họ *Van')
Select	MSSV, Ho + ' ' + Ten as HoVaTen
From	SinhVien
Where	RIGHT(Ho, 3) = N'Van'

--11) Liệt kê MSSV, Họ Ten (ghép họ và tên thành một cột), Tuổi của các sinh viên ở tinh .Long An.
Select	MSSV, Ho + ' ' + Ten as HoVaTen, DATEDIFF(dd,YEAR(NgaySinh),YEAR(NgayNhapHoc)) as Tuoi
From	SinhVien sv, Tinh t
Where	sv.MSTinh = t. MSTinh and TenTinh = N'Long An'

--12) Liệt kê các sinh viên nam từ 23 đến 28 tuổi.
Select	MSSV, Ho + ' ' + Ten as HoVaTen, DATEDIFF(dd,YEAR(NgaySinh),YEAR(NgayNhapHoc)) as Tuoi
From	SinhVien sv
Where	Phai = 'Yes' and DATEDIFF(dd,YEAR(NgaySinh),YEAR(NgayNhapHoc)) between 23 and 28

--13) Liệt kê các sinh viên nam từ 32 tuổi trở lên và các sinh viên nữ từ 27 tuổi trở lên.
Select	MSSV, Ho + ' ' + Ten as HoVaTen, DATEDIFF(dd,YEAR(NgaySinh),YEAR(NgayNhapHoc)) as Tuoi
From	SinhVien sv
Where	(Phai = 'Yes' and DATEDIFF(dd,YEAR(NgaySinh),YEAR(NgayNhapHoc)) >= 32)
		or (Phai = 'No' and DATEDIFF(dd,YEAR(NgaySinh),YEAR(NgayNhapHoc)) >= 27)

--14) Liệt kê các sinh viên khi nhập học còn dưới 18 tuổi, hoặc đã trên 25 tuổi.
Select	MSSV, Ho + ' ' + Ten as HoVaTen, DATEDIFF(dd,YEAR(NgaySinh),YEAR(NgayNhapHoc)) as Tuoi
From	SinhVien sv
Where	DATEDIFF(dd,YEAR(NgaySinh),YEAR(NgayNhapHoc)) <= 18 or DATEDIFF(dd,YEAR(NgaySinh),YEAR(NgayNhapHoc)) >= 25

--15) Liệt kê danh sách các sinh viên của khóa 99 (MSSV có 2 ký tự đầu là *99").
Select	MSSV, Ho + ' ' + Ten as HoVaTen
From	SinhVien 
Where	LEFT(MSSV, 2) = '99'

--16) Liệt kê MSSV, Điểm thi lần 1 môn ‘Co so du lieu’ của lớp ’99TH’
Select	sv.MSSV, Diem
From	SinhVien sv, MonHoc mh, BangDiem bd
Where	sv.MSSV = bd.MSSV and mh.MSMH = bd.MSMH and LanThi = 1 and TenMH = N'Co so du lieu' and MSLop = '99TH'

--17) Liệt kê MSSV, Họ tên của các sinh viên lớp ’99TH’ thi không đạt lần 1 môn *Co sodu lieu'
Select	sv.MSSV, Ho + ' ' + Ten as HoVaTen
From	SinhVien sv, MonHoc mh, BangDiem bd
Where	sv.MSSV = bd.MSSV and mh.MSMH = bd.MSMH and LanThi = 1 and TenMH = N'Co so du lieu' and MSLop = '99TH' and Diem < 5

--18) Liệt kê tất cả các điểm thi của sinh viên có mã số '99TH001’ theo mẫu sau: MSMH, Tên MH, Lần thi, Điểm
Select	mh.MSMH, TenMH, LanThi, Diem
From	MonHoc mh, BangDiem bd
Where	mh.MSMH = bd.MSMH and MSSV = '99TH001'

--19) Liệt kê MSSV, họ tên, MSLop của các sinh viên có điểm thi lần 1 môn ‘Co so du lieu' từ 8 điểm trở lên
Select	sv.MSSV, Ho + ' ' + Ten as HoTen, MSLop
From	SinhVien sv, MonHoc mh, BangDiem bd
Where	sv.MSSV = bd.MSSV and mh.MSMH = bd.MSMH and LanThi = 1 and TenMH = N'Co so du lieu' and Diem >=8

--20) Liệt kê các tỉnh không có sinh viên theo học
Select	*
From	Tinh t
Where	MSTinh Not In (
							Select	sv.MSTinh
							From	SinhVien sv
							Where	t.MSTinh = sv.MSTinh
						)

--21) Liệt kê các sinh viên hiện chưa có điểm môn thi nào.
Select	MSSV, Ho, Ten
From	SinhVien sv
Where	MSSV Not In (
						Select	sv.MSSV
						From	BangDiem bd
						where	sv.MSSV = bd.MSSV
					)

------------------- TRUY VẤN GOM NHOM -------------------
--22) Thống kê số lượng sinh viên ở môi lớp theo mẫu sau: MSLop, TenLop, SoLuongSV) 
Select		l.MSLop, TenLop, COUNT(sv.MSLop) as SoLuongSV
From		Lop l, SinhVien sv
Where		l.MSLop = sv.MSLop
Group by	l.MSLop, TenLop

--23) Thống kê số lượng sinh viên ở môi tỉnh  theo mẫu sau: MSTinh, Tên Tinh, Số SV Nam, Số SV Nữ, tổng cộng
Select		t.MSTinh, TenTinh, 
			SUM (CASE WHEN sv.Phai = 'Yes' then 1 else 0 end) as SoSVNam, 
			SUM (CASE WHEN sv.Phai = 'No' then 1 else 0 end) as SoSVNu ,
			COUNT(sv.MSTinh) as TongCong 
From		Tinh t, SinhVien sv
Where		t.MSTinh = sv.MSTinh
Group by	t.MSTinh, TenTinh

--24) Thống kê kết quả thi lần 1 môn 'Co so du lieu' ở các lớp, theo mẫu sau: MSLop | TenLOP | So SV đạt | Ti lệ đạt (%) | Số SV không đạt | Ti lệ không đat
Select		l.MSLop, TenLop,
			SUM (CASE WHEN	bd.LanThi = 1 and mh.TenMH = N'Co so du lieu' and bd.Diem >= 5 then 1 else 0 end) as SoSVDat,
			ROUND(SUM (CASE WHEN bd.LanThi = 1 and mh.TenMH = N'Co so du lieu' and bd.Diem >= 5 then 1 else 0 end)*100/COUNT(sv.MSSV),2) 
			as TiLeDat,
			SUM (CASE WHEN bd.LanThi = 1 and mh.TenMH = N'Co so du lieu' and bd.Diem < 5 then 1 else 0 end) as SoSVKhongDat,
			ROUND(SUM (CASE WHEN bd.LanThi = 1 and mh.TenMH = N'Co so du lieu' and bd.Diem < 5 then 1 else 0 end)*100/COUNT(sv.MSSV),2) 
			as TiLeKhongDat
From		Lop l, BangDiem bd, SinhVien sv, MonHoc mh
Where		sv.MSLop = l.MSLop and sv.MSSV = bd.MSSV and mh.MSMH = bd.MSMH
Group by	l.MSLop, TenLop

--25) Lọc ra điểm cao nhất trong các lần thi cho các sinh viên theo mẫu sau (điểm in ra của mỗi môn là điểm cao nhất trong các lần thi của môn đó)
--MSSV | MSMH | Tên MH | Hệ số | Điểm x hệ số
Select  sv.MSSV, bd.MSMH, mh.TenMH, mh.HeSo, MAX(bd.Diem) * mh.HeSo as Diemxheso
From	SinhVien sv, BangDiem bd, MonHoc mh
Where	sv.MSSV = bd.MSSV and bd.MSMH = mh.MSMH
Group by sv.MSSV, bd.MSMH, mh.TenMH, mh.HeSo

--26) Lập bảng tổng kết theo mẫu sau: MSSV | Họ | Tên | ĐTB. Trong đó: Điểm trungbình (ĐTB) = Tổng (điểm x hệ số) / Tổng hệ số
Select		sv.MSSV, Ho, Ten, ROUND(SUM(Diem * HeSo)/SUM(HeSo),2) as DTB
From		SinhVien sv, BangDiem bd, MonHoc mh
Where		sv.MSSV = bd.MSSV and mh.MSMH = bd.MSMH
Group by	sv.MSSV, Ho, Ten

--27) Thống kê số lượng sinh viên tỉnh 'Long An' đang theo học ở ở các khoa, theo mẫu sau:Năm học | MSKhoa | TenKhoa | Số lượng SV
Select		YEAR(NgayNhapHoc) as NamHoc, k.MSKhoa, TenKhoa, COUNT(sv.MSLop) as SoLuongSV
From		Tinh t, SinhVien sv, Lop l, Khoa k
Where		t.MSTinh = sv.MSTinh and sv.MSLop = l.MSLop and l.MSKhoa = k.MSKhoa and TenTinh = N'Long An'
Group by	k.MSKhoa, TenKhoa, NgayNhapHoc

------------------- HÀM VÀ THỦ TỤC -------------------
--28) Nhập vào MSSV, in ra bảng điểm của sinh viên đó theo mẫu sau (điểm in ra lấy điểm cao nhất trong các lần thi): 
-- MSMH | Tên MH | Hệ số | Điểm
-- Hàm tìm điểm cao nhất
create function fn_DiemCaoNhatCua1SV (@MSSV char(7), @MSMH char(4)) returns real
As
Begin
	declare	@max real
		select	@max = MAX(Diem)
		from	BangDiem
		where	MSSV = @MSSV and MSMH = @MSMH
	return  @max
End

-- Thủ tục in bảng điểm
create proc usp_InBangDiemCua1SV @MSSV char(7)
As
	if exists (select * from SinhVien where MSSV = @MSSV)
		begin
			if exists (select * from BangDiem where MSSV  = @MSSV)
				begin
					select	MSMH, TenMH, HeSo, dbo.fn_DiemCaoNhatCua1SV(@MSSV, MSMH) as Diem
					from	MonHoc 
					where	MSMH in (
										select	distinct MSMH
										from	BangDiem
										where	MSSV = @MSSV
									)
					end
			else
				print N'Sinh viên có mã số '+  @MSSV + N' không có điểm'
		end
	else
		print N'Sinh viên có mã số '+ @MSSV + N' không tồn tại trong cơ sở dữ liệu'
Go
--drop proc usp_InBangDiemCua1SV
exec usp_InBangDiemCua1SV '98TH002'
--29) Nhập vào 1 MS lớp, in ra bảng tổng kết của lớp đó, theo mẫu sau: MSSV | Ho | Tên | ĐTB | Xếp loại
--Câu này em chưa tìm được hướng làm ạ

------------------- CẬP NHẬT DỮ LIỆU -------------------
--30) Tạo bảng SinhVienTinh trong đó chứa hồ sơ của các sinh viên (lấy từ table Sinh Vien) có quê quán không phải ở TPHCM. 
--Thêm thuộc tính HBONG (học bổng) cho table SinhVienTinh.
create table SinhVienTinh
(
	MSSV		char(7) primary key,
	Ho			nvarchar(30) not null,
	Ten			nvarchar(10) not null,
	NgaySinh	datetime,
	MSTinh		char(2) references Tinh(MSTinh),
	NgayNhapHoc	datetime not null,
	MSLop		char(4) references Lop(MSLop),
	Phai		varchar(3),
	DiaChi		nvarchar(50),
	DienThoai	varchar(10), 
	HBong		int default 0 --đặt học bổng mặc định là 0
)
go

 -- Sao chép dữ liệu từ bảng SinhVien sang bảng SinhVienTinh
insert into SinhVienTinh (MSSV, Ho, Ten, NgaySinh, sv.MSTinh, NgayNhapHoc, MSLop, Phai, DiaChi, DienThoai)
select	MSSV, Ho, Ten, NgaySinh, sv.MSTinh, NgayNhapHoc, MSLop, Phai, DiaChi, DienThoai
from	SinhVien sv, Tinh t
where	sv.MSTinh = t.MSTinh and TenTinh <> 'TPHCM'

select * from SinhVienTinh
--31) Cập nhật thuộc tính HBONG trong table SinhVienThanh 10000 cho tất cả các sinh viên.
UPDATE  SinhVienTinh
set		HBong = 10000

select * from SinhVienTinh
--32) Tăng HBONG lên 10% cho các sinh viên nữ.
UPDATE	SinhVienTinh
set	HBong = HBong * 1.1
where	Phai = 'No'

select * from SinhVienTinh
--33) Xóa tất cả các sinh viên có quê quán ở Long An ra khỏi table SinhVienTinh
delete from SinhVienTinh
where		MSSV in (
						Select	sv.MSSV
						From	SinhVienTinh sv, Tinh t
						Where	sv.MSTinh = t.MSTinh and TenTinh = N'Long An'
					)
select * from SinhVienTinh