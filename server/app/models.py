from app import db

class User(db.Model):
    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(64), unique=True)
    password = db.Column(db.String(64))
    fullname = db.Column(db.String(64))
    role = db.Column(db.String(16), default='guest')

    def __repr__(self):
        return '<User(%s, %s)>' % (self.username, self.role)

    def json(self):
        return {
            'id': self.id,
            'username': self.username,
            'fullname': self.fullname
        }

