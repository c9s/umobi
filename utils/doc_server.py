
from flask import Flask
app = Flask(__name__)

@app.route('/',defaults={'path':'index.html'})
@app.route('/<path:path>')
def catch_all(path):
    return 'You want path: %s' % path

if __name__ == "__main__":
	app.run()
