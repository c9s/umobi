

all:
	node node_modules/requirejs/bin/r.js -o js/build.js

node_modules:
	npm install requirejs

deps: node_modules

