#!/usr/bin/env python
# -*- coding: utf-8 -*-
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

from sqlalchemy import Column, String, Text, Integer, ForeignKey
from sqlalchemy.orm import relationship, backref

def jsonify(dataset):
    """Serialize dataset into json-string"""
    import json
    return json.dumps(dataset, sort_keys=True, indent=4)

class Menu(Base):
    __tablename__ = 'menus'

    id = Column(Integer, primary_key=True)
    parent_id = Column(Integer, ForeignKey('menus.id'))
    name = Column(String(64))
    about = Column(Text)

    children = relationship("Menu",
                          backref=backref("parent", remote_side=[id])
                          )

    cards = relationship("Card",
                          backref="menu"
                          )

    def json(self):
        """Turn entity into json-ready object"""
        return {
            'id': self.id,
            'parent_id': self.parent_id,
            'name': self.name,
            'about': self.about,
            'cards_len': len(self.cards)
        }

    def __repr__(self):
        return "<Menu(%s, %s)>" % (self.id, self.name)

class Card(Base):
    __tablename__ = 'cards'

    id = Column(Integer, primary_key=True)
    menu_id = Column(Integer, ForeignKey('menus.id'))
    name = Column(String(128))
    about = Column(Text)
    image = Column(String(128))

    def __init__(self, name, **kwargs):
        self.name = name
        self.about = kwargs.get('about', None)

    def json(self):
        """Turn entity into json-ready object"""
        return {
            'id': self.id,
            'menu_id': self.menu_id,
            'name': self.name,
            'about': self.about,
            'image': self.image
        }

    def __repr__(self):
        return "<Card(%d, %s)>" % (self.id, self.name)
