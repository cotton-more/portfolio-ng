from app import app
from models import User
from flask import jsonify

@app.route('/')
@app.route('/index')
def index():
    user = User.query.get(2)
    return jsonify(user.json())
