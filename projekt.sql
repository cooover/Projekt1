create database wytwornia_plytowa;
use wytwornia_plytowa;
create table opiekun (id_g int not null auto_increment, gatunek text not null, imie_o text, nazwisko text, ilosc_zespolow int, primary key (id_g));
create table zespoly (id_z int not null auto_increment, nazwa_z text not null, id_g int not null, primary key (id_z), foreign key (id_g) references opiekun(id_g));
create table albumy (id_a int not null auto_increment, nazwa_a text not null, id_z int not null, rok_wydania date, primary key (id_a), foreign key (id_z) references zespoly (id_z)); 
create table sprzedaz (id_s int not null auto_increment, sposob text, id_a int, ilosc int, primary key (id_s), foreign key (id_a) references albumy (id_a));
