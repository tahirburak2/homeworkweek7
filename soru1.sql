use master
go

drop database if EXISTS  LibraryManagement
GO

create database LibraryManagement
GO

USE LibraryManagement
go

CREATE TABLE Kitaplar
(
    KitapID INT PRIMARY KEY,
    KitapAdi NVARCHAR(100),
    Yazar NVARCHAR(100),
    YayınYılı INT,
    SayfaSayisi INT,
    ISBN NVARCHAR(13)
);

CREATE TABLE Dergiler
(
    DergiID INT PRIMARY KEY,
    DergiAdi NVARCHAR(100),
    Yayınci NVARCHAR(100),
    YayınTarihi DATE,
    Sayi INT
);

CREATE TABLE DVDler
(
    DVDID INT PRIMARY KEY,
    DVDAdi NVARCHAR(100),
    Yönetmen NVARCHAR(100),
    YayınYılı INT,
    Süre INT
);

INSERT INTO Kitaplar
    (KitapID, KitapAdi, Yazar, YayınYılı, SayfaSayisi, ISBN)
VALUES
    (1, 'Kırmızı Saçlı Kadın', 'Orhan Pamuk', 2016, 253, '9789754586882'),
    (2, 'Savaş ve Barış', 'Lev Tolstoy', 2010, 1412, '9789754589029'),
    (3, 'Saatleri Ayarlama Enstitüsü', 'Ahmet Hamdi Tanpınar', 2011, 403, '9789750848175'),
    (4, 'Huzursuzluk', 'Zülfü Livaneli', 2017, 160, '9786050963914'),
    (5, 'İnce Memed', 'Yaşar Kemal', 2004, 436, '9789750807172'),
    (6, 'Kuyucaklı Yusuf', 'Sabahattin Ali', 2014, 220, '9786053608799'),
    (7, 'Suç ve Ceza', 'Fyodor Dostoyevski', 2015, 687, '9786053607570'),
    (8, 'Kayıp Zamanın İzinde', 'Marcel Proust', 2005, 592, '9789754705740'),
    (9, 'Beyaz Kale', 'Orhan Pamuk', 1998, 170, '9789754703937'),
    (10, 'Aylak Adam', 'Yusuf Atılgan', 2000, 150, '9789754704767'),
    (11, 'Tutunamayanlar', 'Oğuz Atay', 2013, 724, '9789754702282'),
    (12, 'Madame Bovary', 'Gustave Flaubert', 2001, 432, '9789750733069'),
    (13, 'Anna Karenina', 'Lev Tolstoy', 2015, 864, '9786053326006'),
    (14, '1984', 'George Orwell', 2013, 352, '9786053754809'),
    (15, 'Fahrenheit 451', 'Ray Bradbury', 2013, 208, '9789754589530'),
    (16, 'Denizler Altında Yirmi Bin Fersah', 'Jules Verne', 2014, 328, '9786053608126'),
    (17, 'Kürk Mantolu Madonna', 'Sabahattin Ali', 2015, 160, '9786051712023'),
    (18, 'Simyacı', 'Paulo Coelho', 2005, 166, '9789755101106'),
    (19, 'Yabancı', 'Albert Camus', 2012, 119, '9786050205342'),
    (20, 'Sineklerin Tanrısı', 'William Golding', 2016, 261, '9789750712925');

INSERT INTO Dergiler
    (DergiID, DergiAdi, Yayınci, YayınTarihi, Sayi)
VALUES
    (1, 'Bilim ve Teknik', 'TÜBİTAK', '2022-05-01', 743),
    (2, 'Atlas', 'Doğan Kitap', '2021-09-01', 190),
    (3, 'Popular Science', 'Doğan Burda', '2022-02-01', 582),
    (4, 'National Geographic', 'NG Media', '2021-11-01', 371),
    (5, 'Ekonomist', 'Kapital Medya', '2022-01-01', 250);


INSERT INTO DVDler
    (DVDID, DVDAdi, Yönetmen, YayınYılı, Süre)
VALUES
    (1, 'Babam ve Oğlum', 'Çağan Irmak', 2005, 112),
    (2, 'Vizontele', 'Yılmaz Erdoğan', 2001, 110),
    (3, 'Ahlat Ağacı', 'Nuri Bilge Ceylan', 2018, 188),
    (4, 'Kelebeğin Rüyası', 'Yılmaz Erdoğan', 2013, 118),
    (5, 'GORA', 'Ömer Faruk Sorak', 2004, 127);





CREATE TABLE OduncAlmalar
(
    OgrenciID INT,
    KitapID INT,
    DergiID INT,
    DVDID INT,
    OduncTarihi DATE,
    FOREIGN KEY (OgrenciID) REFERENCES Ogrenciler(OgrenciID),
    FOREIGN KEY (KitapID) REFERENCES Kitaplar(KitapID),
    FOREIGN KEY (DergiID) REFERENCES Dergiler(DergiID),
    FOREIGN KEY (DVDID) REFERENCES DVDler(DVDID)
);


INSERT INTO OduncAlmalar
    (OgrenciID, KitapID, DergiID, DVDID, OduncTarihi)
VALUES
    (1, 1, NULL, NULL, '2024-01-10'),
    (2, 2, 1, NULL, '2024-01-11'),
    (3, 3, NULL, 1, '2024-01-12'),
    (4, NULL, 2, 2, '2024-01-13'),
    (5, 4, NULL, NULL, '2024-01-14'),
    (6, NULL, 3, 3, '2024-01-15'),
    (7, 5, 4, NULL, '2024-01-16'),
    (8, NULL, NULL, 4, '2024-01-17'),
    (9, 6, 5, NULL, '2024-01-18'),
    (10, NULL, NULL, 5, '2024-01-19');



SELECT KitapAdi, Yazar, YayınYılı
FROM Kitaplar;


SELECT KitapAdi, Yazar
FROM Kitaplar
WHERE YayınYılı > 2000;


SELECT o.OgrenciID, k.KitapAdi
FROM OduncAlmalar oa
    JOIN Ogrenciler o ON o.OgrenciID = oa.OgrenciID
    JOIN Kitaplar k ON k.KitapID = oa.KitapID;


SELECT KitapAdi, SayfaSayisi
FROM Kitaplar
ORDER BY SayfaSayisi DESC
LIMIT 5;


SELECT KitapAdi
FROM Kitaplar WHERE Yazar = 'Orhan Pamuk';


SELECT o.OgrenciID, d.DergiAdi, d.Yayınci
FROM OduncAlmalar oa
    JOIN Ogrenciler o ON o.OgrenciID = oa.OgrenciID
    JOIN Dergiler d ON d.DergiID = oa.DergiID;


SELECT o.OgrenciID, o.FullName
FROM Ogrenciler o
    LEFT JOIN OduncAlmalar oa ON o.OgrenciID = oa.OgrenciID
WHERE oa.OgrenciID IS NULL;


    SELECT 'Kitap' AS Type, k.KitapAdi AS Name, COUNT(oa.KitapID) AS BorrowCount
    FROM OduncAlmalar oa
        JOIN Kitaplar k ON k.KitapID = oa.KitapID
    GROUP BY k.KitapAdi
UNION
    SELECT 'Dergi', d.DergiAdi, COUNT(oa.DergiID)
    FROM OduncAlmalar oa
        JOIN Dergiler d ON d.DergiID = oa.DergiID
    GROUP BY d.DergiAdi
UNION
    SELECT 'DVD', dv.DVDAdi, COUNT(oa.DVDID)
    FROM OduncAlmalar oa
        JOIN DVDler dv ON dv.DVDID = oa.DVDID
    GROUP BY dv.DVDAdi;


SELECT KitapAdi, YayınYılı
FROM Kitaplar
ORDER BY YayınYılı ASC
LIMIT 3;


SELECT o.OgrenciID, k.KitapAdi, d.DergiAdi, dv.DVDAdi
FROM Ogrenciler o
LEFT JOIN OduncAlmalar oa ON o.OgrenciID = oa.OgrenciID
LEFT JOIN Kitaplar k ON k
.KitapID = oa.KitapID
LEFT JOIN Dergiler d ON d.DergiID = oa.DergiID
LEFT JOIN DVDler dv ON dv.DVDID = oa.DVDID
WHERE o.FullName = 'Ali Yılmaz';








