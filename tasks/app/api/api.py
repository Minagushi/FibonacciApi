import flask
from flask import request, jsonify
from math import sqrt
import decimal

s5 = decimal.Decimal(5).sqrt()
app = flask.Flask(__name__)
fib = lambda n:int((((1+s5)**n)-((1-s5)**n))/((2**n)*s5))

@app.route('/', methods=['GET'])
def home():
    return '''<h1>Fibonacci Calcucattor API</h1>
<p>A prototype API for calculating Fibonacci numbers.</p>
<p>Just pass any integer with n param to /api/fib, like that: <ip-adress>/api/fib?n=10 and you will get 10th fibonacci number in this exapmle :)</p>'''

# A route to return nth Fibonacci number.
@app.route('/api/fib', methods=['GET'])
def api_fib():
    if 'n' in request.args:
      try:
        n = int(request.args['n'])
      except ValueError:
        return "Error: n is not int. Please provide any int as n."
    else:
      return "Error: No n provided. Please specify a n."
    result = fib(n)
    if 'json' in request.args:
      return jsonify(result)
    return str(result)
      
if __name__ == '__main__':
  app.run()