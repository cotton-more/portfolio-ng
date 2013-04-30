from app import app
#from models import User
from models import Menu
from models import Card
from flask import jsonify
from flask import request, current_app

from functools import wraps

def support_jsonp(f):
    """Wraps JSONified output for JSONP"""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        callback = request.args.get('callback', False)
        if callback:
            content = str(callback) + '(' + str(f(*args,**kwargs).data) + ')'
            return current_app.response_class(content, mimetype='application/javascript')
        else:
            return f(*args, **kwargs)
    return decorated_function

@app.route('/menu/list')
@support_jsonp
def menu_list():
    menu = [e.json() for e in Menu.query.all()]

    return jsonify(result=menu)

@app.route('/get_cards/<int:menu_id>')
@support_jsonp
def get_cards(menu_id):
    q = Card.query.filter(Card.menu_id==menu_id)
    cards = [e.json() for e in q.all()]

    return jsonify(result=cards)

