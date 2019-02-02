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
<p>A prototype API for calculating Fibonacci numbers.</p>'''

# A route to return nth Fibonacci number.
@app.route('/api/fib', methods=['GET'])
def api_fib():
    if 'n' in request.args:
      n = int(request.args['n'])
    else:
      return "Error: No n provided. Please specify a n."
    result = fib(n)
    return jsonify(result)
      
if __name__ == '__main__':
  app.run()