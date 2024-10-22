CREATE DATABASE ÖğrenciKulüpleriYönetimi
GO
USE ÖğrenciKulüpleriYönetimi

CREATE TABLE Kulüpler
(
    KulupID INT PRIMARY KEY,
    KulupAdi VARCHAR(100),
    KurulusYili INT
);

CREATE TABLE OgrenciKulup
(
    OgrenciID INT,
    KulupID INT,
    Rol VARCHAR(50),
    KatilimTarihi DATE,
    PRIMARY KEY (OgrenciID, KulupID),
    FOREIGN KEY (KulupID) REFERENCES Kulüpler(KulupID)
);

INSERT INTO Kulüpler
    (KulupID, KulupAdi, KurulusYili)
VALUES
    (1, 'Tiyatro Kulübü', 2001),
    (2, 'Müzik Kulübü', 1998),
    (3, 'Spor Kulübü', 2005),
    (4, 'Robotik Kulübü', 2010),
    (5, 'Yazılım Kulübü', 2020);


INSERT INTO OgrenciKulup
    (OgrenciID, KulupID, Rol, KatilimTarihi)
VALUES
    (1, 1, 'Başkan', '2022-10-10'),
    (2, 1, 'Üye', '2022-10-15'),
    (3, 1, 'Sekreter', '2022-11-01'),
    (4, 2, 'Başkan', '2023-01-12'),
    (5, 2, 'Üye', '2023-01-14'),
    (6, 2, 'Sekreter', '2023-01-16'),
    (7, 3, 'Başkan', '2021-09-20'),
    (8, 3, 'Üye', '2021-09-25'),
    (9, 3, 'Üye', '2021-09-30'),
    (10, 4, 'Başkan', '2022-12-01'),
    (11, 4, 'Üye', '2023-01-03'),
    (12, 4, 'Üye', '2023-01-05'),
    (13, 5, 'Başkan', '2021-06-15'),
    (14, 5, 'Sekreter', '2021-06-20'),
    (15, 5, 'Üye', '2021-06-25');

-- bütün kulüp üyelerinin rollerini listeleyin
SELECT o.OgrenciID, k.KulupAdi, o.Rol
FROM OgrenciKulup o
    JOIN Kulüpler k ON o.KulupID = k.KulupID;

-- tiyatro külübü üyelerini listeleyin
SELECT o.OgrenciID, o.Rol
FROM OgrenciKulup o
    JOIN Kulüpler k ON o.KulupID = k.KulupID
WHERE k.KulupAdi = 'Tiyatro Kulübü';

-- başkan olanları listele
SELECT o.OgrenciID, k.KulupAdi
FROM OgrenciKulup o
    JOIN Kulüpler k ON o.KulupID = k.KulupID
WHERE o.Rol = 'Başkan';

--kulüplerin üye sayılarının listesi
SELECT k.KulupAdi, COUNT(o.OgrenciID) AS ÜyeSayisi
FROM OgrenciKulup o
    JOIN Kulüpler k ON o.KulupID = k.KulupID
GROUP BY k.KulupAdi;

-- en eski kulübün üyeleri
SELECT top 1
    o.OgrenciID, k.KulupAdi
FROM OgrenciKulup o
    JOIN Kulüpler k ON o.KulupID = k.KulupID
ORDER BY k.KurulusYili ASC
;

-- öğrencilerin kulüblere katıldığı tarihler
SELECT o
.OgrenciID, k.KulupAdi, o.KatilimTarihi
FROM OgrenciKulup o
    JOIN Kulüpler k ON o.KulupID = k.KulupID;

-- müzik kulübünün listeleri
SELECT DISTINCT o.Rol
FROM OgrenciKulup o
    JOIN Kulüpler k ON o.KulupID = k.KulupID
WHERE k.KulupAdi = 'Müzik Kulübü';

--her kulüpteki başkan sayıları
SELECT k.KulupAdi, COUNT(o.OgrenciID) AS BaskanSayisi
FROM OgrenciKulup o
    JOIN Kulüpler k ON o.KulupID = k.KulupID
WHERE o.Rol = 'Başkan'
GROUP BY k.KulupAdi;

--öğrencinin en son hangi kulübe katıldığının listesi
SELECT o.OgrenciID, k.KulupAdi, o.KatilimTarihi
FROM OgrenciKulup o
    JOIN Kulüpler k ON o.KulupID = k.KulupID
ORDER BY o.KatilimTarihi DESC;

-- birden fazla kulübe katılmış öğrencilerin listesi
SELECT o.OgrenciID, COUNT(o.KulupID) AS KulupSayisi
FROM OgrenciKulup o
GROUP BY o.OgrenciID
HAVING COUNT(o.KulupID) > 1;