CREATE DATABASE PersonelveMaaşYönetimi

use PersonelveMaaşYönetimi

CREATE TABLE Personel
(
    PersonelID INT PRIMARY KEY,
    Ad NVARCHAR(50),
    Soyad NVARCHAR(50),
    Pozisyon NVARCHAR(50),
    BaslangicTarihi DATE
);


CREATE TABLE Maaslar
(
    MaasID INT PRIMARY KEY,
    PersonelID INT,
    MaasMiktari DECIMAL(10,2),
    GuncellemeTarihi DATE,
    FOREIGN KEY (PersonelID) REFERENCES Personel(PersonelID)
);



--veri ekleme kısmı


INSERT INTO Personel
    (PersonelID, Ad, Soyad, Pozisyon, BaslangicTarihi)
VALUES
    (1, 'Ali', 'Yılmaz', 'Okul Müdürü', '2015-09-01'),
    (2, 'Ayşe', 'Kaya', 'Öğretmen', '2017-10-10'),
    (3, 'Mehmet', 'Demir', 'Öğretmen', '2018-05-15'),
    (4, 'Fatma', 'Koç', 'Sekreter', '2019-03-20'),
    (5, 'Cem', 'Taş', 'Öğretmen', '2016-07-25'),
    (6, 'Zeynep', 'Güneş', 'Temizlik Görevlisi', '2020-12-01'),
    (7, 'Hüseyin', 'Öztürk', 'Öğretmen', '2015-11-17'),
    (8, 'Elif', 'Çelik', 'Müdür Yardımcısı', '2021-02-20'),
    (9, 'Ahmet', 'Aslan', 'Güvenlik Görevlisi', '2022-04-05'),
    (10, 'Sevil', 'Yıldız', 'Öğretmen', '2019-09-12');



INSERT INTO Maaslar
    (MaasID, PersonelID, MaasMiktari, GuncellemeTarihi)
VALUES
    (1, 1, 7500, '2015-09-01'),
    (2, 2, 5000, '2017-10-10'),
    (3, 3, 4800, '2018-05-15'),
    (4, 4, 3500, '2019-03-20'),
    (5, 5, 4600, '2016-07-25'),
    (6, 6, 2900, '2020-12-01'),
    (7, 7, 4700, '2015-11-17'),
    (8, 8, 6200, '2021-02-20'),
    (9, 9, 3200, '2022-04-05'),
    (10, 10, 4600, '2019-09-12');

--sorgu kısmı

--personellerin maaşlarının listesi
SELECT p.Ad, p.Soyad, m.MaasMiktari, m.GuncellemeTarihi
FROM Personel p
    JOIN Maaslar m ON p.PersonelID = m.PersonelID
WHERE m.GuncellemeTarihi = (
    SELECT MAX(GuncellemeTarihi)
FROM Maaslar
WHERE Maaslar.PersonelID = p.PersonelID
);


--Ortalama maaş
SELECT AVG(MaasMiktari) AS OrtalamaMaas
FROM Maaslar
WHERE GuncellemeTarihi = (
    SELECT MAX(GuncellemeTarihi)
FROM Maaslar
WHERE Maaslar.PersonelID = Maaslar.PersonelID
);


--aynı pozisyomdaki çalışanların maaş karşılaştırması
SELECT p.Pozisyon, MAX(m.MaasMiktari) AS EnYuksekMaas, MIN(m.MaasMiktari) AS EnDusukMaas
FROM Personel p
    JOIN Maaslar m ON p.PersonelID = m.PersonelID
GROUP BY p.Pozisyon;

--çalışanların isim soyisimleri
SELECT Ad, Soyad, Pozisyon
FROM Personel;

--bir pozisyondaki personel sayıları
SELECT Pozisyon, COUNT(*) AS PersonelSayisi
FROM Personel
GROUP BY Pozisyon;

--çalışanın en son aldığı maaş ve en son güncelleme tarihleri
SELECT p.Ad, p.Soyad, m.MaasMiktari, m.GuncellemeTarihi
FROM Personel p
    JOIN Maaslar m ON p.PersonelID = m.PersonelID
WHERE m.GuncellemeTarihi = (
    SELECT MAX(GuncellemeTarihi)
FROM Maaslar
WHERE Maaslar.PersonelID = p.PersonelID
);



--öğretmenlerin isim soyisim
SELECT Ad, Soyad
FROM Personel
WHERE Pozisyon = 'Öğretmen';




--en çok para alan çalışanın adı soyadı
SELECT TOP 1
    p.Ad, p.Soyad, m.MaasMiktari
FROM Personel p
    JOIN Maaslar m ON p.PersonelID = m.PersonelID
ORDER BY m.MaasMiktari DESC;




--maaş değişikliklerinin listesi
SELECT p.Ad, p.Soyad, m.MaasMiktari, m.GuncellemeTarihi
FROM Maaslar m
    JOIN Personel p ON p.PersonelID = m.PersonelID
WHERE p.PersonelID = 3
ORDER BY m.GuncellemeTarihi ASC;

--son 6 ayda maaşı değişen çalışanların listesi
SELECT p.Ad, p.Soyad, m.GuncellemeTarihi
FROM Personel p
    JOIN Maaslar m ON p.PersonelID = m.PersonelID
WHERE m.GuncellemeTarihi >= DATEADD(MONTH, -6, GETDATE());

--maaşı 2 kere değişmiş çalışanlar
SELECT p.Ad, p.Soyad, COUNT(m.MaasID) AS GuncellemeSayisi
FROM Personel p
    JOIN Maaslar m ON p.PersonelID = m.PersonelID
GROUP BY p.Ad, p.Soyad
HAVING COUNT(m.MaasID) >= 2;

