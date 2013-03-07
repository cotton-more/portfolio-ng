#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sqlite3

con = sqlite3.connect('data/portfolio.db')
#con.execute("""
            #CREATE TABLE menu (id INTEGER PRIMARY KEY, parent_id INTEGER, name VARCHAR(255))
            #""")

con.execute(""" INSERT INTO menu VALUES (1, null, 'foo')
            """)
con.execute(""" INSERT INTO menu VALUES (4, 1, 'foo-foo')
            """)
con.execute(""" INSERT INTO menu VALUES (5, 1, 'foo-bar')
            """)
con.execute(""" INSERT INTO menu VALUES (2, null, 'bar')
            """)
con.execute(""" INSERT INTO menu VALUES (6, 2, 'bar-foo')
            """)
con.execute(""" INSERT INTO menu VALUES (7, 2, 'bar-bar')
            """)
con.execute(""" INSERT INTO menu VALUES (8, 2, 'bar-qux')
            """)
con.execute(""" INSERT INTO menu VALUES (9, 8, 'bar-qux-foo')
            """)
con.execute(""" INSERT INTO menu VALUES (3, null, 'qux')
            """)
con.commit()

#con.execute("""
            #CREATE TABLE card (id INTEGER PRIMARY KEY, menu_id INTEGER, name VARCHAR(255), image VARCHAR(255), about VARCHAR(1000))
            #""")
