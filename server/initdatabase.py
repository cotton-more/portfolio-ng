#!/usr/bin/env python
# -*- coding: utf-8 -*-

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

import models

from loremipsum import get_sentence, get_paragraph

import os

database = os.path.abspath( os.path.dirname(__file__) + '/../data/portfolio.db' )
if os.path.exists(database):
    os.unlink(database)

engine = create_engine(
    'sqlite:///%s' % database,
    echo=True
)
Session = sessionmaker(bind=engine)
session = Session()

def run():
    models.Base.metadata.create_all(bind=engine)

    admin = models.User(username='admin', password='admin', role='admin')
    session.add(admin)
    guest = models.User(username='guest', password='guest')
    session.add(guest)

    session.commit()

    menu = models.Menu(name='test-0')
    menu.children = [
        models.Menu(name='test-0-1', about=get_paragraph()),
        models.Menu(name='test-0-2'),
    ]

    menu.children[0].cards = [
        models.Card(get_sentence(), about=get_paragraph()),
        models.Card(get_sentence(), about=get_paragraph()),
        models.Card(get_sentence()),
        models.Card(get_sentence(), about=get_paragraph())
    ]

    menu.children[1].cards = [
        models.Card(get_sentence(), about=get_paragraph()),
        models.Card(get_sentence()),
        models.Card(get_sentence(), about=get_paragraph())
    ]

    session.add(menu)
    session.commit()

    menu = models.Menu(name='test-1', about=get_paragraph())
    menu.children = [
        models.Menu(name='test-1-1', about=get_paragraph()),
        models.Menu(name='test-1-2'),
        models.Menu(name='test-1-3'),
    ]
    menu.children[0].children = [
        models.Menu(name='test-1-1-1'),
        models.Menu(name='test-1-1-2', about=get_paragraph()),
        models.Menu(name='test-1-1-3', about=get_paragraph()),
        models.Menu(name='test-1-1-4', about=get_paragraph()),
    ]
    session.add(menu)

    session.commit()
