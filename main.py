from flask import Flask, session, render_template, request, redirect, g, url_for, flash
import pymysql
import os

app = Flask(__name__)
host = 'localhost'
user = 'root'
password = ''
dbname = 'game_review'

""" Mysql DB connection and run query"""
def connection():
    conn = pymysql.connect(host=host,
                           user=user,
                           passwd=password,
                           db=dbname)
    c = conn.cursor()
    return c, conn

def runQuery(query):
    cursor, con = connection()
    try:
        cursor.execute(query=query)
        con.commit()
    except:
        pass
    return cursor

""" check username and passwrod in users table """
def verify_password(username, password):
    query = "select * from `users` where username='%s' and `password`='%s'" % (username, password)
    cursor = runQuery(query=query)
    return True if cursor.fetchone() else False

""" check username is already existed in users table """
def isUserExist(username, email):
    query = "select * from `users` where `username`='%s' or `email`='%s'" % (username, email)
    cursor = runQuery(query=query)
    return True if cursor.fetchone() else False
""" insert new user to users table (register) """
def action_register(username, email, password):
    query = "insert into `users` (`email`, `username`, `password`) VALUES ('%s', '%s', '%s')" %(email, username, password)
    print(query)
    cursor = runQuery(query=query)

""" get all contents and comments """
def getAllcontents():
    query = "select * from `contents`  LEFT JOIN comments ON `contents`.id=`comments`.content_id LEFT join users on comments.`user_id` = users.`id` ORDER BY `contents`.id ASC"
    cursor = runQuery(query=query)
    res = cursor.fetchall()
    data = []
    id = 0
    content = {}
    """ get all contents with its comments """
    for row in res:
        if row[0] != id:
            if id !=0:
                content['comments'] = comments
                data.append(content)
            id = row[0]
            content = {
                'id' : row[0],
                'image' : row[1],
                'title' : row[2],
                'release_date' : row[3],
                'description' : row[4],
            }
            comments = []
        if row[8]:
            comments.append({
                "comment" : row[8],
                "created_at" : str(row[9]).split(' ')[0],
                "user" : row[13]
            })
    return data

""" get id of current logged in user """
def getCurrentUserid():
    query = "select id from `users` where `username`='%s'" % (g.user)
    cur = runQuery(query=query)
    return cur.fetchone()[0]

""" action_addComment """
def addComment(content_id, comment):
    userid = getCurrentUserid()
    query = "insert into `comments` (`content_id`, `user_id`, `comment`) values (%s, %s, '%s')" % (content_id, userid, comment)
    runQuery(query=query)

""" get all contents of reivews """
def getAllreviews():
    query = "select * from `reviews`"
    cursor = runQuery(query=query)
    res = cursor.fetchall()
    data = []
    for row in res:
        data.append({
            "customer" : row[1],
            "comment" : row[2],
            "created_at" : str(row[3]).split(' ')[0]
        })
    return data

""" action addReview """
def addReview(customer, comment):
    query = "insert into `reviews` (`customer`, `comments`) values ('%s', '%s')" % (customer, comment)
    runQuery(query=query)

@app.route("/login", methods=['GET','POST'])
def login():
    if request.method == 'POST':
        session.pop('user',None)
        username = request.form['username']
        password = request.form['password']
        if verify_password(username=username, password=password):
            session['user'] = username
            flash('You were successfully logged in', 'success')
            return redirect(url_for('index'))
        else:
            flash('Invalid Credentials', 'warning')
    return render_template("login.html")

@app.route('/logout')
def logout():
    dropsession()
    flash('You were successfully logged out', 'success')
    return redirect(url_for('index'))

@app.route("/register", methods=['GET','POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']
        cpassword = request.form['cpassword']
        ## password validation
        if password == cpassword:
            if not isUserExist(username=username, email=email):
                action_register(username=username, password=password, email=email)
                flash('You were successfully registered', 'success')
                return redirect(url_for('login'))
            else:
                flash('Username is already existed', 'warning')
        else:
            flash('Confirm password does not match!', 'warning')
    return render_template("register.html")

""" home page """
@app.route('/', methods = ['GET', 'POST'])
def index():
    if request.method == 'POST':
        """ check login status """
        if not g.user:
            flash("You need to login", 'warning')
        else:
            content_id = request.form['content_id']
            comment = request.form['comment']
            addComment(content_id=content_id, comment=comment)
            flash('Successfully added','success')
    context = {
        'user' : None,
        'contents' : getAllcontents()
    }

    if g.user:
        context['user'] = g.user,
    return render_template('index.html', context=context)


""" review page for guest """
@app.route('/reviews', methods = ['GET', 'POST'])
def reviews():
    if request.method == 'POST':
        customer = request.form['customer']
        comment = request.form['comment']
        addReview(customer=customer, comment=comment)
        flash("Successfully added", 'success')

    context = {
        'user' : g.user,
        'reviews' : getAllreviews()
    }
    return render_template('review.html', context=context)


@app.route('/protected')
def protected():
    if g.user:
        return render_template('protected.html')
    return redirect(url_for('index'))

@app.before_request
def before_request():
    g.user = None
    if 'user' in session:
        g.user = session['user']

@app.route('/getsession')
def getsession():
    if 'user' in session:
        return session['user']
    return 'Not logged in!'

@app.route('/dropsession')
def dropsession():
    session.pop('user', None)
    return 'Dropped!'


if __name__ == "__main__":
    app.secret_key = os.urandom(24)
    app.run()