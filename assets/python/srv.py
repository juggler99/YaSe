from flask import Flask

app = Flask(__name__)

app.route('exec/<filename>')
def run_script():
	targetFile = filename.replace('~', '/')
	file = open(targetFile, 'r').read()
	return exec(file)
	
if __name__ == "__main__":
	app.run(debug=True)