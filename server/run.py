#!/usr/bin/env python
# -*- coding: utf-8 -*-

# add site specific packages
from site import addsitedir
addsitedir('/home/ivan/portfolio-ng/vendors/lib/python2.7/site-packages')

import sys, os
sys.path.append(os.path.abspath(os.path.dirname(__file__) + '/../vendors'))

import initdatabase
initdatabase.run()

from models import jsonify, Menu, Card

from bottle import Bottle, request, response
#from bottle import jinja2_template as template

# add path to views
from bottle import TEMPLATE_PATH
TEMPLATE_PATH.append(os.path.abspath(os.path.dirname(__file__) + '/views'))

# add SQLAlchemy plugin
from bottle.ext import sqlalchemy
plugin = sqlalchemy.Plugin(
    initdatabase.engine,
    initdatabase.models.Base
)

from sqlalchemy.orm import joinedload

app = Bottle()
app.install(plugin)

@app.route('/get_cards/:id')
def menu_get_cards(id, db):
    q = db.query(Card).filter(Card.menu_id==id)
    callback = request.query.callback

    response.content_type = 'text/javascript'
    return "%s(%s)" % (callback, jsonify([e.json() for e in q.all()]))

@app.route('/menu/list')
def menu_list(db):
    """
    Return json representation of data
    """
    callback = request.query.callback
    q = db.query(Menu).\
            options(joinedload('cards')).\
            order_by(Menu.parent_id)

    response.content_type = 'text/javascript'
    menu = [e.json() for e in q.all()]

    return "%s(%s)" % (callback, jsonify(menu))

@app.route('/menu/:id')
def get_menu(id, db):
    callback = request.query.callback
    e = db.query(Menu).get(id)

    response.content_type = 'text/javascript'
    return "%s(%s)" % (callback, jsonify(e.json()))


# run application
app.run(port=8000, reloader=True, debug=True)
