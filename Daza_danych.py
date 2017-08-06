# -*- coding: utf-8 -*-

import pymysql
from Uzytkownik import *

class Baza_danych:
    def init(self):
        conn = pymysql.connect("localhost", "root", "kurs", "wytwornia_plytowa")
        self.c = self.conn.cursor()
        print("Polączenie ustanowione")        
    '''def spr_mail_zespol(self, login_z):
        z = self.c.execute("select id_z form zepoly where mail_z="+login_z)
        if (z==0):
            return False
        else:
            return True
        
    def spr_haslo_opiekun(self, haslo_o):
        z = self.c.execute("select id_z form zepoly where mail_z="+login_o)
        if (z==0):
            print("W bazie nie ma takiego opiekuna")
            return False
        else:
            return True        
    def spr_mail_zespol(self, login_z):
        self.login_z = login_z
        z = self.c.execute("select id_z form zepoly where mail_z="+login_z)
        if (z==0):
            return False
        else:
            return True        '''