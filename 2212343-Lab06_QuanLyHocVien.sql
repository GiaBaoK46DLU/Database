/* 
	Học phần: Cơ sở dữ liệu 
	Bài thực hành: Lab06_QuanLyHocVien
	SV thực hiện: Đinh Lâm Gia Bảo
	MaSV: 2212343
	Thời gian: 04/04/2024
*/	
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
create database Lab06_QuanLyHocVien
go
use Lab06_QuanLyHocVien
go

--Tạo bảng ca học--
create table CaHoc
(Ca			tinyint primary key,
GioBatDau	Datetime,
GioKetThuc	Datetime
)
go

--Tạo bảng giáo viên--
create table GiaoVien
(MSGV		char(4) primary key,
HoGV		nvarchar(20),
TenGV		nvarchar(10),
DienThoai	varchar(11)
)
go

--Tạo bảng lớp--
create table Lop
(MaLop	char(4) primary key,
TenLop	nvarchar(30),
NgayKG	Datetime,
HocPhi	int,
Ca		tinyint references CaHoc(Ca),
SoTiet	int,
SoHV	int,
MSGV	char(4) references GiaoVien(MSGV)
)
go

--Tạo bảng học viên--
create table HocVien
(MSHV		char(6) primary key,
Ho			nvarchar(20),
Ten			nvarchar(10),
NgaySinh	Datetime,
Phai		nvarchar(4),
MaLop		char(4) references Lop(MaLop)
)
go

--Tạo bảng học phí--
create table HocPhi
(
SoBL	char(4) primary key,
MSHV	char(6) references HocVien(MSHV),
NgayThu Datetime,
SoTien	int,
NoiDung	nvarchar(50),
NguoiThu nvarchar(30)
)
go

----Xem các quan hệ--
select * from CaHoc
select * from GiaoVien
select * from Lop
select * from HocVien
select * from HocPhi

------------------CÀI ĐẶT RÀNG BUỘC TOÀN VẸN----------------
--4a) Giờ kết thúc của một ca học không được trước giờ bắt đầu ca học đó (RBTV liên thuộc tính)
Create trigger tr_CaHoc_ins_upd_GioBD_GioKT
On CaHoc  for insert, update
As
if  update(GioBatDau) or update (GioKetThuc)
	     if exists(select * from inserted i where i.GioKetThuc < i.GioBatDau)	
	      begin
	    	 raiserror (N'Giờ kết thúc ca học không thể nhỏ hơn giờ bắt đầu',15,1)--Thông báo lỗi cho người dùng
		     rollback tran	--Hủy thao tác gây ra vi phạm ràng buộc toàn vẹn & đưa CSDL về tình trạng trước khi thao tác
	      end
go	
-----Thử nghiệm hoạt động của trigger tr_CaHoc_ins_upd_GioBD_GioKT----
insert into CaHoc values(4,'16:40','20:00')

Update CaHoc set GioKetThuc = '5:45' where ca = 1
select * from CaHoc

--4b): Số học viên của 1 lớp không quá 30 và đúng bằng số học viên thuộc lớp đó (RBTV do thuộc tính tổng hợp)
create trigger trg_Lop_ins_upd
on Lop for insert, update
AS
if Update(MaLop) or Update(SoHV)
Begin
	if exists(select * from inserted i where i.SOHV > 30) 
	begin
		raiserror (N'Số học viên của một lớp không quá 30', 15, 1)--Thông báo lỗi cho người dùng
		rollback tran --hủy bỏ thao tác thêm lớp học
	end
	if exists (select * from inserted l 
	              where l.SOHV <> (select count(MSHV) 
									from HocVien 
									where HocVien.Malop = l.Malop))
	begin
		raiserror (N'Số học viên của một lớp không bằng số lượng học viên tại lớp đó', 15, 1)--Thông báo lỗi cho người dùng
		rollback tran --hủy bỏ thao tác thêm lớp học
	end
End
	
Go
-- Thử nghiệm 
select * from Lop
--
Set dateformat dmy
go
insert into Lop values('P001',N'Photoshop','1/11/2018',250000,1,100,0,'G004')--Thử nghiệm thêm lớp

update Lop set SoHV = 5 where MaLop = 'P001'--Thử nghiệm sửa sĩ số của lớp
--4b): Hãy Cài đặt trigger cho bảng HocVien
--Tự làm

--4b) Hãy thực hiện yêu cầu 4b bằng cách xây dựng các thủ tục thêm, xóa, sửa học viên kèm cập nhật SoHV trong bảng Lop
--Tự làm

--4c)Tổng số tiền thu của một học viên không vượt quá học phí của lớp mà học viên đó đăng ký học
create trigger tr_HVDongHocPhi
on	HocPhi	for	insert, update
as
	if UPDATE(SoTien) or UPDATE (MSHV)
	if exists(
				Select		HocPhi
				From		HocVien, inserted, Lop
				Where		HocVien.MSHV = inserted.MSHV and Lop.MaLop = HocVien.MaLop
				Group by	inserted.MSHV, Lop.HocPhi
				Having		HocPhi < ( Select SUM(SoTien)
									   From HocPhi hp
									   Where hp.MSHV = inserted.MSHV )
			  )
		begin
			raiserror (N'Số tiền thu của học viên đã vượt qua học phí của lớp', 15, 1)
			rollback tran
		end	
go
--drop trigger tr_HVDongHocPhi
exec usp_ThemHocPhi '0009','E11403','02/01/2008',80000,'HP Access 3-5-7', N'Vân'
exec usp_ThemHocPhi '0010','E11403','02/01/2008',40000,'HP Access 3-5-7', N'Vân'
exec usp_ThemHocPhi '0011','E11401','02/01/2008',1,'HP Access 3-5-7', N'Vân'

----------Tạo các thủ tục----------
----------XÂY DỰNG CÁC THỦ TỤC NHẬP DỮ LIỆU (Câu 5a) -------------
CREATE PROC usp_ThemCaHoc
	@ca tinyint, @giobd Datetime, @giokt Datetime
As
	If exists(select * from CaHoc where Ca = @ca) --kiểm tra có trùng khóa chính (Ca) 
		print N'Đã có ca học ' + @ca + N' trong CSDL!'
	Else
		begin
			insert into CaHoc values(@ca, @giobd, @giokt)
			print N'Thêm ca học thành công.'
		end
go
--Gọi thực hiện thủ tục usp_ThemCaHoc---
exec usp_ThemCaHoc 1,'7:30','10:45'
exec usp_ThemCaHoc 2,'13:30','16:45'
exec usp_ThemCaHoc 3,'17:30','20:45'

select * from CaHoc
---------------------
create proc usp_ThemGiaoVien
	@msgv char(4), @hogv nvarchar(20), @Tengv nvarchar(10),@dienthoai varchar(11)
As
	If exists(select * from GiaoVien where MSGV = @msgv) --kiểm tra có trùng khóa chính (MSGV) 
		print N'Đã có giáo viên có mã số ' +@msgv+ N' trong CSDL!'
	Else
		begin
			insert into GiaoVien values(@msgv, @hogv, @Tengv, @dienthoai)
			print N'Thêm giáo viên thành công.'
		end
go
--Gọi thực hiện thủ tục usp_ThemGiaoVien---
exec usp_ThemGiaoVien 'G001',N'Lê Hoàng',N'Anh', '858936'
exec usp_ThemGiaoVien 'G002',N'Nguyễn Ngọc',N'Lan', '845623'
exec usp_ThemGiaoVien 'G003',N'Trần Minh',N'Hùng', '823456'
exec usp_ThemGiaoVien 'G004',N'Võ Thanh',N'Trung', '841256'
---------------------
--Xem bảng GiaoVien
Select * from GiaoVien

--exec usp_ThemGiaoVien 'G004',N'Nguyễn Văn',N'Ngọc', '8212121'

create proc usp_ThemLopHoc
@malop char(4), @Tenlop nvarchar(20), 
@NgayKG datetime,@HocPhi int, @Ca tinyint, @sotiet int, @sohv int, 
@msgv char(4)
As
	If exists(select * from CaHoc where Ca = @Ca) and exists(select * from GiaoVien where MSGV=@msgv)--kiểm tra các RBTV khóa ngoại
	  Begin
		if exists(select * from Lop where MaLop = @malop) --kiểm tra có trùng khóa chính của quan hệ Lop 
			print N'Đã có lớp '+ @MaLop +' trong CSDL!'
		else	
			begin
				insert into Lop values(@malop, @Tenlop, @NgayKG, @HocPhi, @Ca, @sotiet, @sohv, @msgv)
				print N'Thêm lớp học thành công.'
			end
	  End
	Else -- Bị vi phạm ràng buộc khóa ngoại
		if not exists(select * from CaHoc where Ca = @Ca)
				print N'Không có ca học '+@Ca+' trong CSDL.'
		if not exists(select * from GiaoVien where MSGV=@msgv)
				print N'Không có giáo viên '+@msgv+' trong CSDL.'
go
--Gọi thực hiện thủ tục usp_ThemLopHoc---
set dateformat dmy
go
exec usp_ThemLopHoc 'A075',N'Access 2-4-6','18/12/2008', 150000,3,60,3,'G003'
exec usp_ThemLopHoc 'E114',N'Excel 3-5-7','02/01/2008', 120000,1,45,3,'G003'
exec usp_ThemLopHoc 'A115',N'Excel 2-4-6','22/01/2008', 120000,3,45,0,'G001'
exec usp_ThemLopHoc 'W123',N'Word 2-4-6','18/02/2008', 100000,3,30,1,'G001'
exec usp_ThemLopHoc 'W124',N'Word 3-5-7','01/03/2008', 100000,1,30,0,'G002'
--Xem bảng Lớp
Select * from Lop

----------------------
create proc usp_ThemHocVien
@MSHV char(6), @Ho nvarchar(20), @Ten nvarchar(10),
@NgaySinh Datetime, @Phai	nvarchar(4),@MaLop char(4)
As
	If exists(select * from Lop where MaLop = @MaLop) --kiểm tra có RBTV khóa ngoại
	  Begin
		if exists(select * from HocVien where MSHV = @MSHV) --kiểm tra có trùng khóa chính (MAHV) 
			print N'Đã có mã số học viên này trong CSDL!'
		else
			begin
				insert into HocVien values(@MSHV,@Ho, @Ten,@NgaySinh,@Phai,@MaLop)
				print N'Thêm học viên thành công.'
			end
	  End
	Else
		print N'Lớp '+ @MaLop + N' không tồn tại trong CSDL nên không thể thêm học viên vào lớp này!'	
go
--Gọi thực hiện thủ tục usp_ThemHocVien
set dateformat dmy
go
exec usp_ThemHocVien 'A07501',N'Lê Văn', N'Minh', '10/06/1988',N'Nam', 'A075'
exec usp_ThemHocVien 'A07502',N'Nguyễn Thị', N'Mai', '20/04/1988',N'Nữ', 'A075'
exec usp_ThemHocVien 'A07503',N'Lê Ngọc', N'Tuấn', '10/06/1984',N'Nam', 'A075'
exec usp_ThemHocVien 'E11401',N'Vương Tuấn', N'Vũ', '25/03/1979',N'Nam', 'E114'
exec usp_ThemHocVien 'E11402',N'Lý Ngọc', N'Hân', '01/12/1985',N'Nữ', 'E114'
exec usp_ThemHocVien 'E11403',N'Trần Mai', N'Linh', '04/06/1980',N'Nữ', 'E114'
exec usp_ThemHocVien 'W12301',N'Nguyễn Ngọc', N'Tuyết', '12/05/1986',N'Nữ', 'W123'

--Xem bảng HocVien
Select * from HocVien

----------------------------
create PROC usp_ThemHocPhi
@SoBL char(4),
@MSHV char(6),
@NgayThu Datetime,
@SoTien	int,
@NoiDung nvarchar(50),
@NguoiThu nvarchar(30)
As
	If exists(select * from HocVien where MSHV = @MSHV) --kiểm tra có RBTV khóa ngoại
	  Begin
		if exists(select * from HocPhi where SoBL = @SoBL) --kiểm tra có trùng khóa(SoBL) 
			print N'Đã có số biên lai học phí này trong CSDL!'
		else
		 begin
			insert into HocPhi values(@SoBL,@MSHV,@NgayThu, @SoTien, @NoiDung,@NguoiThu)
			print N'Thêm biên lai học phí thành công.'
		 end
	  End
	Else
		print N'Học viên '+ @MSHV + N' không tồn tại trong CSDL nên không thể thêm biên lai học phí của học viên này!'
go
--Gọi thực hiện thủ tục usp_ThemHocPhi
set dateformat dmy
go
exec usp_ThemHocPhi '0001','E11401','02/01/2008',120000,'HP Access 3-5-7', N'Vân'
exec usp_ThemHocPhi '0002','E11402','02/01/2008',120000,'HP Access 3-5-7', N'Vân'
exec usp_ThemHocPhi '0003','E11403','02/01/2008',80000,'HP Access 3-5-7', N'Vân'
exec usp_ThemHocPhi '0004','W12301','18/02/2008',100000,'HP Word 2-4-6', N'Lan'
exec usp_ThemHocPhi '0005','A07501','16/12/2008',150000,'HP Access 2-4-6', N'Lan'
exec usp_ThemHocPhi '0006','A07502','16/12/2008',100000,'HP Access 2-4-6', N'Lan'
exec usp_ThemHocPhi '0007','A07503','18/12/2008',150000,'HP Access 2-4-6', N'Vân'
exec usp_ThemHocPhi '0008','A07502','15/01/2009',50000,'HP Access 2-4-6', N'Vân'

select * from HocPhi

------------------XÂY DỰNG CÁC THỦ TỤC SỬA DỮ LIỆU----------
--5b) Cập nhật thông tin của một học viên cho trước
create proc usp_CapNhatHocVien
	@MaHV char(6) ,@Ho nvarchar(20), @Ten nvarchar(10), @NgaySinh datetime, @Phai nvarchar(3), @MaLop char(4)
as
	if exists (select * from HocVien where MSHV = @MaHV)
		begin
			if exists (select * from Lop where MaLop = @MaLop)
				begin
					update HocVien
					set	Ho = @Ho, 
						Ten = @Ten, 
						NgaySinh = @NgaySinh, 
						Phai = @Phai, 
						MaLop = @MaLop
					where	MSHV = @MaHV
				end
			else
				print N'Lớp có mã số '+ @MaLop + N' không tồn tại trong cơ sở dữu liệu'
		end
	else
		print N'Học viên có mã số '+ @MaHV + N' không tồn tại trong cơ sở dữ liệu'
go
--Gọi thực hiện thủ tục
exec usp_CapNhatHocVien 'W12301', 'Đinh Lâm Gia', 'Bảo', '26/07/2004', 'Nam', 'W123'
select * from HocVien
--5d) Cập nhật thông tin của một lớp học cho trước
create proc usp_CapNhatLop
	@MaLop char(4), @TenLop nvarchar(30), @NgayKG datetime, @HocPhi int, @Ca char(2), @SoTiet tinyint, @SoHV tinyint, @MSGV char(4)
as
	if exists (select * from Lop where MaLop = @MaLop)
		begin
			if exists (select * from CaHoc where Ca = @Ca)
				begin
					if exists (select * from GiaoVien where MSGV = @MSGV)
						begin
							update Lop
							set	TenLop = @TenLop,
								NgayKG = @NgayKG,
								HocPhi = @HocPhi,
								Ca = @Ca,
								SoTiet = @SoTiet,
								SoHV = @SoHV,
								MSGV = @MSGV
							where	MaLop = @MaLop
						end
					else
						print N'Không tồn tại giáo viên có mã số '+ @MSGV +N' trong cơ sở dữ liệu'
				end
			else
				print N'Không tồn tại ca có mã số '+ @Ca +N' trong cơ sở dữ liệu'
		end
	else
		print N'Không tồn tại lớp có mã số '+ @MaLop +N' trong cơ sở dữ liệu'
go
--Gọi thực hiện thủ tục
exec usp_CapNhatLop 'A075', 'Power Point 2-6', '01/01/2008', '130000', '1', '45', '3', 'G003'

------------------XÂY DỰNG CÁC THỦ TỤC XÓA DỮ LIỆU----------
--5c) Xóa một học viên cho trước
create proc usp_XoaHV	@MSHV char(6)
as
	if exists (select * from HocVien where MSHV = @MSHV)
		begin
			delete from HocVien
			where	MSHV = @MSHV
			update Lop set SoHV = SoHV - 1
			print N'Đã xóa thành công'
		end
	else
		print N'Học viên có mã số'+ @MSHV + N' không có trong cơ sở dữu liệu'
go
--Gọi thực hiện thủ tục 
exec usp_XoaHV 'W12309'

--5e) Xóa một lớp học cho trước nếu lớp học này không có học viên
create proc usp_XoaLopNeuKhongCoHV @Malop char(4)
as
	if exists (select * from Lop where MaLop = @Malop)
		begin
			if not exists (select * from HocVien where MaLop = @Malop)
				begin
					delete from Lop
					where	MaLop = @Malop
				end
			else
				print N'Lớp có học viên, không thể xóa'
		end
	else
		print N'Không có lớp trong cơ sở dữu liệu'
go
--Gọi thực hiện thủ tục 
exec usp_XoaLopNeuKhongCoHV 'W124'

--5f)  Thủ tục lập danh sách học viên của một lớp cho trước. 
Create Proc usp_InDSLop @malop char(4)
As
If exists (Select * from Lop where Malop=@malop)
	Select * From HocVien Where Malop = @malop
Else 
	print N'Không có lớp ' + @malop +' trong CSDL.'
Go

--Gọi thực hiện thủ tục 
exec usp_InDSLop 'E114'

----5f)  Hàm lập danh sách học viên của một lớp cho trước. 
Create Function fn_InDSLop (@malop char(4)) returns Table
As
return (
		Select * 
		From HocVien 
		Where Malop = @malop
		)
Go
--Gọi thực hiện hàm
Select * From fn_InDSLop('E114')

--5g) Thủ tục lập danh sách học viên chưa đóng đủ học phí của một lớp cho trước
--Câu này em chưa tìm được hướng làm ạ

--------------------HÀM CẤP MÃ TỰ ĐỘNG & CÁCH SỬ DỤNG----------------
--1. Viết hàm cấp mã cho giáo viên mới theo quy tắc lấy mã lớn nhất hiện có sau đó tăng thêm 1 đơn vị
create function CapMaGV() returns char(4)
As
Begin
	declare @MaxMaGV char(4)
	declare @NewMaGV varchar(4)
	declare @stt	int
	declare @i	int	
	declare @sokyso	int

	if exists(select * from GiaoVien)---Nếu bảng giáo viên có dữ liệu
	 begin
		--Lấy mã giáo viên lớn nhất hiện có
		select @MaxMaGV = max(MSGV) 
		from GiaoVien

		--Trích phần ký số của mã lớn nhất và chuyển thành số 
		set @stt=convert(int, right(@MaxMaGV,3)) + 1 --Số thứ tự của giáo viên mới
	 end
	else --Nếu bảng giáo viên đang rỗng (nghĩa là chưa có giáo viên nào được lưu trữ trong CSDL)
	 set @stt= 1  --Số thứ tự của giáo viên trong trường hợp chưa có gv nào trong CSDL
	
	--Kiểm tra và bổ sung chữ số 0 để đủ 3 ký số trong mã gv
	set @sokyso = len(convert(varchar(3), @stt))
	set @NewMaGV='G'
	set @i = 0
	while @i < 3 -@sokyso
		begin
			set @NewMaGV = @NewMaGV + '0'
			set @i = @i + 1
		end	
	set @NewMaGV = @NewMaGV + convert(varchar(3), @stt)

return @NewMaGV	
End
--Thử hàm sinh mã
select * from GiaoVien
print dbo.CapMaGV()

--2) Thủ tục thêm giáo viên với mã giáo viên được cấp tự động----
CREATE PROC usp_ThemGiaoVien2
@hogv nvarchar(20), @tengv nvarchar(10), @dthoai varchar(10)
As
	declare @Magv char(4)
	
 if not exists(select * from GiaoVien 
				where HoGV = @hogv and TenGV = @tengv and DienThoai = @dthoai)
	Begin
		
		--sinh mã cho giáo viên mới
		set @Magv = dbo.CapMaGV()
		insert into GiaoVien values(@Magv, @hogv, @tengv,@dthoai)
		print N'Đã thêm giáo viên thành công'
	End
else
	print N'Đã có giáo viên ' + @hogv +' ' + @tengv + ' trong CSDL'
Go
---Sử dụng thủ tục thêm giáo viên
exec usp_ThemGiaoVien2 N'Trần Ngọc Bảo', N'Hân', '0123456789'
exec usp_ThemGiaoVien2 N'Vũ Minh', N'Triết', '0123456788'
select * from GiaoVien

------Cài đặt các hàm (câu 6)------
--6a) Hàm tính tổng số học phí đã thu được của một lớp khi biết mã lớp. 
create function fn_TongHocPhi1Lop(@malop char(4)) returns int
As
Begin
	declare @TongTien int
	if exists (select * from Lop where MaLop = @MaLop) ---Nếu tồn tại lớp @malop trong CSDL
		Begin
		--Tính tổng số học phí thu được trên 1 lớp
		select @TongTien = sum(SoTien)
		from	HocPhi A, HocVien B	
		where	A.MSHV = B.MSHV and B.Malop = @malop
		End	
	 	
return @TongTien
End
--- thử nghiệm hàm-------
print dbo.fn_TongHocPhi1Lop('A075')

--6b) Hàm tính tổng số học phí thu được trong một khoảng thời gian cho trước. 
create function fn_TongHocPhi(@bd datetime,@kt datetime) returns int
As
Begin
	declare @TongTien int
	--Tính tổng số học phí thu được trong khoảng thời gian từ bắt đầu đến kết thúc
	select @TongTien = sum(SoTien)
	from	HocPhi 	
	where	NgayThu between @bd and @kt
return @TongTien
End
--- thu nghiem ham-------
set dateformat dmy
print dbo.fn_TongHocPhi('1/1/2008','15/1/2008')

--6c) Cho biết một học viên cho trước đã nộp đủ học phí hay chưa. 
create function fn_KiemTraNopHocPhi (@mshv char(6)) returns bit
As
Begin
	declare @KetQua bit 
	if exists ( select  l.MaLop
				from Lop l, HocVien hv
				where l.MaLop = hv.MaLop and MSHV = @mshv
				group by l.MaLop, l.HocPhi
				having HocPhi = (select sum(SoTien)
								 from HocPhi hp
								 where MSHV = @mshv
								 group by MSHV))
		set @KetQua = 1 
	else 
		set @KetQua = 0
	return @KetQua
End
--drop funtion fn_KiemTraNopHocPhi
print dbo.fn_KiemTraNopHocPhi ('E11403')
print dbo.fn_KiemTraNopHocPhi ('A07502')

--6d) Hàm sinh mã số học viên theo quy tắc mã số học viên gồm mã lớp của học viên kết hợp với số thứ tự của học viên trong lớp đó. 
create function fn_SinhMSHV (@malop char (4)) returns char (6)
As
Begin
	declare @MSHV char(6)
	--select top 1 @MSHV = MSHV
	--from HocVien
	--where MaLop = @malop
	--order by MSHV desc 
	select @MSHV = max(MSHV)
	from HocVien

	declare @STT int
	--set @STT = cast (RIGHT (@MSHV, 2) as int)
	set @STT = convert (int, RIGHT (@MSHV, 2))
	set @STT = @STT + 1
	set @MSHV = concat(@malop, format(@STT,'0#'))
	return @MSHV
End
--drop function fn_SinhMSHV
print dbo.fn_SinhMSHV ('A075')
print dbo.fn_SinhMSHV ('W123')
