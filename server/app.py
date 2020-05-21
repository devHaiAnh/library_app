from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = "postgresql://postgres:haianh@localhost:5432/library"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)
migrate = Migrate(app, db)

# model
# member


class MemberModel(db.Model):
    __tablename__ = 'members'
    memberId = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(255))
    password = db.Column(db.String(255))
    name = db.Column(db.String(255))
    email = db.Column(db.String(255))
    phone = db.Column(db.String(255))
    admin = db.Column(db.Boolean)

    def __init__(self, username, password, name, email, phone, admin):
        self.username = username
        self.password = password
        self.name = name
        self.email = email
        self.phone = phone
        self.admin = admin

    def __repr__(self):
        return f"<Member {self.username}>"

# author


class AuthorModel(db.Model):
    __tablename__ = 'authors'
    authorId = db.Column(db.Integer, primary_key=True)
    image = db.Column(db.String(255))
    name = db.Column(db.String(255))
    writingGenre = db.Column(db.String(255))
    achievements = db.Column(db.String(255))
    evaluate = db.Column(db.Float)

    def __init__(self, image, name, writingGenre, achievements, evaluate):
        self.image = image
        self.name = name
        self.writingGenre = writingGenre
        self.achievements = achievements
        self.evaluate = evaluate

    def __repr__(self):
        return f"<Author {self.name}>"

# book


class BookModel(db.Model):
    __tablename__ = 'books'
    bookId = db.Column(db.Integer, primary_key=True)
    image = db.Column(db.String(255))
    name = db.Column(db.String(255))
    author = db.Column(db.String(255))
    evaluate = db.Column(db.Float)
    description = db.Column(db.String(255))
    category = db.Column(db.String(255))
    pages = db.Column(db.Integer)
    cover = db.Column(db.String(255))
    language = db.Column(db.String(255))

    def __init__(self, image, name, author, evaluate, description, category, pages, cover, language, status):
        self.image = image
        self.name = name
        self.author = author
        self.evaluate = evaluate
        self.description = description
        self.category = category
        self.pages = pages
        self.cover = cover
        self.language = language

    def __repr__(self):
        return f"<Book {self.name}>"

# bookmark


class BookmarkModel(db.Model):
    __tablename__ = 'bookmarks'
    bookmarkId = db.Column(db.Integer, primary_key=True)
    image = db.Column(db.String(255))
    name = db.Column(db.String(255))
    author = db.Column(db.String(255))
    evaluate = db.Column(db.Float)
    description = db.Column(db.String(255))
    registrationDate = db.Column(db.Integer)
    expirationDate = db.Column(db.Integer)
    status = db.Column(db.Integer)
    username = db.Column(db.String(255))

    def __init__(self, image, name, author, evaluate, description, registrationDate, expirationDate, status, username):
        self.image = image
        self.name = name
        self.author = author
        self.evaluate = evaluate
        self.description = description
        self.registrationDate = registrationDate
        self.expirationDate = expirationDate
        self.status = status
        self.username = username

    def __repr__(self):
        return f"<Bookmark {self.name}>"

# membert


class CartModel(db.Model):
    __tablename__ = 'carts'
    cartId = db.Column(db.Integer, primary_key=True)
    image = db.Column(db.String(255))
    name = db.Column(db.String(255))
    author = db.Column(db.String(255))
    evaluate = db.Column(db.Float)
    description = db.Column(db.String(255))
    count = db.Column(db.Integer)
    cost = db.Column(db.Integer)
    username = db.Column(db.String(255))

    def __init__(self, image, name, author, evaluate, description, count, cost, username):
        self.image = image
        self.name = name
        self.author = author
        self.evaluate = evaluate
        self.description = description
        self.count = count
        self.cost = cost
        self.username = username

    def __repr__(self):
        return f"<cart {self.name}>"

# payment history - order list


class OrderModel(db.Model):
    __tablename__ = 'orders'
    orderId = db.Column(db.Integer, primary_key=True)
    image = db.Column(db.String(255))
    name = db.Column(db.String(255))
    author = db.Column(db.String(255))
    evaluate = db.Column(db.Float)
    registrationDate = db.Column(db.Integer)
    expirationDate = db.Column(db.Integer)
    count = db.Column(db.Integer)
    cost = db.Column(db.Integer)
    status = db.Column(db.Integer)
    username = db.Column(db.String(255))

    def __init__(self, image, name, author, evaluate, registrationDate, expirationDate, count, cost, status, username):
        self.image = image
        self.name = name
        self.author = author
        self.evaluate = evaluate
        self.registrationDate = registrationDate
        self.expirationDate = expirationDate
        self.count = count
        self.cost = cost
        self.status = status
        self.username = username

    def __repr__(self):
        return f"<Order {self.name}>"


@app.route('/')
def hello():
    return {"hello": "world"}

# login


@app.route('/login', methods=['POST'])
def handle_login():
    if request.is_json:
        try:
            data = request.get_json()
            login_member = MemberModel(username=data['username'], password=data['password'],
                                       name=data['name'], email=data['email'], phone=data['phone'], admin=data['admin'])
            member = MemberModel.query.filter_by(
                username=login_member.username).first()
            if member.password == login_member.password:
                return {"message": "login success", "admin": member.admin}
            else:
                return {"message": "wrong password"}
        except:
            return {"message": "wrong username"}
    else:
        return {"message": "login fail"}

# forgot password
@app.route('/forgot', methods=['POST'])
def handle_forgot_password():
    if request.is_json:
        try:
            data = request.get_json()
            forgot_password = MemberModel(username=data['username'], password=data['password'],
                                        name=data['name'], email=data['email'], phone=data['phone'], admin=data['admin'])
            update = MemberModel.query.filter_by(
                username=forgot_password.username).first()
            if update.email == forgot_password.email:
                update.password = forgot_password.password
                db.session.commit()
                return {"message": "update password success"}
            else:
                return {"message": "wrong email"}
        except:
            return {"message": "wrong username"}
    else:
        return {"message": "update password fail"}

# member


@app.route('/members', methods=['POST', 'GET'])
def handle_members():
    if request.method == 'POST':
        if request.is_json:
            try:
                data = request.get_json()
                new_member = MemberModel(username=data['username'], password=data['password'],
                                         name=data['name'], email=data['email'], phone=data['phone'], admin=data['admin'])
                db.session.add(new_member)
                db.session.commit()
                return {"message": "add member success"}
            except:
                return {"message": "add member error"}
        else:
            return {"message": "add member fail"}
    elif request.method == 'GET':
        try:
            members = MemberModel.query.all()
            results = [
                {
                    "username": member.username,
                    "password": member.password,
                    "name": member.name,
                    "email": member.email,
                    "phone": member.phone,
                    "admin": member.admin
                } for member in members]

            return {"members": results, "message": "get member success"}
        except:
            return {"message": "get member fail"}


@app.route('/members/update', methods=['POST'])
def handle_members_update():
    if request.is_json:
        try:
            data = request.get_json()
            update_member = MemberModel(username=data['username'], password=data['password'],
                                        name=data['name'], email=data['email'], phone=data['phone'], admin=data['admin'])
            update = MemberModel.query.filter_by(
                username=update_member.username).first()
            update.password = update_member.password
            update.name = update_member.name
            update.email = update_member.email
            update.phone = update_member.phone
            update.admin = update_member.admin
            db.session.commit()
            return {"message": "update member success"}
        except:
            return {"message": "update member fail"}
    else:
        return {"message": "update member fail"}

@app.route('/members/update/password', methods=['POST'])
def handle_members_update_password():
    if request.is_json:
        try:
            data = request.get_json()
            update_password = MemberModel(username=data['username'], password=data['password'],
                                        name=data['name'], email=data['email'], phone=data['phone'], admin=data['admin'])
            update = MemberModel.query.filter_by(
                username=update_password.username).first()
            update.password = update_password.password
            db.session.commit()
            return {"message": "update password success"}
        except:
            return {"message": "update password fail"}
    else:
        return {"message": "update password fail"}


@app.route('/members/delete', methods=['POST'])
def handle_members_delete():
    if request.is_json:
        try:
            data = request.get_json()
            delete_member = MemberModel(username=data['username'], password=data['password'],
                                        name=data['name'], email=data['email'], phone=data['phone'], admin=data['admin'])
            MemberModel.query.filter_by(
                username=delete_member.username).delete()
            db.session.commit()
            return {"message": "delete member success"}
        except:
            return {"message": "delete member fail"}
    else:
        return {"message": "delete member fail"}

# bookmark


@app.route('/bookmarks', methods=['POST'])
def handle_bookmarks():
    if request.is_json:
        try:
            data = request.get_json()
            get_bookmark = BookmarkModel(image=data['image'], name=data['name'], author=data['author'],
                                         evaluate=data['evaluate'], description=data['description'], registrationDate=data['registrationDate'],
                                         expirationDate=data['expirationDate'], status=data['status'], username=data['username'])

            bookmarks = BookmarkModel.query.filter_by(
                username=get_bookmark.username)
            results = [
                {
                    "image": bookmark.image,
                    "name": bookmark.name,
                    "author": bookmark.author,
                    "evaluate": bookmark.evaluate,
                    "description": bookmark.description,
                    "registrationDate": bookmark.registrationDate,
                    "expirationDate": bookmark.expirationDate,
                    "status": bookmark.status,
                    "username": bookmark.username
                } for bookmark in bookmarks]
            return {"bookmarks": results, "message": "get bookmark success"}
        except:
            return {"message": "get bookmark error"}
    else:
        return {"message": "get bookmark fail"}


@app.route('/bookmarks/add', methods=['POST'])
def handle_bookmarks_add():
    if request.is_json:
        try:
            data = request.get_json()
            new_bookmark = BookmarkModel(image=data['image'], name=data['name'], author=data['author'],
                                         evaluate=data['evaluate'], description=data['description'], registrationDate=data['registrationDate'],
                                         expirationDate=data['expirationDate'], status=data['status'], username=data['username'])
            db.session.add(new_bookmark)
            db.session.commit()
            return {"message": "add bookmark success"}
        except:
            return {"message": "add bookmark error"}
    else:
        return {"message": "add bookmark fail"}


@app.route('/bookmarks/delete', methods=['POST'])
def handle_bookmarks_delete():
    if request.is_json:
        try:
            data = request.get_json()
            delete_bookmark = BookmarkModel(image=data['image'], name=data['name'], author=data['author'],
                                            evaluate=data['evaluate'], description=data[
                                                'description'], registrationDate=data['registrationDate'],
                                            expirationDate=data['expirationDate'], status=data['status'], username=data['username'])
            BookmarkModel.query.filter_by(
                name=delete_bookmark.name, username=delete_bookmark.username).delete()
            db.session.commit()
            return {"message": "delete bookmark success"}
        except:
            return {"message": "delete bookmark error"}
    else:
        return {"message": "delete bookmark fail"}

# cart


@app.route('/carts', methods=['POST'])
def handle_carts():
    if request.is_json:
        try:
            data = request.get_json()
            get_cart = CartModel(image=data['image'], name=data['name'], author=data['author'],
                                 evaluate=data['evaluate'], description=data['description'],
                                 count=data['count'], cost=data['cost'], username=data['username'])
            carts = CartModel.query.filter_by(
                username=get_cart.username)
            results = [
                {
                    "image": cart.image,
                    "name": cart.name,
                    "author": cart.author,
                    "evaluate": cart.evaluate,
                    "description": cart.description,
                    "count": cart.count,
                    "cost": cart.cost,
                    "username": cart.username
                } for cart in carts]
            return {"carts": results, "message": "get cart success"}
        except:
            return {"message": "get cart error"}
    else:
        return {"message": "get cart fail"}


@app.route('/carts/add', methods=['POST'])
def handle_carts_add():
    if request.is_json:
        try:
            data = request.get_json()
            new_cart = CartModel(image=data['image'], name=data['name'], author=data['author'],
                                 evaluate=data['evaluate'], description=data['description'],
                                 count=data['count'], cost=data['cost'], username=data['username'])
            db.session.add(new_cart)
            db.session.commit()
            return {"message": "add cart success"}
        except:
            return {"message": "add cart error"}
    else:
        return {"message": "add cart fail"}


@app.route('/carts/delete', methods=['POST'])
def handle_carts_delete():
    if request.is_json:
        try:
            data = request.get_json()
            delete_cart = CartModel(image=data['image'], name=data['name'], author=data['author'],
                                    evaluate=data['evaluate'], description=data['description'],
                                    count=data['count'], cost=data['cost'], username=data['username'])
            CartModel.query.filter_by(
                name=delete_cart.name, username=delete_cart.username).delete()
            db.session.commit()
            return {"message": "delete cart success"}
        except:
            return {"message": "delete cart error"}
    else:
        return {"message": "delete cart fail"}

# order


@app.route('/orders', methods=['POST', 'GET'])
def handle_orders():
    if request.method == 'POST':
        if request.is_json:
            try:
                data = request.get_json()
                new_order = OrderModel(image=data['image'], name=data['name'], author=data['author'],
                                       evaluate=data['evaluate'],
                                       registrationDate=data['registrationDate'], expirationDate=data['expirationDate'],
                                       count=data['count'], cost=data['cost'],
                                       status=data['status'], username=data['username'])
                db.session.add(new_order)
                db.session.commit()
                return {"message": "add order success"}
            except:
                return {"message": "add order error"}
        else:
            return {"message": "add order fail"}
    elif request.method == 'GET':
        try:
            orders = OrderModel.query.all()
            results = [
                {
                    "image": order.image,
                    "name": order.name,
                    "author": order.author,
                    "evaluate": order.evaluate,
                    "registrationDate": order.registrationDate,
                    "expirationDate": order.expirationDate,
                    "count": order.count,
                    "cost": order.cost,
                    "status": order.status,
                    "username": order.username
                } for order in orders]
            return {"orders": results, "message": "get order success"}
        except:
            return {"message": "get order fail"}


@app.route('/orders/get', methods=['POST'])
def handle_order_member():
    if request.is_json:
        try:
            data = request.get_json()
            get_order = MemberModel(username=data['username'], password=data['password'],
                                    name=data['name'], email=data['email'], phone=data['phone'], admin=data['admin'])
            orders = OrderModel.query.filter_by(
                username=get_order.username)
            results = [
                {
                    "image": order.image,
                    "name": order.name,
                    "author": order.author,
                    "evaluate": order.evaluate,
                    "registrationDate": order.registrationDate,
                    "expirationDate": order.expirationDate,
                    "count": order.count,
                    "cost": order.cost,
                    "status": order.status,
                    "username": order.username
                } for order in orders]

            return {"orders": results, "message": "get order success"}
        except:
            return {"message": "get order error"}
    else:
        return {"message": "add order fail"}


@app.route('/orders/delete', methods=['POST'])
def handle_orders_delete():
    if request.is_json:
        try:
            data = request.get_json()
            delete_order = OrderModel(image=data['image'], name=data['name'], author=data['author'],
                                      evaluate=data['evaluate'],
                                      registrationDate=data['registrationDate'], expirationDate=data['expirationDate'],
                                      count=data['count'], cost=data['cost'],
                                      status=data['status'], username=data['username'])
            OrderModel.query.filter_by(
                name=delete_order.name, username=delete_order.username).delete()
            db.session.commit()
            return {"message": "delete order success"}
        except:
            return {"message": "delete order fail"}
    else:
        return {"message": "delete order fail"}

# book


@app.route('/books', methods=['POST'])
def handle_books_add():
    if request.method == 'POST':
        if request.is_json:
            try:
                data = request.get_json()
                new_book = BookModel(image=data['image'], name=data['name'], author=data['author'], evaluate=data['evaluate'],
                                     description=data['description'], category=data['category'], pages=data['pages'],
                                     cover=data['cover'], language=data['language'])
                db.session.add(new_book)
                db.session.commit()
                return {"message": "add book success"}
            except:
                return {"message": "add book error"}
        else:
            return {"message": "add book fail"}
    elif request.method == 'GET':
        try:
            books = BookModel.query.all()
            results = [
                {
                    "image": book.image,
                    "name": book.name,
                    "author": book.author,
                    "evaluate": book.evaluate,
                    "description": book.description,
                    "category": book.category,
                    "pages": book.pages,
                    "cover": book.cover,
                    "language": book.language
                } for book in books]
            return {"books": results, "message": "get book success"}
        except:
            return {"message": "get order fail"}


@app.route('/books/delete', methods=['POST'])
def handle_books_delete():
    if request.is_json:
        try:
            data = request.get_json()
            delete_book = BookModel(image=data['image'], name=data['name'], author=data['author'], evaluate=data['evaluate'],
                                    description=data['description'], category=data['category'], pages=data['pages'],
                                    cover=data['cover'], language=data['language'], status=data['status'])
            BookModel.query.filter_by(
                name=delete_book.name).delete()
            db.session.commit()
            return {"message": "delete book success"}
        except:
            return {"message": "delete book fail"}
    else:
        return {"message": "delete book fail"}


if __name__ == '__main__':
    app.run(debug=True)
