#create database wytwornia_plytowa;
#use wytwornia_plytowa;

drop view wyswietl_opiekuna;
drop view czyj_album;
drop view najpopularniejszy_album;
drop table sprzedaz;
drop table albumy;
drop table zespoly;
drop table opiekun;

create table opiekun (id_o int not null auto_increment, imie_o text, nazwisko text, mail_o text, haslo_o text, ilosc_zespolow int not null, primary key (id_o));
create table zespoly (id_z int not null auto_increment, nazwa_z text not null, id_o int not null, gatunek text, mail_z text, haslo_z text, ilosc_a int not null, primary key (id_z), foreign key (id_o) references opiekun(id_o));
create table albumy (id_a int not null auto_increment, nazwa_a text not null, id_z int not null, data_wydania date, primary key (id_a), foreign key (id_z) references zespoly (id_z)); 
create table sprzedaz (id_s int not null auto_increment, plytyCD int, winyl int, s_cyfrowa int, id_a int,id_o int, primary key (id_s), foreign key (id_a) references albumy (id_a), foreign key (id_o) references opiekun (id_o));
 
create trigger dodanie_zespolu after insert on zespoly for each row update opiekun set ilosc_zespolow = ilosc_zespolow + 1 where opiekun.id_o = new.id_o;
create trigger usuniecie_zespolu after delete on zespoly for each row update opiekun set ilosc_zespolow = ilosc_zespolow - 1 where opiekun.id_o = old.id_o;
create trigger dodanie_albumu after insert on albumy for each row update zespoly set ilosc_a = ilosc_a + 1 where zespoly.id_z = new.id_z;
create trigger usuniecie_albumu after delete on albumy for each row update zespoly set ilosc_a = ilosc_a - 1 where zespoly.id_z = old.id_z;

create view wyswietl_opiekuna as select nazwa_z, imie_o, nazwisko, mail_o from zespoly  NATURAL LEFT JOIN opiekun;
create view czyj_album as select id_a, nazwa_a, zespoly.id_z, nazwa_z from zespoly, albumy where zespoly.id_z = albumy.id_z  order by albumy.id_a;
create view najpopularniejszy_album as select id_a, nazwa_a, plytyCD, winyl, s_cyfrowa, (plytyCD+ winyl+ s_cyfrowa) as suma from albumy natural left join sprzedaz order by suma desc ;

insert into opiekun values (null, 'Jan', 'Kowalski', 'j.kowalski@gmail.com', 'jank', 0);
insert into opiekun values (null, 'Anna', 'Nowak', 'a.nowak@gmail.com', 'annan', 0);
insert into opiekun values (null, 'Adam', 'Kowalski', 'a.kowalski@gmail.com', 'adamk', 0);
insert into opiekun values (null, 'Wojciech', 'Zawadzki', 'w.zawadzki@gmail.com', 'wojciechz', 0);
insert into opiekun values (null, 'Piotr', 'Wisniewski', 'p.wisniewski@gmail.com', 'piotrw', 0);
insert into opiekun values (null, 'Zofia', 'Jastrzebska', 'z.jastrzebska@gmail.com', 'zofiaj', 0);
insert into opiekun values (null, 'Katarzyna', 'Misiak', 'k.misiak@gmail.com', 'katarzynam', 0);
select * from opiekun;

insert into zespoly values (null, 'Zbigniew Preisner', 7, 'muzyka instrumentalna', 'z.preisner@gmail.com', null, 0);
insert into zespoly values (null, 'Brodka', 7, 'pop', 'm_brodka@gmail.com', null, 0);
insert into zespoly values (null, 'Michal Urbaniak',3, 'jazz', 'm.urbaniak@gmail.com', null, 0);
insert into zespoly values (null, 'Leszek Mozdzer', 5, 'jazz', 'l.mozdzer@gmail.com',null, 0);
insert into zespoly values (null, 'Dawid Podsiadlo', 2, 'indie', 'd,podsiadlo@gmail.com', null, 0);
insert into zespoly values (null, 'Myslovitz', 5, 'rock', 'myslovitz@gmail.com', null, 0);
insert into zespoly values (null, 'Lao Che', 3,'rock', 'lao.che@gmail.com', null, 0);
insert into zespoly values (null, 'The Dumplings', 4, 'electropop', 'the.dumplings@gmail.com', null, 0); 
insert into zespoly values (null, 'O.S.T.R.', 4, 'rap', 'ostr@gmail.com', null,0);
insert into zespoly values (null, 'Anita Lipnicka', 6, 'pop', 'a.lipnicka@gmail.com', null, 0);
insert into zespoly values (null, 'Maanam',5, 'rock', 'maanam@gmail.com', null, 0);
insert into zespoly values (null, 'Stare Dobre Malzenstwo', 1, 'poezja spiewana', 'sdm@gmail.com', null, 0);
insert into zespoly values (null, 'Voo Voo', 6, 'muzyka alternatywna', 'voovoo@gmail.com', null, 0);
insert into zespoly values (null, 'XXANAXX', 2, 'muzyka elektroniczna', 'xxanaxx@gmail.com', null, 0);
insert into zespoly values (null, 'Edyta Gorniak', 7, 'pop', 'e.gorniak@gmail.com', null, 0);
insert into zespoly values (null, 'Marika', 5, 'reggae', 'marika@gmail.com', null, 0);
insert into zespoly values (null, 'Behemoth', 1, 'metal', 'behemoth@gmail.com', null, 0);
insert into zespoly values (null, 'Kroke', 2, 'folk', 'kroke@gmail.com', null, 0);
select * from zespoly;

insert into albumy values (null, 'Gospel', 7, '2008-02-22');
insert into albumy values (null, 'Powstanie Warszawskie', 7, '2005-03-21');
insert into albumy values (null, 'Dzieciom', 7, '2015-03-06');
insert into albumy values (null, 'Moje koledy na koniec wieku', 1, '1999-12-24');
insert into albumy values (null, 'Clashes', 2, '2016-05-13');
insert into albumy values (null, 'Granda', 2, '2010-09-17');
insert into albumy values (null, 'Piano', 4, '2004-06-14');
insert into albumy values (null, 'UrbSymphony', 3, '2003-01-01');
insert into albumy values (null, 'Tabletki ze slow', 12, '2006-12-09');
insert into albumy values (null, 'Tabasko', 9, '2002-06-24');
insert into albumy values (null, 'Dotyk', 15, '1995-05-08');
insert into albumy values (null, 'Triangles', 14, '2014-05-27');
insert into albumy values (null, 'Happiness Is Easy', 6, '2006-05-19');
insert into albumy values (null, '21', 13, '2006-05-12');
insert into albumy values (null, 'Hard Land of Wonder', 10, '2009-11-13');
insert into albumy values (null, 'Traveller', 18, '2017-03-17');
insert into albumy values (null, 'Demigod', 17, '2004-03-26');
insert into albumy values (null, 'Rockandrolle', 11, '1997-10-06');
insert into albumy values (null, 'Dobry wieczor', 13, '2014-10-24');
insert into albumy values (null, 'Plenty', 16, '2008-08-23');
insert into albumy values (null, 'Annoyance and Disappointment', 5, '2015-11-06');
insert into albumy values (null, 'No Bad Days', 8, '2014-05-13');
select * from albumy;

insert into sprzedaz values (null, 24273, 4567, 53728, 21, 2);
insert into sprzedaz values (null, 75839, 15879, 742903, 10, 4);
insert into sprzedaz values (null, 78457, 52355, 620973, 14, 6);
insert into sprzedaz values (null, 478903, 64789, 732586, 3, 3);
insert into sprzedaz values (null, 37469, 24440, 414525, 17, 1);
insert into sprzedaz values (null, 432583, 4329, 526347, 9, 6);
insert into sprzedaz values (null, 63257, 6389, 527290, 1, 3);
insert into sprzedaz values (null, 383649, 4134, 421213, 16, 2);
insert into sprzedaz values (null, 264373, 3883, 317678, 11, 7);
insert into sprzedaz values (null, 346539, 78932, 734290, 13, 5);
insert into sprzedaz values (null, 468909, 27369, 894269, 22, 4);
insert into sprzedaz values (null, 429769, 14879, 761900, 5, 7);
insert into sprzedaz values (null, 897572, 295765, 998775, 18, 5);
insert into sprzedaz values (null, 46880, 41321, 354123, 15, 7);
insert into sprzedaz values (null, 62890, 42918, 746254, 12, 2);
insert into sprzedaz values (null, 23344, 2341, 73342, 2, 3);
insert into sprzedaz values (null, 54399, 43299, 545223, 20, 5);
insert into sprzedaz values (null, 47299, 29348, 284269, 4, 6);
insert into sprzedaz values (null, 46788, 7820, 324790, 8, 3);
insert into sprzedaz values (null, 56778, 28, 962363, 19, 6);
insert into sprzedaz values (null, 35279, 6389, 124789, 6, 7);
insert into sprzedaz values (null, 67579, 758, 768908, 7, 5);
select * from sprzedaz;

select * from wyswietl_opiekuna;
select * from czyj_album;
select * from najpopularniejszy_album;
 # wyswietla nazwy zespolow przy albumach w kolejnosci od najlepiej sie sprzedajacego:
select czyj_album.nazwa_a, suma, nazwa_z, plytyCD from najpopularniejszy_album, czyj_album where czyj_album.id_a = najpopularniejszy_album.id_a order by suma desc;
# wyswietla albumy wraz z nazwa zespolu w kolejnosci od najwiekszej ilosci sprzedanych
#select nazwa_z, nazwa_a, plytyCD, winyl, s_cyfrowa, suma from albumy natural left join zespoly natural right join najpopularniejszy_album order by suma desc;
# wyswietla albumy wraz z nazwami zespolow od najswiezszego:
select nazwa_a, nazwa_z, data_wydania from albumy natural left join zespoly order by data_wydania desc;
# wyswietla albumy wydane przez konkretny zespol w kolejnosci od najswiezszego
select nazwa_a, nazwa_z, data_wydania from albumy natural left join zespoly where nazwa_z = 'Lao Che' order by data_wydania desc;
# wyswietla ilosc albumow wydanych przez zespoly (w razie gdyby nie było triggera)
select count(*) as ilosc_albumow, nazwa_z from albumy natural left join zespoly group by nazwa_z;
select nazwa_z, nazwa_a, plytyCD from zespoly, albumy, sprzedaz where zespoly.id_z = albumy.id_z and albumy.id_a = sprzedaz.id_a;
select nazwa_z, nazwa_a, plytyCD from zespoly natural join albumy natural join sprzedaz;
select id_o from opiekun where mail_o='j.kowalski' and haslo_o='jank';