#!/usr/bin/env python
# -*- coding: utf-8 -*-
__path__ = ['./vendors/', './src/']

import os
import json
from bottle import install, route, request, response, static_file, jinja2_template as template, run, HTTPError


from bottle_sqlite import SQLitePlugin
install(SQLitePlugin(dbfile='data/portfolio.db'))

@route('/static/<filename:path>')
def handle_static(filename):
    """Handle static files"""
    pathname = os.path.dirname(__file__)
    fullpath = os.path.abspath(pathname) + '/static'

    return static_file(filename, root = fullpath)

@route('/portfolio')
def show_portfolio():
    return template('portfolio')

''' Getting menu
'''
@route('/menu/list')
def show(db):
    callback = request.query.callback
    c = db.execute('SELECT * FROM menu')
    result = []
    while True:
        row = c.fetchone()
        if row == None:
            break
        result.append(dict(zip(row.keys(), row)))

    response.content_type = 'text/javascript'

    return callback + '(' + str(json.dumps(result)) + ')'

@route('/menu/<menu_id>')
def get_cards(db, menu_id):
    c = db.execute('SELECT * FROM card WHERE menu_id = ?', (menu_id,))
    result = {'result': []}
    while True:
        row = c.fetchone()
        if row == None:
            break
        result['result'].append(dict(zip(row.keys(), row)))

    return result

@route('/show')
def show_test(db):
    c = db.execute('SELECT id, name FROM menu WHERE id = ?', (2,))
    row = c.fetchone()
    return template('show', title=row['id'], text=row['name'])

@route('/')
@route('/<page>')
def show_page(page = 'index.html'):
    """docstring for show_page"""
    # TODO: write code...
    try:
        return template(page + '.twig', content=page)
    except HTTPError as e:
        return template('error_404.html.twig', message=e.body)

run(host='localhost', port=8000, reloader=True, debug=True)
