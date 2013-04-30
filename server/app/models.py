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

class Menu(db.Model):
    __tablename__ = 'menus'

    id = db.Column(db.Integer, primary_key=True)
    parent_id = db.Column(db.Integer, db.ForeignKey('menus.id'))
    name = db.Column(db.String(64))
    about = db.Column(db.Text)

    children = db.relationship("Menu",
                          backref=db.backref("parent", remote_side=[id])
                          )

    cards = db.relationship("Card",
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

class Card(db.Model):
    __tablename__ = 'cards'

    id = db.Column(db.Integer, primary_key=True)
    menu_id = db.Column(db.Integer, db.ForeignKey('menus.id'))
    name = db.Column(db.String(128))
    about = db.Column(db.Text)
    image = db.Column(db.String(128))

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

