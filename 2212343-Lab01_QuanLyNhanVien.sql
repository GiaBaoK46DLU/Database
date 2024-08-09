/*	Học phần: Cơ sở dữ liệu
	Bài thực hành: Lab01_QLNV
	SV thực hiện: Đinh Lâm Gia Bảo
	Mã SV:		2212343
	Thời gian: 04/03/2024 - ngày kết thúc điền sau
*/
----------------------------------------------------
-------TẠO CƠ SỞ DỮ LIỆU-------------
create database Lab01_QuanLyNhanVien
go
use Lab01_QuanLyNhanVien --sử dụng CSDL 
------Tạo bảng chi nhánh-------
Create table ChiNhanh
(MSCN char(2) primary key,
TenCN nvarchar(30) not null unique
)
go
--lệnh tạo bảng NhanVien
create table NhanVien
(MaNV char(4) primary key,
Ho	nvarchar(20) not null,
Ten nvarchar(10) not null,
NgaySinh datetime not null,
NgayVaoLam datetime not null,
MSCN char(2) references ChiNhanh(MSCN) --Khai báo MSCN là khóa ngoại tham chiếu đến MSCN của ChiNhanh
)
go
------Tạo bảng KyNang-------
Create table KyNang
(MSKN char(2) primary key,
TenKN nvarchar(30) not null unique
)
--Xóa bảng Bị lỗi
--drop table KyNaang
go
---Tạo bảng NhanVienKyNang
Create table NhanVienKyNang
(MaNV char(4) references NhanVien(MaNV),
MSKN char(2) references KyNang(MSKN),
MucDo tinyint check (MucDo>=1 and MucDo<=9),
Primary key (MaNV, MSKN)--khai báo khóa chính gồm nhiều thuộc tính
)
-----------Xem các quan hệ------
Select * from ChiNhanh
Select * from NhanVien
Select * from KyNang
Select * from NhanVienKyNang
--------------------NHẬP DỮ LIỆU VÀO CÁC QUAN HỆ---------
--Nhập bảng ChiNhanh
insert into ChiNhanh values('01', N'Quận 1')
insert into ChiNhanh values('02', N'Quận 5')
insert into ChiNhanh values('03', N'Bình Thạnh')
--xem bảng ChiNhanh
Select * from ChiNhanh
--Nhập bảng NhanVien
set dateformat dmy --báo với SQL Server nhập ngày tháng theo kiểu ngày/tháng/năm
go
insert into Nhanvien values('0001', N'Lê Văn', N'Minh', '10/06/1960', '02/05/1986','01')
insert into Nhanvien values('0002', N'Nguyễn Thị', N'Mai', '20/04/1970', '04/07/2001','01')
insert into NhanVien values('0003',N'Lê Anh',N'Tuấn','25/06/1975','01/09/1982','02')
insert into NhanVien values('0004',N'Vương Tuấn',N'Vũ','25/03/1960','12/01/1986','02')
insert into NhanVien values('0005',N'Lý Anh',N'Hân','01/12/1980','15/05/2004','02')
insert into NhanVien values('0006',N'Phan Lê',N'Tuấn','04/06/1976','25/10/2002','03')
insert into NhanVien values('0007',N'Lê Tuấn',N'Tú','15/08/1975','15/08/2000','03')
--xem bảng ChiNhanh
Select * from NhanVien
--Nhap bang Kynang
insert into KyNang values('01',N'Word')
insert into KyNang values('02',N'Excel')
insert into KyNang values('03',N'Access')
insert into KyNang values('04',N'Power Point')
insert into KyNang values('05','SPSS')
--xem bảng KyNang
select * from KyNang
--nhap bang nhanvienkynang
insert into NhanVienKyNang values('0001','01',2)
insert into NhanVienKyNang values('0001','02',1)
insert into NhanVienKyNang values('0002','01',2)
insert into NhanVienKyNang values('0002','03',2)
insert into NhanVienKyNang values('0003','02',1)
insert into NhanVienKyNang values('0003','03',2)
insert into NhanVienKyNang values('0004','01',5)
insert into NhanVienKyNang values('0004','02',4)
insert into NhanVienKyNang values('0004','03',1)
insert into NhanVienKyNang values('0005','02',4)
insert into NhanVienKyNang values('0005','04',4)
insert into NhanVienKyNang values('0006','05',4)
insert into NhanVienKyNang values('0006','02',4)
insert into NhanVienKyNang values('0006','03',2)
insert into NhanVienKyNang values('0007','03',4)
insert into NhanVienKyNang values('0007','04',3)
--xem bang NhanVienKyNang
select * from NhanVienKyNang
----------------TRUY VẤN DỮ LIỆU-------------
--q1: lập danh sách các nhân viên làm việc tại chi nhánh có mã số chi nhánh 03
Select	*
From	NhanVien
Where	MSCN = '03'
--q2: Cho biết các nhân viên sinh sau năm 1975
Select	*
From	NhanVien
Where	year(NgaySinh) > 1975
--q3: Lập danh sách các nhân viên có họ Lê
--Cách 1
Select *
From NhanVien
Where left(Ho,2) = N'Lê'
--Cách 2: sử dụng toán tử like và ký tự đại diện
Select *
From NhanVien
Where Ho like N'Lê%'
--q4: cho biết các nhân viên làm việc tại chi nhánh '02' vào làm sau năm 1980
Select *
From NhanVien
Where mscn='02' and year(NgayVaolam) > 1980
--q5: Cho biết các thông tin sau của nhân viên: manv, ho, ten, mscn, ngayvaolam
Select MaNV, Ho, Ten, MSCN, NgayVaoLam
From NhanVien
--q5: Cho biết các thông tin sau của nhân viên: manv, họ và tên, mscn, ngayvaolam (sử dụng phép chiết mở rộng)
Select MaNV, Ho +' '+ Ten as HoTen, MSCN, convert(char(10),NgayVaoLam, 105) as NgayVaoLam
From NhanVien
--q6: Cho biết các thông tin sau của nhân viên: manv, ho và tên, tuổi, mscn, số năm làm việc
Select	MaNV, Ho+' '+ Ten As HoTen, year(getdate())-year(NgaySinh) as Tuoi, MSCN,
		year(getdate())-year(NgayVaoLam) as SoNamLV
From	NhanVien
--q7: Cho biết các thông tin sau của nhân viên làm việc tại chi nhánh '02': manv, họ và tên, tuổi, số năm làm việc
Select	MaNV, Ho+' '+ Ten As HoTen, year(getdate())-year(NgaySinh) as Tuoi, 
		year(getdate())-year(NgayVaoLam) as SoNamLV
From	NhanVien
Where	mscn = '02'
--Phép tích
Select *
From NhanVien, ChiNhanh
Order by MaNV
--Phép kết | nối
Select *
From NhanVien, ChiNhanh
Where NhanVien.MSCN = ChiNhanh.MSCN
--Q1b) Liệt kê các thông tin về nhân viên: HoTen, NgaySinh, NgayVaoLam, TenCN (sắp xếp theo tên chi nhánh).
Select	Ho+' '+Ten as HoTen, convert(char(10), NgaySinh, 103) as NgaySinh, convert(char(10), NgayVaoLam, 103) as NgayVL, TenCN
From	NhanVien, ChiNhanh
Where	NhanVien.MSCN = ChiNhanh.MSCN
Order by TenCN, Ten, Ho
--Q1c) Liệt kê các nhân viên sử dụng được 'Word' gồm các thông tin: HoTen, TenKN, MucDo.
Select	Ho+' '+Ten As HoTen, TenKN, MucDo
From	NhanVien, NhanVienKyNang, KyNang
Where	NhanVien.MaNV = NhanVienKyNang.MaNV and NhanVienKyNang.MSKN = KyNang.MSKN 
		and TenKN ='Word'
--Q1d)  Liệt kê các kỹ năng (TenKN, MucDo) mà nhân viên Lê Anh Tuấn biết sử dụng. 
Select	TenKn, MucDo
From	NhanVien A, NhanVienKyNang B, KyNang C ---A, B, C được gọi là bí danh (alias)
--Where	A.MaNV = B.MaNV and B.MSKN = C.MSKN and Ho = N'Lê Anh' and Ten =N'Tuấn' 
Where	A.MaNV = B.MaNV and B.MSKN = C.MSKN and Ho +' '+Ten = N'Lê Anh Tuấn'

------Truy vấn gom nhóm và hàm kết hợp----
--Q3a) Với mỗi chi nhánh cho biết TenCN và số nhân viên làm việc tại chi nhánh đó
Select	TenCN, count(MaNV) As SoNV
From	NhanVien A, ChiNhanh B
Where	A.MSCN = B.MSCN
Group by TenCN
--Q3b) Với mỗi kỹ năng, hãy cho biết TenKN, SoNguoiDung (số nhân viên biết sử dụng kỹ năng đó)
Select		TenKN, count(MaNV) As SoNguoiDung
From		NhanVienKyNang A, KyNang B
Where		A.MSKN = B.MSKN
Group By	TenKN

--Q3c)Cho biết TenKN có từ 3 nhân viên trong công ty sử dụng trở lên. 
Select		TenKN, count(MaNV) As SoNguoiDung
From		NhanVienKyNang A, KyNang B
Where		A.MSKN = B.MSKN
Group By	TenKN
Having		count(MaNV) >=3 

----Truy vấn có sử dụng hàm kết hợp nhưng không có mệnh đề Group by
--Cho biết số lượng nhân viên của công ty
Select count(MaNV)
From NhanVien

/*Q3f) Với mỗi nhân viên, hãy cho biết số kỹ năng tin học mà nhân viên đó sử dụng được. 
Các thông tin cần hiển thị gồm: mã nhân viên, họ tên, tên chi nhánh làm việc và số kỹ năng */
Select	B.MaNV, Ho+' '+ Ten as HoTen, TenCN, COUNT(MSKN) As SoKyNang
From	ChiNhanh A, NhanVien B, NhanVienKyNang C 
Where	A.MSCN = B.MSCN and B.MaNV = C.MaNV
Group by	B.MaNV, Ho, Ten, TenCN
Order by	Ten, Ho
-----------Truy vấn lồng nhau-----------------
--Q2b)Liệt kê MANV, HoTen, TenCN của các nhân viên vừa biết 'Word' vừa biết 'Excel' (Phép giao)
Select	B.MaNV, Ho+' '+Ten as HoTen, TenCN
From	ChiNhanh A, NhanVien B, NhanVienKyNang C, KyNang D
Where	A.MSCN = B.MSCN and B.MaNV = C.MaNV and C.MSKN = D.MSKN and TenKN = 'Excel'
		and B.MaNV In (	Select	E.MaNV
						From	NhanVienKyNang E, KyNang F
						Where	E.MSKN = F.MSKN and TenKN = 'Word'
						)
--q8) Cho biết các nhân viên không sử dụng được 'Access' (Phép hiệu)
--cách 1:
Select *
From NhanVien
Where	MaNV Not In (	Select A.MaNV
						From NhanVienKyNang A, KyNang B
						Where	A.MSKN = B.MSKN and TenKN = 'Access')

--cách 2: Sử dụng phép nối ngoài
Select	NhanVien.*
From	NhanVien left join (Select A.MaNV
						From NhanVienKyNang A, KyNang B
						Where	A.MSKN = B.MSKN and TenKN = 'Access') as NVDungAccess
	on NhanVien.MaNV = NVDungAccess.MaNV
Where	NVDungAccess.MaNV is Null


--q9) Cho biết các nhân viên sử dụng được mọi kỹ năng	(Phép chia)
Select	B.MaNV, Ho+' '+ Ten as HoTen, TenCN, COUNT(MSKN) As SoKyNang
From	ChiNhanh A, NhanVien B, NhanVienKyNang C 
Where	A.MSCN = B.MSCN and B.MaNV = C.MaNV
Group by	B.MaNV, Ho, Ten, TenCN
Having		count(MSKN) = (	Select count(*)
							From	KyNang
						  )
--Thêm dữ liệu để thử nghiệm phép chia
insert into NhanVienKyNang values('0004','04',3)
insert into NhanVienKyNang values('0004','05',3)

--Q2d) Liệt kê các chi nhánh (MSCN, TenCN) mà mọi nhân viên trong chi nhánh đó đều biết 'Word'.
--Phép chia (= truy vấn lồng tương quan)
Select	A.MSCN, TenCN, count(C.MaNV) as SoNVDungWord
From	ChiNhanh A, NhanVien B, NhanVienKyNang C, KyNang D
Where	A.MSCN = B.MSCN and B.MaNV = C.MaNV and C.MSKN = D.MSKN and TenKN = 'Word'
Group by	A.MSCN, TenCN
Having	count(C.MaNV) = (	Select	count(E.MaNV)
							From	NhanVien E	
							Where	E.MSCN = A.MSCN
						)
-------Bài toán MIN | MAX
--Q2a)  Liệt kê MANV, HoTen, MSCN, TenCN của các nhân viên có mức độ thành thạo về 'Excel' cao nhất trong công ty.  
--Cách 1:
Select	B.MaNV, Ho+' '+Ten as HoTen, A.MSCN, TenCN, TenKn, MucDo
From	ChiNhanh A, NhanVien B, NhanVienKyNang C, KyNang D
Where	A.MSCN = B.MSCN and B.MaNV = C.MaNV and C.MSKN = D.MSKN and TenKN = 'Excel'
		and C.MucDo = ( Select	max(E.MucDo)
						From	NhanVienKyNang E, KyNang F
						Where	E.MSKN = F.MSKN and TenKN ='Excel')
--Cách 2:
Select	B.MaNV, Ho+' '+Ten as HoTen, A.MSCN, TenCN, TenKn, MucDo
From	ChiNhanh A, NhanVien B, NhanVienKyNang C, KyNang D
Where	A.MSCN = B.MSCN and B.MaNV = C.MaNV and C.MSKN = D.MSKN and TenKN = 'Excel'
		and C.MucDo >=all ( Select	E.MucDo
						From	NhanVienKyNang E, KyNang F
						Where	E.MSKN = F.MSKN and TenKN ='Excel')

--Q2c) Với từng kỹ năng, hãy liệt kê các thông tin (MANV, HoTen, TenCN, TenKN, MucDo) của những nhân viên thành thạo kỹ năng đó nhất. 
Select	TenKN, B.MaNV, Ho+' '+Ten as HoTen, A.MSCN, TenCN, MucDo
From	ChiNhanh A, NhanVien B, NhanVienKyNang C, KyNang D
Where	A.MSCN = B.MSCN and B.MaNV = C.MaNV and C.MSKN = D.MSKN 
		and C.MucDo = ( Select	max(E.MucDo)
						From	NhanVienKyNang E
						Where	E.MSKN = D.MSKN )
Order by TenKN
--Q3e) Cho biết TenCN có ít nhân viên nhất. 
Select	A.MSCN, TenCN, count(MaNV) As SoNV
From	ChiNhanh A, NhanVien B
Where	A.MSCN = B.MSCN
Group by	A.MSCN, TenCN
Having	count(MaNV) <=all (Select count(MaNV)
							From NhanVien
							Group by	MSCN)
---Cập nhật dữ liệu
--4a) 
insert into KyNang values('06', 'Photoshop')
--4b)
insert into NhanVienKyNang values('0001','06',3)
insert into NhanVienKyNang values('0005','06',2)
--4c) Cập nhật các nhân viên sử dụng Word mức độ thành thạo tăng 1 bậc
Update	NhanVienKyNang
set		MucDo = MucDo+1
Where	MSKN ='01'
--xem kết quả cập nhật
Select * from NhanVienKyNang
where MSKN = '01'
--4d) Tạo bảng mới NhanVienChiNhanh1(MANV, HoTen, SoKyNang)
Create table NhanVienCN1
(MaNV char(4) primary key,
HoTen nvarchar(30) not null,
SoKyNang tinyint
)

--Xem bảng NhanVienCN1
Select * from NhanVienCN1
--4d) Thêm vào bảng trên các thông tin như đã liệt kê của các nhân viên thuộc chi nhánh 1 (dùng câu lệnh Insert Into cho nhiều bộ).
Insert into NhanVienCN1(MaNV, HoTen, SoKyNang)
Select	NhanVien.MaNV, Ho +' '+ Ten as HoTen, COUNT(MSKN)
From	NhanVien, NhanVienKyNang
Where	NhanVien.MaNV = NhanVienKyNang.MaNV and MSCN = '01'
Group by	NhanVien.MaNV, Ho, Ten