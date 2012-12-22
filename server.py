from flask import Flask, request, url_for, render_template, jsonify, g
from copy import copy

#configuration
DEBUG = True

#application
app = Flask(__name__)
app.config.from_object(__name__)

@app.before_request
def before_request():
    g.flag = []
    g.solu = []

#function
def cal_queens(y, n, flag):
    if y == n:
        g.solu.append(copy(flag))
        return
    for x in range(n):
        flg = False
        for i in range(y):
            if abs(x - flag[i]) == y - i:
                flg = True
                break
        if x in flag[:y] or flg:
            continue
        else:
            flag[y] = x
            cal_queens(y+1, n, flag)
            flag[y] = n

#route
@app.route('/', methods = ['GET', 'POST'])
def index():
    if request.method == 'GET':
        return render_template('index.html')

    #POST
    n = int(request.form.get('n'))
    g.solu = []
    flag = [n for i in range(n)]
    cal_queens(0, n, flag)
    return jsonify(solu=g.solu)

if __name__ == '__main__':
    app.run('0.0.0.0', 5000)
