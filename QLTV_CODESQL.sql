DROP DATABASE QLTV;
CREATE DATABASE QLTV;
use qltv;
create table PHANQUYEN(
	MAPQ char(6) primary key not null,
    TENQUYEN varchar(20),
    TONTAI boolean
);
create table LOAISACH(
	MALOAI char(6) primary key not null,
	TENLOAI varchar(30) not null,
	TONTAI boolean
);
create table TACGIA(
	MATG char(6) primary key not null,
	TENTG varchar(50) not null,
	PHAI varchar(10) not null CHECK (PHAI IN('NAM','NU')),
	NGAYSINH date,
	TONTAI boolean
);
create table NHAXUATBAN(
	MANXB char(6) primary key not null,
	TENNXB varchar(50) not null,
	TONTAI boolean
);
create table SACH(
	MASA char(6) not null,
	TENSA varchar(50) not null,
	TT varchar(30) not null,
	SOTRANG smallint  not null,
	SOLUONG smallint,
	gia float,
	SA_MALOAI char(6),
	MATG char(6),
	MANXB char(6),
    MA_ANH char(5),
    primary key (MASA, MA_ANH),
	constraint kn_ml FOREIGN KEY (SA_MALOAI) REFERENCES  LOAISACH(MALOAI),
	constraint kn_mtg foreign key(MATG) references TACGIA(MATG),
	constraint kn_nxb foreign key(MANXB) references NHAXUATBAN(MANXB),
	TONTAI boolean

);
	create table DOCGIA(
	MADG char(6)primary key not null,
	TENDG varchar(50) not null,
	PHAI varchar(10) not null CHECK (PHAI IN('NAM','NU')),
	NGAYSINH date,
	SDT char(10),
	DIACHI varchar(50),
    MAPQ char(6),
    foreign key(MAPQ) references PHANQUYEN(MAPQ),
	TONTAI boolean
);
create table NHANVIEN(
	MANV char(6) primary key not null,
	TENNV varchar(50) not null,
	PHAI varchar(10) not null CHECK (PHAI IN('NAM','NU')),
	NGAYSINH date,
	CCCD char(12),
	SDT char(10),
	DIACHI varchar(50),
    MAPQ char(6),
    foreign key(MAPQ) references PHANQUYEN(MAPQ),
	TONTAI boolean
);
create table PHIEUMUON(
	MAPHIEU char(10) not null,
	MADG char(6),
	MASA char(6),
	MANV char(6),
	NGAYMUON date,
	HANTRA date,
	foreign key(MADG) references DOCGIA(MADG),
	foreign key(MASA) references SACH(MASA),
	foreign key(MANV) references NHANVIEN(MANV),
    PRIMARY KEY (MADG,MASA,MANV,HANTRA),
	SOLUONG smallint,
	TONTAI boolean
);
create table TAIKHOAN(
	TENDN varchar(20) primary key not null,
	MATKHAU varchar(20) not null,
    MAPQ char(6),
    foreign key (MAPQ) references PHANQUYEN(MAPQ),
	TONTAI boolean
);
create table THETHUVIEN(
	MATHE char(10) primary key not null,
	NGAYCAP date,
	HSD date,
	MADG char (6),
	MANV char(6),
	foreign key(MADG) references DOCGIA(MADG),
	foreign key (MANV) references NHANVIEN(MANV),
	TONTAI boolean
);
create table PHIEUTRA(
	MAPHIEU char(10) PRIMARY KEY not null,
	MADG char(6),
	MASA char(6),
	MANV char(6),
    HANTRA date,
	NGAYTRA DATE,
    SOLUONG smallint,
	foreign key(MADG,MASA,MANV,HANTRA) references phieumuon(MADG,MASA,MANV,HANTRA),
	TINHTRANG varchar(50),
	SONGAYQUAHAN smallint,
	TONTAI boolean
);
CREATE TABLE ANH_DG (
    MA_ANH CHAR(5) NOT NULL,
    MADG CHAR(6) NOT NULL,
    FOREIGN KEY (MADG)
        REFERENCES docgia (MADG),
    PRIMARY KEY (MA_ANH , MADG)
);

create table ANH_NV(
	MA_ANH char(5) not null,
    MANV char(6) not null,
    foreign key(MANV) references nhanvien(MANV),
    primary key(MA_ANH,MANV)
);
create table ANH_SA(
    MASA char(6) not null,
    MA_ANH char(5) not null,
	primary key(MASA,MA_ANH),
    foreign key(MASA) references SACH(MASA)
    -- foreign key(MA_ANH) references SACH(MA_ANH)
   
);
insert into PHANQUYEN(MAPQ,TENQUYEN,TONTAI) values
('QL0000','QUẢN LÝ 1',1),
('TT0000','THỦ THƯ 1',1),
('TT0001','THỦ THƯ 2',1),
('TT0002','THỦ THƯ 3',1),
('TT0003','THỦ THƯ 4',1),
('DG0000','ĐỘC GIẢ 1',1);
insert into LOAISACH(MALOAI,TENLOAI,TONTAI) values
('GT0001','GIAO TRINH',1),
('SGK001','SÁCH GIÁO KHOA',1),
('SLD001','SÁCH LUYỆN ĐỀ',1),
('SKH001','SÁCH KHOA HỌC',1),
('LS0001','SÁCH VỀ LỊCH SỬ ',1),
('TT0001','TIỂU THUYẾT',1),
('BTC001','BÁO TẠP CHÍ',1),
('SA0001','SÁCH TÂM LÍ',1),
('VH0001','SÁCH VĂN HỌC',1),
('CT0001','SÁCH CHÍNH TRỊ',1);

insert into TACGIA (MATG,TENTG,PHAI,NGAYSINH,TONTAI) values
('TGGT01','LÊ SĨ ĐỒNG','NAM',NULL,1),
('TGGK01','ĐOÀN QUỲNH','NỮ',NULL,1),
('TGLD01','MẪN NGỌC QUANG','NAM',NULL,1),
('TGKH01','CHARLES DARWIN','NAM',NULL,1),
('TGTT01','J.K.ROWLING','NAM',NULL,1),
('TGSA01','	DALE CARMEGIE','NAM',NULL,1),
('TGVH01','VŨ TRỌNG PHỤNG','NAM',NULL,1);
insert into NHAXUATBAN (MANXB,TENNXB,TONTAI) values
('NXB001','KIM DONG',1),
('NXB002','LAO DONG',1),
('NXB003','THANH NIEN',1),
('NXB004','VAN HOC',1),
('NXB005','GIÁO DỤC VIỆT NAM',1),
('NXB006','TRI THỨC',1),
('NXB007','TRẺ',1);
insert into SACH(MASA,TENSA,TT,SOTRANG,SOLUONG,gia,SA_MALOAI,MATG,MANXB,MA_ANH,TONTAI) values              
('XSTK01','XÁC XUẤT THỐNG KÊ','con nguyen',200,10,65.000,'GT0001','TGGT01','NXB005','00000',1),
('SGKT12','SÁCH GIÁO KHOA TOÁN 12','con nguyen',190,20,30.000,'SGK001','TGGK01','NXB005','00001',1),
('LDTHPT','SÁCH LUYỆN ĐỀ THPT','nguyen',300,30,200.000,'SLD001','TGLD01','NXB005','00002',1),
('KHNGCL','SÁCH NGUỒN GỐC CÁC LOÀI','NGUYEN',200,20,200.000,'SKH001','TGKH01','NXB006','00003',1),
('DVSKTT','ĐẠI VIỆT SỬ KÍ TOÀN THƯ','NGUYEN',1300,10,300.000,'LS0001',null,'NXB006','00004',1),
('HAPO01','HARRY POTTER VÀ HÒN ĐÁ PHÙ THỦY','NGUYEN',636,10,150.000,'TT0001','TGTT01','NXB007','00005',1),
('TCNT01','TẠP CHÍ VĂN HÓA NGHỆ THUẬT','NGUYEN',60,5,20.000,'BTC001',NULL,'NXB003','00006',1),
('DNT001','ĐẮC NHÂN TÂM','NGUYEN',291,10,100.000,'SA0001','TGSA01','NXB007','00007',1),
('SD0001','SỐ ĐỎ','NGUYEN',307,10,60.000,'VH0001','TGVH01','NXB004','00008',1),
('LTM001','LUẬT THƯƠNG MẠI','NGUYEN',166,5,50.000,'CT0001',NULL,'NXB002','00009',1);

insert into DOCGIA(MADG,TENDG,PHAI,NGAYSINH,SDT,DIACHI,MAPQ,TONTAI) values
('000001','LE DUY KHANG','NAM','2003-04-10','0358808913','277 AU DUONG LAN','DG0000',1);
insert into NHANVIEN(MANV,TENNV,PHAI,NGAYSINH,CCCD,SDT,DIACHI,MAPQ,TONTAI) values 
('NV0011','LE DUY KHANG','NAM','2003-10-04','120732921123','0368779041','277 au duong lan','QL0000',1),
('NV0027','NGUYEN THI ANH THU','NỮ','2003-08-15','068303002628','0368779041','101 nguyen thi tan','TT0000',1),
('NV0003','NGUYEN KE CUONG','NAM','2003-11-07','120732921123','0368779041','477 ','TT0001',1),
('NV0010','DO MINH KHANG','NAM','2003-04-14','123456789123','0368779041','LONG AN','TT0002',1),
('NV0001','PHAM MINH TRUNG','NAM','2003-01-01','120732921123','0368779041','1000 nguyen thai son','TT0003',1);


insert into TAIKHOAN(TENDN,MATKHAU,MAPQ,TONTAI) values
('nguyenanhthu03','13062013','TT0000',1),
('dk20031004','04102003','QL0000',1),
('kc07010512','07010512','TT0001',1),
('mk14042003','14042003','TT0002',1),
('mt000000','000000','TT0003',1),
('ldk2003','04102003','DG0000',1);
/*insert into TK_DG(TENDN,MADG,TONTAI)values
('ldk2003','000001',1);
insert into TK_NV (TENDN,MANV,TONTAI) values
('nguyenanhthu03','NV0027',1),
('dk20031004','NV0011',1),
('kc07010512','NV0003',1),
('mk14042003','NV0010',1),
('mt000000','NV0001',1);*/
insert into THETHUVIEN(MATHE,NGAYCAP,HSD,MADG,MANV,TONTAI) values
('000001','2023-04-06','2025-04-06','000001','NV0011',1);


insert into ANH_DG(ma_anh,madg) values
('00000','000001'),
('00001','000001');
insert into ANH_SA(ma_anh,masa) values
('00000','XSTK01'),
('00001','SGKT12'),
('00002','LDTHPT'),
('00003','KHNGCL'),
('00004','DVSKTT'),
('00005','HAPO01'),
('00006','TCNT01'),
('00007','DNT001'),
('00008','SD0001'),
('00009','LTM001');
insert into ANH_NV(ma_anh,maNV) values
('00000','NV0027'),
('00001','NV0027'),
('00011','NV0003'),
('00012','NV0003'),
('00111','NV0010'),
('00101','NV0010'),
('01111','NV0011'),
('01010','NV0011'),
('11111','NV0001'),
('10101','NV0001');
-- Sắp xếp bảng Sách theo chiều giảm dần của Nhà xuất bản
select * 
from SACH t
order by t.MANXB desc;
-- Đưa ra thông tin về tình trạng mượn trả sách của bạn A. Thông tin hiển thị gồm Họ tên, Tên sách, Ngày mượn, Ngày trả
select  TENSA, NGAYMUON, PHIEUMUON.NGAYTRA
from (((DOCGIA join PHIEUMUON on DOCGIA.MADG =PHIEUMUON.MADG)join SACH on SACH.MASA= PHIEUMUON.MASA) 
				join PHIEUTRA on PHIEUMUON.MADG= PHIEUTRA.MADG and PHIEUMUON.MANV=PHIEUTRA.MANV)
where TENDG='A';
-- QUERY

-- cập nhật kho sách khi phiếu mượn được lập
drop trigger before_phieumuon_insert;
DELIMITER $$
CREATE TRIGGER before_phieumuon_insert
before INSERT 
ON PHIEUMUON
for each row
BEGIN
	UPDATE SACH
	SET SOLUONG  = SOLUONG -  new.SOLUONG 
	where new.MASA= SACH.MASA;
END $$
DELIMITER ;
insert into PHIEUMUON(MAPHIEU,MADG,MASA,MANV,NGAYMUON,HANTRA,SOLUONG,TONTAI) values
('000001','000001','SD0001','NV0011','2023-04-06','2023-06-06',1,1);
insert into PHIEUMUON(MAPHIEU,MADG,MASA,MANV,NGAYMUON,HANTRA,SOLUONG,TONTAI) values
('000002','000001','DNT001','NV0011','2023-04-06','2023-06-06',1,1);

-- 

DROP TRIGGER before_phieutra_insert;
SELECT DATEDIFF('2019-02-12','2019-01-12');



DROP TRIGGER before_phieutra_insert;
DELIMITER $$
CREATE TRIGGER before_phieutra_insert 
before INSERT 
ON PHIEUTRA
for each row
BEGIN 
		UPDATE SACH
		SET SOLUONG = SOLUONG + new.SOLUONG
		where new.MASA= SACH.MASA;
		update PHIEUMUON
		SET TONTAI=0 
		WHERE NEW.MASA=PHIEUMUON.MASA AND NEW.MADG=PHIEUMUON.MADG AND NEW.MANV=PHIEUMUON.MANV AND NEW.HANTRA =PHIEUMUON.HANTRA ;
END $$
DELIMITER ;
insert into PHIEUTRA(MAPHIEU,MADG,MASA,MANV,HANTRA,NGAYTRA,SOLUONG,TINHTRANG,SONGAYQUAHAN,TONTAI) values
('000001','000001','SD0001','NV0011','2023-06-06','2023-05-02',1,'CON NGUYEN',0,1);

insert into PHIEUTRA(MAPHIEU,MADG,MASA,MANV,HANTRA,NGAYTRA,SOLUONG,TINHTRANG,SONGAYQUAHAN,TONTAI) values
('000002','000001','DNT001','NV0011','2023-06-06','2023-06-10',1,'nguyen ven',0,1);

UPDATE PHIEUTRA
SET songayquahan= (DATEDIFF(ngaytra,HANTRA))
where (DATEDIFF(ngaytra,HANTRA) > 0);
UPDATE PHIEUTRA
SET songayquahan=0
where (DATEDIFF(ngaytra,HANTRA) <= 0);


SELECT * FROM PHIEUTRA;
SELECT * FROM PHIEUmuon;
SELECT * FROM SACH;