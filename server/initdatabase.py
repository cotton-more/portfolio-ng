#!/usr/bin/env python
# -*- coding: utf-8 -*-

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

import models

from loremipsum import get_sentence

engine = create_engine('sqlite:///:memory:', echo=True)
Session = sessionmaker(bind=engine)
session = Session()

def run():
    models.Base.metadata.create_all(bind=engine)

    menu = models.Menu(name='test-0')
    menu.children = [
        models.Menu(name='test-0-1'),
        models.Menu(name='test-0-2'),
    ]

    menu.children[0].cards = [
        models.Card(get_sentence()),
        models.Card(get_sentence()),
        models.Card(get_sentence()),
        models.Card(get_sentence())
    ]

    menu.children[1].cards = [
        models.Card(get_sentence()),
        models.Card(get_sentence()),
        models.Card(get_sentence())
    ]

    session.add(menu)
    session.commit()

    menu = models.Menu(name='test-1')
    menu.children = [
        models.Menu(name='test-1-1'),
        models.Menu(name='test-1-2'),
        models.Menu(name='test-1-3'),
    ]
    menu.children[0].children = [
        models.Menu(name='test-1-1-1'),
        models.Menu(name='test-1-1-2'),
        models.Menu(name='test-1-1-3'),
        models.Menu(name='test-1-1-4'),
    ]
    session.add(menu)

    session.commit()
