#!/usr/bin/env python
# -*- coding: utf-8 -*-
__path__ = ['./vendors/']

import os

from bottle import route, static_file, template, run

@route('/static/<filename:path>')
def handle_static(filename):
    """Handle static files"""
    pathname = os.path.dirname(__file__)
    fullpath = os.path.abspath(pathname) + '/static'

    return static_file(filename, root = fullpath)

@route('/')
@route('/<page>')
def show_page(page = 'index'):
    """docstring for show_page"""
    # TODO: write code...
    return template(page, content=page)

run(host='localhost', port=8000, reloader=True, debug=True)
