# -*- coding: utf-8 -*-

import pymysql

class Menu:
    def __init__(self):
        self.conn = pymysql.connect("localhost", "root", "kurs", "wytwornia_plytowa")
        self.c = self.conn.cursor()
        print("Polączenie ustanowione") 
        self.nav=""
        while(self.nav!="Q"):
            self.nav = input("Co chcesz zrobić?((Z) - zalogować się jako zespół (O) - zalogować się jako opiekun (Q) - nic, wyjść z programu: ")
            if(self.nav== "Z"):
                self.logowanie_z()
            elif(self.nav=="O"):
                self.logowanie_o()
            else:
                print("Wpisano złe polecenie!")
        self.conn.close()
        print("Polączenie zakończone")
  
    def logowanie_z(self):
        self.login = input("Podaj login: ")
        m = self.c.execute("select id_z from zespoly where mail_z='"+self.login+"';")
        if(m==0):
            print("W bazie nie ma takiego zespołu")
            self.nav=""
        else:
            password = input("Podaj hasło: ")
            h = self.c.execute("select id_z from zespoly where mail_z='"+self.login+"' and haslo_z ='"+password+"';")
            self.nav=""
            if(h==0):
                print("Podano nieprawidłowe hasło")
            else:
                print("Poprawne logowanie")
                self.nav="Q"
                res = self.c.fetchall()
                self.nr = res[0][0] 
                self.nawigacja_z()
   
    def logowanie_o(self):
        login = input("Podaj login: ")
        m = self.c.execute("select id_o from opiekun where mail_o='"+login+"';")
        if(m==0):
            print("W bazie nie ma takiego opiekuna")
            self.nav=""
        else:
            password = input("Podaj hasło: ")
            h = self.c.execute("select id_o from opiekun where mail_o='"+login+"' and haslo_o ='"+password+"';")
            if(h==0):
                print("Podano nieprawidłowe hasło")
                self.nav=""
            else:
                print("Poprawne logowanie")
                self.nav="Q"
                self.nawigacja_o()
                
    def nawigacja_o(self):
        self.nav=""
        while(self.nav!="Q"):
            self.nav = input("Co chcesz zrobić?\n(1) - wyświetlić listę zespołów\n(2) - dodać nowy zespół\n(3) - usunąć zespół\n(4) - dodać nowy album\n(5)  - wyświetlić TOP 3 sprzedanych albumów\n(Q) - nic, wyjść z programu: ")
            if(self.nav== "1"):
                self.wyswietl_zespoly()
            elif(self.nav=="2"):
                self.dodanie_z()
            elif(self.nav=="3"):
                self.usuniecie_z()
            elif(self.nav=="4"):
                self.dodanie_a()
            elif(self.nav=="5"):
                self.wyswietl_TOP()                
            elif(self.nav=="Q"):
                print("Koniec zmian")
            else:
                print("Wpisano złe polecenie!")
                
    def nawigacja_z(self):
        self.nav=""
        while(self.nav!="Q"):
            self.nav = input("Co chcesz zrobić?\n(1) - wyświetlić listę zespołów\n(2) - wyświetlić ilość swoich sprzedanych albumów\n(3) - wyświetlić TOP 3 sprzedanych albumów\n(4) - zmienić hasło\n(Q) - nic, wyjść z programu: ")
            if(self.nav== "1"):
                self.wyswietl_zespoly()
            elif(self.nav=="2"):
                self.wyswietl_a()
            elif(self.nav=="3"):
                self.wyswietl_TOP()   
            elif(self.nav=="4"):
                self.zmiana_h()
            elif(self.nav=="Q"):
                print("Koniec zmian")
            else:
                print("Wpisano złe polecenie!")

    def wyswietl_zespoly(self):
        self.c.execute("select * from zespoly;")
        res = self.c.fetchall()
        print("%-3s %-30s %-15s %-30s %-30s %-10s" % ("Lp.","nazwa zespołu", "id opiekuna", "gatunek", "login","ilosc albumow"))
        print("-------------------------------------------------------------------------------------------------------------------------------")
        for i,v in enumerate(res):
            id_z = v[0]
            nazwa_z = v[1]
            id_o = v[2]
            gatunek = v[3]
            mail_z = v[4]
            ilosc_a = v[6]
            print ("%-3s %-30s %-15s %-30s %-30s %-10s" % (id_z,nazwa_z, id_o, gatunek, mail_z,ilosc_a))           
  
    def dodanie_z(self):
        n = input("Podaj nazwę zespołu: ")
        o = input("Podaj id opiekuna: ")
        g = input("Podaj gatunek: ")
        l = input("Podj login zespołu (adres mailowy): ")
        h = input("Podaj pierwsze hasło: ")
        self.c.execute("insert into zespoly values (null, '"+n+"', "+o+",'"+g+"', '"+l+"', "+h+", 0);")
        self.conn.commit()
        self.wyswietl_zespoly()          
   
    def usuniecie_z(self):
        self.c.execute("select id_z, nazwa_z from zespoly;")
        res = self.c.fetchall()
        print("%-3s %-30s" % ("id","nazwa zespołu"))
        print("--------------------------------------")
        for i,v in enumerate(res):
            id_z = v[0]
            nazwa_z = v[1]
            print ("%-3s %-30s" % (id_z,nazwa_z))         
        nr = input("Podaj id zespołu, który chcesz usunąć: ")
        self.c.execute("delete from zespoly where id_z="+nr+";")
        self.conn.commit()
        self.wyswietl_zespoly()
        self.c.execute("select * from zespoly;")
        res = self.c.fetchall()            
 
    def dodanie_a(self):
        i = input("Podaj id zespołu: ")
        a = input("Podaj nazwę albumu: ")
        d = input("Podaj datę wydania (rrrr-mm-dd): ")
        l = input("Podj login zespołu (adres mailowy): ")
        h = input("Podaj pierwsze hasło: ")
        self.c.execute("insert into albumy values (null, '"+a+"', "+i+",'"+d+");")
        self.conn.commit()        

    def wyswietl_TOP(self):
        self.c.execute("select nazwa_z, czyj_album.nazwa_a as album, suma from najpopularniejszy_album, czyj_album where czyj_album.id_a = najpopularniejszy_album.id_a order by suma desc limit 3;")
        res = self.c.fetchall()
        print("%-3s %-30s %-30s %-10s" % ("Lp.","nazwa_z", "album", "suma"))
        print("--------------------------------------------------------------------------")
        for i,v in enumerate(res):
            nazwa_z = v[0]
            album = v[1]
            suma = v[2]
            print ("%-3i %-30s %-30s %-10s" % (i+1,nazwa_z, album, suma))      
        
    def zmiana_h(self):
        s = input("Podaj stare hasło: ")
        self.c.execute("select haslo_z from zespoly where mail_z='"+self.login+"';")
        res = self.c.fetchall()
        if(s==res[0][0]):
            h = input("Podaj nowe hasło: ")
            h2 = input("Powtórz hasło: ")
            if(h==h2):
                self.c.execute("update zespoly set haslo_z='"+h+"' where mail_z='"+self.login+"';")
                self.conn.commit() 
                print("Hasło zmienione")
            else:
                print("Hasło się nie zgadza")
        else:
            print("Podano błędne hasło")
        
    def wyswietl_a(self):
        self.c.execute("select czyj_album.nazwa_a, suma, plytyCD, winyl, s_cyfrowa from najpopularniejszy_album, czyj_album where czyj_album.id_a = najpopularniejszy_album.id_a and id_z="+str(self.nr)+" order by suma desc;")
        res = self.c.fetchall()
        print("%-30s %-10s %-10s %-10s %-10s" % ("Nazwa albumu","suma", "CD","winyl","s. cyfrowa"))
        print("------------------------------------------------------------------------------")
        for i,v in enumerate(res):
            nazwa_a = v[0]
            suma = v[1]
            plytyCD = v[2]
            winyl = v[3]
            s_cyfrowa = v[4]
            print ("%-30s %-10s %-10s %-10s %-10s" % (nazwa_a,suma,plytyCD,winyl,s_cyfrowa))         




start = Menu()